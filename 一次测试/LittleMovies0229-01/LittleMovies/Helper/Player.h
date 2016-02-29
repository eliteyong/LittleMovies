//
//  Player.h
//  寒假项目
//
//  Created by 韩天旭 on 16/2/8.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface Player : NSObject
@property (nonatomic,strong)AVPlayer *player;
+ (Player *)sharePlayer;
@end
