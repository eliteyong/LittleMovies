//
//  LMItemModel.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LMItemModel.h"

@implementation LMItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.des = value;
    }else if ([key isEqualToString:@"id"]){
        self.number = value;
    }
}

@end
