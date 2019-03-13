//
//  SWUAlertViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWUAlertViewController.h"
#import "Weekitem.h"
#import "SWULabel.h"

@interface SWUAlertViewController ()

@end

@implementation SWUAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+(instancetype)alertControllerWithSWULabel:(SWULabel *)swulabel {
    NSString * title = swulabel.weekitem.lessonName;
    NSString * message = [NSString stringWithFormat:@"教师:%@\n教室:%@\n星期:%@",swulabel.weekitem.teacher,swulabel.weekitem.classRoom,swulabel.weekitem.week];
    SWUAlertViewController * alert = [super alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    alert.view.layer.cornerRadius = 15;
    alert.view.backgroundColor = [UIColor blueColor];
    return alert;
}



@end
