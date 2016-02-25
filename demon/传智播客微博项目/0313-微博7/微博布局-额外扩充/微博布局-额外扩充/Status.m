//
//  Status.m
//  微博布局-额外扩充
//
//  Created by apple on 15-3-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Status.h"

@implementation Status
+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    id status = [[self alloc] init];
    
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}


- (void)setIcon:(NSString *)icon
{
    _icon = [UIImage imageNamed:icon];
}
- (void)setPicture:(NSString *)picture
{
    _picture = [UIImage imageNamed:picture];
}
@end
