//
//  ViewController.m
//  微博布局-额外扩充
//
//  Created by apple on 15-3-13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

#import "Status.h"
#import "StatusCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation ViewController

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        
        _statuses = [NSMutableArray array];
        
        // 解析json数据
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"weibo.json" ofType:nil];
        NSData *fileData = [NSData dataWithContentsOfFile:fileName];
        
        // 获取字典数组
        NSArray *dictArr = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
        
        // 字典转模型
        for (NSDictionary *dict in dictArr) {
            
            Status *s = [Status statusWithDict:dict];
            [_statuses addObject:s];
        }
        
    }
    
    return _statuses;
}
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 自定根据布局计算cell的行高
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    // storyboard其实内部就会帮你注册一个cell
//    [self.tableView registerClass:[StatusCell class] forCellReuseIdentifier:ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    // forIndexPath不能使用自己创建的cell
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    /*
        dequeueReusableCellWithIdentifier:
        // 从缓存池里面去取
        // 判断下tableView有没有注册cell，如果有，就直接创建cell
        // 返回nil
     
     */
    
    cell.status = self.statuses[indexPath.row];

    
    return cell;
    
}

@end
