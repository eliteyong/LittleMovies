//
//  CZComposeToolBar.h
//  传智微博
//
//  Created by apple on 15-3-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZComposeToolBar;
@protocol CZComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(CZComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end

@interface CZComposeToolBar : UIView

@property (nonatomic, weak) id<CZComposeToolBarDelegate> delegate;

@end
