//
//  Video.h
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,isPlayingOrpause) {
    isPlaying,
    isPause
};

@interface Video : UIView
@property (nonatomic, assign) isPlayingOrpause play_pause;

@end
