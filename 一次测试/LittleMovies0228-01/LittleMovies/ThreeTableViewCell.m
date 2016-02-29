//
//  ThreeTableViewCell.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/6.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "ThreeTableViewCell.h"
#import "LMHeader.h"
#define kWidth kScreenW - 20

@implementation ThreeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.pubnick];
        [self addSubview:self.time];
        [self addSubview:self.publish];
    }
    return self;
}

- (UIButton *)pubnick{
    if (!_pubnick) {
        self.pubnick = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pubnick.frame = CGRectMake(0, 0, 140, 30);
        [self.pubnick setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _pubnick;
}
- (UILabel *)time{
    if (!_time) {
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(210, 0, kWidth-140-40-60, 30)];
        
    }
    return _time;
}
- (UILabel *)publish{
    if (!_publish) {
        self.publish = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 60, 30)];
        self.publish.text = @"发布于:";
    }
    return _publish;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
