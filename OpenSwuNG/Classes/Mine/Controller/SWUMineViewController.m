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
#import "SWUAboutViewController.h"



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
    

    //    清除多余的cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(7, 15, 7, 15);

    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * ID = @"Mine";

    SWUMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWUMineTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.swuMine = self.dataArray[indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    SWUHeaderView * view = [[SWUHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];

    return  view;
}

#pragma mark ------ TableViewDelegate ------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SWUMineModel * swuMine = self.dataArray[indexPath.row];

    [self showAlertViewtableView:tableView SwuMine:swuMine];
    
}
//显示alertView
-(void)showAlertViewtableView:(UITableView *)tableView SwuMine:(SWUMineModel *)swuMine {
    NSInteger count = swuMine.count.integerValue;
    if (count != 0) {
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
    }else{
        SWUAboutViewController * aboutVc = [[SWUAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVc animated:YES];
        
    }
}

@end
