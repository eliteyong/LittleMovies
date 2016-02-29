//
//  LMHeaderReusableView.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LMHeaderReusableView.h"
#import "LMHeader.h"

@implementation LMHeaderReusableView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.title];
        [self addSubview:self.add];
    }
    return self;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(40, 240, kScreenW - 40, 30)];
        _title.font = [UIFont systemFontOfSize:23];
    }
    return _title;
}

- (UILabel *)add {
    if (!_add) {
        _add = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 5, 30)];
        _add.backgroundColor = [UIColor orangeColor];
    }
    return _add;
}


@end
