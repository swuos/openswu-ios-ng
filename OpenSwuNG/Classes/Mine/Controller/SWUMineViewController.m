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
#import "SWUBindingViewController.h"
#import "Constants.h"
#import "NSDate+DistanceOfTimes.h"
#import "SWULoginViewController.h"
#import "SWUNavigationController.h"


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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *information = swuMine.information;
    if (count != 0) {
        if ([[userDefaults objectForKey:@"cardNumber"] length] <= 0) {
            if ([swuMine.icon isEqualToString:@"mine_clean"]) {
                information = @"请先绑定校园卡！";
            }
        }
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:NULL message:information preferredStyle:UIAlertControllerStyleAlert];
        if (count == 2) {
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction:cancelAction];
        }
        // 弹出对话框还是切换界面？
        //            点击cell，如果已经绑定校园卡，则解绑
        if ([swuMine.icon isEqualToString:@"mine_card"]) {
            NSString * cardNumber = [userDefaults objectForKey:@"cardNumber"];
            if (cardNumber.length <= 0) {
                SWUBindingViewController * bindingVc = [[SWUBindingViewController alloc] init];
                [self.navigationController pushViewController:bindingVc animated:YES];
                return;
            }
        }
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            绑卡
            if ([swuMine.icon isEqualToString:@"mine_card"]) {
                [userDefaults setObject:@"" forKey:@"cardNumber"];
                [userDefaults setObject:@"" forKey:@"cardNumberPwd"];
                [userDefaults synchronize];
                [fileManager removeItemAtPath:DOCUMENT_PATH(@"schedule.plist") error:nil];
                return ;
            }
//            教务处数据同步
            if ([swuMine.icon isEqualToString:@"mine_clean"]) {
                [NSDate getSchedule];
                return;
            }
//            退出
            if ([swuMine.icon isEqualToString:@"mine_exit"]) {
                [userDefaults setObject:@"" forKey:@"token"];
                [userDefaults setObject:@"" forKey:@"cardNumber"];
                [userDefaults setObject:@"" forKey:@"cardNumberPwd"];
                [userDefaults setObject:@"" forKey:@"phoneNumber"];
                [userDefaults setObject:@"" forKey:@"password"];
                [userDefaults synchronize];
                [fileManager removeItemAtPath:DOCUMENT_PATH(@"schedule.plist") error:nil];
//                退出登录，然后设置主页面为登录界面
                SWULoginViewController * loginVc = [[SWULoginViewController alloc] init];
                SWUNavigationController * nav = [[SWUNavigationController alloc] initWithRootViewController:loginVc];
                [[UIApplication sharedApplication].keyWindow setRootViewController:nav];
                return;
            }
        }];
        [alert addAction:okAction];

        [self presentViewController:alert animated:true completion:nil];
    }else{
        SWUAboutViewController * aboutVc = [[SWUAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVc animated:YES];
    }
}

@end
