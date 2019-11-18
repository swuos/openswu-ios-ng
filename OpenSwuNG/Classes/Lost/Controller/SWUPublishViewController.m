//
//  SWUPublishViewController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/16.
//

#import "SWUPublishViewController.h"
#import "Masonry.h"
#import "SWUFactory.h"
#import "Constants.h"

@interface SWUPublishViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *inputInfoTextView;
@property (nonatomic,strong) UILabel *stringLenghLabel;
@end

@implementation SWUPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"失物发布";
    
    [self setUI];
}


-(void)setUI {
    CGFloat standFontSize = 20;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    titleLabel.text = @"请输入要发布的信息";
    titleLabel.font = [UIFont systemFontOfSize:standFontSize];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    noteLabel.font = [UIFont systemFontOfSize:standFontSize-4];
    noteLabel.textAlignment = NSTextAlignmentLeft;
    noteLabel.numberOfLines = 0;
    noteLabel.text = @"使用须知：\n    为了给大家提供方便，请不要发布虚假无效信息，谢谢配合！我们也将有权利删除用户发布的信息，多次发布类似信息者账号将被封停。";
    [noteLabel sizeToFit];
    [self.view addSubview:noteLabel];
    
    UITextView *inputInfoTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    inputInfoTextView.font = [UIFont systemFontOfSize:standFontSize -3];
    inputInfoTextView.backgroundColor = [UIColor lightGrayColor];
    inputInfoTextView.alpha = 0.5;
    self.inputInfoTextView = inputInfoTextView;
    self.inputInfoTextView.delegate = self;
    [self.view addSubview:_inputInfoTextView];
    
    self.stringLenghLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
    [self.view addSubview:self.stringLenghLabel];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.layer.cornerRadius = 4.0;
    [publishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [publishBtn setBackgroundColor:[UIColor colorWithRed:40/255.0 green:122/255.0 blue:246/255.0 alpha:1.0]];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishBtn];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(CGRectGetMaxY(self.navigationController.navigationBar.frame));
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@30);
    }];
    
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.right.equalTo(titleLabel);
        make.height.equalTo(noteLabel.mas_height);
    }];
    
    [self.inputInfoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteLabel.mas_bottom).offset(10);
        make.left.right.equalTo(titleLabel);
        make.height.equalTo(@200);
    }];
    [self.stringLenghLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.inputInfoTextView).offset(-5);
        make.bottom.equalTo(self.inputInfoTextView).offset(-5);
        make.width.equalTo(self.stringLenghLabel.mas_width);
        make.height.equalTo(self.stringLenghLabel.mas_height);
    }];
    
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputInfoTextView.mas_bottom).offset(10);
        make.left.right.equalTo(titleLabel);
        make.height.equalTo(@40);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _inputInfoTextView.text = @"输入相关信息，不多余600字";
    self.stringLenghLabel.text = [NSString stringWithFormat:@"%lu/600", (unsigned long)self.inputInfoTextView.text.length];
}

#pragma mark ------ delegate -------
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text = @"";
    self.stringLenghLabel.text = [NSString stringWithFormat:@"%lu/600", (unsigned long)textView.text.length];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    self.stringLenghLabel.text = [NSString stringWithFormat:@"%lu/600", (unsigned long)textView.text.length];
    if (textView.text.length >= 600) {
        textView.text = [textView.text substringToIndex:100];
        self.stringLenghLabel.text = @"600/600";
    }
}


#pragma mark ------ 自定义方法 -------
-(void)publishBtnDidClicked {
    if ([self.inputInfoTextView.text isEqualToString:@"输入相关信息，不多余600字"] || self.inputInfoTextView.text.length <= 0) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请输入发布信息！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVc addAction:okAction];
        [self presentViewController:alertVc animated:YES completion:nil];
        return;
    }
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:NULL message:@"发布成功！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.refreshBlock) {
            self.refreshBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertVc addAction:okAction];
    NSLog(@"输入f的内容是：%@",self.inputInfoTextView.text);
    NSString *text = self.inputInfoTextView.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager * manager = [SWUFactory SWUFactoryManage];
        NSString *url = @"https://freegatty.swuosa.xenoeye.org/addLostFoundRecord";
        [manager POST:url parameters:@{
                                       @"phoneNumber":[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"],
                                       @"text":text
                                       }
             progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"%@",responseObject);
                 [self presentViewController:alertVc animated:YES completion:nil];
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"%@",error);
             }];
    });
    
    
    
    
}







@end
