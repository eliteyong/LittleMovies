//
//  LMDetailsViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailsViewController.h"
#import "LMHeader.h"

#define kScrollHeight kScreenH - 260-84

#define kScrollY 260+84

@interface DetailsViewController ()<UIScrollViewDelegate,AboutDelegate>
@property (nonatomic, strong) UIButton *btnDetail;
@property (nonatomic, strong) UIButton *btnAbout;
@property (nonatomic,strong) UIScrollView *scrollV;
@property (nonatomic,strong) Video *PlayerView;
@property (nonatomic,strong)DetailsTableViewController *details;

@end

@implementation DetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    PassURL *pass = [PassURL sharePass];
    [self detailsPassModel:pass.number];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    Player *play = [Player sharePlayer];
    [play.player pause];
}
//获取详情数据
- (void)detailsPassModel:(NSNumber *)number{
    NSString *url = @"http://api2.jxvdy.com/video_info?token=(null)&id=";
    NSString *newURL = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *getStr = [newURL stringByAppendingString:[number stringValue]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self parserDetail:responseObject];
        //创建播放器
        [self creatAVPlayer];
        //创建csrollView
        [self creatCsrollView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self creatAlert];
    }];
}
- (void)parserDetail:(id)responseObject{
    DetailsModel *model = [[DetailsModel alloc]initWithDictionary:responseObject];
    PassURL *pass = [PassURL sharePass];
    pass.model = model;
}
- (void)creatAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"抱歉" message:@"暂无片源信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self .navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
       //创建滑动btn
    [self creatBtn];
    
}

- (void)creatAVPlayer{
    self.PlayerView = [[Video alloc]initWithFrame:CGRectMake(0, 44, kScreenW, 260)];
    [self.view addSubview:self.PlayerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatBtn{
    self.btnDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnDetail setTitle:@"详情" forState:UIControlStateNormal];
    self.btnDetail.frame = CGRectMake(0, 260+44, kScreenW/2, 40);
    [self.btnDetail setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.btnDetail.backgroundColor = [UIColor colorWithRed:1.000 green:0.982 blue:0.919 alpha:1.000];
    [self.btnDetail addTarget:self action:@selector(handleDetail) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btnAbout = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAbout setTitle:@"相关" forState:UIControlStateNormal];
    self.btnAbout.frame = CGRectMake(kScreenW/2, 260+44, kScreenW/2, 40);
    [self.btnAbout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btnAbout.backgroundColor = [UIColor colorWithRed:1.000 green:0.982 blue:0.919 alpha:1.000];
    [self.btnAbout addTarget:self action:@selector(handleAbout) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, 260+49, 2, 30)];
    label.backgroundColor = [UIColor grayColor];

    
    
    [self.view addSubview:self.btnDetail];
    
    [self.view addSubview:self.btnAbout];
    [self.view addSubview:label];
}
- (void)handleDetail{
    [self.btnDetail setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.btnAbout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    self.scrollV.contentOffset = CGPointMake(0, 0);
}

- (void)handleAbout{
    [self.btnDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnAbout setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.scrollV.contentOffset = CGPointMake(kScreenW, 0);
}

- (void)creatCsrollView{
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kScrollY, kScreenW, kScrollHeight)];
    self.scrollV.contentSize = CGSizeMake(kScreenW*2, kScrollHeight);
    self.scrollV.bounces = NO;
    self.scrollV.pagingEnabled = YES;
    self.scrollV.delegate = self;
    
    //详情界面
    self.details = [[DetailsTableViewController alloc]init];
    [self addChildViewController:_details];
    _details.view.frame = CGRectMake(10, 0, kScreenW - 20, kScrollHeight);
    [self.scrollV addSubview:_details.view];
    
    //相关界面
    AboutViewController *about = [[AboutViewController alloc]init];
    about.delegate = self;
    [self addChildViewController:about];
    about.view.frame = CGRectMake(kScreenW , 0, kScreenW, kScrollHeight);
    
    [self.scrollV addSubview:about.view];
    //将scrollView添加至视图
    [self.view addSubview:self.scrollV];

}
#pragma mark - AboutDelegate
- (void)refresh{
    Player *play = [Player sharePlayer];
    [play.player pause];
    [self.PlayerView removeFromSuperview];
    [self.details removeFromParentViewController];
    [self creatAVPlayer];
    self.details = [[DetailsTableViewController alloc]init];
    [self addChildViewController:_details];
    _details.view.frame = CGRectMake(10, 0, kScreenW - 20, kScrollHeight);
    [self.scrollV addSubview:_details.view];
}
@end
