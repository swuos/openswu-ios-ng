//
//  SWUPublishViewController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/16.
//

#import "SWUPublishViewController.h"
#import "SWUFactory.h"
#import "Constants.h"
#import "SWUPublishView.h"

@interface SWUPublishViewController ()<UITextViewDelegate>
@property (nonatomic,strong) SWUPublishView *publishView;
@end

@implementation SWUPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"失物发布";
    [self.view addSubview:self.publishView];
    __weak typeof(self)weakSelf = self;
    self.publishView.publishBlock = ^{
        if ([self.publishView.inputInfoTextView.text isEqualToString:@"输入相关信息，不多余600字"] || self.publishView.inputInfoTextView.text.length <= 0) {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请输入发布信息！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVc addAction:okAction];
            [weakSelf presentViewController:alertVc animated:YES completion:nil];
            return;
        }
        UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:NULL message:@"发布成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [alertVc addAction:okAction];
        NSString *text = weakSelf.publishView.inputInfoTextView.text;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
            NSString *url = @"https://freegatty.swuosa.xenoeye.org/addLostFoundRecord";
            [manager POST:url parameters:@{
                                           @"phoneNumber":[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"],
                                           @"text":text
                                           }
                 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     [weakSelf presentViewController:alertVc animated:YES completion:nil];
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSLog(@"%@",error);
                 }];
        });
    };
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.publishView.inputInfoTextView.text = @"输入相关信息，不多余600字";
    self.publishView.stringLenghLabel.text = [NSString stringWithFormat:@"%lu/600", (unsigned long)self.publishView.inputInfoTextView.text.length];
}
#pragma mark ------ lazyLoad -------
-(SWUPublishView *)publishView {
    if(!_publishView) {
        self.publishView = [[SWUPublishView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _publishView;
}






@end
