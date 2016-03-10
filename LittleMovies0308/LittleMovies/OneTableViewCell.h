//
//  OneTableViewCell.h
//  寒假项目
//
//  Created by 韩天旭 on 16/2/6.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *score;
@property (nonatomic,strong)UILabel *des;
@property (nonatomic,strong)UILabel *directors;
@property (nonatomic,strong)UILabel *writers;
@property (nonatomic,strong)UILabel *actors;
@property (nonatomic,strong)UILabel *type;
@property (nonatomic,strong)UILabel *zone;
@property (nonatomic,strong)UILabel *year;
- (void)changeHeight;
@end
