//
//  XSBreakthroughtMainVC.m
//  XSBreakthrought
//
//  Created by suxx on 2017/6/2.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "XSBreakthroughtMainVC.h"
#import <Masonry.h>
#import "XSBreakthroughtModel.h"
#import "XSBIntroduceView.h"
#import "XSBreakthroughtManager.h"
#import "XSBTipView.h"

//以iphone6为参考
#define ScreenScaleX(x) x*[UIScreen mainScreen].bounds.size.width/375.0
#define ScreenScaleY(y) y*[UIScreen mainScreen].bounds.size.height/667.0

@interface XSBreakthroughtMainVC ()

@property (nonatomic, strong)XSBreakthroughtMainModel *dataModel;

@property (nonatomic, strong)XSBreakthroughtManager *manager;

@end

@implementation XSBreakthroughtMainVC

#pragma mark - LiftCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if 0 //测试
    XSBreakthroughtStatue *statue = [XSBreakthroughtManager sharedXSBreakthroughtManager].breakthroughtStatue;
    statue.currentPage = 0;
    statue.currentStep = 4;
    statue.currentStatue = FAIL_BREAKTHROUGHT;
#endif
    
    [self prepareForSubView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate


#pragma mark - Event Handle
-(void)bottomMenuAction:(UIButton *)btn{
    NSUInteger tag = btn.tag - 100;
    if (tag == 0) {
        NSLog(@"荣誉榜");
    }else if (tag == 1){
        NSLog(@"说明");
        XSBTipView *bivc = [[XSBTipView alloc] init];
        [self.view addSubview:bivc];
        bivc.breakthroughtDesc = @"电商营销的基础知识点";
//        bivc.breakthroughtStatueDes = @"未解锁...";
        bivc.breakthroughtScore = @"34分";
        bivc.breakthroughtCondition = @"关卡分数达80%";
        bivc.breakthroughtedMans = @"高露洁，佳洁士等7位同学";
        bivc.bottomMenu = @[@"icon_Breakthrought_待解锁", @"icon_Breakthrought_重新闯关"];
        __weak typeof(self) weakSelf = self;
        [bivc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(weakSelf.view);
        }];
    }else if (tag == 2){
        NSLog(@"退出");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Private Method
-(void)prepareForSubView{
    
    self.navigationController.navigationBarHidden = YES;
    
    [self addBackgroundImage];
}

-(void)reloadView{
    
    [self addBottomMenuView];
    
    [self addPoints];
}

-(void)addBackgroundImage{
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [self.view addSubview:bgImageView];
    
    
    NSString *imageName = [NSString stringWithFormat:@"XSBreakthroughMain_%zd", self.manager.breakthroughtStatue.currentPage];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    bgImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    
    __weak typeof(self) weakSelf = self;
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(weakSelf.view);
    }];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    [self.view addSubview:bottomImageView];
    bottomImageView.image = [UIImage imageNamed:@"icon_Breakthrought_底部"];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(ScreenScaleX(344));
        make.height.mas_equalTo(ScreenScaleY(76.6));
    }];
}

-(void)addBottomMenuView{
    NSArray *imageArr = @[@"icon_Breakthrought_荣誉榜", @"icon_Breakthrought_说明", @"icon_Breakthrought_退出"];
    
    float x, y, width, height;
    float oWidth, oHeight, oOffsetX;
    oWidth = oHeight = 60;
    oOffsetX = 40;
    
    
    width = ScreenScaleX(oWidth);
    height = ScreenScaleY(oHeight);
    
    x = ScreenScaleX((375.0-oWidth*imageArr.count - oOffsetX*(imageArr.count-1))/2.0);
    y = ScreenScaleY(600);
    for (int i = 0; i < imageArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, width, height);
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(bottomMenuAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        x += ScreenScaleX(oWidth + oOffsetX);
    }
}

-(void)addPoints{
    
    NSUInteger currentStep = self.manager.breakthroughtStatue.currentStep;
    TBreakthroughtStatue statue = self.manager.breakthroughtStatue.currentStatue;
    
    NSArray *pointArr = self.dataModel.pointCoords;
    float x, y;
    for (int i = 0; i < pointArr.count; i++) {
        NSDictionary *dic = pointArr[i];
        x = [dic[@"x"] floatValue];
        y = [dic[@"y"] floatValue];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenScaleX(x), ScreenScaleY(y), ScreenScaleX(43), ScreenScaleY(28));
        NSString *imageName = @"icon_Breakthrought_未解锁";
        if (i < currentStep) {
            imageName = @"icon_Breakthrought_已通关";
        }else if (i == currentStep){
            if (statue == WAIT_BREAKTHROUGHT) {
                imageName = @"icon_Breakthrought_待通关";
            }else if (statue == WAIT_GRADE){
                imageName = @"icon_Breakthrought_待评分";
            }else if (statue == FAIL_BREAKTHROUGHT){
                imageName = @"icon_Breakthrought_闯关失败";
            }
        }else{
            imageName = @"icon_Breakthrought_未解锁";
        }
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
    }
}


#pragma mark - Public Method

#pragma mark - Getter 和 Setter
-(XSBreakthroughtMainModel *)dataModel{
    if (_dataModel == nil) {
        _dataModel = [[XSBreakthroughtMainModel alloc] init];
    }
    
    return _dataModel;
}

-(XSBreakthroughtManager *)manager{
    if (!_manager) {
        _manager = [XSBreakthroughtManager sharedXSBreakthroughtManager];
    }
    
    return _manager;
}

@end
