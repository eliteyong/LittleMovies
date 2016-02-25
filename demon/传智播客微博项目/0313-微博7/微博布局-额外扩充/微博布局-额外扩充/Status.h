//
//  Status.h
//  微博布局-额外扩充
//
//  Created by apple on 15-3-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 {
 "vip" : 1,
 "icon" : "50.jpeg",
 "name" : "笑多了会怀孕",
 "text" : "妈妈说，女人一定要爱自己的脸，别人打你左脸，你再把右脸伸过去让他打，不然粉底不一样厚。"
 },
 */
@interface Status : NSObject
/**
 *  会员
 */
@property (nonatomic, assign) BOOL vip;
/**
 *  图片
 */
@property (nonatomic, strong) UIImage *icon;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  正文
 */
@property (nonatomic, copy) NSString *text;


/**
 *  配图
 */
@property (nonatomic, strong) UIImage *picture;


+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
