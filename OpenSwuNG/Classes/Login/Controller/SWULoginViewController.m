//
//  SWULoginViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWULoginViewController.h"
#import "SWUTextField.h"
#import "Masonry.h"
#import "UIButton+Login.h"
#import "SVProgressHUD.h"
#import "SWURegisterViewController.h"
#import "SWUForgetPwdViewController.h"
#import "Constants.h"
#import "SWUTabBarController.h"
#import "SWULoginModel.h"
#import "MJExtension.h"
#import "SWUAFN.h"



@interface SWULoginViewController ()<UITextFieldDelegate>
/** 账号  */
@property (nonatomic,strong) SWUTextField * userTextField;
/** 密码  */
@property (nonatomic,strong) SWUTextField * pwdTextfield;
/** 登录按钮  */
@property (nonatomic,strong) UIButton * loginBtn;
/** userDefaults  */
@property (nonatomic,strong) NSUserDefaults * userDefaults;

@end

@implementation SWULoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * phoneNumber = [self.userDefaults objectForKey:@"phoneNumber"];
    NSString * cardNumber = [self.userDefaults objectForKey:@"cardNumber"];
    if (phoneNumber.length > 0 && cardNumber.length > 0) {
        self.userTextField.text = [self.userDefaults objectForKey:@"phoneNumber"];
        self.pwdTextfield.text = [self.userDefaults objectForKey:@"password"];
        [self login];
    }
}
//布局
-(void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    //      添加图标
    UIImageView * logImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_logo"]];
    [self.view addSubview:logImageView];
    [logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(90);
        make.height.equalTo(@70);
        make.width.mas_equalTo(logImageView.mas_height).multipliedBy(1.0);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //    添加textfield 快速注册和忘记密码按钮
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logImageView.frame)+170, SCREEN_WIDTH, 140)];
    //    backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:backView];
    self.userTextField = [SWUTextField SWUTextFieldWithFrame:CGRectMake(WEEK_SCROLLERVIEW_HEIGHT, 5, SCREEN_WIDTH-2*WEEK_SCROLLERVIEW_HEIGHT, WEEK_SCROLLERVIEW_HEIGHT) LeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_account"]] Text:@"请输入账号" KeyBoardType:UIKeyboardTypeNumberPad];
    _userTextField.delegate = self;
    [backView addSubview:_userTextField];
    self.pwdTextfield = [SWUTextField SWUTextFieldWithFrame:CGRectMake(WEEK_SCROLLERVIEW_HEIGHT, WEEK_SCROLLERVIEW_HEIGHT+15, SCREEN_WIDTH-2*WEEK_SCROLLERVIEW_HEIGHT, WEEK_SCROLLERVIEW_HEIGHT) LeftView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_passowrd"]] Text:@"请输入密码" KeyBoardType:UIKeyboardTypeDefault];
    _pwdTextfield.delegate = self;
    _pwdTextfield.userInteractionEnabled = NO;
    _pwdTextfield.secureTextEntry = YES;
    [backView addSubview:_pwdTextfield];
    //    添加按钮
    //    registerBtn
    UIButton * registerBtn = [UIButton ButtonWithTitle:@"快速注册" Frame:CGRectMake(CGRectGetMinX(_pwdTextfield.frame), CGRectGetMaxY(_pwdTextfield.frame)+20, _pwdTextfield.frame.size.width*0.5, 25) Alignment:UIControlContentHorizontalAlignmentLeft titleColor:[UIColor blackColor]];
    [registerBtn addTarget:self action:@selector(quickRegister) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:registerBtn];
    UIButton * forgetPwdBtn = [UIButton ButtonWithTitle:@"忘记密码" Frame:CGRectMake(CGRectGetMaxX(registerBtn.frame), CGRectGetMaxY(_pwdTextfield.frame)+20, _pwdTextfield.frame.size.width*0.5, 25) Alignment:UIControlContentHorizontalAlignmentRight titleColor:[UIColor blackColor]];
    [forgetPwdBtn addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:forgetPwdBtn];
    
    
    //    添加登录按钮
    _loginBtn = [UIButton ButtonWithTitle:@"登录" Frame:CGRectMake(CGRectGetMinX(_pwdTextfield.frame), CGRectGetMaxY(backView.frame)+35, _pwdTextfield.frame.size.width, 40) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor whiteColor]];
    _loginBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}

//快速注册
-(void)quickRegister {
    SWURegisterViewController * registerVc  = [[SWURegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}
//忘记密码
-(void)forgetPwd {
    SWUForgetPwdViewController * forgetPwdVc = [[SWUForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetPwdVc animated:YES];
}
//登录
-(void)login {
    if (_pwdTextfield.text.length <= 0 && _userTextField.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写账号和密码"];
        if (![self checkPhoneNumber:_userTextField.text]) {
            [SVProgressHUD showErrorWithStatus:@"请检查手机号"];
        }
        return ;
    }
    [SVProgressHUD showWithStatus:@"请稍后..."];
//    登录请求
    AFHTTPSessionManager * manger = [SWUAFN swuAfnManage];
    
    NSDictionary * paraDic = @{
                               @"phoneNumber":_userTextField.text,
                               @"password":_pwdTextfield.text
                               };
    [manger POST:@"https://freegatty.swuosa.xenoeye.org/ac/login" parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SWULoginModel * loginModel = [SWULoginModel mj_objectWithKeyValues:responseObject];
        if(loginModel.success.intValue != 1) {
            [SVProgressHUD showErrorWithStatus:@"请检查账户和密码后重试"];
            return ;
        }
//        将登录的actoken进行解析出来，然后存放到NSuserdefaults中
//        NSLog(@"登录保存的actoken：%@",loginModel.result[@"acToken"]);
        [self.userDefaults setObject:loginModel.result[@"acToken"] forKey:@"acToken"];
        [self.userDefaults setObject:self.userTextField.text forKey:@"phoneNumber"];
        [self.userDefaults setObject:self.pwdTextfield.text forKey:@"password"];
        [self.userDefaults synchronize];
        
        [SVProgressHUD dismiss];
        
        SWUTabBarController * tabVc = [[SWUTabBarController alloc] init];
        [[UIApplication sharedApplication].keyWindow setRootViewController:tabVc];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络!"];
    }];
}


#pragma mark ------ UITextFieldDelegate ------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self becomeFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _userTextField && range.location >= 11) {
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _userTextField && _userTextField.text.length == 11) {
        _pwdTextfield.userInteractionEnabled = YES;
    }
}

- (BOOL)checkPhoneNumber:(NSString *)phoneNumber
{
    NSString *regex = @"^[1][3-8]\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNumber];
}

#pragma mark ------ 手势 ------
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
