//
//  AppDelegate.m
//  QQ侧滑界面
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "QQMainView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //在window上创建一个透明的View
    QQMainView *mainView = [[QQMainView alloc] initWithFrame:CGRectMake(-self.window.frame.size.width*0.25,0,self.window.bounds.size.width,self.window.bounds.size.height)];
    //设置冰川背景图
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebar_bg"]];
    image.frame = CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height*0.4);
    
    [self.window addSubview:image];
    [self.window addSubview:mainView];
    
    MainTabBarController *main = [[MainTabBarController alloc] init];
    self.window.rootViewController = main;
    
    
    //    设置window的背景色
    self.window.backgroundColor=[UIColor colorWithRed:13/255.0 green:184/255.0 blue:246/255.0 alpha:1];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
