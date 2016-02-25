//
//  CZAccountTool.m
//  传智微博
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZAccountTool.h"
#import "CZAccount.h"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation CZAccountTool

// 类方法一般用静态变量代替成员属性

static CZAccount *_account;
+ (void)saveAccount:(CZAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:CZAccountFileName];
}

+ (CZAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];

        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    
   
    return _account;
}

@end
