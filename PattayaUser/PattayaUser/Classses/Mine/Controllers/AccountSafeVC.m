//
//  AccountSafeVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/26.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AccountSafeVC.h"
#import "QNUploadManager.h"
#import "QNConfiguration.h"
#define HEADTITLES @[@"  基本信息",@"  账号绑定"]
#define IMAGES @[@"icon_wechat",@"icon_QQ"]

@interface AccountSafeVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)UIImageView *headImg;
@property(nonatomic, strong)UITextField *name;
@property(nonatomic, strong)UIButton *layoutBT;

@property (nonatomic, strong) NSMutableArray * nameText;
@property (nonatomic, assign) NSInteger  ImagePickerControllerTpye;

@end

@implementation AccountSafeVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KdthirdBindSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KdthirdQQ" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thirdBindSuccess:) name:@"KdthirdBindSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QQsuccess:) name:@"KdthirdQQ" object:nil];
    
    [self setupUI];
    
    [self netRequestData];
    
}



-(void)setupUI{
    [super setupUI];
    [self loadDataCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    self.navigationItem.title = @"账户安全";
}

- (void)loadDataCell
{
    NSString * str1 = @"解除绑定";
    NSString * str2 = @"点击绑定";
    
    _nameText = [NSMutableArray array];
    if (_userModel.userSocialLinks.count > 0) {
        
        if (_userModel.userSocialLinks.count == 1) {
            NSDictionary * dicwecht = _userModel.userSocialLinks[0];
            if ([dicwecht[@"socialType"] isEqualToString:@"WECHAT"]) {
                [_nameText addObject:str1];
                [_nameText addObject:str2];
            } else
            {
                [_nameText addObject:str2];
                [_nameText addObject:str1];
            }
        } else
        {
            //        NSDictionary * dicwecht = _listUserSocial[0];
            //        NSDictionary * dicQQ = _listUserSocial[1];
            [_nameText addObject:str1];
            [_nameText addObject:str1];
            
        }
    } else
    {
        [_nameText addObject:str2];
        [_nameText addObject:str2];
        
    }
}

-(void)netRequestData{
    
    _titleArray = @[@[@"头像",@"手机号（不支持修改）",@"昵称"],
                    @[@"微信",@"QQ"]
                    ];
    
}
#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}




-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 78;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.text = HEADTITLES[section];
    headLabel.backgroundColor = UIColorWhite;
    headLabel.font = fontStely(@"PingFangSC-Regular", 16);
    headLabel.textColor = TextColor;
    return headLabel;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = App_TotalGrayWhite;
    if (section==1) {
        //提交
        _layoutBT = [UIButton buttonWithType:UIButtonTypeCustom];
        _layoutBT.frame = CGRectMake((SCREEN_Width-250)/2, 40, 250, 38);
        [_layoutBT setTitle:@"退出登录" forState:UIControlStateNormal];
        [_layoutBT addTarget:self action:@selector(layout) forControlEvents:UIControlEventTouchUpInside];
        [_layoutBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
        _layoutBT.backgroundColor = App_Nav_BarDefalutColor;
        _layoutBT.layer.cornerRadius = 19;
        _layoutBT.layer.masksToBounds = YES;
        [footerView addSubview:_layoutBT];
    }
   
   
    return footerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = TextColor;
    cell.textLabel.font = K_LABEL_SMALL_FONT_14;
    
    if (indexPath.section==0) {
        //section2
        if (indexPath.row == 0) {
            //头像
            // NSURL *url = [NSURL URLWithString:[self.personInfoDic objectForKey:@"avatar"]];
            self.headImg = [[UIImageView alloc]init];
            self.headImg.frame = CGRectMake(SCREEN_Width-36 - 38, 11, 38, 38);
            self.headImg.layer.cornerRadius = 19;
            self.headImg.layer.masksToBounds = YES;
            self.headImg.contentMode = UIViewContentModeScaleAspectFill;
            self.headImg.tag = 1001;
            NSString *url = (_userModel.headImgUrl) ? (_userModel.headImgUrl) : (_userModel.userSocialLinks.count > 0 ? _userModel.userSocialLinks[0][@"headImgUrl"] : @"123");
            self.headImg.image = nil;
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"main_cell_headImg_bg"]];
          
            [cell.contentView addSubview:self.headImg];
            //cell.accessoryView = self.headImg;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.row == 1) {
            //手机
            //cell.detailTextLabel.text = [self.personInfoDic objectForKey:@"phone"];
            cell.detailTextLabel.text = _userModel.mobile;
            cell.detailTextLabel.textColor = UIColorFromRGB(0x4A4A4A);
        }
        
        
        if (indexPath.row == 2) {
            //昵称
//            self.name = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_Width- 36 - 200, 10, 200, 35)];
//            self.name.returnKeyType = UIReturnKeyDone;
//            self.name.font = [UIFont systemFontOfSize:14];
//            self.name.textAlignment = 2;
//            self.name.delegate = self;
//            self.name.text = _userModel.mobile;
//            [cell.contentView addSubview:self.name];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.detailTextLabel.text = _userModel.userSocialLinks.count > 0 ? _userModel.userSocialLinks[0][@"nickName"] : _userModel.userName;;
            cell.detailTextLabel.textColor = UIColorFromRGB(0x4A4A4A);
        }
        
    }else{
       //section2
       // cell.imageView.frame = CGRectMake(0, 0, 30, 30);
        cell.imageView.image = [UIImage imageNamed:IMAGES[indexPath.row]];
        //2、调整大小
        CGSize itemSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        cell.detailTextLabel.text = _nameText[indexPath.row];
        if (_userModel.userSocialLinks.count > 0) {
            NSDictionary * dicwecht = _userModel.userSocialLinks[0];
            if (_userModel.userSocialLinks.count == 1) {
                if ( indexPath.row == 0){
                    cell.detailTextLabel.textColor = [dicwecht[@"socialType"] isEqualToString:@"WECHAT"] ? UIColorFromRGB(0xE4344A) : App_Nav_BarDefalutColor;
                }else  if ( indexPath.row == 1){
                    cell.detailTextLabel.textColor = [dicwecht[@"socialType"] isEqualToString:@"QQ"] ? UIColorFromRGB(0xE4344A) : App_Nav_BarDefalutColor;

                }
                
            }else{
                 cell.detailTextLabel.textColor = UIColorFromRGB(0xE4344A);
            }
            
        }else{
            cell.detailTextLabel.textColor = App_Nav_BarDefalutColor;
        }
        
    cell.detailTextLabel.font = fontStely(@"PingFangSC-Regular", 14);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0 && indexPath.section == 0) {
        NSLog(@"选择头像");
        [self hideKeyBoard];
        [self alterHeadPortrait];
        
    }else if (indexPath.section == 1){
        // NSLog(@"点击绑定");
      UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//      cell.detailTextLabel.text = @"解除绑定";
//      cell.detailTextLabel.textColor = UIColorFromRGB(0xE4344A);
       
        
        NSString * str = _nameText[indexPath.row];
        if (indexPath.row == 0) {
            if ([str isEqualToString:@"解除绑定"]) {
                
                for (NSDictionary * dic in _userModel.userSocialLinks) {
                    if ([dic[@"socialType"] isEqualToString:@"WECHAT"]) {
                        [self deletedUnBind:@{@"openId":dic[@"openId"],@"socialType":@"WECHAT"}];
                    }
                }
                
                
            } else{
                //绑定
                [self weChatLogin];
            }
            
        } else if (indexPath.row == 1)
        {
            if ([str isEqualToString:@"解除绑定"]) {
                for (NSDictionary * dic in _userModel.userSocialLinks) {
                    if ([dic[@"socialType"] isEqualToString:@"QQ"]) {
                        [self deletedUnBind:@{@"openId":dic[@"openId"],@"socialType":@"QQ"}];
                    }
                }
                
            } else
            {
                ///绑定
                [self QQLogin];
                
            }
        }
        
    }
    
}

- (void)QQLogin
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    
    [GetAppDelegate.tencentOAuth setAuthShareType:AuthShareType_QQ];
    [GetAppDelegate.tencentOAuth authorize:permissions inSafari:NO];
    
}

-(void)bindOrNot{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[PattayaUserServer singleton] logOutUserRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
            if ([ResponseModel isData:ret]) {
                [PattayaTool INVALID_ACCESS_TOKEN];
                [GetAppDelegate getTabbarVC];
                [PattayaTool chenkLogin:@""];
            } else
            {
                [YDProgressHUD showMessage:ret[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma  退出登录
-(void)layout{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[PattayaUserServer singleton] logOutUserRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
            if ([ResponseModel isData:ret]) {
                [PattayaTool INVALID_ACCESS_TOKEN];
                [GetAppDelegate getTabbarVC];
                [PattayaTool chenkLogin:@""];
            } else
            {
                [YDProgressHUD showMessage:ret[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
}

#pragma mark 点击弹出Alert
-(void)alterHeadPortrait{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _ImagePickerControllerTpye = 2;
        
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
        _ImagePickerControllerTpye = 1;
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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
        //定义一个newPhoto，用来存放我们选择的图片。
        UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        self.headImg.image = newPhoto;
        [self dismissViewControllerAnimated:YES completion:nil];
        NSString * string;
        if (@available(iOS 11.0, *)) {
            string = info[UIImagePickerControllerImageURL];
        } else {
            // Fallback on earlier versions
            string =  info[UIImagePickerControllerMediaURL];
        }
        //        self.headImage.layer.cornerRadius = 24;
        //压缩图片
        NSData *fileData = UIImageJPEGRepresentation(self.headImg.image, 1.0);
       //保存图片至相册
        if (_ImagePickerControllerTpye == 1) {
            
            UIImageWriteToSavedPhotosAlbum( self.headImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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
       // [self.tableView reloadData];
        
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
            [YDProgressHUD showMessage:ret[@"message"]];
            //[self showToast:ret[@"message"]];
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KdUserInfoHtppLoad" object:nil];
            
        } else
        {
            [YDProgressHUD showMessage:ret[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
////PickerImage完成后的代理方法
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//
//    //定义一个newPhoto，用来存放我们选择的图片。
//    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    self.headImg.image = newPhoto;
//    //_myHeadPortrait.image = newPhoto;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

//
- (void)hideKeyBoard{
   
    [self.name endEditing:YES];
}

- (void)deletedUnBind:(NSDictionary *)dic
{
    [[PattayaUserServer singleton] deleteDunBindOrderRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        
        if ([ResponseModel isData:ret]) {
            [self userInfoHttp];
        } else
        {
             [YDProgressHUD showHUD:@"message"];
        }
       
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)thirdBindHttp:(NSDictionary *)dic
{
    [[PattayaUserServer singleton]thirdBinOrderRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        if ([ResponseModel isData:ret]) {
            
            [self userInfoHttp];
            
        } else
        {
            [YDProgressHUD showHUD:@"message"];
        }
        //        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
- (void)weChatLogin
{
    SendAuthReq * reques = [[SendAuthReq alloc]init];
    reques.scope = @"snsapi_userinfo";
    reques.state = @"iOSPattaya-user";
    if ([WXApi isWXAppInstalled]) {
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:reques];
    } else
    {
        [GetAppDelegate sendAuthReq:reques viewController:self];
    }
}
- (void)thirdBindSuccess:(NSNotification *)info
{
    //
    WS(weakSelf);
    [[PattayaUserServer singleton] WeChatCodeRequest:info.object[@"code"] success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            [weakSelf thirdBindHttp:@{@"openId":ret[@"data"][@"openId"],@"socialType":@"WECHAT",@"nickName":ret[@"data"][@"nickname"],@"headImgUrl":ret[@"data"][@"headImgUrl"]}];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)QQsuccess:(NSNotification *)info
{
    
    NSDictionary * dic = info.object[@"QQ"];
    [self thirdBindHttp:@{@"openId":GetAppDelegate.tencentOAuth.openId,@"socialType":@"QQ",@"nickName":dic[@"nickname"],@"headImgUrl":dic[@"figureurl_qq_2"]}];
    
}


- (void)userInfoHttp
{
    [[PattayaUserServer singleton] UserInfoRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            _userModel = [[UserModel alloc] initWithDictionary:ret[@"data"] error:nil];
//            _listUserSocial = [NSMutableArray array];
//            _listUserSocial = mode.userSocialLinks;
            [self loadDataCell];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"KdUserInfoHtppLoad" object:nil];
        } else
        {
            [YDProgressHUD showHUD:@"message"];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
