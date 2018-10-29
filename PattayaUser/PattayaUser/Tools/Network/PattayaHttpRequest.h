//
//  PattayaHttpRequest.h
//  pattaya-dri
//
//  Created by 明克 on 2018/2/25.
//  Copyright © 2018年 大卫. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
/*
 *******   网络请求类  封装
 */

//@class LDJActivityIndicator;

//网络请求成功，回调块
typedef void (^success)(NSURLSessionDataTask *operation,id responesObject);

//网络请求失败，回调块
typedef void (^failure)(NSURLSessionDataTask *operation,NSError *error);
typedef void (^ConnectionAvailable)(BOOL http);

@interface PattayaHttpRequest : AFHTTPSessionManager
@property (strong, nonatomic) success succ;
@property (strong, nonatomic) failure fail;
@property (strong, nonatomic) ConnectionAvailable available;
+ (instancetype)tempsharedHttpManager;
//静态方法，
+ (instancetype)sharedHttpManager;
+ (instancetype)newHttpManager;
+ (instancetype)logionsharedHttpManager;
+ (instancetype)newHttpManagerXIOao;
//判断网络连接状态
- (void)isConnectionAvailable;
//delete 方法
- (void)DeleteWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//PUT 方法
- (void)PUTWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//get 方法
- (void)getWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
//post 方法
- (void)postWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)parameter isNeedIndicator:(BOOL)isNeedIndicator success:(void (^)(NSURLSessionDataTask * operation, NSDictionary *responesObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;
- (void)isAccessToken:(NSString *)code;
- (void)codeIsAccessToken:(NSInteger)code;

@end
