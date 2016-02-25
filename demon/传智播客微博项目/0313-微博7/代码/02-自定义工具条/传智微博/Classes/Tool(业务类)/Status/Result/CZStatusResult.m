//
//  CZStatusResult.m
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZStatusResult.h"

#import "CZStatus.h"
@implementation CZStatusResult
// 告诉MJ框架，数组里的字典转换成哪个模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[CZStatus class]};
}
@end
