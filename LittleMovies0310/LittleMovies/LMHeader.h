//
//  LMHeader.h
//  LittleMovies
//
//  Created by qingyun on 16/2/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef LMHeader_h
#define LMHeader_h


#import "MainViewController.h"
#import "LMDrawerViewController.h"
#import "LMNavigationController.h"


#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "AppDelegate.h"

#import "LMHeaderReusableView.h"
#import "LMTittleReusableView.h"
#import "MainCollectionViewCell.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "LMItemModel.h"

#import "SDCycleScrollView.h"

#import "DetailsViewController.h"
#import "DetailsModel.h"
#import "PassURL.h"
#import "Player.h"
#import "History.h"


#import <AVFoundation/AVFoundation.h>
#import "Video.h"
#import "AboutCollectionViewCell.h"
#import "AboutViewController.h"
#import "DetailsTableViewController.h"

#import "ScreenViewController.h"
#import "orderView.h"

#import "MJRefresh.h"

#import "HistoryViewController.h"
#import "SearchViewController.h"

#import "SeachCollectionReusableView.h"

#define kBtnWidthAndHeight 80
//#define kBtnX 100
//#define kBtnNX 80
//#define kBtnSeachY 120
//#define kBtnHistoryY kBtnSeachY + 160

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


#define cScreenW [UIScreen mainScreen].bounds.size.width*3/4
#define kBtnNX (cScreenW - 80)/2 - 20
#define kBtnX (cScreenW - 80)/2
#define kBtnSeachY kScreenH/2 -120
#define kBtnHistoryY kBtnSeachY + 160

#endif /* LMHeader_h */
