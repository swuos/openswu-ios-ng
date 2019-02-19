//
//  SWUMineViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/16.
//

#import "SWUMineViewController.h"
#import "SWUHeaderView.h"
#import "SWUMineTableViewCell.h"
#import "MJExtension.h"
#import "SWUMineModel.h"


@interface SWUMineViewController ()
/** 模型数组  */
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation SWUMineViewController

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [SWUMineModel mj_objectArrayWithFilename:@"Mine.plist"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.sectionHeaderHeight = 100;
    //    清除多余的cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(7, 15, 7, 15);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    SWUMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWUMineTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.swuMine = self.dataArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWUHeaderView * view = [[SWUHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    return  view;
}

#pragma mark ------ TableViewDelegate ------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SWUMineModel * swuMine = self.dataArray[indexPath.row];
    NSInteger count = swuMine.count.integerValue;
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NULL message:swuMine.information preferredStyle:UIAlertControllerStyleAlert];
    if (count == 2) {
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:cancelAction];
    }
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}




@end
