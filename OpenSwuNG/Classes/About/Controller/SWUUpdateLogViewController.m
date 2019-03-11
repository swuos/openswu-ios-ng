//
//  SWUUpdateLogViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/22.
//

#import "SWUUpdateLogViewController.h"

@interface SWUUpdateLogViewController ()

@end

@implementation SWUUpdateLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    清除多余的cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorColor = [UIColor lightGrayColor];
//    self.tableView.separatorInset = UIEdgeInsetsMake(7, 15, 7, 15);
    self.title = @"更新日志";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * ID  = @"update";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"西大助手2.0";
    [cell.imageView removeFromSuperview];
    return  cell;
}


@end
