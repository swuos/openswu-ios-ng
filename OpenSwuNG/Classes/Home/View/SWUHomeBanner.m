//
//  SWUHomeBanner.m
//  OpenSwuNG
//
//  Created by 501 on 2019/3/7.
//

#import "SWUHomeBanner.h"
@interface SWUHomeBanner ()
@property(nonatomic,strong)NSArray *images;
@property(assign,nonatomic)NSInteger page;
@property(nonatomic,weak)NSTimer* timer;
@end

@implementation SWUHomeBanner
+ (instancetype)bannerWithFrame:(CGRect)frame
{
    SWUHomeBanner* banner=[[SWUHomeBanner alloc]initWithFrame:frame];
    //设置banner属性
    banner.contentSize=CGSizeMake(banner.frame.size.width*3, 0);
    banner.backgroundColor=[UIColor redColor];
    banner.showsVerticalScrollIndicator=NO;
    banner.showsHorizontalScrollIndicator=NO;
    banner.pagingEnabled=YES;
    banner.bounces=NO;
    banner.page=0;
    banner.images=@[[UIColor blueColor],[UIColor greenColor],[UIColor grayColor]];
    [banner setBannerImages:banner.images];
    [banner startTimer];
    return banner;
}


-(void)setBannerImages:(NSArray*)images{
    //添加图片
    for(int i=0;i<3;i++){
        UIView *temp=[[UIView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        temp.backgroundColor=images[i];
        [self addSubview:temp];
    }
}

#pragma mark - NSTimer
-(void)startTimer{
    _timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer{
    [_timer invalidate];
}

-(void)nextPage{
    if(_page==2){
        [self toPage:0];
    }
    else
        [self toPage:_page+1];
}

-(void)toPage:(NSInteger)page{
    _page=page;
    [self setContentOffset:CGPointMake(self.frame.size.width*page, 0) animated:YES];
}

@end
