//
//  CZUserTool.h
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//  处理用户业务

#import <Foundation/Foundation.h>
@class CZUserResult;
@interface CZUserTool : NSObject


/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(CZUserResult *result))success failure:(void(^)(NSError *error))failure;

@end
