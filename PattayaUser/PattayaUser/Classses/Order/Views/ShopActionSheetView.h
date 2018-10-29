//
//  ShopActionSheetView.h
//  PattayaUser
//
//  Created by yanglei on 2018/10/8.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopActionSheetView : UIView

@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)ShopModel *shopModel;

//隐藏视图
-(void)hiddenView;

//展示视图
-(void)showViewWith:(ShopModel*)shopModel;

@end
