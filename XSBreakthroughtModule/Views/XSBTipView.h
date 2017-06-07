//
//  XSBTipView.h
//  XSBreakthrought
//
//  Created by suxx on 2017/6/6.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBTipView : UIView

//关卡描述
@property (nonatomic, copy)NSString *breakthroughtDesc;
//闯关状态
@property (nonatomic, copy)NSString *breakthroughtStatueDes;

//闯关分数
@property (nonatomic, copy)NSString *breakthroughtScore;
//闯关条件
@property (nonatomic, copy)NSString *breakthroughtCondition;
//通关人员
@property (nonatomic, copy)NSString *breakthroughtedMans;

//底部的控制菜单
@property (nonatomic, strong)NSArray *bottomMenu;

@property (nonatomic, strong)void (^bottomMenuClick)(NSUInteger index);

@end
