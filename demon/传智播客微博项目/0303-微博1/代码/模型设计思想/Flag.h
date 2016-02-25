//
//  Flag.h
//  模型设计思想
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Flag : NSObject

@property (nonatomic, strong) UIImage *icon;

// 工厂方法
// SubFlag *
+ (instancetype)flag;

@end
