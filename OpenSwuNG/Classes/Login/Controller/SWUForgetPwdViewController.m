//
//  SWUForgetPwdViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/1.
//

#import "SWUForgetPwdViewController.h"
#import "Constants.h"
#import "UIButton+Login.h"
#import "SWUTextField.h"
#import "SWULoginLabel.h"
#import "SVProgressHUD.h"
#import "SWUFactory.h"
#import "SWUVerificationCodeButton.h"

@interface SWUForgetPwdViewController ()
/** 手机号  */
@property (nonatomic,strong) SWUTextField * userPhoneNumber;
/** 验证码  */
@property (nonatomic,strong) SWUTextField * verificationCode;
/** 第一次密码  */
@property (nonatomic,strong) SWUTextField * firstPwd;
/** 第二次密码  */
@property (nonatomic,strong) SWUTextField * secondPwd;
/** 确认修改密码  */
@property (nonatomic,strong) UIButton * confirmBtn;
/** 网络回话管理者  */
@property (nonatomic,strong) AFHTTPSessionManager * manager;
/** 网络请求传递的参数  */
@property (nonatomic,strong) NSDictionary * paraDic;
/** 获取验证码的按钮  */
@property (nonatomic,strong) SWUVerificationCodeButton * getVerCodeBtn;
@end

@implementation SWUForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setUpUI];
}

-(void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    //    绑定校园卡
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY+10, SCREEN_WIDTH, 220)];
    [self.view addSubview:backView];
    int i = 0;
    SWULoginLabel * phoneLabel = [SWULoginLabel SWULoginLabelwithText:@"手机号"];
    self.userPhoneNumber = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:phoneLabel Text:@"请输入手机号码" KeyBoardType:UIKeyboardTypeNumberPad];
    //    设置底部的线条
    [_userPhoneNumber setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _userPhoneNumber.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _userPhoneNumber];
    i++;
    
    SWULoginLabel * veriLabel  = [SWULoginLabel SWULoginLabelwithText:@"验证码"];
    self.verificationCode = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:veriLabel Text:@"请输入验证码" KeyBoardType:UIKeyboardTypeNumberPad];
    //    添加获取验证的按钮
    self.getVerCodeBtn = [[SWUVerificationCodeButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.8-20, 0, SCREEN_WIDTH*0.2, WEEK_SCROLLERVIEW_HEIGHT)];
    [_getVerCodeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [_verificationCode addSubview:_getVerCodeBtn];
    [_verificationCode setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _userPhoneNumber.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _verificationCode];
    i++;
    
    SWULoginLabel * firstPwdLabel = [SWULoginLabel SWULoginLabelwithText:@"密码"];
    self.firstPwd = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:firstPwdLabel Text:@"请输入新密码" KeyBoardType:UIKeyboardTypeDefault];
    _firstPwd.secureTextEntry = YES;
    //    设置底部的线条
    [_firstPwd setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _firstPwd.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _firstPwd];
    i++;
    
    SWULoginLabel * secondPwdLabel  = [SWULoginLabel SWULoginLabelwithText:@"确认密码"];
    self.secondPwd = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:secondPwdLabel Text:@"请再次输入新密码" KeyBoardType:UIKeyboardTypeDefault];
    [_secondPwd setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _secondPwd.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    _secondPwd.secureTextEntry = YES;
    [backView addSubview: _secondPwd];
    
    //    添加确认按钮
    self.confirmBtn = [UIButton ButtonWithTitle:@"确认" Frame:CGRectMake(SCREEN_WIDTH*0.05, CGRectGetMaxY(backView.frame)+30,SCREEN_WIDTH*0.9, 40) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor whiteColor]];
    _confirmBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
    [_confirmBtn addTarget:self action:@selector(confirmModify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
}
//获取验证码
-(void)getVerificationCode {
    if (_userPhoneNumber.text.length == 11 && [self checkPhoneNumber:_userPhoneNumber.text]) {
        //        设置计时器开始计时
        [self.getVerCodeBtn timeFailBeginFrom:150];
        self.manager = [SWUFactory SWUFactoryManage];
        self.paraDic = @{
                         @"phoneNumber":_userPhoneNumber.text
                         };
        [_manager POST:@"https://freegatty.swuosa.xenoeye.org/ac/sendVerificationCode" parameters:_paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
        }];
        return ;
    }
    [SVProgressHUD showErrorWithStatus:@"请检查手机号!"];
}
- (BOOL)checkPhoneNumber:(NSString *)phoneNumber
{
    NSString *regex = @"^[1][3-8]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNumber];
}
//确认修改按钮
-(void)confirmModify {
    
    //    判断两次的密码是否相同
    if (_firstPwd.text.length <= 0 ||  _secondPwd.text.length <= 0 ) {
        [SVProgressHUD showErrorWithStatus:@"密码为空，请输入"];
        return;
    }
    if (![_firstPwd.text isEqualToString:_secondPwd.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
        return;
    }
    if (_verificationCode.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码为空!"];
        return;
    }
    self.paraDic = @{
                     @"password":_firstPwd.text,
                     @"verificationCode":_verificationCode.text,
                     };
    [_manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forHTTPHeaderField:@"token"];
    [_manager POST:@"https://freegatty.swuosa.xenoeye.org/ac/changePassword" parameters:_paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        修改密码后怎么办？
//        NSLog(@"%@",responseObject);
        NSString * success = responseObject[@"success"];
//        NSString * message = responseObject[@"message"];
//        NSLog(@"%@",message);
        if (success.intValue == 1) {
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功!"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
        NSString *string =[[NSString alloc]initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];

        NSLog(@"%@",string);
        [SVProgressHUD showErrorWithStatus:@"请检查网络，稍后重试!"];
    }];
}



@end
