//
//  SelcetAddressVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/25.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "SelcetAddressVC.h"

@interface SelcetAddressVC ()

@end

@implementation SelcetAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

-(void)setupUI{
    [super setupUI];
    self.navigationItem.title = @"选择收获地址";
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
    
    
   
    
    
    return footerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 3) {
        NSLog(@"选择地址");
        
        
    }
    
}

@end
