//
//  RedView.h
//  Block传值
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// name:block类型的别名
typedef void(^RedViewBlock)(NSString *str);

// 代理：打电话叫别人做事情
// block: 小弟，可以随时让小弟做事情

// 利用block传值，不需要返回值,需要传递什么出去，就写在Block里面
// void(^)(NSString *str)
// block只有在方法中才是 (void(^)(NSString *str)) myBlock

// block不能乱用，一般用来传值
// 代理：一般封装控件的时候用代理,为了代码的扩张性
@interface RedView : UIView
 
// void(^)(NSString *str) 没有返回，参数字符串的block
//@property (nonatomic, strong) void(^myBlock)(NSString *str);
@property (nonatomic, strong) RedViewBlock myBlock;


@end
