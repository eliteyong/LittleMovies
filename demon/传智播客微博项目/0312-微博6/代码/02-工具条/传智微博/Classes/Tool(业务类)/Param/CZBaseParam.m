//
//  CZBaseParam.m
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZBaseParam.h"
#import "CZAccountTool.h"
#import "CZAccount.h"

@implementation CZBaseParam

+ (instancetype)param
{
    CZBaseParam *param = [[self alloc] init];
    
    param.access_token = [CZAccountTool account].access_token;
    
    return param;
}

@end
