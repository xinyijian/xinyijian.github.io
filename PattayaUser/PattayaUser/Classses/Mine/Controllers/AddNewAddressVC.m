//
//  AddNewAddressVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AddNewAddressVC.h"
#import "AMapAddressViewController.h"

#define TITLES @[@"联系人",@"",@"电话",@"地址",@"门牌号",@"标签"]
#define SEXTITLES @[@"先生",@"女士"]
#define TYPETITLES @[@"家",@"公司",@"学校"]


@interface AddNewAddressVC ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *nameTF;
@property(nonatomic, strong)UITextField *phoneTF;

@property(nonatomic, strong)UIButton *currentSexBT;
@property(nonatomic, strong)UIButton *currentTypeBT;
@property(nonatomic, strong)UILabel *addressLabel;

@property(nonatomic, strong)UILabel *houseNumberLabel;

@property (nonatomic,strong) UIButton * saveBT;//保存


@end

@implementation AddNewAddressVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

-(void)setupUI{
    [super setupUI];
    self.navigationItem.title = @"新增地址";
}

#pragma <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 112;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = App_TotalGrayWhite;
    UIView *whiteBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 34)];
    whiteBg.backgroundColor = UIColorWhite;
    [footerView addSubview:whiteBg];
    
    
    //提交
    _saveBT = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBT.frame = CGRectMake((SCREEN_Width-250)/2, 74, 250, 38);
    [_saveBT setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBT addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [_saveBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _saveBT.backgroundColor = App_Nav_BarDefalutColor;
    _saveBT.layer.cornerRadius = 19;
    _saveBT.layer.masksToBounds = YES;
    [footerView addSubview:_saveBT];
    
    
    return footerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = TITLES[indexPath.row];
    cell.textLabel.font = K_LABEL_SMALL_FONT_14;
    cell.textLabel.textColor = TextColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0) {
       
        //修改姓名
        self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(85), 18, 200, 20)];
        self.nameTF.returnKeyType = UIReturnKeyDone;
        self.nameTF.textColor = TextColor;
        self.nameTF.placeholder = @"姓名";
        self.nameTF.font = [UIFont systemFontOfSize:14];
        self.nameTF.delegate = self;
        //self.nameTF.textAlignment = 2;
        //self.nick.text = [self.personInfoDic objectForKey:@"nname"];
        [cell.contentView addSubview:self.nameTF];
        
    }
    
    if (indexPath.row == 1){
        
        for (int i=0; i<2; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(85)+i*(68+10), 14, 68, 28)];
            [btn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"label_bg_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"label_bg_selected"] forState:UIControlStateSelected];
            [btn setTitle:SEXTITLES[i] forState:UIControlStateNormal];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];
            btn.titleLabel.font = K_LABEL_SMALL_FONT_14;
            [cell.contentView addSubview:btn];
            btn.tag = i + 98000;
        }
       
    }
    
    if (indexPath.row == 2) {
        
        //电话
        self.phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(85), 18, 200, 20)];
        self.phoneTF.returnKeyType = UIReturnKeyDone;
        self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        self.phoneTF.textColor = TextColor;
        self.phoneTF.placeholder = @"手机号码";
        self.phoneTF.font = [UIFont systemFontOfSize:14];
        self.phoneTF.delegate = self;
        //self.nameTF.textAlignment = 2;
        //self.nick.text = [self.personInfoDic objectForKey:@"nname"];
        [cell.contentView addSubview:self.phoneTF];
        
        
    }
    
    if (indexPath.row == 3) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(85), 18, 200, 20)];
        _addressLabel.text = @"深兰人工智能大厦";
        _addressLabel.textColor = TextColor;
        _addressLabel.font = K_LABEL_SMALL_FONT_14;
        [cell.contentView addSubview:_addressLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 4) {
        _houseNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(85), 18, 200, 20)];
        _houseNumberLabel.text = @"03号楼609";
        _houseNumberLabel.textColor = TextColor;
        _houseNumberLabel.font = K_LABEL_SMALL_FONT_14;
        [cell.contentView addSubview:_houseNumberLabel];
        
    }
    
    if (indexPath.row == 5){
        
        for (int i=0; i<3; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(85)+i*(68+10), 14, 68, 28)];
            [btn addTarget:self action:@selector(selectAddressType:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"label_bg_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"label_bg_selected"] forState:UIControlStateSelected];
            [btn setTitle:TYPETITLES[i] forState:UIControlStateNormal];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];
            btn.titleLabel.font = K_LABEL_SMALL_FONT_14;
            [cell.contentView addSubview:btn];

        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 3) {
        NSLog(@"选择地址");
        AMapAddressViewController * amap = [[AMapAddressViewController alloc] init];
        [self.navigationController pushViewController:amap animated:YES];
        
    }
   
}

- (void)saveAddress{
    
    //DOTO
    //没有跳转地图->需要连接一下
    //areaid == 是地图返回的 adcode
    //其他就是address 跟 lat lon
    
    NSDictionary * dic = @{@"areaId":@"310100",@"contactGender":[NSString stringWithFormat:@"%ld",_currentSexBT.tag - 98000],@"contactMobile":_phoneTF.text,@"contactName":_nameTF.text,@"formattedAddress":_addressLabel.text,@"latitude":[PattAmapLocationManager singleton].lat,@"longitude":[PattAmapLocationManager singleton].lng,@"tagAlias":_currentTypeBT.titleLabel.text,@"houseNumber":_houseNumberLabel.text};
//
    [[PattayaUserServer singleton] AddRessRequest:dic Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@,=====",ret);
        if ([ResponseModel isData:ret]) {
            [YDProgressHUD showMessage:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma 选择性别
-(void)selectSex:(UIButton *)btn{
    if (_currentSexBT == nil){
        btn.selected = YES;
        [btn setTitleColor:UIColorWhite forState:UIControlStateNormal];
        _currentSexBT = btn;
    }
    else if (_currentSexBT !=nil && _currentSexBT == btn){
        btn.selected = YES;
        [btn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    }else if (_currentSexBT!= btn && _currentSexBT!=nil){
        _currentSexBT.selected = NO;
        [_currentSexBT setTitleColor:TextColor forState:UIControlStateNormal];
        btn.selected = YES;
        [btn setTitleColor:UIColorWhite forState:UIControlStateNormal];
        _currentSexBT = btn;
    }
    
}

#pragma 选择地址类型
-(void)selectAddressType:(UIButton *)btn{
    btn.selected = YES;
    [btn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    if (_currentTypeBT) {
        _currentTypeBT.selected = NO;
        [_currentTypeBT setTitleColor:TextColor forState:UIControlStateNormal];

    }
    _currentTypeBT = btn;
}

#pragma 保存
-(void)saveClick{
    [self saveAddress];
}

@end
