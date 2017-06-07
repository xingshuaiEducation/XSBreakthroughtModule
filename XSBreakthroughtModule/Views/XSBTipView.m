//
//  XSBTipView.m
//  XSBreakthrought
//
//  Created by suxx on 2017/6/6.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "XSBTipView.h"
#import <Masonry.h>
#import "XSBreakthroughtUtil.h"
#import "XSBreakthroughtUtil.h"

@interface XSBTipView()

@property (nonatomic, strong)__block UIView *tipBGView;
@property (nonatomic, strong)UILabel *descLabel;
@property (nonatomic, strong)UILabel *statueLabel;


@end

@implementation XSBTipView

#pragma mark - LiftCycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareForUI];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Delegate

#pragma mark - Event Handle
-(void)remove{
    [self removeFromSuperview];
}

-(void)bottomMenuAction:(UIButton *)button{
    NSUInteger tag = button.tag - 100;
    
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
    
    animation2.duration = .3f;
    
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
        imageView.image = [UIImage imageNamed:@"icon_Breakthrought_关卡详情"];
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

-(void)setBreakthroughtDesc:(NSString *)breakthroughtDesc{
    if (breakthroughtDesc) {
        _breakthroughtDesc = breakthroughtDesc;
        UILabel *label = [[UILabel alloc] init];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"DFPHaiBaoW12" size:ScreenScaleX(20.0)], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-8, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:breakthroughtDesc attributes:attributeDict];
        label.attributedText = AttributedStr;
        
        self.descLabel = label;
        [self.tipBGView addSubview:label];
        WeakSelf(self);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tipBGView).offset(ScreenScaleY(31.7));
            make.centerX.equalTo(weakSelf.tipBGView);
            make.left.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(36));
            make.right.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(-36));
        }];
    }
}

-(void)setBreakthroughtStatueDes:(NSString *)breakthroughtStatueDes{
    if (breakthroughtStatueDes) {
        _breakthroughtStatueDes = breakthroughtStatueDes;
        UILabel *label = [[UILabel alloc] init];
        self.statueLabel = label;
        [self.tipBGView addSubview:label];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"DFPHaiBaoW12" size:ScreenScaleX(42.0) ], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:breakthroughtStatueDes attributes:attributeDict];
        self.statueLabel.attributedText = AttributedStr;
        
        WeakSelf(self);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tipBGView).offset(ScreenScaleY(84.2));
            make.centerX.equalTo(weakSelf.tipBGView);
            make.left.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(36));
            make.right.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(-36));
        }];
        
    }
}

-(void)setBreakthroughtScore:(NSString *)breakthroughtScore{
    if (breakthroughtScore) {
        _breakthroughtScore = breakthroughtScore;
        UILabel *label = [[UILabel alloc] init];
        self.statueLabel = label;
        [self.tipBGView addSubview:label];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"Georgia-BoldItalic" size:ScreenScaleX(42.0f) ], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-3, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:breakthroughtScore attributes:attributeDict];
        [AttributedStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"DFPHaiBaoW12" size:ScreenScaleX(20.0f) ], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-3, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]} range:NSMakeRange(breakthroughtScore.length-1, 1)];
        self.statueLabel.attributedText = AttributedStr;
        
        WeakSelf(self);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tipBGView).offset(ScreenScaleY(84.2));
            make.centerX.equalTo(weakSelf.tipBGView);
            make.left.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(36));
            make.right.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(-36));
        }];
        
#if 0
        UILabel *slabel = [[UILabel alloc] init];
        [self.tipBGView addSubview:label];
        
        NSDictionary *attributeDict1 = @{NSFontAttributeName:[UIFont systemFontOfSize:20.0f], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"分" attributes:attributeDict1];
        slabel.attributedText = AttributedStr;
        
        [slabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.statueLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(weakSelf.statueLabel.mas_right).offset(ScreenScaleX(10));
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
        }];
#endif
        
    }
}

-(void)setBreakthroughtCondition:(NSString *)breakthroughtCondition{
    if (breakthroughtCondition) {
        _breakthroughtCondition = breakthroughtCondition;
        UILabel *topLabel = [[UILabel alloc] init];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"DFPHaiBaoW12" size:ScreenScaleX(15.0) ], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"通关条件" attributes:attributeDict];
        topLabel.attributedText = AttributedStr;
        
        [self.tipBGView addSubview:topLabel];
        WeakSelf(self);
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tipBGView).offset(ScreenScaleY(171));
            make.left.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(76.6));
        }];
        
        UILabel *bottomLabel = [[UILabel alloc] init];
        
        attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"DFPHaiBaoW12" size:ScreenScaleX(13.0) ], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:breakthroughtCondition attributes:attributeDict];
        bottomLabel.attributedText = AttributedStr1;
        [self.tipBGView addSubview:bottomLabel];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLabel.mas_bottom).offset(ScreenScaleY(7));
            make.left.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(76.6));
        }];
    }
}

-(void)setBreakthroughtedMans:(NSString *)breakthroughtedMans{
    if (breakthroughtedMans) {
        _breakthroughtedMans = breakthroughtedMans;
        UILabel *topLabel = [[UILabel alloc] init];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributeDict = @{NSFontAttributeName:[UIFont fontWithName:@"DFPHaiBaoW12" size:ScreenScaleX(15.0) ], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"已经通关" attributes:attributeDict];
        topLabel.attributedText = AttributedStr;
        [self.tipBGView addSubview:topLabel];
        WeakSelf(self);
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.tipBGView).offset(ScreenScaleY(240));
            make.left.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(76.6));
        }];
        
        UILabel *bottomLabel = [[UILabel alloc] init];
        bottomLabel.text = breakthroughtedMans;
        NSDictionary *attributeDict1 = @{NSFontAttributeName:[UIFont fontWithName:@"DFPHaiBaoW12" size:ScreenScaleX(13.0) ], NSParagraphStyleAttributeName:paragraph, NSForegroundColorAttributeName:[UIColor whiteColor], NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:[XSBreakthroughtUtil colorWithHexString:@"#a65e09"]};
        AttributedStr = [[NSMutableAttributedString alloc]initWithString:breakthroughtedMans attributes:attributeDict1];
        bottomLabel.attributedText = AttributedStr;        [self.tipBGView addSubview:bottomLabel];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLabel.mas_bottom).offset(ScreenScaleY(7));
            make.left.equalTo(weakSelf.tipBGView).offset(ScreenScaleX(76.6));
        }];
    }
}

-(void)setBottomMenu:(NSArray *)bottomMenu{
    if (bottomMenu) {
        _bottomMenu = bottomMenu;
        if (bottomMenu.count == 1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:[bottomMenu lastObject]] forState:UIControlStateNormal];
            button.tag = 100 + 1;
            [button addTarget:self action:@selector(bottomMenuAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.tipBGView addSubview:button];
            
            WeakSelf(self);
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(ScreenScaleY(293.2));
                make.centerX.equalTo(weakSelf.tipBGView);
                make.width.mas_equalTo(ScreenScaleX(105));
                make.height.mas_equalTo(ScreenScaleY(40.6));
            }];
        }else if (bottomMenu.count == 2){
            float x, y, width, height, offsetX;
            x = ScreenScaleX(29);
            y = ScreenScaleX(293.2);
            width = ScreenScaleX(108.7);
            height = ScreenScaleY(40.6);
            offsetX = ScreenScaleX(19.3);
            
            for (int i = 0; i < bottomMenu.count; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setImage:[UIImage imageNamed:bottomMenu[i]] forState:UIControlStateNormal];
                button.tag = 100 + 1;
                [button addTarget:self action:@selector(bottomMenuAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.tipBGView addSubview:button];
                
                WeakSelf(self);
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(y);
                    make.left.equalTo(weakSelf.tipBGView).offset(x);
                    make.width.mas_equalTo(width);
                    make.height.mas_equalTo(height);
                }];
                x += offsetX + width;
            }
        }
    }
}


@end
