//
//  HistoryViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HistoryViewController.h"
#import "LMHeader.h"

@interface HistoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)History *history;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UICollectionView *collection;

@end

@implementation HistoryViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.collection reloadData];
    [self.dataArray removeAllObjects];
    self.history = [History shareHistory];
    for (int i = 0; i < self.history.dataSource.count; i++) {
        [self.dataArray addObject:self.history.dataSource[self.history.dataSource.count-1-i]];
    }
    if (self.dataArray.count == 0) {
        [self creatLabel];
    }else{
        [self.view addSubview:self.collection];
    }
    [self.collection reloadData];
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"浏览历史";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"关闭"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBack)];
    self.navigationItem.rightBarButtonItem = barBtn;
    // Do any additional setup after loading the view.
    //    NSLog(@"%ld",self.dataArray.count);
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"清除历史" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 80, 40);
    [button addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
-(UICollectionView *)collection{
    if (!_collection) {
        [self creatCollectionV];
    }
    return _collection;
}
- (void)creatCollectionV{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake((kScreenW - 50)/3, 1.5 * (kScreenW - 50)/3 + 55);
    //设置分区缩进
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
    //设置item最小行间距
    layout.minimumLineSpacing = 10;
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"history"];
    [self.view addSubview:_collection];
}
- (void)creatLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, [UIScreen mainScreen].bounds.size.width-40, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.clipsToBounds = YES;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor colorWithWhite:0.439 alpha:1.000].CGColor;
    label.text = @"抱歉,没有浏览记录,因为您还未浏览任何作品";
    [self.view addSubview:label];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"history" forIndexPath:indexPath];
    LMItemModel *model = self.dataArray[indexPath.item];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.icon.text = model.des;
    cell.title.text = model.title;
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LMItemModel *model = self.dataArray[indexPath.item];
    PassURL *pass = [PassURL sharePass];
    pass.number = model.number;
    self.history = [History shareHistory];
    [self.history addHistoryModel:model];
    NSLog(@"%@-----",self.history.dataSource);
    DetailsViewController *detail = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)handleBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)clearHistory {
    self.history = [History shareHistory];
    [self.history removeAllModel];
    [self.dataArray removeAllObjects];
    [self.collection reloadData];
}

@end
