//
//  SliderTableView.m
//  QQ侧滑界面
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SliderTableView.h"

@interface SliderTableView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation SliderTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //初始化数据
        self.titleArray = @[@"我的商城",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件"];
        self.imageArray = @[@"sidebar_business",@"sidebar_purse",@"sidebar_decoration",@"sidebar_favorit",@"sidebar_album",@"sidebar_file"];
        //设置代理和数据源
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 50;
        self.separatorStyle = NO;
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    //    点击cell时没有点击效果
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    

    
    return cell;
}

@end
