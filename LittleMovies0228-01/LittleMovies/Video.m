//
//  Video.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Video.h"
#import "LMHeader.h"

typedef NS_ENUM(NSUInteger,isHiddenY_N) {
    isHinY,
    isHinN
};
#define kViewLeft 0
#define kViewTop 220
#define kViewWidth [UIScreen mainScreen].bounds.size.width
#define kViewHeight 40

#define kZore 0

#define kBtnLeft 10
#define kBtnWidth 40
#define kBtnHeight 40

#define kSliderLeft kTimeCurrentLeft + kTimeCurrentWidth + 10
#define kSliderTop 0
#define kSliderWidth 200
#define kSliderHeight 40

#define kRepeatBtnX 140
#define kRepeatBtnY 100
#define kRepeatBtnWidth 80
#define kRepeatBtnHeight 80

#define kTimeCurrentLeft kBtnLeft + kBtnWidth + 10
#define kTimeCurrentWidth 42
#define kTimeCurrentHeight 40

#define kTimeDurationLeft kSliderLeft + kSliderWidth + 10
#define kTimeDurationWidth kTimeCurrentWidth
#define kTimeDurationHeight kTimeCurrentHeight
@interface Video ()
@property (nonatomic,strong)UIView *AVPlayView;
@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,assign)isHiddenY_N HidY_N;

@property (nonatomic,strong)AVPlayerItem *item;
//AVPlayer视频播放是在layer层,该类表示播放的层
@property (nonatomic,retain)AVPlayerLayer *AVlayer;
//负责保存资源的信息
@property (nonatomic,strong)AVURLAsset *asset;
@property (nonatomic,strong)UISlider *slider;
@property (nonatomic,strong)UIButton *repeat;
@property (nonatomic,strong)UILabel *timeCurrent;
@property (nonatomic,strong)UILabel *timeDuration;
@property (nonatomic,strong)UIButton *btn;
@end
@implementation Video
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.AVPlayView];
        [self addSubview:self.repeat];
        [self addSubview:self.backgroundView];
        self.backgroundColor = [UIColor blackColor];
        [self creatVideo:frame];
        [self creatBtn];
        [self creatSlider];
    }
    return self;
    
}
- (UIView *)AVPlayView{
    if (!_AVPlayView) {
        self.AVPlayView = [[UIView alloc]initWithFrame:self.bounds];
        //        self.AVPlayView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
        [self.AVPlayView addGestureRecognizer:tap];
    }
    return _AVPlayView;
}

- (void)creatVideo:(CGRect)frame{
    PassURL *pass =[PassURL sharePass];
    NSString *url = [NSString string];
    if (pass.model.playurl[@"360P"]) {
        url = pass.model.playurl[@"360P"];
    }else{
        url = pass.model.playurl[@"720P"];
    }
    
    Player *play = [Player sharePlayer];
    self.item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    play.player = [AVPlayer playerWithPlayerItem:self.item];
    self.AVlayer = [AVPlayerLayer playerLayerWithPlayer:play.player];
    self.AVlayer.frame = self.AVPlayView.bounds;
    [self.AVPlayView.layer addSublayer:self.AVlayer];
    [play.player play];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handleProgress) userInfo:nil repeats:YES];
    //添加观察者
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    
}
- (UIView *)backgroundView{
    if (!_backgroundView) {
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(kViewLeft,kViewTop,kViewWidth, kViewHeight)];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        //在其上添加时间控件
        [self.backgroundView addSubview:self.timeCurrent];
        [self.backgroundView addSubview:self.timeDuration];
        self.backgroundView.hidden = YES;
        self.HidY_N = isHinY;
    }
    return _backgroundView;
}
//暂停/开始
- (void)creatBtn{
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(kBtnLeft, kZore, kBtnWidth, kBtnHeight);
    [_btn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(handlePlay:) forControlEvents:UIControlEventTouchUpInside];
    self.play_pause = isPlaying;
    [self.backgroundView addSubview:_btn];
}
- (void)handlePlay:(UIButton *)btn{
    Player *play = [Player sharePlayer];
    if (self.play_pause == isPlaying) {
        [play.player pause];
        [btn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        self.play_pause = isPause;
    }else{
        [play.player play];
        [btn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        self.play_pause = isPlaying;
    }
}
//进度
- (void)creatSlider{
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(kSliderLeft, kSliderTop, kSliderWidth, kSliderHeight)];
    _slider.minimumTrackTintColor = [UIColor orangeColor];
    _slider.maximumTrackTintColor = [UIColor grayColor];
    _slider.thumbTintColor = [UIColor orangeColor];
    [_slider setThumbImage:[UIImage imageNamed:@"h"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"h"] forState:UIControlStateHighlighted];
    [self.backgroundView addSubview:_slider];
    [_slider addTarget:self action:@selector(handleSlider:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(handleOutside:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)handleSlider:(UISlider *)slider{
    Player *play = [Player sharePlayer];
    [play.player seekToTime: CMTimeMake(CMTimeGetSeconds(play.player.currentItem.duration) * slider.value, 1) ];
    [_btn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
}
- (void)handleOutside:(UISlider *)slider{
    if (self.play_pause == isPlaying) {
        [_btn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    }
    Player *play = [Player sharePlayer];
    if (self.play_pause == isPlaying) {
        [play.player play];
    }else{
        [play.player pause];
    }
}
//监控进度
- (void)handleProgress{
    Player *play = [Player sharePlayer];
    self.slider.value = CMTimeGetSeconds(play.player.currentTime)/CMTimeGetSeconds(play.player.currentItem.duration);
    if (self.slider.value == 1.0) {
        self.repeat.hidden = NO;
    }
}
//重播
- (UIButton *)repeat{
    if (!_repeat) {
        self.repeat = [UIButton buttonWithType:UIButtonTypeCustom];
        self.repeat.frame = CGRectMake(kRepeatBtnX, kRepeatBtnY,kRepeatBtnWidth , kRepeatBtnHeight);
        self.repeat.backgroundColor = [UIColor clearColor];
        [self.repeat setBackgroundImage:[UIImage imageNamed:@"repeat"] forState:UIControlStateNormal];
        [self.repeat addTarget:self action:@selector(handleRepeat) forControlEvents:UIControlEventTouchUpInside];
        self.repeat.hidden = YES;
    }
    return _repeat;
}
- (void)handleRepeat{
    Player *play = [Player sharePlayer];
    self.slider.value = 0;
    [play.player seekToTime:CMTimeMake(0, 1)];
    [play.player play];
    self.repeat.hidden = YES;
}
//设置轻拍手势
- (void)handleTap{
    //    [self bringSubviewToFront:self.backgroundView];
    //    [self performSelector:@selector(handleDealy) withObject:nil afterDelay:5];
    if (self.HidY_N == isHinY) {
        self.backgroundView.hidden = NO;
        self.HidY_N = isHinN;
    }else{
        self.backgroundView.hidden = YES;
        self.HidY_N = isHinY;
    }
}
//播放时间
- (UILabel *)timeCurrent{
    if (!_timeCurrent) {
        self.timeCurrent = [[UILabel alloc]initWithFrame:CGRectMake(kTimeCurrentLeft, kZore, kTimeCurrentWidth, kTimeCurrentHeight)];
        self.timeCurrent.textColor = [UIColor whiteColor];
        self.timeCurrent.font = [UIFont systemFontOfSize:15];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(handleTimeCurrent) userInfo:nil repeats:YES];
    }
    return _timeCurrent;
}
- (UILabel *)timeDuration{
    if (!_timeDuration) {
        self.timeDuration = [[UILabel alloc]initWithFrame:CGRectMake(kTimeDurationLeft, kZore, kTimeDurationWidth, kTimeDurationHeight)];
        self.timeDuration.textColor = [UIColor whiteColor];
        self.timeDuration.font = [UIFont systemFontOfSize:15];
    }
    return _timeDuration;
}
//监控时间
- (void)handleTimeCurrent{
    Player *play = [Player sharePlayer];
    self.timeCurrent.text = [self getTimeString:play.player.currentTime.value/play.player.currentTime.timescale];
}

-(NSString *)getTimeString:(CGFloat)timeInterval
{
    NSInteger hour = timeInterval / 3600.f;
    NSInteger minute = (timeInterval - hour * 3600.f) / 60.f;
    NSInteger second = timeInterval - hour * 3600.f - minute * 60.f;
    
    if(hour > 0)
    {
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld",(long)hour,(long)minute,(long)second];
    }
    else
    {
        return [NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second];
    }
}
//观察属性变化触发的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    Player *play = [Player sharePlayer];
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerStatusReadyToPlay:
            { NSTimeInterval duration = CMTimeGetSeconds(play.player.currentItem.duration);
                self.timeDuration.text = [self getTimeString:duration];
            }
                break;
            default:
                break;
        }
    }
}
@end