//
//  LMLaunchViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LMLaunchViewController.h"

@interface LMLaunchViewController ()
{
    UIImageView *_FirstImageV;
    UIImageView *_SecondImageV;
}

@end

@implementation LMLaunchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatImageV];
    [self Animation];
}
- (void)creatImageV{
    _SecondImageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _SecondImageV.contentMode = UIViewContentModeScaleAspectFill;
    _SecondImageV.image = [UIImage imageNamed:@"123.jpg"];
    [self.view addSubview:_SecondImageV];
    
    _FirstImageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _FirstImageV.contentMode = UIViewContentModeScaleAspectFill;
    _FirstImageV.image = [UIImage imageNamed:@"v.jpg"];
    [self.view addSubview:_FirstImageV];
}
- (void)Animation{
   [UIView animateWithDuration:2.f animations:^{
       _FirstImageV.alpha = 0.f;
       _SecondImageV.transform = CGAffineTransformMakeScale(1.1, 1.1);
   } completion:^(BOOL finished) {
       [_FirstImageV removeFromSuperview];
       [UIView animateWithDuration:0.5 animations:^{
           _SecondImageV.alpha = 0;
       } completion:^(BOOL finished) {
           [_SecondImageV removeFromSuperview];
           [self.view removeFromSuperview];
       }];
   }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
