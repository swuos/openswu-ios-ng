//
//  SWUAboutViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/20.
//

#import "SWUAboutViewController.h"
#import "SWUAboutHeaderView.h"
#import "SWUAboutModel.h"
#import "MJExtension.h"
#import "SWUUpdateLogViewController.h"
#import "SWUAboutUsViewController.h"
#import "Masonry.h"

@interface SWUAboutViewController ()
/** 关键字数据数组  */
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation SWUAboutViewController
-(NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [SWUAboutModel mj_objectArrayWithFilename:@"About.plist"];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    //    清除多余的cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(7, 15, 7, 15);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [self setUpBottom];
}

//设置底部的开源协会
-(void)setUpBottom {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 30)];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Copyright©2018 西南大学开源协会\nAll rights reserved" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 10],NSForegroundColorAttributeName: [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0]}];
    label.attributedText = string;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * ID = @"About";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell.imageView removeFromSuperview];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SWUAboutModel * swuAbout = self.dataArray[indexPath.row];
    cell.textLabel.text = swuAbout.content;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SWUAboutModel * swuAbout = self.dataArray[indexPath.row];
    NSInteger symbol = swuAbout.symbol.integerValue;
    if (symbol != 0) {
        UIViewController * vc ;
        if ([swuAbout.controller isEqualToString:@"AUS"]) {
            vc = [[SWUAboutUsViewController alloc] init];
        } else if ([swuAbout.controller isEqualToString:@"AUL"]) {
            vc = [SWUUpdateLogViewController new];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else {

        UIAlertController * alert = [UIAlertController alertControllerWithTitle:NULL message:@"检测到新版本,是否立即更新?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:true completion:nil];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWUAboutHeaderView * headView = [[SWUAboutHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    return headView;
}
//设置头部和cell一起滑动
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 200;
//    if (scrollView.contentOffset.y<= sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}



@end
