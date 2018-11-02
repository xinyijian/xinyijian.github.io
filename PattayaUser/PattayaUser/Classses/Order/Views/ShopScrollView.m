//
//  ShopScrollView.m
//  AppPark
//
//  Created by 池康 on 2018/7/10.
//

#import "ShopScrollView.h"
#import "ShopHomePageView.h"//商家主页
#import "LJDynamicItem.h"

static CGFloat rubberBandDistance(CGFloat offset, CGFloat dimension) {
    const CGFloat constant = 0.55f;
    CGFloat result = (constant * fabs(offset) * dimension) / (dimension + constant * fabs(offset));
    // The algorithm expects a positive offset, so we have to negate the result if the offset was negative.
    return offset < 0.0f ? -result : result;
}

@interface ShopScrollView()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    __block BOOL     isVertical;//是否是垂直
    NSInteger       _maxOffset_Y;
}
@property (nonatomic , strong) ShopHomePageView         *shopHomePageView;//商家列表主页,二级联动
@property (nonatomic , strong) UIScrollView             *subTableView;//获取当前页面的子tableView.
@property (nonatomic , strong) NewShopModel             *shopModel;//数据模型

//弹性和惯性动画
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, weak)   UIDynamicItemBehavior *decelerationBehavior;
@property (nonatomic, strong) LJDynamicItem *dynamicItem;
@property (nonatomic, weak)   UIAttachmentBehavior *springBehavior;
@end

@implementation ShopScrollView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame  withShopModel:(NewShopModel *)model  withGroupID:(NSString *)groupId currentVC:(UIViewController *)currentVC
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.scrollEnabled = NO;
        _shopModel = model;
        _groupId = groupId;
        //NSArray *activityList = _shopModel.activityList;//活动数组
//        if (activityList.count > 0) {
//            _maxOffset_Y = (Size(150) + 48 - kDefaultNavBarHeight);
//        }else{
//            _maxOffset_Y = (Size(150) + 48 - kDefaultNavBarHeight - 28);
//        }
        _maxOffset_Y = ShopHeadH;
        self.contentSize = CGSizeMake(self.width, self.height + _maxOffset_Y);
        [self addSubview:self.shopHomePageView];//店铺主页
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerAction:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.dynamicItem = [[LJDynamicItem alloc] init];
        
        self.subTableView = [self currentSubTableView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllBehaviors:) name:@"removeAllBehaviors" object:nil];
    }
    return self;
}

////删除所有动力行为。
- (void)removeAllBehaviors:(NSNotification *)not
{
    [self.animator removeAllBehaviors];
}

#pragma mark - 控制方法

#pragma mark -  UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"===%f",self.contentOffset.y);
    //委托 方法
    if (scrollView == self) {
        if (self.contentOffset.y == 0) {//如果已经回到顶部了，则移除手势，禁止来回谈动
            [self.animator removeAllBehaviors];
        }
        if (!_isStopAnimation) {
            if ([self.scrollDelegate respondsToSelector:@selector(ListScrollViewDidScroll:)]) {
                [self.scrollDelegate ListScrollViewDidScroll:scrollView];
            }
        }
        //设置二级联动的左tableview的偏移量
        if (_shopHomePageView) {
            [_shopHomePageView superScrollViewDidScrollOffset:scrollView.contentOffset.y];
        }
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bottomShopCartOffsetY" object:self userInfo:@{@"offsetY":[NSString stringWithFormat:@"%f",scrollView.mj_offsetY]}];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark 手势,是否支持多个手手势共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat currentY = [recognizer translationInView:self].y;
        CGFloat currentX = [recognizer translationInView:self].x;
        if (currentY == 0.0) {
            isVertical = NO;
            return YES;
        } else {
            ////判断如果currentX为currentY的5倍及以上就是断定为横向滑动，返回YES，否则返货NO
            if (fabs(currentX)/fabs(currentY) >= 5.0) {
                isVertical = NO;
                return YES;
            } else {
                isVertical = YES;
                return NO;
                
            }
        }
    }
    return NO;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer {
    _isStopAnimation = NO;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            if (isVertical) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GestureRecognizerStateBegan" object:self];
            }
            [self.animator removeAllBehaviors];
            break;
        case UIGestureRecognizerStateChanged:
        {
            //locationInView:获取到的是手指点击屏幕实时的坐标点；
            //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
            if (isVertical) {
                //往上滑为负数，往下滑为正数
                CGFloat currentY = [recognizer translationInView:self].y;
                //                NSLog(@"currentY....%f",currentY);
                [self controlScrollForVertical:currentY AndState:UIGestureRecognizerStateChanged];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (isVertical) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GestureRecognizerStateEnded" object:self];
                if (self.contentOffset.y <= -100) {
                    //向下滑动
                    if ([self.scrollDelegate respondsToSelector:@selector(ListScrollViewDropDown:)]) {
                        [self.scrollDelegate ListScrollViewDropDown:self];
                    }
                }
                else{
                    self.dynamicItem.center = CGPointMake(0, 0);
                    //velocity是在手势结束的时候获取的竖直方向的手势速度
                    CGPoint velocity = [recognizer velocityInView:self];
                    UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicItem]];
                    [inertialBehavior addLinearVelocity:CGPointMake(0, velocity.y) forItem:self.dynamicItem];
                    // 通过尝试取2.0比较像系统的效果
                    inertialBehavior.resistance = 5.0;
                    __block CGPoint lastCenter = CGPointZero;
                    __weak typeof(self) weakSelf = self;
                    inertialBehavior.action = ^{
                        if (isVertical) {
                            //得到每次移动的距离
                            CGFloat currentY = weakSelf.dynamicItem.center.y - lastCenter.y;
                            [weakSelf controlScrollForVertical:currentY AndState:UIGestureRecognizerStateEnded];
                        }
                        lastCenter = weakSelf.dynamicItem.center;
                    };
                    [self.animator addBehavior:inertialBehavior];
                    self.decelerationBehavior = inertialBehavior;
                }
            }
        }
            break;
        default:
            break;
    }
    //保证每次只是移动的距离，不是从头一直移动的距离
    [recognizer setTranslation:CGPointZero inView:self];
}

//控制上下滚动的方法
- (void)controlScrollForVertical:(CGFloat)detal AndState:(UIGestureRecognizerState)state {
    //判断是主ScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
    if (self.contentOffset.y >= _maxOffset_Y) {
        CGFloat offsetY = self.subTableView.contentOffset.y - detal;
        if (offsetY < 0) {
            //当子ScrollView的contentOffset小于0之后就不再移动子ScrollView，而要移动主ScrollView
            offsetY = 0;
            self.contentOffset = CGPointMake(self.frame.origin.x, self.contentOffset.y - detal);
        } else if (offsetY > (self.subTableView.contentSize.height - self.subTableView.frame.size.height)) {
            //当子ScrollView的contentOffset大于contentSize.height时
            offsetY = self.subTableView.contentOffset.y - rubberBandDistance(detal, self.height);
        }
        self.subTableView.contentOffset = CGPointMake(0, offsetY);
    }
    else {
        if (self.subTableView.contentOffset.y != 0 && detal >= 0) {
            
            CGFloat offsetY = self.subTableView.contentOffset.y - detal;
            if (offsetY < 0) {
                //当子ScrollView的contentOffset小于0之后就不再移动子ScrollView，而要移动主ScrollView
                offsetY = 0;
                self.contentOffset = CGPointMake(self.frame.origin.x, self.contentOffset.y - detal);
            } else if (offsetY > (self.subTableView.contentSize.height - self.subTableView.frame.size.height)) {
                //当子ScrollView的contentOffset大于contentSize.height时
                offsetY = self.subTableView.contentOffset.y - rubberBandDistance(detal, self.height);
            }
            self.subTableView.contentOffset = CGPointMake(0, offsetY);
            
        }else{
            CGFloat mainOffsetY = self.contentOffset.y - detal;
            if (mainOffsetY < 0) {
                //滚到顶部之后继续往上滚动需要乘以一个小于1的系数
                mainOffsetY = self.contentOffset.y - rubberBandDistance(detal, self.height);
                
            } else if (mainOffsetY > _maxOffset_Y) {
                mainOffsetY = _maxOffset_Y;
            }
            self.contentOffset = CGPointMake(self.frame.origin.x, mainOffsetY);
            
            if (mainOffsetY == 0) {
                self.subTableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    
    BOOL outsideFrame = self.contentOffset.y < 0 || self.subTableView.contentOffset.y > (self.subTableView.contentSize.height - self.subTableView.frame.size.height);
    BOOL isMore = self.subTableView.contentSize.height >= self.subTableView.frame.size.height || self.contentOffset.y >= _maxOffset_Y||self.contentOffset.y < 0 ;
    if (isMore && outsideFrame &&
        (self.decelerationBehavior && !self.springBehavior)) {
        CGPoint target = CGPointZero;
        BOOL isMian = NO;
        if (self.contentOffset.y < 0) {
            self.dynamicItem.center = self.contentOffset;
            target = CGPointZero;
            isMian = YES;
        } else if (self.subTableView.contentOffset.y > (self.subTableView.contentSize.height - self.subTableView.frame.size.height)) {
            self.dynamicItem.center = self.subTableView.contentOffset;
            
            target = CGPointMake(self.subTableView.contentOffset.x, (self.subTableView.contentSize.height - self.subTableView.frame.size.height));
            //********判断tableview的contentsize.height是否大于自身高度，从而控制滚动/
            if (self.subTableView.contentSize.height <= self.subTableView.frame.size.height) {
                target = CGPointMake(self.subTableView.contentOffset.x,0);
            }
            isMian = NO;
        }
        [self.animator removeBehavior:self.decelerationBehavior];
        __weak typeof(self) weakSelf = self;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.dynamicItem attachedToAnchor:target];
        springBehavior.length = 0;
        springBehavior.damping = 1;
        springBehavior.frequency = 2;
        springBehavior.action = ^{
            if (isMian) {
                weakSelf.contentOffset = weakSelf.dynamicItem.center;
                if (weakSelf.contentOffset.y == 0) {
                    self.subTableView.contentOffset = CGPointMake(0, 0);
                }
            } else {
                
                weakSelf.subTableView.contentOffset = self.dynamicItem.center;
            }
        };
        [self.animator addBehavior:springBehavior];
        self.springBehavior = springBehavior;
    }
}

#pragma mark - 公用方法
//移除手势
- (void)removeBehaviors
{
    [self.animator removeAllBehaviors];
}
//获取当前页面的子tableView.
- (UIScrollView *)currentSubTableView
{
    return self.shopHomePageView.rightTabView;;
}

#pragma mark - 懒加载

- (ShopHomePageView *)shopHomePageView
{
    if (!_shopHomePageView) {
        _shopHomePageView = [[ShopHomePageView alloc]initWithFrame:CGRectMake(0,ShopHeadH, self.width, self.height)];
       // _shopHomePageView.shopSuperView = self;
        _shopHomePageView.groupId = _groupId;
        _shopHomePageView.shopModel = _shopModel;
    }
    return _shopHomePageView;
}

@end
