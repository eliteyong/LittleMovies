//
//  CZPhotosView.m
//  传智微博
//
//  Created by apple on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZPhotosView.h"
#import "CZPhoto.h"
#import "UIImageView+WebCache.h"

@implementation CZPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        
        // 添加9个子控件
    
        [self setUpAllChildView];

    }
    return self;
}


// 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
#warning TODO：设置配图的内容模式
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        imageV.clipsToBounds = YES;
        [self addSubview:imageV];
    }
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    // 4
    _pic_urls = pic_urls;
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        UIImageView *imageV = self.subviews[i];
        
        if (i < _pic_urls.count) { // 显示
            imageV.hidden = NO;

            // 获取CZPhoto模型
            CZPhoto *photo = _pic_urls[i];
            
            // 赋值
            [imageV sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
        }else{
            imageV.hidden = YES;
        }
        
    }
    
}

// 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
    
    
}
@end
