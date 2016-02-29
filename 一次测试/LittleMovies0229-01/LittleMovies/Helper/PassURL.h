//
//  PassURL.h
//  寒假项目
//
//  Created by 韩天旭 on 16/2/5.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailsModel;
@interface PassURL : NSObject
@property (nonatomic,strong)NSNumber *number;
@property (nonatomic,strong)DetailsModel *model;
+(PassURL *)sharePass;
@end
