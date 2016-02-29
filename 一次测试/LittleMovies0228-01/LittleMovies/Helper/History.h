//
//  History.h
//  寒假项目
//
//  Created by 韩天旭 on 16/2/17.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LMItemModel;
@interface History : NSObject
@property (nonatomic,strong)NSMutableArray *dataSource;
+ (History *)shareHistory;
//添加model
- (void)addHistoryModel:(LMItemModel *)model;

//删除所有的model
- (void)removeAllModel;
@end
