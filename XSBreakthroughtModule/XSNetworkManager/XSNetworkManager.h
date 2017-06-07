//
//  XSNetworkManager.h
//  XSEnterpriseEDU
//
//  Created by Tassos on 2017/2/20.
//  Copyright © 2017年 xsteach.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBreakthroughtUrlHead.h"



#define XS_RESP_DATA            @"message"
#define XS_STATUSCODE_SUCCESS   @"0"



// 网络类型
typedef NS_ENUM(NSInteger, XSNetworkMethod) {
    XSNetworkMethod_POST        = 0,
    XSNetworkMethod_GET         = 1,
    XSNetworkMethod_PUT         = 2,
    XSNetworkMethod_DELETE      = 3,
};



typedef void(^XSFailedBlock)(NSString *errMsg);
typedef void(^XSCompletionBlock)(NSDictionary *respData);



@interface XSNetworkManager : NSObject

+(XSNetworkManager *)shareInstance;

- (void)networkWithURL:(NSString *)url useMethod:(XSNetworkMethod)method DataParams:(NSDictionary *)dataparams requesrHeader:(NSString *)header requesrheaderValue:(NSString *)headerValue completionBlock:(XSCompletionBlock)completionBlock failedBlock:(XSFailedBlock)failedBlock;

@end








