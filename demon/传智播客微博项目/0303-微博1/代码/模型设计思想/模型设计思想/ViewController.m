//
//  ViewController.m
//  模型设计思想
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Flag.h"
#import "SubFlag.h"

@interface ViewController ()

@end

@implementation ViewController
//z
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   SubFlag *subFlag = [SubFlag flag];
    
   subFlag.age = 123;
    
//    UIImageView *iamgeV = [[UIImageView alloc] init];
//    iamgeV.image = flag.icon;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
