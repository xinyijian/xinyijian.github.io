//
//  StoreCarDetailsVIew.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "StoreCarDetailsVIew.h"

@implementation StoreCarDetailsVIew
{
    NSUInteger _timeNumber;
    NSString * orderId;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}
- (void)initUI{
    
    _title = [[UILabel alloc] init];
    [self addSubview:_title];
    [_title activateConstraints:^{
        [_title.left_attr equalTo:self.left_attr constant:41.5];
        [_title.right_attr equalTo:self.right_attr constant:-40];
        _title.height_attr.constant = 21;
        [_title.top_attr equalTo:self.top_attr constant:18];
    }];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.textColor = TextColor;
    _title.font =fontStely(@"PingFangSC-Medium", 15);
    
    _feeLaber = [[UILabel alloc] init];
    [self addSubview:_feeLaber];
    [_feeLaber activateConstraints:^{
        [_feeLaber.left_attr equalTo:self.left_attr constant:41.5];
        [_feeLaber.right_attr equalTo:self.right_attr constant:-40];
        _feeLaber.height_attr.constant = 15;
        [_feeLaber.top_attr equalTo:_title.bottom_attr constant:5];
    }];
    _feeLaber.textAlignment = NSTextAlignmentLeft;
    _feeLaber.textColor = UIColorFromRGB(0x8a8fab);
    _feeLaber.font =fontStely(@"PingFangSC-Regular", 11);

    _apartLaber = [[UILabel alloc] init];
    [self addSubview:_apartLaber];
    [_apartLaber activateConstraints:^{
        [_apartLaber.left_attr equalTo:self.left_attr constant:41.5];
        [_apartLaber.right_attr equalTo:self.right_attr constant:-40];
        _apartLaber.height_attr.constant = 15;
        [_apartLaber.top_attr equalTo:_feeLaber.bottom_attr constant:5];
    }];
    _apartLaber.textAlignment = NSTextAlignmentLeft;
    _apartLaber.textColor = UIColorFromRGB(0x43496a);
    _apartLaber.font =fontStely(@"PingFangSC-Regular", 11);

    
    _addressLaber = [[UILabel alloc] init];
    [self addSubview:_addressLaber];
    [_addressLaber activateConstraints:^{
        [_addressLaber.left_attr equalTo:self.left_attr constant:41.5];
        [_addressLaber.right_attr equalTo:self.right_attr constant:-118];
        _addressLaber.height_attr.constant = 15;
        [_addressLaber.top_attr equalTo:_apartLaber.bottom_attr constant:5];
    }];
    _addressLaber.textAlignment = NSTextAlignmentLeft;
    _addressLaber.textColor = UIColorFromRGB(0x43496a);
    _addressLaber.font =fontStely(@"PingFangSC-Regular", 11);

    
    
    UIButton * addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: addressBtn];
    [addressBtn activateConstraints:^{
        [addressBtn.right_attr equalTo:self.right_attr constant:-45.5];
        addressBtn.width_attr.constant = 45;
        addressBtn.top_attr = _addressLaber.top_attr;
        addressBtn.height_attr.constant = 15;
    }];
    addressBtn.titleLabel.font = fontStely(@"PingFangSC-Regular", 9);
    [addressBtn setTitle:@"当前地址" forState:UIControlStateNormal];
    addressBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [addressBtn setTitleColor:TextColor forState:UIControlStateNormal];
    addressBtn.layer.cornerRadius = 5;
    [addressBtn addTarget:self action:@selector(addressClike:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView * arowimage = [[UIImageView alloc]init];
    arowimage.image = [UIImage imageNamed:@"icon"];
    [self addSubview: arowimage];
    [arowimage activateConstraints:^{
        [arowimage.right_attr equalTo:self.right_attr constant:-33];
        arowimage.centerY_attr = addressBtn.centerY_attr;
        arowimage.height_attr.constant = 7.5;
    }];
    
    _callOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_callOrderBtn];
    [_callOrderBtn activateConstraints:^{
        [_callOrderBtn.left_attr equalTo:self.left_attr constant:27.5];
        [_callOrderBtn.right_attr equalTo:self.centerX_attr constant:-5];
        _callOrderBtn.height_attr.constant = 40;
        [_callOrderBtn.top_attr equalTo:_addressLaber.bottom_attr constant:11];
    }];
    _callOrderBtn.backgroundColor = BlueColor;
    [_callOrderBtn setTitle:@"立刻打店" forState:UIControlStateNormal];
    _callOrderBtn.layer.cornerRadius = 20;
    _callOrderBtn.layer.masksToBounds = YES;
    
    _detailsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_detailsBtn];
    [_detailsBtn activateConstraints:^{
        [_detailsBtn.right_attr equalTo:self.right_attr constant:-27.5];
        [_detailsBtn.left_attr equalTo:self.centerX_attr constant:5];
        _detailsBtn.height_attr.constant = 40;
        [_detailsBtn.top_attr equalTo:_addressLaber.bottom_attr constant:11];
    }];
    _detailsBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [_detailsBtn setTitleColor:TextColor forState:UIControlStateNormal];
    [_detailsBtn setTitle:@"详情" forState:UIControlStateNormal];
    _detailsBtn.layer.cornerRadius = 20;
    _detailsBtn.layer.masksToBounds = YES;
    
    _callOrderBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);
    _detailsBtn.titleLabel.font = fontStely(@"PingFangSC-Medium", 13);

    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_closeBtn];
    [_closeBtn activateConstraints:^{
        
        _closeBtn.height_attr.constant = 46;
        _closeBtn.width_attr.constant = 46;
        [_closeBtn.top_attr equalTo:self.top_attr];
        [_closeBtn.right_attr equalTo:self.right_attr];
    }];
    
    [_closeBtn setImage:[UIImage imageNamed:@"icon-Close"] forState:UIControlStateNormal];

}


- (void)callOrderResp:(NSInteger)timeN OrderId:(NSString *)orId
{
    _timeNumber = timeN;
    orderId = orId;
    _callOrderBtn.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [_callOrderBtn setTitleColor:TextColor forState:UIControlStateNormal];

}
- (void)overtime
{
    _callOrderBtn.backgroundColor = BlueColor;;
    [_callOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)timeNumss{
////    __block NSInteger second = _timeNumber;
//    //(1)
//    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //(2)
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
//    //(3)
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    //(4)
//    dispatch_source_set_event_handler(timer, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (second == 0) {
//                _callOrderBtn.enabled = YES;
//                [_callOrderBtn setTitle:NSLocalizedString(@"超时",nil) forState:UIControlStateNormal];
//                [_callOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//
//                second = _timeNumber;
//                //(6)
//                dispatch_cancel(timer);
//                [self PUTcallorderRequest];
//            } else {
//               NSString * st = NSLocalizedString(@"等待接单",nil);
//                _callOrderBtn.enabled = NO;
//                [_callOrderBtn setTitle:[NSString stringWithFormat:@"%@单(%lds)",st,(long)second] forState:UIControlStateNormal];
//                [_callOrderBtn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
//                second--;
//            }
//        });
//    });
//    //(5)
//    dispatch_resume(timer);
    
}

- (void)PUTcallorderRequest
{
//    [[PattayaUserServer singleton] PUTcallorderRequest:orderId Success:^(NSURLSessionDataTask *operation, NSDictionary *ret) {
//        NSLog(@"取消订单");
//        if ([ResponseModel isData:ret]) {
//            [self overtime];
//        }
//
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//
//    }];
}

- (void)closeView
{
    self.hidden = YES;
}
- (void)addressClike:(UIButton *)btn
{
    BLOCK_EXEC(_clickEdit);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
