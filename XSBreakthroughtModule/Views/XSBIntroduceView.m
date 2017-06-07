//
//  XSBIntroduceView.m
//  XSBreakthrought
//
//  Created by suxx on 2017/6/2.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "XSBIntroduceView.h"
#import <Masonry.h>
#import "XSBreakthroughtUtil.h"

#pragma mark - LiftCycle

@interface XSBIntroduceView()

@property (nonatomic, strong)__block UIView *tipBGView;

@end

@implementation XSBIntroduceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareForUI];
        
    }
    return self;
}


#pragma mark - Delegate

#pragma mark - Event Handle
-(void)remove{
    [self removeFromSuperview];
}

#pragma mark - Private Method
-(void)drawRect:(CGRect)rect{
    [self addAnimate];
}

-(void)prepareForUI{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];//[UIColor blackColor];
    
    
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.backgroundColor = [UIColor clearColor];
    [bgBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgBtn];
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    self.tipBGView.backgroundColor = [UIColor clearColor];
}

-(void)addAnimate{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation1.fromValue = [NSNumber numberWithInteger:0];
    animation1.toValue = [NSNumber numberWithInteger:1];
    animation1.duration = .3f;
    [self.layer addAnimation:animation1 forKey:@"opacityAnimation"];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithInteger:0.5];
    animation2.toValue = [NSNumber numberWithInteger:1];
    
    animation2.duration = .5f;
    
    [self.tipBGView.layer addAnimation:animation2 forKey:@"scaleAnimation"];
    
}

#pragma mark - Public Method

#pragma mark - Getter 和 Setter
-(UIView *)tipBGView{
    if (!_tipBGView) {
        _tipBGView = [[UIView alloc] init];
        [self addSubview:self.tipBGView];
        
        WeakSelf(self);
        [_tipBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ScreenScaleX(283));
            make.height.mas_equalTo(ScreenScaleY(353));
            make.center.equalTo(weakSelf);
        }];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_Breakthrought_说明Tip"];
        imageView.userInteractionEnabled = NO;
        [_tipBGView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(_tipBGView);
        }];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"icon_Breakthrought_关闭"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        [_tipBGView addSubview:closeBtn];
        
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_tipBGView);
            make.width.height.mas_equalTo(ScreenScaleX(33));
        }];
        
    }
    
    return _tipBGView;
}

@end
