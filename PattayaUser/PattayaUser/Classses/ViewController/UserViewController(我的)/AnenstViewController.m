//
//  AnenstViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/24.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "AnenstViewController.h"
#import "WebHelpViewController.h"
@interface AnenstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView * tableview;
@property (nonatomic, strong) NSMutableArray * arrayText;
@end

@implementation AnenstViewController

- (void)addlistTabelview
{
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self.view addSubview:lineView];
    [lineView activateConstraints:^{
        lineView.height_attr.constant = 1;
        [lineView.top_attr equalTo:self.view.top_attr_safe constant:129];
        [lineView.left_attr equalTo:self.view.left_attr constant:16];
        [lineView.right_attr equalTo:self.view.right_attr constant:-16];
    }];
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.scrollEnabled = NO;
    [self.tableview activateConstraints:^{
        [self.tableview.top_attr equalTo: self.view.top_attr constant:130];
        self.tableview.width_attr = self.view.width_attr;
        self.tableview.bottom_attr = self.view.bottom_attr;
    }];
}
- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"关于叮咚打店";
    _arrayText = [NSMutableArray array];
    [_arrayText addObject:@"隐私政策"];
    [_arrayText addObject:@"用户协议"];
    [_arrayText addObject:@"联系客服"];
    UIImageView * imageIocn = [[UIImageView alloc] init];
    imageIocn.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageIocn];
    [imageIocn activateConstraints:^{
        [imageIocn.top_attr equalTo:self.view.top_attr_safe constant:20];
        imageIocn.height_attr.constant = 60;
        imageIocn.width_attr.constant = 60;
        [imageIocn.centerX_attr equalTo:self.view.centerX_attr];
    }];
    imageIocn.image = [UIImage imageNamed:@"iocnAppAnedt.png"];
    
    
    UILabel * labermageBottom = [[UILabel alloc]init];
    [self.view addSubview:labermageBottom];
    [labermageBottom activateConstraints:^{
        [labermageBottom.top_attr equalTo:imageIocn.bottom_attr constant:20];
        labermageBottom.left_attr = self.view.left_attr;
        labermageBottom.right_attr = self.view.right_attr;
    }];
    labermageBottom.font = [UIFont systemFontOfSize:14];
    labermageBottom.textAlignment = NSTextAlignmentCenter;
    labermageBottom.textColor = TextGrayColor;
    labermageBottom.text = @"叮咚打店 Ding Dong 1.0";
    
    
    [self addlistTabelview];
    
    
    UILabel * laberBottom = [[UILabel alloc]init];
    [self.view addSubview:laberBottom];
    [laberBottom activateConstraints:^{
        [laberBottom.bottom_attr equalTo:self.view.bottom_attr_safe constant:-40];
        laberBottom.left_attr = self.view.left_attr;
        laberBottom.right_attr = self.view.right_attr;
    }];
    laberBottom.font = [UIFont systemFontOfSize:14];
    laberBottom.textAlignment = NSTextAlignmentCenter;
    laberBottom.textColor = TextGrayColor;
    laberBottom.numberOfLines = 3;
    laberBottom.text = @"© 2018深兰科技（上海）有限公司 版权所有\nCopyright © 2014-2018 DeepBlue\nAll Rights Reserved.";
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
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
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellanenstview"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCellanenstview"];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 54, SCREEN_Width - 32, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [cell.contentView addSubview:lineView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = TextColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = _arrayText[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * httpArray = @[@"https://www.callstore.cn/policies/user-privacy/",@"https://www.callstore.cn/policies/user-agreements/",@"https://www.callstore.cn/app/contact"];
    WebHelpViewController * vc = [[WebHelpViewController alloc] init];
    vc.httpString = httpArray[indexPath.row];
    vc.title = _arrayText[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
