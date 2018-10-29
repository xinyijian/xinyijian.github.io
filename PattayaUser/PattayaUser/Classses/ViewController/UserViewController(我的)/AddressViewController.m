//
//  AddressViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AddressViewController.h"
#import "MakeSureLocationViewController.h"
#import "AddressModel.h"
#import "HomeViewController.h"
@interface AddressViewController ()<UITextFieldDelegate>
@property (nonatomic,copy) UIButton * tmpBtn;
@property (nonatomic,strong) UIView * backgroundView;
@property (nonatomic, strong) UITextField * texfield;
@property (nonatomic, strong) NSString * adcode;
@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_EidtModel && ![PattayaTool isNull:_EidtModel.contactName]) {
        self.customTitle = NSLocalizedString(@"修改地址",nil);

    } else
    {
        self.customTitle = NSLocalizedString(@"新增收藏地址",nil);

    }
    
    _backgroundView = [[UIView alloc]init];
    [self.view addSubview:_backgroundView];
    [_backgroundView activateConstraints:^{
        [_backgroundView.left_attr equalTo:self.view.left_attr constant:15];
        [_backgroundView.right_attr equalTo:self.view.right_attr constant:-15];
        _backgroundView.height_attr.constant = 202;
        [_backgroundView.top_attr equalTo:self.view.top_attr_safe constant:10];
    }];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.layer.borderColor = UIColorFromRGB(0xe4e4e4).CGColor;
    _backgroundView.layer.borderWidth = 0.5f;
    _backgroundView.layer.cornerRadius = 5.0f;
    
    
    
    [_backgroundView addSubview:[self UIitemINit:1 top:10 image:@"icon-联系人" text:NSLocalizedString(@"联系人：",nil) placeholder:NSLocalizedString(@"请输入姓名",nil) index:1 + 99999]];
    [_backgroundView addSubview:[self UIitemINit:3 top:60.5 image:@"Fill 1" text:NSLocalizedString(@"电话：",nil) placeholder:NSLocalizedString(@"输入电话号码",nil) index:2 + 99999]];
    [_backgroundView addSubview:[self UIitemINit:2 top:111 image:@"icon-地址" text:NSLocalizedString(@"地址：",nil) placeholder:NSLocalizedString(@"选择地址",nil) index:3+99999]];
    [_backgroundView addSubview:[self UIitemINit:3 top:161.5 image:@"icon-标签" text:NSLocalizedString(@"标签：",nil) placeholder:NSLocalizedString(@"例如：公司／学校（最多5个字）",nil) index:4 + 99999]];
    UITextField * text =  [self.view viewWithTag:2+99999];
    text.keyboardType =  UIKeyboardTypePhonePad;
    
    UITextField * tagsTextfide =  [self.view viewWithTag:4+99999];

    [tagsTextfide addTarget:self action:@selector(tagsTextBig:) forControlEvents:UIControlEventEditingDidEnd];
    
    UITextField * iphoneTextfide =  [self.view viewWithTag:2+99999];
    
    [iphoneTextfide addTarget:self action:@selector(iphoneTextfideBig:) forControlEvents:UIControlEventEditingChanged];

    
    
    UIButton * saveBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [self.view addSubview: saveBtn];
    [saveBtn activateConstraints:^{
        [saveBtn.top_attr equalTo:_backgroundView.bottom_attr constant:50.5];
        [saveBtn.left_attr equalTo:self.view.left_attr constant:15];
        [saveBtn.right_attr equalTo:self.view.right_attr constant:-15];
        saveBtn.height_attr.constant = 40;
    }];
    saveBtn.backgroundColor = BlueColor;
    saveBtn.layer.cornerRadius = 20;
    [saveBtn setTitle:NSLocalizedString(@"保存",nil) forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * eitdBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [self.view addSubview: eitdBtn];
    [eitdBtn activateConstraints:^{
        [eitdBtn.top_attr equalTo:saveBtn.bottom_attr constant:10];
        [eitdBtn.left_attr equalTo:self.view.left_attr constant:15];
        [eitdBtn.right_attr equalTo:self.view.right_attr constant:-15];
        eitdBtn.height_attr.constant = 40;
    }];
    eitdBtn.backgroundColor = [UIColor whiteColor];
    eitdBtn.layer.borderColor = BlueColor.CGColor;
    eitdBtn.layer.borderWidth = 0.5;
    eitdBtn.layer.cornerRadius = 20;
    [eitdBtn setTitle:NSLocalizedString(@"取消",nil) forState:UIControlStateNormal];
    [eitdBtn setTitleColor:BlueColor forState:UIControlStateNormal];
    eitdBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 13);
    saveBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 13);
    [eitdBtn addTarget:self action:@selector(notSave:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
    if (_EidtModel) {
        UITextField * tfName = [self.view viewWithTag:1+99999];
        UITextField * tfMobli = [self.view viewWithTag:2+99999];
        UITextField * tfaddress = [self.view viewWithTag:3+99999];
        UITextField * tftag = [self.view viewWithTag:4+99999];
        tfName.text = _EidtModel.contactName;
        tfMobli.text = _EidtModel.contactMobile;
        tfaddress.text = _EidtModel.formattedAddress;
        tftag.text = _EidtModel.tagAlias;
        UIButton * gri = [self.view viewWithTag:211111];
        UIButton * boy = [self.view viewWithTag:1 + 211111];
        _longitude = _EidtModel.longitude;
        _latitude = _EidtModel.latitude;
        _adcode = _EidtModel.areaId;
        if (_EidtModel.contactGender.integerValue == 0) {
            gri.selected = YES;
            boy.selected = NO;
            _tmpBtn = gri;
        } else
        {
            gri.selected = NO;
            boy.selected = YES;
            _tmpBtn = boy;
        }
    }
}
- (void)tagsTextBig:(UITextField *)text
{
    if (text.tag == 4 + 99999) {
        if (text.text.length > 4) {
            text.text = [text.text substringWithRange:NSMakeRange(0, 4)];
        }
    }
    
}
- (void)iphoneTextfideBig:(UITextField *)text
{
    if (text.tag == 2 + 99999) {
        if (text.text.length > 11) {
            text.text = [text.text substringWithRange:NSMakeRange(0, 11)];
        }
    }
}
- (UIView *)UIitemINit:(NSInteger)typ top:(CGFloat)topY image:(NSString *)imageName text:(NSString *)texts placeholder:(NSString *)placeholderText index:(NSInteger)tag
{
    UIView * bloackGrou = [[UIView alloc]init];
    [self.view addSubview: bloackGrou];
    [bloackGrou activateConstraints:^{
        [bloackGrou.left_attr equalTo:self.view.left_attr constant:15];
        [bloackGrou.right_attr equalTo:self.view.right_attr constant:-15];
        bloackGrou.height_attr.constant = 50.5;
        [bloackGrou.top_attr equalTo:self.view.top_attr_safe constant:topY];
    }];
    bloackGrou.backgroundColor = [UIColor whiteColor];
    bloackGrou.layer.borderColor = UIColorFromRGB(0xe4e4e4).CGColor;
    bloackGrou.layer.borderWidth = 0.5f;
    bloackGrou.layer.cornerRadius = 5.0f;
    
    
    UIImageView * userImage = [[UIImageView alloc]init];
//    userImage.backgroundColor = [UIColor redColor];
    userImage.image = [UIImage imageNamed:imageName];
    [bloackGrou addSubview:userImage];
    [userImage activateConstraints:^{
        [userImage.top_attr equalTo:bloackGrou.top_attr constant:17.5];
        [userImage.left_attr equalTo:bloackGrou.left_attr constant:25];
        userImage.height_attr.constant = 16;
        userImage.width_attr.constant = 15;
    }];
    
    UILabel * userLabel = [[UILabel alloc]init];
    [bloackGrou addSubview:userLabel];
    userLabel.text = texts;
    userLabel.textColor = TextGrayColor;
    userLabel.font = fontStely(@"PingFangSC-Regular", 12);
    userLabel.textAlignment = NSTextAlignmentLeft;
    [userLabel activateConstraints:^{
        [userLabel.left_attr equalTo:userImage.right_attr constant:10];
        [userLabel.top_attr equalTo:bloackGrou.top_attr constant:17.5f];
        userLabel.height_attr.constant = 15;
        userLabel.width_attr.constant = 48;
    }];
    
    UITextField * userTextFieled = [[UITextField alloc]init];
    [bloackGrou addSubview:userTextFieled];
    userTextFieled.placeholder = placeholderText;
    userTextFieled.textColor = TextColor;
    userTextFieled.font = fontStely(@"PingFangSC-Regular", 12);
    userTextFieled.textAlignment = NSTextAlignmentLeft;
    [userTextFieled activateConstraints:^{
        [userTextFieled.left_attr equalTo:userLabel.right_attr constant:0];
        [userTextFieled.top_attr equalTo:bloackGrou.top_attr constant:0];
        userTextFieled.height_attr.constant = 50.5f;
        [userTextFieled.right_attr equalTo:bloackGrou.right_attr constant:-78];
    }];
    userTextFieled.delegate  = self;
    userTextFieled.tag = tag;
    if (typ == 2) {
        self.texfield = userTextFieled;
    }
    if (typ == 1) {
        
        UIButton * ladyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ladyBtn setTitle:NSLocalizedString(@"女士",nil) forState:UIControlStateNormal];
        [ladyBtn setTitleColor:DD_RedColor forState:UIControlStateSelected];
        [ladyBtn setTitleColor:TextColor forState:UIControlStateNormal];
        ladyBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
        [bloackGrou addSubview:ladyBtn];
        [ladyBtn activateConstraints:^{
            [ladyBtn.right_attr equalTo:bloackGrou.right_attr constant:-38.5];
            [ladyBtn.left_attr equalTo:userTextFieled.right_attr constant:10];
            [ladyBtn.top_attr equalTo:bloackGrou.top_attr constant:0];
            ladyBtn.height_attr.constant = 50.5f;
        }];
        ladyBtn.tag = 211111;

        
        UIButton *  misterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [misterBtn setTitle:NSLocalizedString(@"先生",nil) forState:UIControlStateNormal];
        [misterBtn setTitleColor:DD_RedColor forState:UIControlStateSelected];
        [misterBtn setTitleColor:TextColor forState:UIControlStateNormal];
        misterBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
        [bloackGrou addSubview:misterBtn];
        [misterBtn activateConstraints:^{
            [misterBtn.right_attr equalTo:bloackGrou.right_attr constant:-9.5];
            [misterBtn.left_attr equalTo:ladyBtn.right_attr constant:0];
            [misterBtn.top_attr equalTo:bloackGrou.top_attr constant:0];
            misterBtn.height_attr.constant = 50.5f;
        }];
        misterBtn.tag = 1 + 211111;
        
        [misterBtn addTarget:self action:@selector(ActionGender:) forControlEvents:UIControlEventTouchUpInside];
        [ladyBtn addTarget:self action:@selector(ActionGender:) forControlEvents:UIControlEventTouchUpInside];
        ladyBtn.selected = YES;
        _tmpBtn = ladyBtn;
        
    } else if (typ == 2)
    {
        userTextFieled.tintColor = [UIColor clearColor];
        UIImageView * imageAr = [[UIImageView alloc] init];
        imageAr.image = [UIImage imageNamed:@"Imported Layers Copy"];
        [bloackGrou addSubview:imageAr];
        [imageAr activateConstraints:^{

            [imageAr.right_attr equalTo:bloackGrou.right_attr constant:-9.5];
            imageAr.height_attr.constant = 9.0f;
            imageAr.width_attr.constant = 5.0f;
            imageAr.centerY_attr =bloackGrou.centerY_attr;
        }];
        
    } else
    {
        
    }
    return bloackGrou;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 3 + 99999) {
        [textField resignFirstResponder];
        MakeSureLocationViewController * VC = [[MakeSureLocationViewController alloc]init];
        VC.block = ^(NSString *address, NSString *adCode, NSString *latitude, NSString *longitude) {
            _longitude = longitude;
            _latitude = latitude;
            _adcode = adCode;
//            UITextField * Field = [self.view viewWithTag:3+99999];
            textField.text = address;
            NSLog(@"%@",address);
        };
        [self.navigationController pushViewController:VC animated:YES];
        
        return NO;
    }
    return YES;
}

- (void)ActionGender:(UIButton *)btn
{
    if (_tmpBtn == nil){
        btn.selected = YES;
        _tmpBtn = btn;
    }
    else if (_tmpBtn !=nil && _tmpBtn == btn){
        btn.selected = YES;
    }else if (_tmpBtn!= btn && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        btn.selected = YES;
        _tmpBtn = btn;
    }
    
    //    [_tableview reloadData];
    
    
}
- (void)addressHttp
{
    [self.view endEditing:YES];

    if ([PattayaTool isNull: [[self.view viewWithTag:1+99999] text]]) {
        return [self showToast:NSLocalizedString(@"请输入姓名",nil)];
    }
    if ([PattayaTool isNull: [[self.view viewWithTag:2+99999] text]]) {
        return [self showToast:NSLocalizedString(@"请输入电话号码",nil)];
    }
    if ([PattayaTool isNull: [[self.view viewWithTag:3+99999] text]]) {
        return [self showToast:NSLocalizedString(@"请选择地址",nil)];
    }
    if ([PattayaTool isNull: [[self.view viewWithTag:4+99999] text]]) {
        return [self showToast:NSLocalizedString(@"请输入标签",nil)];
    }
    NSDictionary * dic;
    if (_EidtModel && ![PattayaTool isNull:_EidtModel.contactName] && ![PattayaTool isNull:_EidtModel.id]) {
        if ([PattayaTool isNull:_adcode]) {
            _adcode = @"310100";
        }
        dic = @{@"areaId":_adcode,@"contactGender":[NSString stringWithFormat:@"%ld",_tmpBtn.tag - 211111],@"contactMobile":[[self.view viewWithTag:2+99999] text],@"contactName":[[self.view viewWithTag:1+99999] text],@"formattedAddress":[[self.view viewWithTag:3+99999] text],@"latitude":_latitude,@"longitude":_longitude,@"tagAlias":[[self.view viewWithTag:4+99999] text],@"id":_EidtModel.id};
        
    } else
    {
        _EidtModel = [[AddressModel alloc] init];
        _EidtModel.areaId =_adcode;
        if ([PattayaTool isNull:_EidtModel.areaId]) {
            _EidtModel.areaId = @"310100";
        }
        _EidtModel.contactGender = [NSString stringWithFormat:@"%ld",_tmpBtn.tag - 211111];
        _EidtModel.contactMobile = [[self.view viewWithTag:2+99999] text];
        _EidtModel.contactName = [[self.view viewWithTag:1+99999] text];
        _EidtModel.formattedAddress = [[self.view viewWithTag:3+99999] text];
        _EidtModel.latitude = _latitude;
        _EidtModel.longitude = _longitude;
        _EidtModel.tagAlias = [[self.view viewWithTag:4+99999] text];


        dic = @{@"areaId":_EidtModel.areaId,@"contactGender":_EidtModel.contactGender,@"contactMobile":_EidtModel.contactMobile,@"contactName":_EidtModel.contactName,@"formattedAddress":_EidtModel.formattedAddress,@"latitude":_EidtModel.latitude,@"longitude":_EidtModel.longitude,@"tagAlias":_EidtModel.tagAlias};
        
    }
 
    [[PattayaUserServer singleton] AddRessRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        if ([ResponseModel isData:ret]) {
            BLOCK_EXEC(self.saveBlock);
            if (_viewcontrollerTpye == 1) {

                for (UIViewController * viewControler in self.navigationController.viewControllers) {
                    if ([viewControler isKindOfClass:[HomeViewController class]]) {
                        HomeViewController * home = (HomeViewController *)viewControler;
                        home.latitude = _EidtModel.latitude;
                        home.longitude = _EidtModel.longitude;
                        home.addressText = _EidtModel.formattedAddress;
                        [home selectedAddressRelod];
                        [self.navigationController popToViewController:viewControler animated:YES];
                    }
                }
            } else
            {
            [self.navigationController popViewControllerAnimated:YES];
            }

        } else
        {
            [self showToast:ret[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)notSave:(UIButton *)btn
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAddress:(UIButton *)btn
{
    [self.view endEditing:YES];

    [self addressHttp];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
