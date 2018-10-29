//
//  LoacationTableViewCell.h
//  PattayaUser
//
//  Created by 明克 on 2018/2/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^refreshLoactionBlock) (void);
@interface LoacationTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel * loaction;
@property (nonatomic, strong)UIButton * refreshLoaction;
@property (nonatomic, copy)refreshLoactionBlock refreshBlcok;
@end
