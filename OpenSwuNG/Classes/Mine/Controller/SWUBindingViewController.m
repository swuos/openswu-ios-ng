//
//  SWUBindingViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWUBindingViewController.h"
#import "UIButton+Login.h"
#import "Constants.h"
#import "SWUTextField.h"
#import "SWULoginLabel.h"
#import "SVProgressHUD.h"
#import "SWUAFN.h"
#import "SWUBindingModel.h"
#import "MJExtension.h"
#import "NSDate+DistanceOfTimes.h"

@interface SWUBindingViewController ()
/** 卡号  */
@property (nonatomic,strong) SWUTextField * cardNumber;
/** 卡号的密码  */
@property (nonatomic,strong) SWUTextField * cardNumberPwd;
/** 绑定按钮  */
@property (nonatomic,strong) UIButton * bindingBtn;
@end

@implementation SWUBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定校园卡";
    [self setUpUI];
}


-(void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    //    绑定校园卡
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 120)];
    [self.view addSubview:backView];
    int i = 0;
    SWULoginLabel * phoneLabel = [SWULoginLabel SWULoginLabelwithText:@"卡号"];
    self.cardNumber = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:phoneLabel Text:@"请输入一卡通卡号" KeyBoardType:UIKeyboardTypeNumberPad];
    //    设置底部的线条
    [_cardNumber setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _cardNumber.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _cardNumber];
    i++;
    
    SWULoginLabel * firstPwdLabel  = [SWULoginLabel SWULoginLabelwithText:@"密码"];
    self.cardNumberPwd = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:firstPwdLabel Text:@"请输入教务处登录密码" KeyBoardType:UIKeyboardTypeDefault];
    [_cardNumberPwd setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _cardNumberPwd.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    _cardNumberPwd.secureTextEntry = YES;
    [backView addSubview: _cardNumberPwd];
    
    //    添加绑定按钮
    self.bindingBtn = [UIButton ButtonWithTitle:@"绑定" Frame:CGRectMake(SCREEN_WIDTH*0.05, CGRectGetMaxY(backView.frame)+35,SCREEN_WIDTH*0.9, 40) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor whiteColor]];
    _bindingBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
    [_bindingBtn addTarget:self action:@selector(bindingCard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bindingBtn];
}

-(void)bindingCard {
    if (_cardNumber.text.length == 15) {
        if (_cardNumberPwd.text.length > 0) {
            [SVProgressHUD showWithStatus:@"请稍等...."];
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            
            AFHTTPSessionManager * manager = [SWUAFN swuAfnManage];
            [manager.requestSerializer setValue:[userDefaults objectForKey:@"acToken"] forHTTPHeaderField:@"acToken"];
            NSDictionary * paraDic = @{
                                       @"swuid":_cardNumber.text,
                                       @"password":_cardNumberPwd.text
                                       };
            //            发送请求
            [manager POST:@"https://freegatty.swuosa.xenoeye.org/ac/bindSwuac" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SWUBindingModel * bindingModel = [SWUBindingModel mj_objectWithKeyValues:responseObject];
                NSLog(@"success:%@----message%@",bindingModel.success,bindingModel.message);
                if (bindingModel.success.intValue != 1) {
                    [SVProgressHUD showErrorWithStatus:@"请检查账号和密码"];
                    return ;
                }
                [userDefaults setObject:self.cardNumber.text forKey:@"cardNumber"];
                [userDefaults setObject:self.cardNumberPwd.text forKey:@"cardNumberPwd"];
                [userDefaults synchronize];
                [self dismissViewControllerAnimated:YES completion:nil];
//                下载课表
                [NSDate getSchedule];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD showErrorWithStatus:@"请检查网络!"];
            }];
            [SVProgressHUD dismiss];
        }else {
            [SVProgressHUD showErrorWithStatus:@"请检查卡号密码"];
        }
    }else {
        [SVProgressHUD showErrorWithStatus:@"请检查卡号"];
    }
}


@end
