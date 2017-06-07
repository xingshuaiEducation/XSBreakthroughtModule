//
//  XSBreakthroughtModel.m
//  XSBreakthrought
//
//  Created by suxx on 2017/6/2.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "XSBreakthroughtModel.h"

@implementation XSBreakthroughtModel

@end

@implementation XSBreakthroughtMainModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pointCoords = @[@{@"x":@"17", @"y":@"566.5"},
                             @{@"x":@"43", @"y":@"512"},
                             @{@"x":@"133.5", @"y":@"469.5"},
                             @{@"x":@"217", @"y":@"495"},
                             @{@"x":@"310.5", @"y":@"517"},
                             @{@"x":@"322", @"y":@"433"},
                             @{@"x":@"320.5", @"y":@"353.5"},
                             @{@"x":@"198", @"y":@"368.5"},
                             @{@"x":@"133.5", @"y":@"330.5"},
                             @{@"x":@"221.5", @"y":@"281"},
                             @{@"x":@"127", @"y":@"265.5"},
                             @{@"x":@"31", @"y":@"232"},
                             @{@"x":@"117", @"y":@"199.5"},
                             @{@"x":@"284", @"y":@"169"},
                             @{@"x":@"316", @"y":@"97.5"},
                             @{@"x":@"268", @"y":@"49.5"},
                             @{@"x":@"99.5", @"y":@"59.5"},
                             @{@"x":@"25.5", @"y":@"26"}
                             ];
    }
    return self;
}


@end

@implementation XSBreakthroughtStatue

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentPage = self.currentStep = self.currentStatue = 0;
    }
    return self;
}


@end

@implementation XSBreakthroughtListModel


@end

@implementation XSBreakthroughtListsModel


@end
