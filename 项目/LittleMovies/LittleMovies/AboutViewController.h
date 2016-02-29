//
//  AboutViewController.h
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutDelegate <NSObject>
- (void)refresh;
@end

@interface AboutViewController : UIViewController
@property (nonatomic, assign)id<AboutDelegate>delegate;
@end
