//
//  History.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/17.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "History.h"
#import "LMItemModel.h"

@implementation History
static History *helper = nil;
+ (History *)shareHistory{
    @synchronized(self) {
        if (!helper) {
            helper = [[History alloc]init];
        }
        return helper;
    }
}
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}
- (void)addHistoryModel:(LMItemModel *)model{
    History *history = [History shareHistory];
    for (int i = 0; i < history.dataSource.count; i++) {
        LMItemModel *item = history.dataSource[i];
        if ([model.title isEqualToString:item.title]) {
            [history.dataSource removeObjectAtIndex:i];
        }
    }
    [history.dataSource addObject:model];
}
@end
