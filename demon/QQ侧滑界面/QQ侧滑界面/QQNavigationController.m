//
//  QQNavigationController.m
//  QQ侧滑界面
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QQNavigationController.h"

@interface QQNavigationController ()

@end

@implementation QQNavigationController

+ (void)initialize {
    //获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    //设置导航条的颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置navigationBar的背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"1.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
