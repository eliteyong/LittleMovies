//
//  MainTabBarController.m
//  QQ侧滑界面
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainTabBarController.h"
#import "UIView+frame.h"
#import "NewsTableViewController.h"
#import "ContacterTableViewController.h"
#import "DynamicTableViewController.h"

#import "QQNavigationController.h"

@interface MainTabBarController ()

@property (nonatomic, strong) UIViewController *viewC;

@end

@implementation MainTabBarController

- (NSString *)name {
    if (!_name) {
        _name = @"消息";
    }
    return _name;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加拖拽
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanEvent:)];
    [self.view addGestureRecognizer:pan];

    [self addAllSubViewControllers];
}

- (void)didPanEvent:(UIPanGestureRecognizer *)recognizer {
    //1.获取手指拖拽的时候平移的值
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    //2.让当前的空间做相应的平移
    recognizer.view.transform = CGAffineTransformTranslate(recognizer.view.transform, translation.x, 0);
    
    [[[UIApplication sharedApplication].delegate window].subviews objectAtIndex:1].transformTX = recognizer.view.transformTX / 3;
    
    //3.每次平移手势识别完毕后，让平移的值不要累加
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    
    //获取最右边范围
    CGAffineTransform rightScopeTransform = CGAffineTransformTranslate([[UIApplication sharedApplication].delegate window].transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);

    //当移动到右边极限时
    if (recognizer.view.transform.tx > rightScopeTransform.tx) {
        //限制最右边的范围
        recognizer.view.transform = rightScopeTransform;
        //限制透明view最右边的范围
        [[[UIApplication sharedApplication].delegate window].subviews objectAtIndex:1].transformTX = recognizer.view.transformTX / 3;
        
    //当移动到最左边的极限时
    } else if (recognizer.view.transformTX < 0.0) {
        //限制最左边的范围
        recognizer.view.transform = CGAffineTransformTranslate([[UIApplication sharedApplication].delegate window].transform,0, 0);
        
        //限制透明View最左边的范围
        [[[UIApplication sharedApplication].delegate window].subviews objectAtIndex:1].transformTX = recognizer.view.transformTX / 3;
    }
    
    //当拖拽手势结束时执行
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
            if (recognizer.view.x > [UIScreen mainScreen].bounds.size.width * 0.5) {
                recognizer.view.transform = rightScopeTransform;
                [[[UIApplication sharedApplication].delegate window].subviews objectAtIndex:1].transformTX = recognizer.view.transformTX / 3;
            } else {
                recognizer.view.transform = CGAffineTransformIdentity;
                [[[UIApplication sharedApplication].delegate window].subviews objectAtIndex:1].transformTX = recognizer.view.transformTX / 3;
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addAllSubViewControllers {
    NewsTableViewController *news = [[NewsTableViewController alloc] init];
    [self addOneChildViewController:news image:[UIImage imageNamed:@"tab_recent_nor"] title:@"消息"];
    
    ContacterTableViewController *contacter = [[ContacterTableViewController alloc] init];
    [self addOneChildViewController:contacter image:[UIImage imageNamed:@"tab_buddy_nor"] title:@"联系人"];
    
    DynamicTableViewController *dynamic = [[DynamicTableViewController alloc] init];
    [self addOneChildViewController:dynamic image:[UIImage imageNamed:@"tab_qworld_nor"] title:@"动态"];
}

- (void)addOneChildViewController:(UIViewController *)vc image:(UIImage *)image title:(NSString *)title {
    vc.title = title;
    vc.tabBarItem.image = image;
    
    QQNavigationController *nav = [[QQNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
