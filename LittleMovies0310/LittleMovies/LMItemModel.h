//
//  LMItemModel.h
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMItemModel : NSObject
//item
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, strong) NSNumber *number;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
