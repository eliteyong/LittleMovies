//
//  CZAccountTool.m
//  传智微博
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZAccountTool.h"
#import "CZAccount.h"
#import "AFNetworking.h"

#import "CZHttpTool.h"
#import "CZAccountParam.h"

#import "MJExtension.h"


#define CZAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define CZClient_id     @"374863808"
#define CZRedirect_uri  @"http://www.baidu.com"
#define CZClient_secret @"1d177228020d69117d71a2178f5f0c84"

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

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    CZAccountParam *param = [[CZAccountParam alloc] init];
    param.client_id = CZClient_id;
    param.client_secret = CZClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = CZRedirect_uri;
    
    [CZHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        CZAccount *account = [CZAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [CZAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
