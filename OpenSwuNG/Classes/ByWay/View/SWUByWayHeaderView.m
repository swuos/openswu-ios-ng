//
//  SWUByWayHeaderView.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/17.
//

#import "SWUByWayHeaderView.h"
#import "Masonry.h"
#import "SWUByWayPickerView.h"
#import "SVProgressHUD.h"

@interface SWUByWayHeaderView()
@property (nonatomic,strong) UILabel *startLabel;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,strong) UIView *backView;
@end

@implementation SWUByWayHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bywayBackImage"] highlightedImage:nil];
    [self addSubview:imageView];
    
    //    backView
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15,183.5,345,127)];
    backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    backView.layer.cornerRadius = 3;
    self.backView = backView;
    [self addSubview:self.backView];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 20],NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]}];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectStation:)];
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(72.5,213.5,55,18)];
    startLabel.numberOfLines = 0;
//    startLabel.backgroundColor = [UIColor orangeColor];
    startLabel.attributedText = string;
    startLabel.userInteractionEnabled = YES;
    [startLabel addGestureRecognizer:tap1];
    startLabel.text = @"起点";
    startLabel.textAlignment = NSTextAlignmentCenter;
    self.startLabel = startLabel;
    [backView addSubview:self.startLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectStation:)];
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(72.5,213.5,55,18)];
    endLabel.numberOfLines = 0;
    endLabel.attributedText = string;
    endLabel.userInteractionEnabled = YES;
//    endLabel.backgroundColor = [UIColor greenColor];
    [endLabel addGestureRecognizer:tap];
    endLabel.text = @"终点";
    endLabel.textAlignment = NSTextAlignmentCenter;
    self.endLabel = endLabel;
    [backView addSubview:self.endLabel];
    
    
    UIButton *changeWayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    changeWayBtn.frame = CGRectMake(50, 150, 100, 50);
    [changeWayBtn setBackgroundImage:[UIImage imageNamed:@"changeWay"] forState:UIControlStateNormal];
    [changeWayBtn addTarget:self action:@selector(changeWayBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:changeWayBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchBtnDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [searchBtn setBackgroundColor:[UIColor colorWithRed:40/255.0 green:122/255.0 blue:246/255.0 alpha:1.0]];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 4;
    [backView addSubview:searchBtn];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self).offset(0);
        make.height.equalTo(imageView.mas_width).multipliedBy(150.0/375);
    }];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(imageView.mas_bottom).offset(-30);
        make.height.equalTo(backView.mas_width).multipliedBy(127.0/345);
    }];
    [startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(35);
        make.top.equalTo(backView).offset(20);
        make.width.equalTo(@90);
        make.height.equalTo(startLabel.mas_width).multipliedBy(20.0/60);
    }];
    //
    [endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-35);
        make.top.equalTo(startLabel);
        make.height.width.equalTo(startLabel);
    }];

    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(20);
        make.right.equalTo(backView).offset(-20);
        make.bottom.equalTo(backView).offset(-15);
        make.height.equalTo(searchBtn.mas_width).multipliedBy(40.0/310);
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat changeBtnWidth = endLabel.frame.size.height * 8/3.0;
    CGFloat distance = CGRectGetMinX(endLabel.frame) - CGRectGetMaxX(startLabel.frame);
    CGFloat padding = (distance - changeBtnWidth) * 0.5;
//    NSLog(@"%lf %lf %lf",changeBtnWidth,distance,padding);
    [changeWayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startLabel).offset(5);
        make.left.equalTo(startLabel.mas_right).offset(padding);
        make.width.equalTo([NSNumber numberWithDouble:changeBtnWidth]);
        make.height.equalTo(changeWayBtn.mas_width).multipliedBy(2.5/8);
    }];
    
    
}


-(void)changeWayBtnDidClicked:(UIButton *)btn {
    NSString *temp = self.startLabel.text;
    self.startLabel.text = self.endLabel.text;
    self.endLabel.text = temp;
//    btn.transform = CGAffineTransformRotate(btn.transform, M_PI);
}

-(void)searchBtnDidClicked {
    if ([self.startLabel.text isEqualToString:@"起点"] || [self.endLabel.text isEqualToString:@"终点"] || [self.startLabel.text isEqualToString:@"终点"] || [self.endLabel.text isEqualToString:@"起点"] || [self.startLabel.text isEqualToString:self.endLabel.text]) {
        [SVProgressHUD showErrorWithStatus:@"请选择正确的站点"];
        return;
    }
    if (self.searchBtnBlock) {
//        NSLog(@"%@--%@",self.startLabel.text, self.endLabel.text);
        self.searchBtnBlock(self.startLabel.text, self.endLabel.text,CGRectGetMaxY(self.backView.frame)+10);
    }
}

-(void)selectStation:(UITapGestureRecognizer *)tap {
//    SCREEN_WIDTH*0.15, SCREEN_HEIGHT/2-125, SCREEN_WIDTH*0.7, SCREEN_WIDTH*0.7*14/15
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    SWUByWayPickerView* picker = [[SWUByWayPickerView alloc] initWithFrame:CGRectMake(width*0.15, height/2-125, width*0.7, width*0.7*14/15)];
    picker.center = self.center;
    UILabel *stationLabel = (UILabel *)tap.view;
    picker.block = ^(NSString * _Nonnull station) {
        stationLabel.text = station;
    };
    if (self.selectStationBlock) {
        self.selectStationBlock(picker);
    }
}

@end
