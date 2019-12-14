//
//  SWUByWayCell.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/17.
//

#import "SWUByWayCell.h"
#import "Masonry.h"
#import "SWUByWayModel.h"

@interface SWUByWayCell()
@property (nonatomic,strong) UILabel *planNumberLabel;
@property (nonatomic,strong) UILabel *startStationLabel;
@property (nonatomic,strong) UILabel *endStationLabel;
@property (nonatomic,strong) UIView *addBackView;
@end

@implementation SWUByWayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        self.userInteractionEnabled = NO;
    }
    return self;
}
-(void)setUI {
    self.planNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.planNumberLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.planNumberLabel];
    
    self.startStationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.startStationLabel.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.startStationLabel];
    
    self.endStationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.endStationLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:self.endStationLabel];
    
    
}

-(void)setModel:(SWUByWayModel *)model {
    _model = model;
    self.planNumberLabel.text = [NSString stringWithFormat:@"方案%@",model.count];
    self.startStationLabel.text = model.startStaName;
    self.endStationLabel.text = model.endStaName;
//    @property (nonatomic,copy) NSString *transferStaDerict;//导航指路
//    @property (nonatomic,copy) NSString *transferLines;
//    @property (nonatomic,copy) NSString *price;
//    @property (nonatomic,copy) NSString *needTimeScope;
//    @property (nonatomic,copy) NSString *transferStaNames;//途径的站点
//    @property (nonatomic,copy) NSString *transferLinesColor;
//    @property (nonatomic,copy) NSString *latestReachTimes;//末班发车c时间
    NSArray *transferLinesArray = [model.transferLines componentsSeparatedByString:@","];
    NSArray *transferStaNamesArray = [model.transferStaDerict componentsSeparatedByString:@","];
    
    
    NSLog(@"方案%@--%@---%@--%@",model.count,model.transferLines,model.transferStaNames,model.transferStaNames);
    
    self.addBackView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width-15*2.0, transferLinesArray.count * 50.0)];
    [self addSubview:self.addBackView];
    for (int i = 0; i < transferLinesArray.count; i++) {
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, i*50, 5, 5)];
        pointView.backgroundColor = [UIColor blackColor];
        pointView.layer.cornerRadius = pointView.frame.size.height * 0.5;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + i*50, self.addBackView.frame.size.width, 30)];
        label.text = [NSString stringWithFormat:@"%@--%@",transferLinesArray[i],transferStaNamesArray[i]];
        label.backgroundColor = [UIColor greenColor];
        [self.addBackView addSubview:pointView];
        [self.addBackView addSubview:label];
    }
    [self.planNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [self.startStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.planNumberLabel.mas_bottom).offset(5);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self);
        make.height.equalTo(@30);
    }];

    [self.addBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startStationLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.startStationLabel);
        make.height.equalTo(self.addBackView.mas_height);
    }];
    [self.endStationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addBackView.mas_bottom).offset(5);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self);
        make.height.equalTo(@30);
    }];
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetMaxY(self.endStationLabel.frame));
    
    
}


@end
