//
//  Player.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/8.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "Player.h"

@implementation Player
static Player *play = nil;
+ (Player *)sharePlayer{
    @synchronized(self) {
            if (!play) {
        play = [[Player alloc]init];
        }
        return play;
    }
}

//+ (Player *)sharePlayer {
//    static Player *play;
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//        play = [[Player alloc] init];
//    });
//    return play;
//}
- (AVPlayer *)player{
    if (!_player) {
        self.player = [[AVPlayer alloc]init];
    }
    return _player;
}
@end
