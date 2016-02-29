//
//  TwoTableViewCell.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/6.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "TwoTableViewCell.h"
#import "LMHeader.h"

#define kZone 0
#define kWidth kScreenW - 20
#define kY 10
@implementation TwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.introduction];
    }
    return self;
}

- (UILabel *)introduction{
    if (!_introduction) {
        self.introduction = [[UILabel alloc]initWithFrame:CGRectMake(kZone, kY, kWidth, kZone)];
        self.introduction.numberOfLines = 0;
//        self.introduction.textColor = [UIColor lightGrayColor];
        self.introduction.font = [UIFont systemFontOfSize:16];
    }
    return _introduction;
}
- (void)changeFrame{
    self.introduction.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize newSize = [self.introduction sizeThatFits:CGSizeMake(kWidth, MAXFLOAT)];
    self.introduction.frame = CGRectMake(kZone, kY, kWidth, newSize.height);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
