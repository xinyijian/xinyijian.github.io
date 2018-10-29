//
//  DeveloperViewController.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/11.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "DeveloperViewController.h"

@interface DeveloperViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView * tableviews;
@property (nonatomic, strong) NSMutableArray * httpArray;
@property (nonatomic, strong) NSMutableArray * addressArray;
@property (nonatomic, strong) UILabel * lalonMAmapView;

@end

@implementation DeveloperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"开发者选项";
    [self addlistTabelview];
    _httpArray = [NSMutableArray array];
    _addressArray = [NSMutableArray array];
 
    [_httpArray addObject:[NSString stringWithFormat:@"开发环境(%@)",APP_DEV_URL]];
    [_httpArray addObject:[NSString stringWithFormat:@"Test(%@)",APP_TEST_URL]];
    [_addressArray addObject:APP_DEV_URL];
    [_addressArray addObject:APP_TEST_URL];
    UITextField * textf = [[UITextField alloc] init];
    [self.view addSubview:textf];
    textf.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [textf activateConstraints:^{
        textf.top_attr = self.view.top_attr;
        textf.width_attr = self.view.width_attr;
        textf.height_attr.constant = 40;;
    }];
    textf.delegate = self;
    [textf addTarget:self action:@selector(addHttpAddress:) forControlEvents:UIControlEventEditingDidEnd];
    
    [PattAmapLocationManager singleton].isNowlocationBlock = ^(CLLocation *location, NSString *address) {
        _lalonMAmapView.text = [NSString stringWithFormat:@"%@==%@",[NSString stringWithFormat:@"%f",location.coordinate.latitude],[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
    };
    _lalonMAmapView = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, 200, 30)];
    [self.view addSubview:_lalonMAmapView];
    _lalonMAmapView.backgroundColor = [UIColor cyanColor];
    
    // Do any additional setup after loading the view.
}
- (void)addHttpAddress:(UITextField *)text
{
    [_httpArray addObject:[NSString stringWithFormat:@"+新加(%@)",text.text]];
    [_addressArray addObject:text.text];
    [_tableviews reloadData];
}
- (void)addlistTabelview
{
    self.tableviews.backgroundColor = [UIColor whiteColor];
    self.tableviews.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableviews activateConstraints:^{
        [self.tableviews.top_attr equalTo: self.view.top_attr constant:40];
        self.tableviews.width_attr = self.view.width_attr;
        self.tableviews.bottom_attr = self.view.bottom_attr;
    }];

}
- (UITableView *)tableviews
{
    if (_tableviews == nil) {
        _tableviews = [[UITableView alloc] init];
        _tableviews.delegate = self;
        _tableviews.dataSource = self;
        [self.view addSubview:_tableviews];
    }
    return _tableviews;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _httpArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellDeveloper"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellDeveloper"];
    }
        cell.textLabel.text = _httpArray[indexPath.row];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        PTLAlertView * aler = [[PTLAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"确定把%@替换成%@",APP_BASE_URL,_addressArray[indexPath.row]] cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
    aler.selctBtnBlock = ^(NSInteger tag, NSString * st) {
        if (tag == 0) {
            APP_BASE_URL = _addressArray[indexPath.row];
            BLOCK_EXEC(_devBlock);
        }
    };
  
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
