//
//  ShopHomePageView.m
//  AppPark
//
//  Created by 池康 on 2018/7/10.
//

#import "ShopHomePageView.h"
#import "TakeawayProductListCell.h"//店铺主页列表样式

#import "NewShopListModel.h"

#define  takeawayLeft_W   KScreenWidth * (80.0/375)
#define  takeawayRight_W  KScreenWidth * (295.0/375)

@interface ShopHomePageView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    NSInteger _leftIndex;//左边被选中的索引值
    
    NSMutableArray *_dataArray;
    NSInteger _maxOffset_Y;
    
    BOOL  _gestureEnd;//手势是否已经结束
    
    UIScrollView *_currentSubView;
    
    BOOL _isSelectSlide;//是点击leftTableView，还是拖拽右边的滑动视图
}
@property (nonatomic , strong) NSMutableArray *titlesAry;
/// 添加的商品数据
@property (nonatomic,strong) NSMutableArray *addOrderList;
/// 商品数据
@property (nonatomic,strong) NSArray *productList;

@end

@implementation ShopHomePageView

/// 存放用户添加到购物车的商品数组
-(NSMutableArray *)addOrderList
{
    if (!_addOrderList) {
        _addOrderList = [NSMutableArray new];
    }
    return _addOrderList;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = App_TotalGrayWhite;
        _leftIndex = 0;
        _dataArray = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gestureStateBegan:) name:@"GestureRecognizerStateBegan" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gestureStateEnd:) name:@"GestureRecognizerStateEnded" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bottomShoppingCartMethod:) name:@"bottomShopCartOffsetY" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRightTableView) name:@"reloadRightTableView" object:nil];

    }
    return self;
}

#pragma mark ---通知方法
//清空刷新
-(void)reloadRightTableView{
    [self.rightTabView reloadData];
    
}

- (void)gestureStateBegan:(NSNotification *)not{
    
    BOOL isMore = _currentSubView.contentOffset.y >= (_currentSubView.contentSize.height - _currentSubView.height);
    if (isMore) {
        _gestureEnd = NO;
    }
    //手动拖拽
    _isSelectSlide = NO;
}

- (void)gestureStateEnd:(NSNotification *)not{
    //    手势已经结束
    BOOL isMore = _currentSubView.contentOffset.y > (_currentSubView.contentSize.height - _currentSubView.height);
    if (isMore) {
        //如果滑动的偏移量超出最大的内容范围
        CGFloat between = _currentSubView.contentOffset.y - (_currentSubView.contentSize.height - _currentSubView.height);
        if (between >= 70) {
            _gestureEnd = YES;
        }
    }
}

//底部购物车，暂时隐藏
- (void)bottomShoppingCartMethod:(NSNotification *)not
{
    NSDictionary *dic = not.userInfo;
    CGFloat offsetY = [dic[@"offsetY"] floatValue];
}
////底部购物车视图
//- (void)createBottonView
//{
//    _shopCarView = [[ShoppingCartBottonView alloc]initWithFrame:CGRectMake(0, self.height-49-30 - _maxOffset_Y, kScreenWidth, 49+30) inView:nil];
//    _shopCarView.delegate = self;
//    [self addSubview:_shopCarView];
//}

#pragma mark - get/set方法
- (void)setShopModel:(NewShopModel *)shopModel{
    _shopModel = shopModel;
//    _titlesAry = _shopModel.sortInfo;
//    NSArray *activityList = _shopModel.activityList;
//    if (activityList.count > 0) {
//        _maxOffset_Y = (Size(150) + 48 - kDefaultNavBarHeight);
//    }else{
//        _maxOffset_Y = (Size(150) + 48 - kDefaultNavBarHeight - 28);
//    }
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 37)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(12, 14.5, 2, 8)];
    line.backgroundColor = UIColorFromRGB(0x4A4A4A);
    [bgView addSubview:line];
    
    UILabel *titleLab =  [[UILabel alloc]initWithFrame:CGRectMake(line.YD_x+8,0, 200, 37)];
    titleLab.font = fontStely(@"PingFangSC", 16);
    titleLab.textColor = TextColor;
           // NSDictionary *dic = _titlesAry[section];
    titleLab.text = @"在售商品";//dic[@"name"]
    [bgView addSubview:titleLab];
    
    _maxOffset_Y = ShopHeadH;
    [self createView];
    
    _currentSubView = [self currentScorllView];
}

#pragma mark - 创建视图
- (void)createView
{
    self.leftTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 38,takeawayLeft_W, self.height-_maxOffset_Y-38 - BottomH) style:UITableViewStyleGrouped];
    self.leftTabView.dataSource = self;
    self.leftTabView.delegate = self;
    self.leftTabView.backgroundColor = UIColorFromRGB(0xF4F4F4);
    self.leftTabView.tableFooterView = [UIView new];
    self.leftTabView.separatorColor = UIColorFromRGB(0xF4F4F4);
    self.leftTabView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.leftTabView];
    
//    UILabel *line = [UITool lineLabWithFrame:CGRectMake(takeawayLeft_W-0.5, 0, 0.5, self.height)];
//    line.backgroundColor = kColor_bgHeaderViewColor;
//    [self.leftTabView addSubview:line];
    [self createRightTableView];
    
}

- (void)createRightTableView
{
    self.rightTabView = [[UITableView alloc]initWithFrame:CGRectMake(takeawayLeft_W, 38,takeawayRight_W, self.height-38 - BottomH) style:UITableViewStylePlain];
    self.rightTabView.dataSource = self;
    self.rightTabView.delegate = self;
    self.rightTabView.backgroundColor = [UIColor whiteColor];
    self.rightTabView.tableFooterView = [UIView new];
    self.rightTabView.separatorColor = [UIColor whiteColor];
    self.rightTabView.showsVerticalScrollIndicator = NO;
    self.rightTabView.scrollEnabled = NO;
    [self addSubview:self.rightTabView];
}


- (void)superScrollViewDidScrollOffset:(CGFloat)offset
{
    if (offset <= _maxOffset_Y) {
        _leftTabView.mj_h = self.height-_maxOffset_Y + offset;
    }
}

#pragma mark - ThrowLineToolDelegate methods
/// 抛物线结束动画回调
- (void)animationDidFinish
{
    
}

#pragma mark - FSBaseTableViewDataSource & FSBaseTableViewDelegate  委托方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.leftTabView) {
        return 1;
    }
    return _shopModel.titleArray.count;//_titlesAry.count
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTabView) {
        return _shopModel.titleArray.count;//_titlesAry.count
    }
    NSArray *arr = _shopModel.productArray[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTabView) {
        return 44;
    }else{
        
        return 110;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (_rightTabView == tableView) {
//        return 30;
//    }else{
//        return 0.01;
//    }
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //最后一个
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    if (tableView == _leftTabView) {
        bgView.backgroundColor = UIColorFromRGB(0xF4F4F4);
    }
    return bgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (tableView == _rightTabView) {
//        UIView *bgView = [[UIView alloc]init];
//        bgView.backgroundColor = [UIColor whiteColor];
//
//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 1, 14)];
//       // [UITool lineLabWithFrame:CGRectMake(10, 10, 1, 14)];
//        line.backgroundColor = UIColorFromRGB(0xFF5A49);
//        [bgView addSubview:line];
//
//        UILabel *titleLab =  [[UILabel alloc]initWithFrame:CGRectMake(line.YD_x+7,0, 200, 34)];
//        titleLab.font = K_LABEL_SMALL_FONT_12;
////        [UITool createLabelWithFrame:CGRectMake(line.maxX+7,0, 200, 34) backgroundColor:[UIColor clearColor] textColor:kColor_GrayColor textSize:12 alignment:NSTextAlignmentLeft lines:1];
//        NSDictionary *dic = _titlesAry[section];
//        titleLab.text = @"蔬菜";//dic[@"name"]
//        [bgView addSubview:titleLab];
//
//        return bgView;
//    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTabView) {
        static NSString *reuseID = @"leftCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, takeawayLeft_W, 50)];
            titleLab.font = K_LABEL_SMALL_FONT_12;
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.textColor = TextColor;
//            [UITool createLabelWithFrame:CGRectMake(0,0, takeawayLeft_W, 50) backgroundColor:[UIColor clearColor] textColor:kColor_darkBlackColor textSize:13 alignment:NSTextAlignmentCenter lines:1];
            titleLab.tag = 10;
            [cell.contentView addSubview:titleLab];
            
            UIView *selectView = [[UIView alloc]initWithFrame:cell.frame];
            selectView.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = selectView;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0 );
        }
        UILabel *titleLab = [cell.contentView viewWithTag:10];
        NSDictionary *dic = _titlesAry[indexPath.row];
        titleLab.text = _shopModel.titleArray[indexPath.row];//dic[@"name"]
        if (indexPath.row == _leftIndex) {
            [_leftTabView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        cell.backgroundColor = UIColorFromRGB(0xF5F5F5);
        return cell;
        
    }else
    {
        
        static NSString *listCell = @"listCell1";
        TakeawayProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
        if (!cell) {
            cell = [[TakeawayProductListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0 );
        }
         NewShopListModel *model = _shopModel.productArray[indexPath.section][indexPath.row];
         cell.productModel = model;
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTabView == tableView) {
        //选中_leftTabView而不是拖拽右边的滑动视图
        _isSelectSlide = YES;
        [_rightTabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTabView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        
        _leftIndex = indexPath.row;
    }else{
        //DMLog(@"--跳转到详情。。。");
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //当拖拽_leftTabView时候，应该停止右视图的手势,停止滚动
   // [_shopSuperView removeBehaviors];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView != _leftTabView) {
        NSArray *array;
        array = _rightTabView.indexPathsForVisibleRows;
        if (array.count > 0) {
            //1:找到indexPath
            NSIndexPath *indexPath = array[0];
            //2:可见的第一个section位置
            NSInteger section = indexPath.section;
            //3:
            if (!_isSelectSlide) {
                //只有拖拽的时候，才执行该方法
                [_leftTabView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
    }
}

- (UIScrollView *)currentScorllView
{
    return _rightTabView;
}

@end
