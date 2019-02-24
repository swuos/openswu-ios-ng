//
//  SWUAboutUsViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/22.
//

#import "SWUAboutUsViewController.h"

@interface SWUAboutUsViewController ()
/** dataArray存放cell的显示的文本信息  */
@property (nonatomic,strong) NSArray * dataArray;
@end

@implementation SWUAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    清除多余的cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.title = @"关于我们";
    
}
-(NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"开发：徐小康 501 canoejun",@"设计：澜水砚墨金 耳东 管苟伊",@"服务器：许枭飞 cyk",@"后端：高满 徐永健 310103270@qq.com",@"支持：杜老板", nil];
    }
    return _dataArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * ID = @"aboutus";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID]; 
    }
    [cell.imageView removeFromSuperview];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

@end
