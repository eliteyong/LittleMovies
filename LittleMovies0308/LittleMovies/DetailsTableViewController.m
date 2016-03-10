//
//  DetailsTableViewController.m
//  LittleMovies
//
//  Created by qingyun on 16/2/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailsTableViewController.h"
#import "LMHeader.h"
#import "OneTableViewCell.h"
#import "TwoTableViewCell.h"
#import "ThreeTableViewCell.h"

@interface DetailsTableViewController ()
@property (nonatomic) CGFloat OneHeight;
@property (nonatomic) CGFloat TwoHeight;
@property (nonatomic,strong)PassURL *pass;
@end

@implementation DetailsTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[OneTableViewCell class] forCellReuseIdentifier:@"one"];
    [self.tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:@"two"];
    [self.tableView registerClass:[ThreeTableViewCell class] forCellReuseIdentifier:@"three"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //监听
    //[self.pass addObserver:self forKeyPath:@"number" options:NSKeyValueObservingOptionNew context:nil];
}
#warning ?
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"pass"]) {
//        NSLog(@"~~~~~为什么呢");
//        [self.tableView reloadData];
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplet implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.pass = [PassURL sharePass];
    if (indexPath.section == 0) {
        OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one" forIndexPath:indexPath];
        cell.title.text = _pass.model.title;
        cell.des.text = _pass.model.des;
        cell.directors.text = _pass.model.directors;
        cell.writers.text = _pass.model.writers;
        cell.actors.text = _pass.model.actors;
        cell.zone.text = _pass.model.zone;
        cell.year.text = _pass.model.year;
        NSMutableString *string = [[NSMutableString alloc]init];
        for (NSString *str in _pass.model.type) {
            [string appendString:str];
        }
        cell.type.text = string;
        
        //自定义高度
        [cell changeHeight];
        self.OneHeight = cell.year.frame.origin.y ;
        // Configure the cell...
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }if (indexPath.section == 1) {
        TwoTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
        cell2.introduction.text = _pass.model.introduction;
        [cell2 changeFrame];
        self.TwoHeight = cell2.introduction.frame.size.height;
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }else{
        ThreeTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"three" forIndexPath:indexPath];
        [cell3.pubnick setTitle:_pass.model.pubnick forState:UIControlStateNormal];
        NSString *str = [_pass.model.time stringValue];
        long long int timeInt = [str intValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInt];
        NSString *time = [NSString stringWithFormat:@"%@",date];
        
        NSArray *array = [time componentsSeparatedByString:@"+"];
        time = array[0];
        cell3.time.text = time;
        
        
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    DetailsViewController *details = [[DetailsViewController alloc]init];
//    [self.navigationController pushViewController:details animated:YES];
//}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.OneHeight+30;
    }else if (indexPath.section == 1){
        return self.TwoHeight + 20;
    }else{
        return 60;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
