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

// 什么时候调用：程序一启动的时候就会把所有的类加载进内存
// 作用：加载类的时候调用
//+ (void)load
//{
//    
//}

// 什么调用：当第一次使用这个类或者子类的时候调用
// 作用：初始化类

// appearance只要一个类遵守UIAppearance，就能获取全局的外观，UIView

+ (void)initialize
{
    // 获取所有的tabBarItem外观标识
//    UITabBarItem *item = [UITabBarItem appearance];
    
    // self -> CZTabBarController
    // 获取当前这个类下面的所有tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    [att setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    CZTabBar *tabBar = [[CZTabBar alloc] initWithFrame:self.tabBar.frame];

    NSLog(@"%@",self.tabBar);
    // 利用KVC把readly的属性改
    [self setValue:tabBar forKeyPath:@"tabBar"];
//    objc_msgSend(self, @selector(setTabBar:),tabBar);
    NSLog(@"%@",self.tabBar);
//    self.tabBar = tabBar;
    // 修改系统tabBar上面的按钮的位置
//    NSLog(@"%@",self.tabBar.subviews);
//    
//    self.tabBar =
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}



// Item:就是苹果的模型命名规范
// tabBarItem:决定着tabBars上按钮的内容
// 如果通过模型设置控件的文字颜色，只能通过文本属性（富文本：颜色，字体，空心，阴影，图文混排）

// 在ios7之后，默认会把UITabBar上面的按钮图片渲染成蓝色
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
