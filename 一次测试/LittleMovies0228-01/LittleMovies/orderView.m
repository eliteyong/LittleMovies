//
//  orderView.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/9.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "orderView.h"
#import "LMHeader.h"
#define kSegmented_Left 20
#define kSegmented_Top 5
#define kSegmented_Width kScreenW - 40
#define kSegmented_Height 30
@implementation orderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.000 green:0.982 blue:0.919 alpha:1.000];
        [self addSubview:self.segmented];
    }
    return self;
}
- (UISegmentedControl *)segmented{
    if (!_segmented) {
        self.segmented = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"最热",@"好评"]];
        self.segmented.frame = CGRectMake(kSegmented_Left, kSegmented_Top, kSegmented_Width, kSegmented_Height);
        self.segmented.tintColor = [UIColor orangeColor];
        self.segmented.selectedSegmentIndex = 0;
    }
    return _segmented;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
