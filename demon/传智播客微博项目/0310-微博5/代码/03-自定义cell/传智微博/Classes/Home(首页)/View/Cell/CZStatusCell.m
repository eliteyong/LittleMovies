//
//  CZStatusCell.m
//  传智微博
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZStatusCell.h"

#import "CZOriginalView.h"
#import "CZRetweetView.h"
#import "CZStatusToolBar.h"

@interface CZStatusCell ()


@property (nonatomic, weak) CZOriginalView *originalView;
@property (nonatomic, weak) CZRetweetView *retweetView ;
@property (nonatomic, weak)  CZStatusToolBar *toolBar;

@end

@implementation CZStatusCell

// 注意：cell是用initWithStyle初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
    }
    
    return self;
    
}
// 添加所有子控件
- (void)setUpAllChildView
{
    // 原创微博
    CZOriginalView *originalView = [[CZOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    CZRetweetView *retweetView = [[CZRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    CZStatusToolBar *toolBar = [[CZStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

/*
    问题：1.cell的高度应该提前计算出来
         2.cell的高度必须要先计算出每个子控件的frame，才能确定
         3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
    
    解决:MVVM思想
 
 */

- (void)setStatus:(CZStatus *)status
{
    _status = status;
    
    
    // 计算每个子控件的位置
    
    // 赋值
    
}

@end
