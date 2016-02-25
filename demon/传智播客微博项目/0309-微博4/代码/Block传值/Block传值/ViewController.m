//
//  ViewController.m
//  Block传值
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "RedView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet RedView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _redView.myBlock = ^(NSString *str){
    
        self.str = str;
    
    };
    
}

- (void)setStr:(NSString *)str
{
    _str = [str copy];
    
    NSLog(@"%@",_str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
