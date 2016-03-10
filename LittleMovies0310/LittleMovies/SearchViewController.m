//
//  SearchViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SearchViewController.h"
#import "LMHeader.h"

typedef NS_ENUM(NSInteger,Header) {
    isHeader,
    notHeader
};
@interface SearchViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UISearchBar *seach;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UICollectionView *collection;
@property (nonatomic,assign)Header header;
@end

@implementation SearchViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.seach becomeFirstResponder];
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(handleSeach)];
    // Do any additional setup after loading the view.
    self.seach = [[UISearchBar alloc]init];
    self.seach.placeholder = @"搜索微电影";
    self.seach.delegate = self;
    self.navigationItem.titleView = self.seach;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"关闭"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBack)];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (UICollectionView *)collection{
    if (!_collection) {
        [self creatCollectionV];
    }
    return _collection;
}
- (void)creatCollectionV{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake((kScreenW - 50)/3, 1.5 * (kScreenW - 50)/3 + 55);
    //设置分区缩进
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
    //设置item最小行间距
    layout.minimumLineSpacing = 10;
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"seach"];
    [_collection registerClass:[MainCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"seachHead"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    return self.dataArray.count;
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LMItemModel *model = self.dataSource[indexPath.item];
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"seach" forIndexPath:indexPath];
    cell.title.text = model.title;
    cell.icon.text = model.des;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.img]];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (self.header == isHeader) {
            SeachCollectionReusableView *header = [self.collection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"seachHead" forIndexPath:indexPath];
            return header;
        }
    }return nil;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *details = [[DetailsViewController alloc]init];
    LMItemModel *model = self.dataSource[indexPath.item];
    PassURL *pass = [PassURL sharePass];
    pass.number = model.number;
    History *history = [History shareHistory];
    [history addHistoryModel:model];
    [self.navigationController pushViewController:details animated:YES];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.header == isHeader) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    }
    return CGSizeMake(0, 0);
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self handleSeach];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)handleSeach{
    [self.dataSource removeAllObjects];
    NSString *str = [NSString stringWithFormat:@"http://api2.jxvdy.com/search_list?model=screenplay&count=15&keywords=%@&token=",self.seach.text];
    NSString *newStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:newStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self parser:responseObject];
        [self.view addSubview:self.collection];
        if (self.header == isHeader) {
            [manager GET:@"http://api2.jxvdy.com/search_list?model=screenplay&&order=random&count=15&attr=2" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [self parserIsHeader:responseObject];
                [self.collection reloadData];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
        [self.collection reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       // NSLog(@"搜索失败");
    }];
    [self.seach resignFirstResponder];
}
- (void)parser:(id)responseObject{
    for (NSDictionary *dic in responseObject) {
        LMItemModel *model = [[LMItemModel alloc]initWithDictionary:dic];
        [self.dataSource addObject:model];
    }
    if (self.dataSource.count == 0) {
        self.header = isHeader;
    }else{
        self.header = notHeader;
    }
}
- (void)parserIsHeader:(id)responseObject{
    for (NSDictionary *dic in responseObject) {
        LMItemModel *model = [[LMItemModel alloc]initWithDictionary:dic];
        [self.dataSource addObject:model];
    }
}
- (void)handleBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
