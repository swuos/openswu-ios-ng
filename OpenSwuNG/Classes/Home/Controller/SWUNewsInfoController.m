//
//  SWUNewsInfoController.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/8.
//

#import "SWUNewsInfoController.h"
#import "SWUMainViewController.h"
#import "SWUNewsModel.h"
#import "Constants.h"
#import "AFNetworking.h"


@interface SWUNewsInfoController ()<UIScrollViewDelegate>

@end

@implementation SWUNewsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.toolbarHidden = NO;//uitoolbar出现
    
    self.view.backgroundColor = [UIColor whiteColor];
    SWUNewsModel * model ;
    if (self.newInfoBlock) {
//        model = self.newInfoBlock();
        NSDictionary *resultDic = self.newInfoBlock();
        model = resultDic[@"model"];
        self.navigationItem.title = [NSString stringWithFormat:@"%@详情",resultDic[@"name"]];
    }
    
    [self setUI:model];
    
}
-(void)setUI:(SWUNewsModel *)model {
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVA_MAXY, SCREEN_WIDTH, SCREEN_HEIGHT-NAVA_MAXY)];
//    contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentView];
    
    CGFloat padding = 10;
    CGFloat fontSize = 19;
    //    标题
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 3, SCREEN_WIDTH-2*padding, 50)];
    titlelabel.numberOfLines = 0;
    titlelabel.font = [UIFont systemFontOfSize:fontSize];
    titlelabel.text = model.title;
//    titlelabel.backgroundColor = [UIColor blueColor];
    [titlelabel sizeToFit];
    CGSize size = [self calculateProperRect:titlelabel padding:padding];
//    titlelabel.frame = CGRectMake(titlelabel.frame.origin.x, titlelabel.frame.origin.y, size.width, size.height);
    titlelabel.center = CGPointMake(self.view.center.x, titlelabel.center.y);
    [contentView addSubview:titlelabel];
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, CGRectGetMaxY(titlelabel.frame)+5, 60, 20)];
    timeLabel.font = [UIFont systemFontOfSize:(fontSize - 6)];
    timeLabel.text = model.time;
//    timeLabel.backgroundColor = [UIColor blueColor];
    [timeLabel sizeToFit];
//    size = [self calculateProperRect:timeLabel padding:padding];
//    timeLabel.frame = CGRectMake(timeLabel.frame.origin.x, timeLabel.frame.origin.y, size.width, size.height);
    [contentView addSubview:timeLabel];
    
    
    
    CGFloat picWidth = SCREEN_WIDTH-2*padding;
    CGFloat picHeight = picWidth / 1.5;
    if (model.imgUrl.count > 0) {
        for (int i = 0; i < model.imgUrl.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(timeLabel.frame)+5 + i*(picHeight + 2), picWidth, picHeight)];
            [self loadImageView:model.imgUrl[i] imageView:imageView];
            [contentView addSubview:imageView];
        }
    }
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(timeLabel.frame)+model.imgUrl.count * (picHeight + 2)+5, picWidth, 9000)];
    contentLabel.font = [UIFont systemFontOfSize:(fontSize - 3)];
    contentLabel.text = [NSString stringWithFormat:@"    %@",model.contents];
    contentLabel.numberOfLines = 0;
    size = [self calculateProperRect:contentLabel padding:padding];
    [contentLabel sizeToFit];
//    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, size.width, size.height);
    //    CGRect rect = titlelabel.frame;
    //    NSLog(@"%lf %lf %lf %lf",rect.origin.x,rect.origin.y, rect.size.width,rect.size.height);
    [contentView addSubview:contentLabel];
    //    NSLog(@"%lf  %lf %lf",CGRectGetMaxY(contentLabel.frame),SCREEN_WIDTH,SCREEN_HEIGHT);
    contentView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(contentLabel.frame));
    
}

-(void)loadImageView:(NSString *)url imageView:(UIImageView *)imageView{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    [manager.requestSerializer setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        imageView.image = [UIImage imageWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//自适应label的高度
-(CGSize )calculateProperRect:(UILabel *)label padding:(CGFloat)padding {
//    CGFloat fontSize = label.font.pointSize;
//    NSMutableParagraphStyle *paragraphstyle=[[NSMutableParagraphStyle alloc]init];
//    paragraphstyle.lineBreakMode=NSLineBreakByCharWrapping;
//    NSDictionary *dic=@{NSFontAttributeName:label.font,NSParagraphStyleAttributeName:paragraphstyle.copy};
//    CGRect rect=[label.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-2*padding, self.view.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
//    [label.text sizeWithFont:[UIFont boldSystemFontOfSize:17.0f] constrainedToSize:CGSizeMake(self.view.frame.size.width, 300) lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

@end
