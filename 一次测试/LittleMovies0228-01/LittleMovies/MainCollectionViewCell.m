//
//  MainCollectionViewCell.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainCollectionViewCell.h"
#import "LMHeader.h"

@implementation MainCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageV];
        [self addSubview:self.title];
        [self addSubview:self.icon];
    }
    return self;
}
//懒加载
- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * 1.5)];
    }
    return _imageV;
}
- (UILabel *)title{
    if (!_title) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.width * 1.5, self.frame.size.width, 25)];
        self.title.font = [UIFont systemFontOfSize:13];
    }
    return _title;
}
- (UILabel *)icon{
    if (!_icon) {
        self.icon = [[UILabel alloc]initWithFrame:CGRectMake(0,self.imageV.frame.size.height + self.title.frame.size.height, self.frame.size.width, 30)];
        self.icon.font = [UIFont systemFontOfSize:12];
        self.icon.textColor = [UIColor lightGrayColor];
        self.icon.numberOfLines = 2;
    }
    return _icon;
}


@end
