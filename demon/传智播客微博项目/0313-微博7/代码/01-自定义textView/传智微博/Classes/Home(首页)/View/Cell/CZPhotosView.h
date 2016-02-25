//
//  CZPhotosView.h
//  传智微博
//
//  Created by apple on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//  相册View包含所有的配图

#import <UIKit/UIKit.h>

@interface CZPhotosView : UIView

/**
 *  CZPhoto,每一个模型对应一个小配图
 */
@property (nonatomic, strong) NSArray *pic_urls;

@end
