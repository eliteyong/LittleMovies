//
//  DetailsModel.h
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailsModel : NSObject
@property (nonatomic,strong)NSDictionary *playurl;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *des;
@property (nonatomic,copy)NSString *directors;
@property (nonatomic,copy)NSString *writers;
@property (nonatomic,copy)NSString *actors;
@property (nonatomic,strong)NSArray *type;
@property (nonatomic,copy)NSString *zone;
@property (nonatomic,copy)NSString *year;
@property (nonatomic,copy)NSString *introduction;
@property (nonatomic,copy)NSString *pubnick;
@property (nonatomic,strong)NSNumber *time;
@property (nonatomic,strong)NSNumber *number;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
