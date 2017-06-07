//
//  XSNetworkManager.m
//  XSEnterpriseEDU
//
//  Created by Tassos on 2017/2/20.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import "XSNetworkManager.h"
#import "AFNetworking.h"
#import "XSBreakthroughtUtil.h"

// API 返回的状态
#define Socket_LoginOut @"Socket_LoginOut"                //下线通知
#define API_StatusNoLogin @"401"                //未登录
#define API_StatusNoPermission @"403"           //无权限访问
#define API_StatusNoFind @"404"                 //页面不存在
#define API_LoginNotification @"needToLogin"    // API 对应状态的通知

#ifdef DEBUG
#	define DLog(fmt, ...) NSLog((@"%s #%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

NSString *const kNetworkCookie = @"kNetworkCookie";

static XSNetworkManager *engine = nil;

@implementation XSNetworkManager

+(XSNetworkManager *)shareInstance{
    static dispatch_once_t httpEngineOnceToken;
    
    dispatch_once(&httpEngineOnceToken, ^{
        if (!engine) {
            engine = [[self alloc] init];
        }
    });
    
    return engine;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!engine) {
            engine = [super allocWithZone:zone];
        }
    }
    
    return engine;
}


/**
 *  统一处理Status
 *  401 未登录
 *  403 无权访问
 *  404 页面找不到
 **/
- (void)dealAPIStatus:(NSDictionary *)responseData{
    if ([responseData.allKeys containsObject:@"status"]) {
        if ([[XSBreakthroughtUtil dealAPIToString:responseData[@"status"]] isEqualToString:API_StatusNoLogin]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:API_LoginNotification object:responseData];
        }else if([[XSBreakthroughtUtil dealAPIToString:responseData[@"status"]] isEqualToString:API_StatusNoPermission]){
            [[NSNotificationCenter defaultCenter] postNotificationName:API_LoginNotification object:responseData];
        }else if([[XSBreakthroughtUtil dealAPIToString:responseData[@"status"]] isEqualToString:API_StatusNoFind]){
            [[NSNotificationCenter defaultCenter] postNotificationName:API_LoginNotification object:responseData];
        }
    }
}


- (void)networkWithURL:(NSString *)url useMethod:(XSNetworkMethod)method DataParams:(NSDictionary *)dataparams requesrHeader:(NSString *)header requesrheaderValue:(NSString *)headerValue completionBlock:(XSCompletionBlock)completionBlock failedBlock:(XSFailedBlock)failedBlock{

    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json", @"text/javascript", nil];
    
   NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:kNetworkCookie];
    
    
    
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:[XSBreakthroughtUtil getHttpUserAgent] forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//    if(header){
//        [manager.requestSerializer setValue:headerValue forHTTPHeaderField:header];
//    }else{
//        [manager.requestSerializer clearAuthorizationHeader];
//    }
    switch (method) {
        case XSNetworkMethod_POST:
        {
            [manager POST:url parameters:dataparams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self dealAPIStatus:responseObject];
                completionBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
                DLog(@"错误码 %zd",error.code);
//                NSData *data =  [NSJSONSerialization dataWithJSONObject:error.userInfo options:NSJSONWritingPrettyPrinted error:nil];
//                //打印JSON数据
//                DLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            


                failedBlock(error.localizedDescription);
               
            }];
        }
            break;
        case XSNetworkMethod_GET:
        {
            [manager GET:url parameters:dataparams progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self dealAPIStatus:responseObject];
                
                NSLog(@"%@",responseObject);
                
                completionBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"错误码 %zd",error.code);
                DLog(@"错误内容 %@",error.localizedDescription);
                if ([error.localizedDescription isEqualToString:@"未能读取数据，因为它的格式不正确。"] || [error.localizedDescription isEqualToString:@"未能找到使用指定主机名的服务器。"] || error.code == 1 || error.code == 3 || error.code == -1011 || error.code == -1009 || error.code == 310 || error.code == 3840) {
                    failedBlock(@"网络错误");
                }else
                {
                    failedBlock(error.localizedDescription);
                }
                
            }];
        }
            break;
        case XSNetworkMethod_PUT:
        {
            [manager PUT:url parameters:dataparams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self dealAPIStatus:responseObject];
                completionBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"错误码 %zd",error.code);
                failedBlock(error.localizedDescription);
            }];
        }
            break;
        case XSNetworkMethod_DELETE:
        {
            [manager DELETE:url parameters:dataparams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self dealAPIStatus:responseObject];
                    completionBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"错误码 %zd",error.code);
                failedBlock(error.localizedDescription);
            }];
        }
            break;
        default:
            break;
    }
    
    
    
}

@end











