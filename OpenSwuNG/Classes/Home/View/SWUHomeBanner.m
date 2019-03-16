//
//  SWUHomeBanner.m
//  OpenSwuNG
//
//  Created by 501 on 2019/3/7.
//

#import "SWUHomeBanner.h"
@interface SWUHomeBanner ()
/** banner的图片 */
@property(nonatomic,copy)NSArray *images;
/** banner当前页数 */
@property(nonatomic,assign)NSInteger page;
/** timer */
@property(nonatomic,weak)NSTimer* timer;
@end

@implementation SWUHomeBanner

//690 320 px
//345 160 pt

+(instancetype)bannerWithFrame:(CGRect)frame
{
    SWUHomeBanner* banner = [[SWUHomeBanner alloc]initWithFrame:frame];
    //设置banner属性
    banner.contentSize = CGSizeMake(banner.frame.size.width*3, 0);
    banner.layer.cornerRadius = 5;
    banner.showsVerticalScrollIndicator = NO;
    banner.showsHorizontalScrollIndicator = NO;
    banner.pagingEnabled = YES;
    banner.bounces = NO;
    banner.page = 0;
    banner.images = @[@"banner1",@"banner2",@"banner3"];
    [banner initBannerImages:banner.images];
    [banner startTimer];
    return banner;
}

-(void)initBannerImages:(NSArray*)images{
    //添加图片
    for(int i=0;i<3;i++){
        UIImageView *temp = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        temp.image = [UIImage imageNamed:images[i]];
        [self addSubview:temp];
    }
}

#pragma mark - NSTimer
-(void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer{
    [self.timer invalidate];
}

-(void)nextPage{
    if(self.page == 2){
        [self toPage:0];
    }
    else
        [self toPage:self.page+1];
}

-(void)toPage:(NSInteger)page{
    self.page = page;
    [self setContentOffset:CGPointMake(self.frame.size.width*page, 0) animated:YES];
}

@end
