//
//  MainViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "LMHeader.h"

@interface MainViewController () <UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) AppDelegate *APPDelegate;

@property (nonatomic, strong) MMDrawerBarButtonItem *leftBBI;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2;
@property (nonatomic, strong) NSMutableArray *scrollDataSource;
@property (nonatomic, strong) NSMutableArray *itemDataSource;
@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, strong) UICollectionView *collection;


@end

@implementation MainViewController

#pragma mark - 懒加载
- (MMDrawerBarButtonItem *)leftBBI {
    if (!_leftBBI) {
        _leftBBI = [[MMDrawerBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"个人"] style:UIBarButtonItemStyleDone target:self action:@selector(handleChoose:)];
    }
    return _leftBBI;
}
- (void)handleChoose:(MMDrawerBarButtonItem *)btn{
    [self.APPDelegate.MMDrawerVC openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished){
        [self drawerAnimate];
    }];

}

- (NSMutableArray *)itemDataSource{
    if (!_itemDataSource) {
        _itemDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _itemDataSource;
}
- (NSMutableArray *)scrollDataSource{
    if (!_scrollDataSource) {
        _scrollDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _scrollDataSource;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftBBI;
    self.navigationItem.title = @"微电影";
    
    //self.lock = [[NSLock alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatScreenAndFind];
    
    [self creatCollectionView];

    [self creatDrawer];//添加抽屉效果
}

#pragma mark - 添加collectionView
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, kScreenW, kScreenH - 104) collectionViewLayout:layout];
    //这里设置collection的背景颜色
    collection.backgroundColor = [UIColor whiteColor];
    layout.itemSize = CGSizeMake((kScreenW - 50)/3, 1.5 * (kScreenW - 50)/3 + 55);
    //设置分区缩进
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 15);
    //设置item最小行间距
    layout.minimumLineSpacing = 10;
    collection.delegate = self;
    collection.dataSource = self;
    [self.view addSubview:collection];
    self.collection = collection;
    //注册
    [self.collection registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"xxx"];
    [self.collection registerClass:[LMTittleReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ooo"];
    [self.collection registerClass:[LMHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"qqq"];

    //[collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //网络请求数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api2.jxvdy.com/search_list?model=video&count=6&order=time&direction=1&attr=2" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [self parseItem:responseObject];
        [self.collection reloadData];
        
        [manager GET:@"http://api2.jxvdy.com/search_list?model=video&zone=23&order=random&count=6&attr=2" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [self parseItem:responseObject];
            [self.collection reloadData];
            [manager GET:@"http://api2.jxvdy.com/search_list?model=video&zone=24&order=random&count=6&attr=2" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [self parseItem:responseObject];
                [self.collection reloadData];
            } failure:nil];
        } failure:nil];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
//item数据
- (void)parseItem:(id)obj {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *dict in obj) {
        LMItemModel *model = [[LMItemModel alloc] initWithDictionary:dict];
        [arr addObject:model];
        [self.lock lock];
    }
    [self.itemDataSource addObject:arr];
    [self.lock unlock];
    //NSLog(@"%d",[self.itemDataSource.firstObject count]);
}
//滚动视图的数据
- (void)parseScroll:(id)responseObject {
    for (NSDictionary *dict in responseObject) {
        LMItemModel *model = [[LMItemModel alloc] initWithDictionary:dict];
        [self.scrollDataSource addObject:model];
    }
}

#pragma mark - collectionView的代理和数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.itemDataSource[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   // NSLog(@"%d",self.itemDataSource.count);
    return self.itemDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"xxx" forIndexPath:indexPath];;
    LMItemModel *model = self.itemDataSource[indexPath.section][indexPath.row];
    
    cell.title.text = model.title;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.icon.text = model.des;
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
//设置section的高度（大小）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return CGSizeMake(kScreenW, 270);
            break;
        default:
            return CGSizeMake(kScreenW, 50);
            break;
    }
}

//设置每个section的头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        switch (indexPath.section) {
            case 0:{
                //设置轮播图
                LMHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"qqq" forIndexPath:indexPath];
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager GET:@"http://api2.jxvdy.com/focus_pic?name=video" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    //NSLog(@"%@",responseObject);
                    [self parseScroll:responseObject];
                    LMItemModel *model1 = self.scrollDataSource[0];
                    LMItemModel *model2 = self.scrollDataSource[1];
                    LMItemModel *model3 = self.scrollDataSource[2];
                    NSArray *arr = @[model1.img,model2.img,model3.img];
                    NSArray *arr2 = @[model1.title,model2.title,model3.title];
                    self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, 220) imageURLStringsGroup:arr];
                    _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                    _cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
                    _cycleScrollView2.titlesGroup = arr2;
                    _cycleScrollView2.delegate = self;
                    [header addSubview:_cycleScrollView2];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];
                header.title.text = @"佳作推荐";
                return header;
                break;
            }

            case 1: {
                LMTittleReusableView *tittleHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ooo" forIndexPath:indexPath];
                tittleHeader.tittle.text = @"国内作品";
                return tittleHeader;
                break;
            }
            case 2: {
                LMTittleReusableView *tittleHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ooo" forIndexPath:indexPath];
                tittleHeader.tittle.text = @"国外作品";
                return tittleHeader;
                break;
            }

            default:
                return nil;
                break;
        }
    } else {
        return nil;
    }
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    LMItemModel *model = self.scrollDataSource[index];
    PassURL *pass = [PassURL sharePass];
    pass.number = model.number;
    History *history = [History shareHistory];
    [history addHistoryModel:model];
    DetailsViewController *details = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark - 选中item触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LMItemModel *model = self.itemDataSource[indexPath.section][indexPath.row];
    PassURL *pass = [PassURL sharePass];
    pass.number = model.number;
    History *history = [History shareHistory];
    [history addHistoryModel:model];
    DetailsViewController *details = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark - 创建筛选和发现按钮
- (void)creatScreenAndFind {
    UIButton *btnScreen = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatOneBtn:btnScreen withFrame:CGRectMake(0, 64, kScreenW / 2, 40) andTitle:@"筛选微电影"];
    [btnScreen addTarget:self action:@selector(handleScreen) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnFind = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatOneBtn:btnFind withFrame:CGRectMake(kScreenW / 2, 64, kScreenW / 2, 40) andTitle:@"发现微电影"];
    [btnFind addTarget:self action:@selector(handleFind) forControlEvents:UIControlEventTouchUpInside];
}
//点击筛选微电影按钮
- (void)handleScreen{
    ScreenViewController *screen = [[ScreenViewController alloc]init];
    [self.navigationController pushViewController:screen animated:YES];
}

//点击发现微电影按钮（随机出现微电影）
- (void)handleFind{
    DetailsViewController *details = [[DetailsViewController alloc]init];
    PassURL *pass = [PassURL sharePass];
    int number = arc4random()%(700-100+1)+100;
    NSLog(@"%d",number);
    pass.number = [NSNumber numberWithInt:number];
    [self.navigationController pushViewController:details animated:YES];
}

- (void)creatOneBtn:(UIButton *)btn withFrame:(CGRect)rect andTitle:(NSString *)title {
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:0.450 green:0.426 blue:0.425 alpha:1.000];

    [self.view addSubview:btn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//抽屉效果
- (void)creatDrawer {
    self.APPDelegate = [UIApplication sharedApplication].delegate;
    [self.APPDelegate.MMDrawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.APPDelegate.MMDrawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self drawerAnimate];
}
- (void)drawerAnimate {
    __weak MainViewController *weakself = self;
    
    [self.APPDelegate.MMDrawerVC setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        if (percentVisible == 1) {
            weakself.navigationItem.leftBarButtonItem = nil;
            [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.1 initialSpringVelocity:7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                weakself.APPDelegate.leftDrawerVC.btnSeach.frame = CGRectMake(kBtnX, kBtnSeachY, kBtnWidthAndHeight, kBtnWidthAndHeight);
            } completion:nil];
            
            [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.1 initialSpringVelocity:7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
               weakself.APPDelegate.leftDrawerVC.btnHistory.frame = CGRectMake(kBtnX, kBtnHistoryY, kBtnWidthAndHeight, kBtnWidthAndHeight);
            } completion:nil];
        } else if (percentVisible == 0) {
            weakself.navigationItem.leftBarButtonItem = weakself.leftBBI;
            weakself.APPDelegate.leftDrawerVC.btnSeach.frame = CGRectMake(-kBtnNX, kBtnSeachY, kBtnWidthAndHeight, kBtnWidthAndHeight);
            weakself.APPDelegate.leftDrawerVC.btnHistory.frame = CGRectMake(-kBtnNX, kBtnHistoryY, kBtnWidthAndHeight, kBtnWidthAndHeight);
        } else {
            weakself.APPDelegate.leftDrawerVC.btnSeach.frame = CGRectMake(-kBtnNX+percentVisible*180, kBtnSeachY, kBtnWidthAndHeight, kBtnWidthAndHeight);
            weakself.APPDelegate.leftDrawerVC.btnHistory.frame = CGRectMake(-kBtnNX+percentVisible*180, kBtnHistoryY, kBtnWidthAndHeight, kBtnWidthAndHeight);
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    [self.APPDelegate.MMDrawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.APPDelegate.MMDrawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.APPDelegate.MMDrawerVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.APPDelegate.MMDrawerVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    
    //关闭抽屉
    [self.APPDelegate.MMDrawerVC closeDrawerAnimated:YES completion:nil];
}

@end
