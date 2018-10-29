//
//  DD_SeachbarView.m
//  PattayaUser
//
//  Created by 明克 on 2018/1/31.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "DD_SeachbarView.h"
@interface DD_SeachbarView ()<UITextFieldDelegate>
{
    UIButton * locationBtn;
}
@end
@implementation DD_SeachbarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  [self initUI];
    }
    
    return self;
}
- (void)locationView
{
    _seachView = [[UITextField alloc] init];
    [self addSubview:_seachView];
    _seachView.delegate = self;
    _seachView.leftViewMode = UITextFieldViewModeAlways;
    _seachView.returnKeyType = UIReturnKeySearch;
    [_seachView activateConstraints:^{
        
        [_seachView.bottom_attr equalTo:self.bottom_attr constant:-8];
        [_seachView.left_attr equalTo:self.left_attr constant:15];
        _seachView.height_attr.constant = 29.0f;
        [_seachView.right_attr equalTo:self.right_attr constant:-107];
        
    }];
    _seachView.layer.cornerRadius = 29.0f / 2.0f;
    _seachView.backgroundColor = UIColor.whiteColor;
//    _seachView.placeholder = NSLocalizedString(@"输入商品名称",nil);
    _seachView.font = fontStely(@"PingFangSC-Regular", 12);
    [_seachView addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];

    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 83, 29)];
    //    leftView.backgroundColor = [UIColor greenColor];
    leftView.layer.cornerRadius = 29.0f / 2.0f;
    
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.frame = CGRectMake(0, 0, 70, 29);
    //    [locationBtn setTitle:@"上海" forState:UIControlStateNormal];
    [locationBtn setTitleColor:TextColor forState:UIControlStateNormal];
    [locationBtn setImage:[UIImage imageNamed:@"icon-下拉"] forState:UIControlStateNormal];
//    [locationBtn setImage:[UIImage imageNamed:@"packup"] forState:UIControlStateSelected];
    locationBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [leftView addSubview:locationBtn];
    locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [locationBtn addTarget:self action:@selector(locationClinke:) forControlEvents:UIControlEventTouchUpInside];
    UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(70, 7.5, 1, 14.5)];
    lineview.backgroundColor =LineColor;
    [leftView addSubview:lineview];
    
    _seachView.leftView = leftView;
    
    UIButton * addlocationView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: addlocationView];
    [addlocationView setTitle:NSLocalizedString(@"新增地址",nil) forState:UIControlStateNormal];
    addlocationView.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [addlocationView activateConstraints:^{
        [addlocationView.bottom_attr equalTo:self.bottom_attr constant:-8];
        [addlocationView.left_attr equalTo:_seachView.right_attr constant:10];
        addlocationView.height_attr.constant = 28;
        [addlocationView.right_attr equalTo:self.right_attr constant:-49];
    }];
    [addlocationView addTarget:self action:@selector(loactionClike:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backBtn];
    //    backBtn.backgroundColor = UIColor.redColor;
    [backBtn setTitle:NSLocalizedString(@"取消",nil) forState:UIControlStateNormal];
    backBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [backBtn activateConstraints:^{
        [backBtn.bottom_attr equalTo:self.bottom_attr constant:-8];
        [backBtn.left_attr equalTo:addlocationView.right_attr constant:0];
        backBtn.height_attr.constant = 28;
        [backBtn.right_attr equalTo:self.right_attr constant:0];
    }];
    
    [backBtn addTarget:self action:@selector(backClinke:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)seachAddressView
{
    _seachView = [[UITextField alloc] init];
    [self addSubview:_seachView];
    _seachView.delegate = self;
    _seachView.leftViewMode = UITextFieldViewModeAlways;
    _seachView.returnKeyType = UIReturnKeySearch;
    [_seachView activateConstraints:^{
        
        [_seachView.bottom_attr equalTo:self.bottom_attr constant:-8];
        [_seachView.left_attr equalTo:self.left_attr constant:15];
        _seachView.height_attr.constant = 29.0f;
        [_seachView.right_attr equalTo:self.right_attr constant:-107];
        
    }];
    _seachView.layer.cornerRadius = 29.0f / 2.0f;
    _seachView.backgroundColor = UIColor.whiteColor;
//    _seachView.placeholder = NSLocalizedString(@"输入商品名称",nil);
    _seachView.font = fontStely(@"PingFangSC-Regular", 12);
    [_seachView addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];

    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 83, 29)];
    //    leftView.backgroundColor = [UIColor greenColor];
    leftView.layer.cornerRadius = 29.0f / 2.0f;
    
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.frame = CGRectMake(0, 0, 70, 29);
//    [locationBtn setTitle:@"上海" forState:UIControlStateNormal];
    [locationBtn setTitleColor:TextColor forState:UIControlStateNormal];
    [locationBtn setImage:[UIImage imageNamed:@"icon-下拉"] forState:UIControlStateNormal];
//    [locationBtn setImage:[UIImage imageNamed:@"packup"] forState:UIControlStateSelected];
    locationBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [leftView addSubview:locationBtn];
    locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [locationBtn addTarget:self action:@selector(locationClinke:) forControlEvents:UIControlEventTouchUpInside];
    UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(70, 7.5, 1, 14.5)];
    lineview.backgroundColor =LineColor;
    [leftView addSubview:lineview];
    
    _seachView.leftView = leftView;
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backBtn];
    //    backBtn.backgroundColor = UIColor.redColor;
    [backBtn setTitle:NSLocalizedString(@"取消",nil) forState:UIControlStateNormal];
    backBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [backBtn activateConstraints:^{
        [backBtn.bottom_attr equalTo:self.bottom_attr constant:-8];
        [backBtn.left_attr equalTo:_seachView.right_attr constant:10];
        backBtn.height_attr.constant = 28;
        [backBtn.right_attr equalTo:self.right_attr constant:0];
    }];
    
    [backBtn addTarget:self action:@selector(backClinke:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initUI{
    _seachView = [[UITextField alloc] init];
    [self addSubview:_seachView];
    _seachView.delegate = self;
    _seachView.leftViewMode = UITextFieldViewModeAlways;
    _seachView.returnKeyType = UIReturnKeySearch;
    [_seachView activateConstraints:^{
        
        [_seachView.bottom_attr equalTo:self.bottom_attr constant:-8];
        [_seachView.left_attr equalTo:self.left_attr constant:15];
        _seachView.height_attr.constant = 29.0f;
        [_seachView.right_attr equalTo:self.right_attr constant:-51];
        
    }];
    _seachView.layer.cornerRadius = 29.0f / 2.0f;
    _seachView.backgroundColor = UIColor.whiteColor;
    _seachView.placeholder = NSLocalizedString(@"输入商品名称",nil);
    _seachView.font = fontStely(@"PingFangSC-Regular", 12);
    [_seachView addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];

    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 83, 29)];
    //    leftView.backgroundColor = [UIColor greenColor];
    leftView.layer.cornerRadius = 29.0f / 2.0f;
    
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.frame = CGRectMake(0, 0, 70, 29);
//    [locationBtn setTitle:@"上海" forState:UIControlStateNormal];
    [locationBtn setTitleColor:TextColor forState:UIControlStateNormal];
    [locationBtn setImage:[UIImage imageNamed:@"icon-下拉"] forState:UIControlStateNormal];
//    [locationBtn setImage:[UIImage imageNamed:@"packup"] forState:UIControlStateSelected];
    locationBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [leftView addSubview:locationBtn];
    locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [locationBtn addTarget:self action:@selector(locationClinke:) forControlEvents:UIControlEventTouchUpInside];
    UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(70, 7.5, 1, 14.5)];
    lineview.backgroundColor =LineColor;
    [leftView addSubview:lineview];
    
    _seachView.leftView = leftView;
    
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backBtn];
    //    backBtn.backgroundColor = UIColor.redColor;
    [backBtn setTitle:NSLocalizedString(@"取消",nil) forState:UIControlStateNormal];
    backBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 12);
    [backBtn activateConstraints:^{
        [backBtn.bottom_attr equalTo:self.bottom_attr constant:-8];
        [backBtn.left_attr equalTo:_seachView.right_attr constant:0];
        backBtn.height_attr.constant = 28;
        [backBtn.right_attr equalTo:self.right_attr constant:0];
    }];
    
    [backBtn addTarget:self action:@selector(backClinke:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    if (cityName) {
        
        [locationBtn setTitle:cityName forState:UIControlStateNormal];
    }
}

- (void)locationClinke:(UIButton *)btn
{
    //    btn.selected = !btn.selected;
    //    NSArray * array = [NSArray array];
    NSLog(@"搜索 右边城市 按钮点击");
    [self.DD_delegate locationClinkeCityName:btn.titleLabel.text];
    //     [JMDropMenu showDropMenuFrame:CGRectMake(15, 64, 70, 130) ArrowOffset:35.f TitleArr:@[@"上海",@"杭州",@"北京"] ImageArr:array Type:JMDropMenuTypeQQ LayoutType:JMDropMenuLayoutTypeTitle RowHeight:40.f Delegate:self];
}
//- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
//    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
//    [locationBtn setTitle:title forState:UIControlStateNormal];
//
//}

- (void)backClinke:(UIButton *)btn
{
    [self.DD_delegate back];
    
}


- (void)textValueChanged
{
    
//    [self.DD_delegate changText:_seachView.text];

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([PattayaTool isNull:textField.text] ) {
        return NO;
    }
    [_seachView resignFirstResponder];
    NSLog(@"点击搜索按钮");
    [self loadText:textField.text];
    [self.DD_delegate changText:textField.text];
    return YES;
}

- (void)loadText:(NSString *)seachTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:@"myArray"]];
    
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [NSMutableArray array];
    searTXT = [myArray mutableCopy];
    
    BOOL isEqualTo1,isEqualTo2;
    isEqualTo1 = NO;
    isEqualTo2 = NO;
    
    if (searTXT.count > 0) {
        isEqualTo2 = YES;
        //判断搜索内容是否存在，存在的话放到数组最后一位，不存在的话添加。
        for (NSString * str in myArray) {
            if ([seachTxt isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [myArray indexOfObject:seachTxt];
                [searTXT removeObjectAtIndex:index];
                [searTXT addObject:seachTxt];
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    if (!isEqualTo1 || !isEqualTo2) {
        [searTXT addObject:seachTxt];
    }
    
    if(searTXT.count > 10)
    {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"myArray"];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"text = %@ , rangs = %@",textField.text,string);
    if ([string isEqualToString:@""] && range.location == 0) {
        [self.DD_delegate closeText];
    } else
    {
        ////按需求来是即使搜索,还是按seach
        //  [self.DD_delegate changText:[_seachView.text stringByAppendingString:string]];
    }
    return YES;
}

- (void)loactionClike:(UIButton *)btn
{
    NSLog(@"点击新增地址");
    [self.DD_delegate addressCliket];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
