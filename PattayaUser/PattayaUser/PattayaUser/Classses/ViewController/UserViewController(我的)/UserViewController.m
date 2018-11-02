//
//  UserViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/5.
//  Copyright © 2018年 明克. All rights reserved.
//
#import "WebHelpViewController.h"
#import "UserViewController.h"
#import "UserHeadView.h"
#import "UserTableViewCell.h"
#import "UserAddressViewController.h"
#import "UserModel.h"
#import "ThirdPartyViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QiniuSDK.h>
#import "DeveloperViewController.h"
#import "AnenstViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray * titleArray;
    NSArray * imageArray;
}
@property (strong, nonatomic) UITableView * tableview;
@property (strong, nonatomic) UserHeadView * headview;
@property (strong, nonatomic) NSMutableArray * socialArray;
@property (nonatomic, assign) NSInteger  ImagePickerControllerTpye;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addlistTabelview];
    //    self.tabBarController.delegate = self;
#ifdef DEBUG
    titleArray = @[NSLocalizedString(@"我的地址",nil),NSLocalizedString(@"账户与安全",nil),NSLocalizedString(@"我的客服",nil),NSLocalizedString(@"关于叮咚打店",nil),NSLocalizedString(@"切换环境",nil)];
    
#else
    titleArray = @[NSLocalizedString(@"我的地址",nil),NSLocalizedString(@"账户与安全",nil),NSLocalizedString(@"我的客服",nil),NSLocalizedString(@"关于叮咚打店",nil),];
#endif
    _headview = [[UserHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 200)];
    self.tableview.tableHeaderView = _headview;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerIamge)];
    [_headview.userImg addGestureRecognizer:tap];
    [self userInfoHttp];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoHttp) name:@"KdUserInfoHtppLoad" object:nil];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)headerIamge
{
    [self showSheet];
}

- (void)showSheet {
    
    
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"头像"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                             
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"相机",nil) style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action) {
                                                             if([[SystemAuthority singleton] CameraAuthority])
                                                             {
                                                                 _ImagePickerControllerTpye = 1;
                                                                 [self imagepickerControllerPresent];
                                                             }
                                                             
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                             
                                                             
                                                         }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"相册",nil) style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           if([[SystemAuthority singleton] PhotoLibraryAuthority])
                                                           {
                                                               _ImagePickerControllerTpye = 2;
                                                               [self imagepickerControllerPresent];
                                                           }
                                                           
                                                           //响应事件
                                                           NSLog(@"action = %@", action);
                                                           
                                                       }];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)imagepickerControllerPresent
{
    if (@available(iOS 10.0, *)) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusDenied ||status == PHAuthorizationStatusRestricted){
                NSLog(@"家长控制,不允许访问");
                // TODO:...
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
                return;
            }else if (status == PHAuthorizationStatusNotDetermined||status == PHAuthorizationStatusAuthorized){
                NSLog(@"用户允许当前应用访问相册");
                [self getImageFromIpc];
                
            }
            
        }];
    } else
    {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
            //无权限  //无权限 引导去开启
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            return;
        }
        [self getImageFromIpc];
        
    }
    
    
}

- (void)getImageFromIpc
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    ipc.allowsEditing = YES; //可编辑
    
    
    // 3. 设置打开照片相册类型(显示所有相簿)
    if (_ImagePickerControllerTpye == 1) {
        // 照相机
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        //        ipc.mediaTypes = @[(NSString *)kUTTypeMovie];
        
    } else if(_ImagePickerControllerTpye == 2)
    {
        // 相册
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
    
}
#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        _headview.userImg.image = info[UIImagePickerControllerEditedImage];
        NSString * string;
        if (@available(iOS 11.0, *)) {
            string = info[UIImagePickerControllerImageURL];
        } else {
            // Fallback on earlier versions
            string =  info[UIImagePickerControllerMediaURL];
        }
        //        self.headImage.layer.cornerRadius = 24;
        //压缩图片
        NSData *fileData = UIImageJPEGRepresentation(_headview.userImg.image, 1.0);
        //        //保存图片至相册
        if (_ImagePickerControllerTpye == 1) {
            
            UIImageWriteToSavedPhotosAlbum(_headview.userImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
        //上传图片
        //        [self uploadImageWithData:fileData];
        [self qinniHttpToken:fileData];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    // 设置图片
    //    self.imageView.image = info[UIImagePickerControllerOriginalImage];
}
#pragma mark 视频保存完毕的回调
- (void)image:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        [self.tableview reloadData];
        
    }
}

- (void)qinniHttpToken:(NSData *)data
{
    [[PattayaUserServer singleton]QiniuTokenRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"获取七牛token==%@",ret);
        if ([ResponseModel isData:ret]) {
            
            [self updateImage:ret[@"data"][@"uploadToken"] imageData:data filekey:ret[@"data"][@"filekey"]];
        } else
        {
            [self showToast:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)updateImage:(NSString *)token imageData:(NSData*)data filekey:(NSString *)key
{
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNFixedZone zone0];
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    //    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
    [upManager putData:data key:key token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", info);
                  NSLog(@"%@", resp);
                  if (![PattayaTool isNull:key]) {
                      [self postHeadImg:key];
                  }
                  
              } option:nil];
}
- (void)postHeadImg:(NSString *)key
{
    [[PattayaUserServer singleton] headImgSaveRequest:key Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            
        } else
        {
            [self showToast:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
- (void)addlistTabelview
{
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview activateConstraints:^{
        self.tableview.top_attr = self.view.top_attr;
        self.tableview.width_attr = self.view.width_attr;
        self.tableview.bottom_attr = self.view.bottom_attr;
    }];
}
- (UITableView *)tableview
{
    
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return titleArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return NULL;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return NULL;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    if (!cell) {
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleText = titleArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
 
    if ([PattayaTool isUserLoginStats] == NO) {
        [[PattayaHttpRequest singleton] codeIsAccessToken:401];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (indexPath.row == 0) {
        UserAddressViewController *  vc = [[UserAddressViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1)
    {
        ThirdPartyViewController * vc = [[ThirdPartyViewController alloc] init];
        vc.listUserSocial = _socialArray;
        vc.infoBlock = ^{
            [weakSelf userInfoHttp];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2)
    {
        WebHelpViewController * vc = [[WebHelpViewController alloc] init];
        vc.httpString = @"https://www.callstore.cn/app/contact";
        vc.title = @"联系客服";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3)
    {
        AnenstViewController * vc = [[AnenstViewController alloc] init];
        
        //        WebHelpViewController * vc = [[WebHelpViewController alloc] init];
        ////        vc.httpString = @"https://www.callstore.cn/policies/user-privacy/";
        //        vc.httpString = @" ";
        //
        //        vc.customTitle = NSLocalizedString(@"叮咚打店APP",nil);
        [self.navigationController pushViewController:vc animated:YES];
    }
    
#ifdef DEBUG
    
    if (indexPath.row == 4) {
        DeveloperViewController * DevelopVC = [[DeveloperViewController alloc]init];
        DevelopVC.devBlock = ^{
            [[PattayaUserServer singleton] logOutUserRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
                if ([ResponseModel isData:ret]) {
                    [PattayaHttpRequest sharedHttpManager];
                    [PattayaTool INVALID_ACCESS_TOKEN];
                    [PattayaTool chenkLogin:@""];
                    [GetAppDelegate getTabbarVC];
                } else
                {
                    [self showToast:ret[@"message"]];
                }
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                
            }];
        };
        [self.navigationController pushViewController:DevelopVC animated:YES];
    }
#else
    
#endif
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userInfoHttp
{
    [[PattayaUserServer singleton] UserInfoRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            UserModel * mode = [[UserModel alloc] initWithDictionary:ret[@"data"] error:nil];
            _headview.userName.text = mode.maskMobile;
            _headview.userMobil.text = mode.maskMobile;
            _socialArray = [NSMutableArray array];
            _socialArray = mode.userSocialLinks;
            [_headview.userImg sd_setImageWithURL:[NSURL URLWithString:mode.headImgUrl] placeholderImage:[UIImage imageNamed:@"boy"]];
            [PattayaTool loginSavename:mode.userName mobile:mode.mobile];
        } else
        {
            [self showToast:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
