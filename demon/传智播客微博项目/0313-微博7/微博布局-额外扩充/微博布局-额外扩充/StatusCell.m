//
//  StatusCell.m
//  微博布局-额外扩充
//
//  Created by apple on 15-3-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "StatusCell.h"
#import "Status.h"

@interface StatusCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PictureHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginCons;

@end

@implementation StatusCell

- (void)setStatus:(Status *)status
{
    _status = status;
    
    // 头像
    _iconView.image = status.icon;
    
    // 昵称
    _nameView.text = status.name;
    
    if (status.vip) {
        _vipView.hidden = NO;
    }else{
        _vipView.hidden = YES;
    }
    
    _textView.text = status.text;
    
    // 设置配图
    if (status.picture) {
        _pictureView.image = status.picture;
//        _pictureView.hidden = NO;
        
        _PictureHeightCons.constant = 70;
        _marginCons.constant = 10;
    }else{
//        _pictureView.hidden = YES;
        _marginCons.constant= 0;
        _PictureHeightCons.constant = 0;
    }
    
}
@end
