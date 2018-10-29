//
//  AccountSafeVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/26.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AccountSafeVC.h"

#define HEADTITLES @[@"  基本信息",@"  账号绑定"]
#define IMAGES @[@"icon_wechat",@"icon_QQ"]

@interface AccountSafeVC ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)UIImageView *headImg;
@property(nonatomic, strong)UITextField *name;
@property(nonatomic, strong)UIButton *layoutBT;


@end

@implementation AccountSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self netRequestData];
    
}

-(void)setupUI{
    [super setupUI];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    self.navigationItem.title = @"账户安全";
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
            //        self.headImg.layer.borderColor = [[UIColor whiteColor]CGColor];
            //        self.headImg.layer.borderWidth = 2.0f;
            self.headImg.backgroundColor = [UIColor blackColor];
            
            //        if (self.uploadImage) {
            //            self.headImg.image = self.uploadImage;
            //        }else{
            //            [self.headImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"contacts.png"]];
            //        }
            
            [cell.contentView addSubview:self.headImg];
            //cell.accessoryView = self.headImg;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.row == 1) {
            //手机
            //cell.detailTextLabel.text = [self.personInfoDic objectForKey:@"phone"];
            cell.detailTextLabel.text = @"15071047088";
            cell.detailTextLabel.textColor = UIColorFromRGB(0x4A4A4A);
        }
        
        
        if (indexPath.row == 2) {
            //昵称
            //姓名
            self.name = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_Width- 36 - 200, 10, 200, 35)];
            self.name.returnKeyType = UIReturnKeyDone;
            self.name.font = [UIFont systemFontOfSize:14];
            self.name.textAlignment = 2;
            self.name.delegate = self;
            self.name.text = @"Yvonne";
            [cell.contentView addSubview:self.name];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
     
        cell.detailTextLabel.text = @"点击绑定";
        cell.detailTextLabel.textColor = App_Nav_BarDefalutColor;
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
      cell.detailTextLabel.text = @"解锁绑定";
      cell.detailTextLabel.textColor = UIColorFromRGB(0xE4344A);
    }
    
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
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
   
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.headImg.image = newPhoto;
    //_myHeadPortrait.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)hideKeyBoard{
   
    [self.name endEditing:YES];
}

@end
