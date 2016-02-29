//
//  LMTittleReusableView.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LMTittleReusableView.h"

@implementation LMTittleReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tittle];
        [self addSubview:self.add];
    }
    return self;
}

- (UILabel *)tittle{
    if (!_tittle ) {
        _tittle = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 355, 30)];
        _tittle.font = [UIFont systemFontOfSize:23];
    }
    return _tittle;
}

- (UILabel *)add{
    if (!_add) {
        _add = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 5, 30)];
        _add.backgroundColor = [UIColor orangeColor];
        
    }
    return _add;
}


@end
