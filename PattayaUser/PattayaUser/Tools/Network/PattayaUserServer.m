//
//  PattayaUserServer.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/1.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "PattayaUserServer.h"

@implementation PattayaUserServer
#pragma mark --- 通过微信返回的code去请求token来回去微信用户信息
- (void)WeChatCodeRequest:(NSString *)code success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/user/pub/wxUser?code=%@",code] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}

#pragma mark --- ///POST /pub/loginOrRegister 登录
- (void)loginOrRegisterToken:(NSDictionary *)dic Requestsuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:@"/user/pub/login" parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark --- POST /pub/sendVerifyCode 验证码
- (void)sendVerifyCodeRequest:(NSDictionary *)dic success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult;
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:@"/user/pub/sendVerifyCode" parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark --- get/ stroe 条件搜索店铺
- (void)SeachStoreCodeRequest:(NSDictionary *)dic success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:@"/gse/pub/store" parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark --- get/ stroe/{id} 店铺详情
- (void)GetStoredbStoreRequest:(NSDictionary *)dic success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:@"/gse/pub/store" parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark --- get/ current 用户信息
- (void)UserInfoRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:@"/user/current" parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark --- post/ address 添加地址
- (void)AddRessRequest:(NSDictionary *)address Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:@"/user/address" parameter:address isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark --- get/ address 获取地址
- (void)GetAddRessRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:@"/user/address" parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];

}

#pragma mark --- post/ deviceToken
- (void)deviceTokenRequest:(NSDictionary *)token Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:@"/user/deviceToken" parameter:token isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark --- post/ callorder 召唤/下单
- (void)callOrderRequest:(NSDictionary *)token Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
  
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:@"/user/callorder" parameter:token isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /pub/category 分类查询
- (void)categoryRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:@"/gse/pub/category" parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /upfile/token 获取七牛的token
- (void)QiniuTokenRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:@"/user/upfile/token" parameter:@{@"fileName":@"headerimage.png"} isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
    
}


#pragma mark ---PUT /callorder/{orderId}/cancel 取消
- (void)PUTcallorderRequest:(NSString *)orderId Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] PUTWithUrlPath:[NSString stringWithFormat:@"/user/callorder/%@/cancel",orderId] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---get /callorder/{orderId} 订单详情
- (void)getcallorderRequest:(NSString *)orderId Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/user/callorder/%@",orderId] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /callorder/processingOrder 查询是否有正在执行的订单
- (void)getProcessingOrderRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/user/callorder/processingOrder"] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /callorder/processingOrder 在appdele查询是否有正在执行的订单(轮询)
- (void)appDelegateProcessingOrderRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/user/callorder/processingOrder"] parameter:nil isNeedIndicator:NO success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /pub/sys/address/c 可服务城市
- (void)getServiceCityRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/user/pub/sys/address/c"] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /pub/store/{id} 搜索单个商店车的信息
- (void)getServiceCityIdRequest:(NSString *)storeId Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/gse/pub/store/%@",storeId] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /pub/store/{id} 搜索单个商店车的信息
- (void)getFindServiceCityIdRequest:(NSDictionary *)storeId Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/gse/pub/store"] parameter:storeId isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /pub/ad/{system}/{position} 广告位信息
- (void)getBannerRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/gse/pub/ad/USER_IOS/HOME_BANNER"] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
    
}
#pragma mark ---GET /consumeOrder 消费订单列表
- (void)getConsumeOrderRequest:(NSDictionary *)dic Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/order/order"] parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /unBind 解除绑定
- (void)deleteDunBindOrderRequest:(NSDictionary *)dic Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:[NSString stringWithFormat:@"/user/unBind"] parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}

#pragma mark ---GET /thirdBin 绑定
- (void)thirdBinOrderRequest:(NSDictionary *)dic Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:[NSString stringWithFormat:@"/user/thirdBind"] parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /logOutUser 退出登录
- (void)logOutUserRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:[NSString stringWithFormat:@"/user/logOutUser"] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}

#pragma mark ---GET /headImg 保存头像
- (void)headImgSaveRequest:(NSString *)file Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:[NSString stringWithFormat:@"/user/headImg?headImgKey=%@",file] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}

#pragma mark ---deleted /address/{addressId} 删除地址
- (void)deletedAddressRequest:(NSString *)addressId Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] DeleteWithUrlPath:[NSString stringWithFormat:@"/user/address/%@",addressId] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---GET /pub/hot 获取热词
- (void)HotRequestSuccess:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] getWithUrlPath:[NSString stringWithFormat:@"/gse/pub/hot"] parameter:nil isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
#pragma mark ---POST /pub/checkCreateOrder 校验司机位置和用户订单目的地位置距离,以及行驶时间
- (void)checkCreateOrderRequest:(NSDictionary *)dic Success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{
    [[PattayaHttpRequest sharedHttpManager] postWithUrlPath:[NSString stringWithFormat:@"/user/pub/checkCreateOrder"] parameter:dic isNeedIndicator:YES success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}

#pragma mark  检查更新
- (void)checkUpdateRequest:(NSDictionary *)dic success:(void (^)(NSURLSessionDataTask *operation,NSDictionary *ret))successResult failure:(void (^)(NSURLSessionDataTask *operation,NSError *error))failureResult
{//[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
    NSDictionary * dics = @{@"version":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],@"platformType":@"ios"};
    [[PattayaHttpRequest sharedHttpManager]postWithUrlPath:[NSString stringWithFormat:@"/user/pub/version/check"] parameter:dics isNeedIndicator:NO success:^(NSURLSessionDataTask *operation, NSDictionary *responesObject) {
        successResult(operation,responesObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failureResult(operation,error);
    }];
}
@end
