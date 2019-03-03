//
//  SWURegisterViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWURegisterViewController.h"
#import "Constants.h"
#import "SWUTextField.h"
#import "SWULoginLabel.h"
#import "UIButton+Login.h"
#import "SVProgressHUD.h"
#import "SWUBindingViewController.h"


@interface SWURegisterViewController ()<UITextFieldDelegate>
/** 手机号  */
@property (nonatomic,strong) SWUTextField * userPhoneNumber;
/** 验证码  */
@property (nonatomic,strong) SWUTextField * verificationCode;
/** 第一次密码  */
@property (nonatomic,strong) SWUTextField * firstPwd;
/** 第二次密码  */
@property (nonatomic,strong) SWUTextField * secondPwd;
/** 注册按钮  */
@property (nonatomic,strong) UIButton * registerBtn;
@end

@implementation SWURegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setUpUI];
}

-(void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"快速注册";
    //    添加手机号  密码  验证码等textfield
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
    UIButton * getVerCodeBtn = [UIButton ButtonWithTitle:@"获取验证码" Frame:CGRectMake(SCREEN_WIDTH*0.8-20, 0, SCREEN_WIDTH*0.2, WEEK_SCROLLERVIEW_HEIGHT) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0]];
    getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_verificationCode addSubview:getVerCodeBtn];
    [_verificationCode setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _userPhoneNumber.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _verificationCode];
    i++;
    
    SWULoginLabel * firstPwdLabel  = [SWULoginLabel SWULoginLabelwithText:@"密码"];
    self.firstPwd = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:firstPwdLabel Text:@"请输入密码" KeyBoardType:UIKeyboardTypeDefault];
    [_firstPwd setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _userPhoneNumber.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _firstPwd];
    i++;
    
    UILabel * secondPwdLabel  = [SWULoginLabel SWULoginLabelwithText:@"确认密码"];
    self.secondPwd = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:secondPwdLabel Text:@"请输入密码" KeyBoardType:UIKeyboardTypeDefault];
    [_secondPwd setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _userPhoneNumber.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _secondPwd];
    
    
    //    添加注册按钮
    self.registerBtn = [UIButton ButtonWithTitle:@"注册" Frame:CGRectMake(SCREEN_WIDTH*0.05, CGRectGetMaxY(backView.frame)+30,SCREEN_WIDTH*0.9, 40) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor whiteColor]];
    _registerBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
    [_registerBtn addTarget:self action:@selector(registerAndBinding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
}




-(void)registerAndBinding {
    //    判断两次的密码是否相同
    if (_firstPwd.text.length > 0 &&  _secondPwd.text.length > 0 ) {
        if ([_firstPwd.text isEqualToString:_secondPwd.text]) {
            //    相同 网络请求注册，然后判断是否成功
//                    if (<#condition#>) {
//                        <#statements#>
////                    请稍后
//                    }
            //        弹出绑定界面进行校园卡的绑定
            SWUBindingViewController * bindingVc = [[SWUBindingViewController alloc] init];
            [self presentViewController:bindingVc animated:YES completion:nil];
//            [self.navigationController pushViewController:bindingVc animated:YES];
            
        }else {
            [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
        }
    }else {
        [SVProgressHUD showErrorWithStatus:@"密码为空，请输入"];
    }
}

#pragma mark ------ 手势 ------
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




@end
