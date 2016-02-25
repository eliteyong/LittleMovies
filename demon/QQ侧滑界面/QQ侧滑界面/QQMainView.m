//
//  QQMainView.m
//  QQ侧滑界面
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QQMainView.h"
#import "SliderTableView.h"

@implementation QQMainView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubViewsForMainView];
    }
    return self;
}

- (void)addSubViewsForMainView {
    //按钮的frame
    CGFloat bX = 30;
    CGFloat bY = 100;
    CGFloat bW = 270;
    CGFloat bH = 60;
    
    //在背景图上添加按钮
    UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(bX, bY, bW, bH)];
    
    //头像的frame
    CGFloat iX = 0;
    CGFloat iY = 0;
    CGFloat iW = headBtn.bounds.size.height;
    CGFloat iH = headBtn.bounds.size.height;
    //在按钮上添加头像
    UIImageView *headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123"]];
    headImage.frame = CGRectMake(iX, iY, iW, iH);
    headImage.layer.cornerRadius = headBtn.bounds.size.height * 0.5;
    headImage.layer.masksToBounds = YES;
    
    //名称的frame
    CGFloat lX = iW + 10;
    CGFloat lY = iY;
    CGFloat lW = iW * 2;
    CGFloat lH = iW * 0.5;
    //在按钮上显示名称
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(lX, lY, lW, lH)];
    headLabel.text = @"不曾走远";
    
    //二维码的frame
    CGFloat qW = headBtn.bounds.size.height;
    CGFloat qH = headBtn.bounds.size.height;
    CGFloat qX = headBtn.bounds.size.width - qW;
    CGFloat qY = 0;
    
    UIButton *qrCode = [[UIButton alloc] initWithFrame:CGRectMake(qX, qY, qW, qH)];
    [qrCode setImage:[UIImage imageNamed:@"sidebar_ QRcode_normal"] forState:UIControlStateNormal];
    
    //创建透明view上的tableView
    SliderTableView *slider = [[SliderTableView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height * 0.4,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height * 0.6 - 48)];
    slider.backgroundColor = [UIColor clearColor];
    
    //创建底部view的按钮
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48 *2, 48)];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
    
    UIButton *dayBtn = [[UIButton alloc] initWithFrame:CGRectMake(48 * 2, 0, 48 * 2, 48)];
    [dayBtn setTitle:@"夜间" forState:UIControlStateNormal];
    [dayBtn setImage:[UIImage imageNamed:@"sidebar_nightmode_on"] forState:UIControlStateNormal];
    
    //创建透明View上的底部View
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-48,[UIScreen mainScreen].bounds.size.width, 48)];
    footView.backgroundColor = [UIColor clearColor];
    
    [footView addSubview:settingBtn];
    [footView addSubview:dayBtn];
    
    [headBtn addSubview:qrCode];
    [headBtn addSubview:headLabel];
    [headBtn addSubview:headImage];
    
    [self addSubview:headBtn];
    [self addSubview:slider];
    [self addSubview:footView];
}

@end
