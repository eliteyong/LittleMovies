//
//  OneTableViewCell.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/6.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "OneTableViewCell.h"
#import "LMHeader.h"

#define kAllWidth [UIScreen mainScreen].bounds.size.width - 20
#define kZore 0
#define kHeight 30
#define kTitleWidth kScreenW - 60
#define kScoreWidth 40

#define kDesY 35

#define kBtnWidth 60

#define sBtnX 60
#define sBtnWidth kAllWidth - kBtnWidth

@interface OneTableViewCell ()
@property CGFloat height;
@property (nonatomic,strong)UILabel *daoyan;
@property (nonatomic,strong)UILabel *bianju;
@property (nonatomic,strong)UILabel *zhuyan;
@property (nonatomic,strong)UILabel *leixing;
@property (nonatomic,strong)UILabel *diqu;
@property (nonatomic,strong)UILabel *nianfen;
@end
@implementation OneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatV];
        [self addSubview:self.title];
        [self addSubview:self.score];
        [self addSubview:self.des];
        [self addSubview:self.directors];
        [self addSubview:self.writers];
        [self addSubview:self.actors];
        [self addSubview:self.type];
        [self addSubview:self.zone];
        [self addSubview:self.year];
    }
    return self;
    
}
- (UILabel *)title{
    if (!_title) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore+5, kTitleWidth , kHeight)];
        //        self.title.backgroundColor = [UIColor grayColor];
        self.title.font = [UIFont systemFontOfSize:19];
    }
    return _title;
}
- (UILabel *)score{
    if (!_score) {
        self.score = [[UILabel alloc]initWithFrame:CGRectMake(kTitleWidth, kZore, kScoreWidth , kHeight)];
        //        self.score.backgroundColor = [UIColor purpleColor];
        self.score.textColor = [UIColor orangeColor];
    }
    return _score;
}
- (UILabel *)des{
    if (!_des) {
        self.des = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore, kAllWidth, kHeight)];
        self.des.font = [UIFont systemFontOfSize:16];
        self.des.textColor = [UIColor lightGrayColor];
        self.des.numberOfLines = 0;
    }
    return _des;
}
- (void)creatV{
    self.daoyan = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore, kBtnWidth, kHeight)];
    self.daoyan.text = @"导演:";
    self.daoyan.textColor = [UIColor grayColor];
    [self addSubview:self.daoyan];
    
    self.bianju = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore, kBtnWidth, kHeight)];
    self.bianju.text = @"编剧:";
    self.bianju.textColor = [UIColor grayColor];
    [self addSubview:self.bianju];
    
    self.zhuyan = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore, kBtnWidth, kHeight)];
    self.zhuyan.text = @"主演:";
    self.zhuyan.textColor = [UIColor grayColor];
    [self addSubview:self.zhuyan];
    
    self.leixing = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore, kBtnWidth, kHeight)];
    self.leixing.text = @"类型:";
    self.leixing.textColor = [UIColor grayColor];
    [self addSubview:self.leixing];
    
    self.diqu = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore, kBtnWidth, kHeight)];
    self.diqu.text = @"地区:";
    self.diqu.textColor = [UIColor grayColor];
    [self addSubview:self.diqu];
    
    self.nianfen = [[UILabel alloc]initWithFrame:CGRectMake(kZore, kZore, kBtnWidth, kHeight)];
    self.nianfen.text = @"年份:";
    self.nianfen.textColor = [UIColor grayColor];
    [self addSubview:self.nianfen];
}

- (UILabel *)directors{
    if (!_directors) {
        self.directors = [[UILabel alloc]initWithFrame:CGRectMake(sBtnX, kZore, sBtnWidth, kHeight)];
        self.directors.text = @"不详";
    }
    return _directors;
}
- (UILabel *)writers{
    if (!_writers) {
        self.writers = [[UILabel alloc]initWithFrame:CGRectMake(sBtnX, kZore, sBtnWidth, kHeight)];
        self.writers.text = @"不详";
    }
    return _writers;
}
- (UILabel *)actors{
    if (!_actors) {
        self.actors = [[UILabel alloc]initWithFrame:CGRectMake(sBtnX, kZore, sBtnWidth, kHeight)];
        self.actors.text = @"不详";
        self.actors.numberOfLines = 0;
    }
    return _actors;
}
- (UILabel *)type{
    if (!_type) {
        self.type = [[UILabel alloc]initWithFrame:CGRectMake(sBtnX, kZore, sBtnWidth, kHeight)];
        self.type.text = @"不详";
    }
    return _type;
}
- (UILabel *)zone{
    if (!_zone) {
        self.zone = [[UILabel alloc]initWithFrame:CGRectMake(sBtnX, kZore, sBtnWidth, kHeight)];
        self.zone.text = @"不详";
    }
    return _zone;
}
- (UILabel *)year{
    if (!_year) {
        self.year = [[UILabel alloc]initWithFrame:CGRectMake(sBtnX, kZore, sBtnWidth, kHeight)];
        self.year.text = @"不详";
    }
    return _year;
}
//设置控件高度
- (void)changeHeight{
    //自适应des高度
    self.des.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maxDesLabelSize = CGSizeMake(kAllWidth, MAXFLOAT);
    CGSize expectSize = [self.des sizeThatFits:maxDesLabelSize];
    self.des.frame = CGRectMake(kZore, kDesY, kAllWidth, expectSize.height);
    //改变其他控件高度
    self.daoyan.frame = CGRectMake(kZore, kDesY + expectSize.height + 5, kBtnWidth, kHeight);
    self.bianju.frame = CGRectMake(kZore, kDesY + expectSize.height + 5 + kHeight, kBtnWidth, kHeight);
    self.zhuyan.frame = CGRectMake(kZore, kDesY + expectSize.height + 5 + kHeight*2, kBtnWidth, kHeight);
    self.directors.frame = CGRectMake(sBtnX, kDesY + expectSize.height + 5, sBtnWidth, kHeight);
    self.writers.frame = CGRectMake(sBtnX, kDesY + expectSize.height + 5 + kHeight, sBtnWidth, kHeight);
    self.actors.frame = CGRectMake(sBtnX, kDesY + expectSize.height + 5 + kHeight*2, sBtnWidth, kHeight);
    //自适应actors高度
    self.actors.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maxActorsLabelSize = CGSizeMake(sBtnWidth, MAXFLOAT);
    CGSize expectSizeActors = [self.actors sizeThatFits:maxActorsLabelSize];
    self.actors.frame = CGRectMake(sBtnX, kDesY + expectSize.height + 5 + kHeight*2, sBtnWidth, expectSizeActors.height);
    if (expectSizeActors.height<30) {
        expectSizeActors.height = 30;
    }
    self.height = kDesY + expectSize.height + 5 + kHeight*2 + expectSizeActors.height;
    //改变其他控件高度
    self.leixing.frame = CGRectMake(kZore, self.height, kBtnWidth, kHeight);
    self.type.frame = CGRectMake(sBtnX, self.height, sBtnWidth, kHeight);
    self.diqu.frame = CGRectMake(kZore, self.height + kHeight, kBtnWidth, kHeight);
    self.zone.frame = CGRectMake(sBtnX, self.height + kHeight, sBtnWidth, kHeight);
    self.nianfen.frame = CGRectMake(kZore, self.height + kHeight*2, kBtnWidth, kHeight);
    self.year.frame = CGRectMake(sBtnX, self.height + kHeight*2, sBtnWidth, kHeight);
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
