//
//  SearchVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "SearchVC.h"
#import "newsreelView.h"
#import "HotModel.h"
#import "StoreListCell.h"
@interface SearchVC ()<UITextFieldDelegate>

//导航栏pop按钮
@property (nonatomic, strong) UIButton *backBT;
@property (nonatomic, strong) UIButton *searchBT;
//搜索栏
@property (nonatomic, strong) UITextField *searchTF;

//历史搜索 热门搜索
@property (nonatomic, strong) newsreelView * sreelView;
@property (nonatomic, strong) NSMutableArray  * hotArray;//热门搜索 数组


@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self netRequestData];
}

#pragma mark - 初始化UI
- (void)setupUI{
    
    [super setupUI];
    self.navStyle = NavgationStyleAppTheme;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBT];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBT];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    self.navigationItem.titleView = self.searchTF;
    
    [self.view addSubview:self.sreelView];
}
//网络数据
-(void)netRequestData{
    //热门搜索
    [self hotHttp];
}
//热门搜索
- (void)hotHttp
{
    [[PattayaUserServer singleton] HotRequestSuccess:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
        NSLog(@"%@",ret);
        _hotArray = [NSMutableArray array];
        if ([ResponseModel isData:ret]) {
            HotListModel * mode = [[HotListModel alloc] initWithDictionary:ret error:nil];
            if (mode.data.count >=15) {
                [_hotArray addObjectsFromArray: [mode.data subarrayWithRange:NSMakeRange(0, 15)]];
            } else
            {
                [_hotArray addObjectsFromArray:mode.data];
            }
            NSMutableArray * arr = [NSMutableArray array];
            for (int i = 0; i < _hotArray.count; i++) {
                HotModel * mode = _hotArray[i];
                [arr addObject:mode.key];
            }
            _sreelView.arrayHotText = arr;
        } else
        {
           // [self showToast:ret[@"message"]];
            [YDProgressHUD showHUD:ret[@"message"]];

            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark - 导航栏pop按钮
-(UIButton*)backBT{
    if (!_backBT) {
        
        _backBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBT addTarget:self action:@selector(navgationPopClick) forControlEvents:UIControlEventTouchUpInside];
        [_backBT setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateNormal];
        [_backBT setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateHighlighted];
    }
    return _backBT;
}

-(UIButton*)searchBT{
    if (!_searchBT) {
        
        _searchBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBT addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [_searchBT setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBT setTitleColor:App_Nav_BarDefalutColor forState:UIControlStateNormal];
        _searchBT.titleLabel.font = K_LABEL_SMALL_FONT_14;
    }
    return _searchBT;
}

-(void)searchClick{
   
    NSLog(@"点击搜索按钮");
    self.sreelView.hidden = YES;
    [self loadText:self.searchTF.text];
}


- (void)loadText:(NSString *)seachTxt
{
    if (seachTxt.length == 0) {
        return;
    }
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


-(UITextField*)searchTF{
    if (!_searchTF) {
        _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width-60, 28)];
        _searchTF.delegate = self;
        UIView * leftView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 32, 28)];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(9, 7, 14, 14)];
        imageView.image=[UIImage imageNamed:@"search"];
        [leftView addSubview:imageView];
        _searchTF.leftView = leftView;
        _searchTF.leftViewMode = UITextFieldViewModeAlways;
//        _seachView.returnKeyType = UIReturnKeySearch;
        _searchTF.layer.cornerRadius = 4.0f;
        _searchTF.layer.masksToBounds = YES;
        _searchTF.backgroundColor = UIColorFromRGB(0xf5f5f5);
        _searchTF.placeholder = @"搜索商家、美食";
        _searchTF.font = fontStely(@"PingFangSC-Regular", 14);
        _searchTF.tintColor = App_Nav_BarDefalutColor;
       // [_searchTF addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchTF;
}

//_sreelView = [[newsreelView alloc]init];
//_sreelView.backgroundColor = [UIColor whiteColor];
//[self.view addSubview:_sreelView];
-(newsreelView *)sreelView{
    if (!_sreelView) {
        _sreelView = [[newsreelView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_Width, SCREEN_Height - TopBarHeight - SafeAreaBottomHeight - 10)];
    }
    _sreelView.backgroundColor = [UIColor whiteColor];
    return _sreelView;
}

-(void)navgationPopClick{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - tableView datasource && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return IgnoreHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *listCell = @"StoreListCell";
    StoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    if (!cell) {
        cell = [[StoreListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0 );
        
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
