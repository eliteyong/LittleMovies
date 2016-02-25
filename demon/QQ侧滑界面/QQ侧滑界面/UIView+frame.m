//
//  UIView+frame.m
//  QQ侧滑界面
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)transformTX {
    return self.transform.tx;
}
- (void)setTransformTX:(CGFloat)transformTX {
    CGAffineTransform transform = self.transform;
    transform.tx = transformTX;
    self.transform = transform;
}

- (CGFloat)transformTY {
    return self.transform.ty;
}
- (void)setTransformTY:(CGFloat)transformTY {
    CGAffineTransform transform = self.transform;
    transform.ty = transformTY;
    self.transform = transform;
}


@end
