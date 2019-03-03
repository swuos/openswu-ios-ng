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
    UIButton * getVerCodeBtn = [UIButton ButtonWithTitle:@"获取验证码" Frame:CGRectMake(SCREEN_WIDTH*0.8-20, 0, SCREEN_WIDTH*0.2, WEEK_SCROLLERVIEW_HEIGHT) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0]];
    getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_verificationCode addSubview:getVerCodeBtn];
    [_verificationCode setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _userPhoneNumber.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _verificationCode];
    i++;
    
    SWULoginLabel * firstPwdLabel = [SWULoginLabel SWULoginLabelwithText:@"密码"];
    self.firstPwd = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:firstPwdLabel Text:@"请输入新密码" KeyBoardType:UIKeyboardTypeDefault];
    //    设置底部的线条
    [_firstPwd setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _firstPwd.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _firstPwd];
    i++;
    
    SWULoginLabel * secondPwdLabel  = [SWULoginLabel SWULoginLabelwithText:@"确认密码"];
    self.secondPwd = [SWUTextField SWUTextFieldWithFrame:CGRectMake(0, i*(WEEK_SCROLLERVIEW_HEIGHT+10), SCREEN_WIDTH, WEEK_SCROLLERVIEW_HEIGHT) LeftView:secondPwdLabel Text:@"请再次输入新密码" KeyBoardType:UIKeyboardTypeDefault];
    [_secondPwd setLineViewLength:CGRectMake(SCREEN_WIDTH*0.05, _secondPwd.frame.size.height, SCREEN_WIDTH*0.9, 0.5)];
    [backView addSubview: _secondPwd];
    
    //    添加确认按钮
    self.confirmBtn = [UIButton ButtonWithTitle:@"确认" Frame:CGRectMake(SCREEN_WIDTH*0.05, CGRectGetMaxY(backView.frame)+30,SCREEN_WIDTH*0.9, 40) Alignment:UIControlContentHorizontalAlignmentCenter titleColor:[UIColor whiteColor]];
    _confirmBtn.backgroundColor = [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0];
    [_confirmBtn addTarget:self action:@selector(confirmModify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
}
-(void)confirmModify {
    
    
}





@end
