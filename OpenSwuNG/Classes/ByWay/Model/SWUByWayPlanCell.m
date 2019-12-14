//
//  SWUByWayPlanCell.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/18.
//

#import "SWUByWayPlanCell.h"
#import "SWUByWayModel.h"
#import "Masonry.h"

@interface SWUByWayPlanCell()
@property (nonatomic,strong) UILabel *planNumberLabel;
@property (nonatomic,strong) UILabel *startStationLabel;
@property (nonatomic,strong) UILabel *endStationLabel;
@property (nonatomic,strong) UIView *addBackView;
@end

@implementation SWUByWayPlanCell

-(instancetype)initWithFrame:(CGRect)frame model:(SWUByWayModel *)model{
    if (self = [super initWithFrame:frame]) {
        
        [self setUI:model];
    }
    return self;
}

-(void)setUI:(SWUByWayModel *)model {
    
    CGFloat left = 25;
    CGFloat width = self.frame.size.width;
    CGFloat imageHeight = 60.0;
    
    self.planNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    self.planNumberLabel.text = [NSString stringWithFormat:@"方案%@",model.count];
    self.planNumberLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.planNumberLabel];
    
    
    UIView *pointView1 = [self creatPointwithFrame:CGRectMake(0, CGRectGetMaxY(self.planNumberLabel.frame), 20, 20)];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    imageView1.frame = CGRectMake(0, CGRectGetMaxY(self.planNumberLabel.frame), 15, imageHeight);
    imageView1.center = CGPointMake(pointView1.center.x, imageView1.center.y);
    [self addSubview:imageView1];
    [self addSubview:pointView1];
    
    
    self.startStationLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, CGRectGetMaxY(self.planNumberLabel.frame),width, 20)];
//    self.startStationLabel.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.startStationLabel];
    self.startStationLabel.text = model.startStaName;
    
//    添加价钱
    NSArray *imageArray = @[@"cost",@"time",@"end"];
    NSArray *infoArray = @[
                           [NSString stringWithFormat:@"票价%@元",model.price],
                           [NSString stringWithFormat:@"预计乘车时间%d分钟",(int)ceil(model.needTimeScope.integerValue/60)],
                           [NSString stringWithFormat:@"末班车发车时间为%@",model.latestReachTimes]
                           ];
//    NSArray *infoArray = @
    for (int i = 0; i <3; i++) {
        [self infoViewWithFrame:CGRectMake(left, CGRectGetMaxY(self.startStationLabel.frame)+5+i*20, width, 15) image:[UIImage imageNamed:imageArray[i]] info:infoArray[i] contain:self];
    }

//    途径
    NSArray *transferLinesArray = [model.transferLines componentsSeparatedByString:@","];
    NSArray *transferStaDerictArray = [model.transferStaDerict componentsSeparatedByString:@","];
    NSArray *transferStaNamesArray = [model.transferStaNames componentsSeparatedByString:@","];
    self.addBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), width, transferLinesArray.count * imageHeight)];
    self.addBackView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.addBackView];
    
    for (NSInteger i = transferLinesArray.count - 1; i > -1 ; i--) {
        UIView *pointView = [self creatPointwithFrame:CGRectMake(0, (i+1)*imageHeight, 20, 20)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        imageView.frame = CGRectMake(2.5, i*imageHeight, 15, imageHeight);
        [self.addBackView addSubview:imageView];
        [self.addBackView addSubview:pointView];

        if (i < transferLinesArray.count-1) {
            UILabel *stationLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, imageView.center.y, width, 20)];
            stationLabel.text = transferStaNamesArray[i];
            stationLabel.center = CGPointMake(stationLabel.center.x, pointView.center.y+imageHeight+30);
            [self addSubview:stationLabel];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, imageView.center.y, width, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = [NSString stringWithFormat:@"%@---%@",transferLinesArray[i],transferStaDerictArray[i]];
        [self.addBackView addSubview:label];
    }
    
    self.endStationLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, CGRectGetMaxY(self.addBackView.frame),width, 20)];
    self.endStationLabel.text = model.endStaName;
    [self addSubview:self.endStationLabel];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, CGRectGetMaxY(self.endStationLabel.frame));
    
    
}
-(CGFloat)getSize{
    return CGRectGetMaxY(self.endStationLabel.frame);
}

-(UIView *)creatPointwithFrame:(CGRect)frame {
    CGFloat WH = frame.size.width;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, WH, WH)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView *bluePointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WH, WH)];
    bluePointView.backgroundColor = [UIColor colorWithRed:40/255.0 green:122/255.0 blue:246/255.0 alpha:1.0];
    bluePointView.layer.cornerRadius = WH*0.5;
    [backView addSubview:bluePointView];
    
    UIView *whitePointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WH*0.4, WH*0.4)];
    whitePointView.backgroundColor = [UIColor whiteColor];
    whitePointView.layer.cornerRadius = WH*0.5*0.4;
    whitePointView.center = bluePointView.center;
    [backView addSubview:whitePointView];
    
    return backView;
}

-(void)infoViewWithFrame:(CGRect)frame image:(UIImage *)image info:(NSString *)info contain:(UIView *)contain{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
    [backView addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 0, frame.size.width-frame.size.height-10, frame.size.height)];
    label.text = info;
    label.font = [UIFont systemFontOfSize:frame.size.height-2];
    label.center = CGPointMake(label.center.x, imageView.center.y);
    [backView addSubview:label];
    [contain addSubview:backView];
}




@end
