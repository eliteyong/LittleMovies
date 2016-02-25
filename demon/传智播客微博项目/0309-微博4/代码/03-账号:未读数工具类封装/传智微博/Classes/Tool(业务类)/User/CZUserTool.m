//
//  CZUserTool.m
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZUserTool.h"

#import "CZUserParam.h"
#import "CZUserResult.h"

#import "CZHttpTool.h"

#import "CZAccountTool.h"
#import "CZAccount.h"
#import "MJExtension.h"

@implementation CZUserTool

+ (void)unreadWithSuccess:(void (^)(CZUserResult *))success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    CZUserParam *param = [CZUserParam param];
    param.uid = [CZAccountTool account].uid;
    
    [CZHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
       
        // 字典转换模型
        CZUserResult *result = [CZUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
