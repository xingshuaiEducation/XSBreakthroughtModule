//
//  XSBreakthroughtUtil.h
//  XSBreakthrought
//
//  Created by suxx on 2017/6/2.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XSBreakthroughtUtil : NSObject

//以iphone6为参考
#define ScreenScaleX(x) x*[UIScreen mainScreen].bounds.size.width/375.0
#define ScreenScaleY(y) y*[UIScreen mainScreen].bounds.size.height/667.0

#define WeakSelf(self) __weak typeof(self) weakSelf = self;

+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 *  处理 null 以及其他类型
 *
 *  @param deal 输入任意类型
 *
 *  @return string
 */
+(NSString *)dealAPIToString:(id)deal;

/**
 *@brief 构造User-Agent 头
 *
 *
 *
 
 *@return   :
 */
+(NSString *)getHttpUserAgent;

@end
