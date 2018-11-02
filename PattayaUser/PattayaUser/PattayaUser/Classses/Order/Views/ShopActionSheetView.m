//
//  ShopActionSheetView.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "ShopActionSheetView.h"
#import "ShopActionSheetCell.h"

@interface ShopActionSheetView()<UITableViewDelegate,UITableViewDataSource,ShopActionSheetCellDelegate>
{
    int totalCount;
}

@property (nonatomic , strong)NSMutableArray *dataArray;//显示数据

@end

@implementation ShopActionSheetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        [self initViews];
       
    }
    return self;
}

-(void)initViews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.height ,self.width, 60*3 + 37 + 21) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = UIColorWhite;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = UIColorWhite;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.tableView];
    
}

//隐藏视图
-(void)hiddenView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, self.height ,self.width, 60*3 + 37 + 21);
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
    
}

//展示视图
-(void)showViewWith:(NewShopModel*)shopModel{
    _shopModel = shopModel;
    
    [_dataArray removeAllObjects];
       for (NSArray *array in shopModel.productArray) {
        for (NewShopListModel *model in array) {
            if ([model.selectCount intValue] > 0) {
                [_dataArray addObject:model];
            }
        }
    }
    
    if (_dataArray.count==0) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hidden = NO;
        self.tableView.frame = CGRectMake(0, self.height - (60*(_dataArray.count > 6 ? 6 :_dataArray.count) + 37 + 21) ,self.width, 60*(_dataArray.count > 6 ? 6 :_dataArray.count) + 37 + 21);
        
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hiddenView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 21;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
        UILabel *titleLab =  [[UILabel alloc]initWithFrame:CGRectMake(13,0, 200, 37)];
        titleLab.font = K_LABEL_SMALL_FONT_14;
        titleLab.textColor = TextColor;
        titleLab.text = @"已选商品";
        [bgView addSubview:titleLab];
    
        UIButton *clearBT = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBT.frame = CGRectMake(self.width - 20 - 28,0, 30, 37);
        clearBT.titleLabel.font = K_LABEL_SMALL_FONT_14;
        [clearBT setTitle:@"清空" forState:UIControlStateNormal];
        [clearBT addTarget:self action:@selector(clearAllClick:) forControlEvents:UIControlEventTouchUpInside];
        [clearBT setTitleColor:TextColor forState:UIControlStateNormal];
        [bgView addSubview:clearBT];
    
        return bgView;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    return bgView;
    
}

#pragma mark - 清空
-(void)clearAllClick:(UIButton *)btn{
    NSLog(@"清空");
    for (NewShopListModel *model in _dataArray) {
        model.selectCount = [NSString stringWithFormat:@"%d",0];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeselectcount" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadRightTableView" object:nil];

    [self hiddenView];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *listCell = @"ShopActionSheetCell";
    ShopActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    if (!cell) {
        cell = [[ShopActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0 );
    }

    cell.delegate = self;
    cell.productModel = _dataArray[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}


#pragma mark - ShopActionSheetCellDelegate
-(void)ShopActionSheet:(ShopActionSheetCell *)ShopActionSheet showShopCount:(NSInteger)count{
    
    if (count == 0) {
        
        totalCount = 0;
     
        for (NSArray *array in _shopModel.productArray) {
            for (NewShopListModel *model in array) {
                totalCount = [model.selectCount intValue] + totalCount;
            }
        }
        if (totalCount==0) {
            [self hiddenView];
        }else{
            [self showViewWith:_shopModel];
        }
        
        
    }
}


@end
