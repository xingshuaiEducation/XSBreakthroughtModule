//
//  XSBEntanceView.m
//  XSBreakthrought
//
//  Created by suxx on 2017/6/2.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "XSBEntanceView.h"
#import <Masonry.h>

//上面图片的宽高
#define TOP_IMAGE_WIDTH_HEIGHT 62

//下面图片的宽高
#define BOTTOM_IMAGE_WIDTH 39
#define BOTTOM_IMAGE_HEIGHT 17

@interface XSBEntanceView()

//顶部控件
@property (nonatomic, strong)UIImageView *topImageView;
//底部阴影控件
@property (nonatomic, strong)UIImageView *shadowImageView;

@end

#pragma mark - LiftCycle

@implementation XSBEntanceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self prepareSubView];
        
    }
    return self;
}

#pragma mark - Delegate

#pragma mark - Event Handle
-(void)tapAction:(UITapGestureRecognizer *)tapGesture{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

#pragma mark - Private Method
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self addJumpAnimate];
}

-(void)prepareSubView{
    
    [self addSubview:self.topImageView];
    [self addSubview:self.shadowImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
}

-(void)addJumpAnimate{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(TOP_IMAGE_WIDTH_HEIGHT / 2.0, (TOP_IMAGE_WIDTH_HEIGHT + 20) / 2.0)];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(TOP_IMAGE_WIDTH_HEIGHT / 2.0, TOP_IMAGE_WIDTH_HEIGHT / 2.0)];
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = YES;
    
    [self.topImageView.layer addAnimation:animation forKey:@"positionAnimation"];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue = [NSNumber numberWithInteger:.5];
    animation1.toValue = [NSNumber numberWithInteger:1];
    animation1.duration = 1.0f;
    animation1.autoreverses = YES;
    animation1.repeatCount = MAXFLOAT;
    
    [self.shadowImageView.layer addAnimation:animation1 forKey:@"headJumpAnimation"];
}

#pragma mark - Public Method

#pragma mark - Getter 和 Setter
-(UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, TOP_IMAGE_WIDTH_HEIGHT, TOP_IMAGE_WIDTH_HEIGHT)];
        _topImageView.image = [UIImage imageNamed:@"icon_Breakthrought_我要闯关"];
    }
    
    return _topImageView;
}

-(UIImageView *)shadowImageView{
    if (!_shadowImageView) {
        _shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake((TOP_IMAGE_WIDTH_HEIGHT - BOTTOM_IMAGE_WIDTH) / 2.0, 10 + TOP_IMAGE_WIDTH_HEIGHT, BOTTOM_IMAGE_WIDTH, BOTTOM_IMAGE_HEIGHT)];
        _shadowImageView.image = [UIImage imageNamed:@"icon_Breakthrought_我要闯关投影"];
    }
    
    return _shadowImageView;
}

-(void)setTopImage:(UIImage *)topImage{
    _topImage = topImage;
    self.topImageView.image = topImage;
    
    [self setNeedsDisplay];
}

-(void)setShadowImage:(UIImage *)shadowImage{
    _shadowImage = shadowImage;
    self.shadowImageView.image = shadowImage;
    
    [self setNeedsDisplay];
}
     
     

@end
