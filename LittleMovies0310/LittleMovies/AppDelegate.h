//
//  AppDelegate.h
//  LittleMovies
//
//  Created by qingyun on 16/2/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMHeader.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MMDrawerController *MMDrawerVC;
@property (nonatomic, strong) LMDrawerViewController *leftDrawerVC;
@property (nonatomic, strong) LMNavigationController *LMNavigationVC;

@end

