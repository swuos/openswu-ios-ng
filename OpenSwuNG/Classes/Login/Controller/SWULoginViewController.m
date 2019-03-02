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


@interface SWULoginViewController ()<UITextFieldDelegate>
/** 账号  */
@property (nonatomic,strong) SWUTextField * userTextField;
/** 密码  */
@property (nonatomic,strong) SWUTextField * pwdTextfield;
/** 登录按钮  */
@property (nonatomic,strong) UIButton * loginBtn;

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
    _loginBtn.userInteractionEnabled = NO;
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

#pragma mark ------ UITextFieldDelegate ------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self becomeFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _userTextField) {
        if (range.location >= 11) {
            if ([self checkPhoneNumber:textField.text]) {
                _pwdTextfield.userInteractionEnabled = YES;
            }else {
                [SVProgressHUD showErrorWithStatus:@"请检查手机号是否正确"];
            }
            return NO;
        }
        _pwdTextfield.userInteractionEnabled = NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    _loginBtn.userInteractionEnabled = YES;
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
