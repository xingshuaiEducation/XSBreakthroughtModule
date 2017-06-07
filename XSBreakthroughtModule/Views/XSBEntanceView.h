//
//  XSBEntanceView.h
//  XSBreakthrought
//
//  Created by suxx on 2017/6/2.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBEntanceView : UIView

//上面的图片，没有设置则采用默认的
@property (nonatomic, strong)UIImage *topImage;

//下面的阴影图片，没有设置则采用默认的
@property (nonatomic, strong)UIImage *shadowImage;

//点击事件
@property (nonatomic, strong)void (^clickBlock)(void);

@end
