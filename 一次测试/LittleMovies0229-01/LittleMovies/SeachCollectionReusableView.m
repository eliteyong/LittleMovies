//
//  SeachCollectionReusableView.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/19.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "SeachCollectionReusableView.h"

@implementation SeachCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}
- (UILabel *)label{
    if (!_label) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.bounds.size.width-40, 40)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:16];
        _label.clipsToBounds = YES;
        _label.layer.masksToBounds = YES;
        _label.layer.cornerRadius = 5;
        _label.layer.borderWidth = 1;
        _label.layer.borderColor = [UIColor colorWithWhite:0.439 alpha:1.000].CGColor;
        _label.text = @"抱歉,未找到您所搜索的内容,为您推荐以下作品";
    }
    return _label;
}
@end
