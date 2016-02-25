//
//  CZTabBarController.m
//  传智微博
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZTabBarController.h"
#import "UIImage+Image.h"
#import "CZTabBar.h"

#import <objc/message.h>

@interface CZTabBarController ()

@end

@implementation CZTabBarController

+ (void)initialize
{

    // self -> CZTabBarController
    // 获取当前这个类下面的所有tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 创建属性字典
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
   
    // 设置模型的标题属性修改控件的文字颜色
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    CZTabBar *tabBar = [[CZTabBar alloc] initWithFrame:self.tabBar.frame];

    // 利用KVC把readly的属性改
    [self setValue:tabBar forKeyPath:@"tabBar"];
//    objc_msgSend(self, @selector(setTabBar:),tabBar);

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    home.view.backgroundColor = [UIColor greenColor];
    
    // 消息
    UIViewController *message = [[UIViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    message.view.backgroundColor = [UIColor blueColor];
    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    discover.view.backgroundColor = [UIColor purpleColor];
    

    // 我
    UIViewController *profile = [[UIViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    profile.view.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.badgeValue = @"10";
    vc.tabBarItem.selectedImage = selectedImage;

    [self addChildViewController:vc];
}


@end
