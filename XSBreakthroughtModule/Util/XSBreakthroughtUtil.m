//
//  XSBreakthroughtUtil.m
//  XSBreakthrought
//
//  Created by suxx on 2017/6/2.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "XSBreakthroughtUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/sysctl.h"
#import <AVFoundation/AVFoundation.h>

@implementation XSBreakthroughtUtil

#pragma mark - Delegate

#pragma mark - Event Handle

#pragma mark - Private Method

#pragma mark - Public Method
+ (UIColor *) colorWithHexString: (NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+(NSString *)dealAPIToString:(id)deal{
    if ([deal isKindOfClass:[NSString class]]) {
        return deal;
    }else if([deal isKindOfClass:[NSNull class]]){
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",deal];
    }
}

+(NSString *)getHttpUserAgent
{
    NSString *appVertion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *devType = [[UIDevice currentDevice] model];
    NSString *sysVertion = [[UIDevice currentDevice] systemVersion];
    NSString *sysName = [[UIDevice currentDevice] systemName];
    NSString *model = [self doDevicePlatform]; //具体手机型号
    NSString *str = [NSString stringWithFormat:@"XSTeach/%@ (%@; %@ %@; %@) XSTeachENT/%@",@"1.0" ,devType,sysName,sysVertion,model, appVertion];
    return str;
}

//获得设备型号
+ (NSString*) doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        platform = @"iPhone";
        
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        
        platform = @"iPhone 3G";
        
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        
        platform = @"iPhone 3GS";
        
    } else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
        
        platform = @"iPhone 4";
        
    } else if ([platform isEqualToString:@"iPhone4,1"]) {
        
        platform = @"iPhone 4S";
        
    } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
        
        platform = @"iPhone 5";
        
    }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
        
        platform = @"iPhone 5C";
        
    }else if ([platform isEqualToString:@"iPhone6,2"]||[platform isEqualToString:@"iPhone6,1"]) {
        
        platform = @"iPhone 5S";
        
    } else if ([platform isEqualToString:@"iPhone8,4"]) {
        
        platform = @"iPhone SE";
        
    } else if ([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }
    else if ([platform isEqualToString:@"iPhone7,1"])
    {
        return @"iPhone 6 Plus";
    }
    else if ([platform isEqualToString:@"iPhone8,1"])
    {
        return @"iPhone 6S";
    }
    else if ([platform isEqualToString:@"iPhone8,2"])
    {
        return @"iPhone 6S Plus";
    }
    else if ([platform isEqualToString:@"iPod4,1"]) {
        
        platform = @"iPod touch 4";
        
    }else if ([platform isEqualToString:@"iPod5,1"]) {
        
        platform = @"iPod touch 5";
        
    }else if ([platform isEqualToString:@"iPod3,1"]) {
        
        platform = @"iPod touch 3";
        
    }else if ([platform isEqualToString:@"iPod2,1"]) {
        
        platform = @"iPod touch 2";
        
    }else if ([platform isEqualToString:@"iPod1,1"]) {
        
        platform = @"iPod touch";
        
    } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]||[platform isEqualToString:@"iPad3,3"]) {
        
        platform = @"iPad 3";
        
    } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
        
        platform = @"iPad 2";
        
    }else if ([platform isEqualToString:@"iPad1,1"]) {
        
        platform = @"iPad 1";
        
    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]||[platform isEqualToString:@"iPad4,5"]||[platform isEqualToString:@"iPad4,6"]||[platform isEqualToString:@"iPad4,4"]) {
        
        platform = @"iPad mini";
        
    } else if ([platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
        
        platform = @"iPad 4";
        
    } else if ([platform isEqualToString:@"iPad4,1"]||[platform isEqualToString:@"iPad4,2"]||[platform isEqualToString:@"iPad4,3"]) {
        
        platform = @"iPad Air";
        
    }
    
    return platform;
}

#pragma mark - Getter 和 Setter

@end
