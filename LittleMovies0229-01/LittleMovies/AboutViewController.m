//
//  AboutViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AboutViewController.h"
#import "LMHeader.h"

@interface AboutViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation AboutViewController
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PassURL *pass = [PassURL sharePass];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://api2.jxvdy.com/video_related?id=%@&count=6&offset=0",[pass.number stringValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self parseItem:responseObject];
        [self creatCollectionView];
    } failure:nil];
}
- (void)parseItem:(id)responseObject{
    for (NSDictionary *dic in responseObject) {
        LMItemModel *model = [[LMItemModel alloc]initWithDictionary:dic];
        [self.dataSource addObject:model];
       // NSLog(@"%@",model.title);
    }
}
- (void)creatCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    layout.itemSize = CGSizeMake((kScreenW - 50)/3, 1.5 * (kScreenW - 50)/3 + 55);
    //设置分区缩进
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    layout.minimumLineSpacing = 11;
    collection.delegate = self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collection];
    [collection registerClass:[AboutCollectionViewCell class] forCellWithReuseIdentifier:@"about"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AboutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"about" forIndexPath:indexPath];
    LMItemModel *model = self.dataSource[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.title.text = model.title;
    cell.icon.text = model.des;
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LMItemModel *model = self.dataSource[indexPath.item];
//    NSLog(@"%@",model.number);
//    NSLog(@"%@",[model.number stringValue]);
    [self detailsPassModel:[model.number stringValue]];
    History *history = [History shareHistory];
    [history addHistoryModel:model];
}
//获取详情数据
- (void)detailsPassModel:(NSString *)number{
    NSString *url = @"http://api2.jxvdy.com/video_info?token=(null)&id=";
    NSString *getStr = [url stringByAppendingString:number];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self parserDetail:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       // NSLog(@"%@",error);
    }];
}
- (void)parserDetail:(id)responseObject{
    DetailsModel *model = [[DetailsModel alloc]initWithDictionary:responseObject];
    PassURL *pass = [PassURL sharePass];
    pass.model = model;
    [self.delegate refresh];
    
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
