//
//  PassURL.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/5.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "PassURL.h"

@implementation PassURL
static PassURL *help = nil;
+(PassURL *)sharePass{
    @synchronized(self) {
        if (!help) {
            help = [[PassURL alloc]init];
        }
        return help;
    }
}
@end
