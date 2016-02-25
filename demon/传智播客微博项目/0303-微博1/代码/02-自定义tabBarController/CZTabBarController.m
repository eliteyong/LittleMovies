//
//  CZTabBarController.m
//  传智微博
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZTabBarController.h"
#import "UIImage+Image.h"

@interface CZTabBarController ()

@end

@implementation CZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self setUpAllChildViewController];

    
}
// 在ios7之后，默认会把UITabBar上面的按钮图片渲染成蓝色
#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    home.tabBarItem.title = @"首页";
    home.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    home.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_home_selected"];
    
    home.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:home];
    
    // 消息
    UIViewController *message = [[UIViewController alloc] init];
    message.tabBarItem.title = @"消息";
    message.view.backgroundColor = [UIColor blueColor];
    
    [self addChildViewController:message];
    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    
    discover.view.backgroundColor = [UIColor purpleColor];
    
    [self addChildViewController:discover];
    
    // 我
    UIViewController *profile = [[UIViewController alloc] init];
    
    profile.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addChildViewController:profile];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
