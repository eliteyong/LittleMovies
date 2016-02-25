//
//  RedView.m
//  Block传值
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RedView.h"

@implementation RedView
/*
    传值的条件：
    接收方必须要有一个属性接收
    什么时候传值：点击view，通知控制器接收值
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (_myBlock) {
        _myBlock(@"红色");
    }
    
//    block();
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
