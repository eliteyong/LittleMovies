//
//  ScreenViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ScreenViewController.h"
#import "LMHeader.h"

#define kAll_Width [UIScreen mainScreen].bounds.size.width
#define kAll_Height [UIScreen mainScreen].bounds.size.height

#define kOrder_Left 0
#define kOrder_Top 64
#define kOrder_Width kAll_Width
#define kOrder_Height 40

#define kCollectionView_Left 0
#define kCollectionView_Top kOrder_Top + kOrder_Height
#define kCollectionView_Width kAll_Width
#define kCollectionView_Height kAll_Height - kOrder_Top - kOrder_Height
@interface ScreenViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIApplicationDelegate>
@property (nonatomic,strong)UICollectionView *collectionV;

@property (nonatomic,assign)NSInteger number;
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ScreenViewController
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.000 green:0.982 blue:0.919 alpha:1.000];
    self.navigationItem.title = @"筛选微电影";
    // Do any additional setup after loading the view.
    [self order];
    [self creatCollectionView];
}
- (void)order{
    orderView *orderV = [[orderView alloc]initWithFrame:CGRectMake(kOrder_Left, kOrder_Top, kOrder_Width, kOrder_Height)];
    [orderV.segmented addTarget:self action:@selector(handleSegmented:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:orderV];
}
- (void)creatCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(kCollectionView_Left, kCollectionView_Top, kCollectionView_Width, kCollectionView_Height) collectionViewLayout:layout];
    self.collectionV.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake((kScreenW - 50)/3, 1.5 * (kScreenW - 50)/3 + 55);
    //设置分区缩进
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
    //设置item最小行间距
    layout.minimumLineSpacing = 10;
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    [_collectionV registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"screen"];
    [self Refreshing:@"time"];
    [self.view addSubview:self.collectionV];
}
- (void)handleSegmented:(UISegmentedControl *)segmented{
    NSInteger index = segmented.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self Refreshing:@"time"];
            break;
        case 1:
            [self Refreshing:@"hits"];
            break;
        case 2:
            [self Refreshing:@"like"];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//请求数据
- (void)RequestData:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.number == 0) {
            [self.dataSource removeAllObjects];
            NSLog(@"~~~~~~~~%ld",self.dataSource.count);
        }
        [self parser:responseObject];
    } failure:nil];
}

- (void)parser:(id)responseObject{
    for (NSDictionary *dic in responseObject) {
        LMItemModel *model = [[LMItemModel alloc]initWithDictionary:dic];
        [self.dataSource addObject:model];
    }
    [self.collectionV reloadData];
    NSLog(@"%ld",self.dataSource.count);
}
//下拉刷新,上拉加载
- (void)Refreshing:(NSString *)type{
    //上拉刷新
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.number = 0;
        NSString *url = [NSString stringWithFormat:@"http://api2.jxvdy.com/search_list?model=video&order=%@&count=15&offset=%ld&type=0",type,self.number];
        [self RequestData:url];
        [self.collectionV.mj_header endRefreshing];
    }];
    [self.collectionV.mj_header beginRefreshing];
    //下拉加载
    self.collectionV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.number += 15;
        NSString *url = [NSString stringWithFormat:@"http://api2.jxvdy.com/search_list?model=video&order=%@&count=15&offset=%ld&type=0",type,self.number];
        [self RequestData:url];
        [self.collectionV.mj_footer endRefreshing];
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"screen" forIndexPath:indexPath];
    LMItemModel *model = self.dataSource[indexPath.item];
    cell.title.text = model.title;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.icon.text = model.des;
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LMItemModel *model = self.dataSource[indexPath.item];
    PassURL *pass = [PassURL sharePass];
    pass.number = model.number;
    History *history = [History shareHistory];
    [history addHistoryModel:model];
    DetailsViewController *details = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:details animated:YES];
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
