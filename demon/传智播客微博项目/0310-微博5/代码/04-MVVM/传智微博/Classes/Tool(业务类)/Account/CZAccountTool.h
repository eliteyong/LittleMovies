//
//  CZAccountTool.h
//  传智微博
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//  专门处理账号的业务（账号存储和读取）

#import <Foundation/Foundation.h>

@class CZAccount;
@interface CZAccountTool : NSObject

+ (void)saveAccount:(CZAccount *)account;

+ (CZAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
