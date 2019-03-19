//
//  SWUHomeScheduleSubview.m
//  OpenSwuNG
//
//  Created by 501 on 2019/3/6.
//

#import "SWUHomeScheduleSubview.h"

@interface SWUHomeScheduleSubview()
@end

@implementation SWUHomeScheduleSubview
+(instancetype)scheduleSubviewWithFrame:(CGRect)frame
                                  Title:(NSString*)titleText
                                Content:(NSString*)contenText
                                 number:(NSInteger)number{
    SWUHomeScheduleSubview* sub = [[SWUHomeScheduleSubview alloc]initWithFrame:frame];
    
    //title
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(sub.frame.size.width/10.0,sub.frame.size.height*16.0/65.0,sub.frame.size.width-(sub.frame.size.width/10.0)-20, sub.frame.size.height*16.0/65.0)];
    title.font = [UIFont boldSystemFontOfSize:16];
    title.adjustsFontSizeToFitWidth = YES;
    title.textColor = [UIColor whiteColor];
    [title setText:titleText];
    title.numberOfLines = 0;
    [sub addSubview:title];
    
    //content
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(sub.frame.size.width/10.0,title.frame.origin.y+title.frame.size.height+8,sub.frame.size.width-(sub.frame.size.width/10.0)-10, sub.frame.size.height*10.0/65.0)];
    content.font = [UIFont systemFontOfSize:10];
    content.adjustsFontSizeToFitWidth = YES;
    content.textColor = [UIColor whiteColor];
    [content setText:contenText];
    content.numberOfLines = 0;
    //image
    NSArray *image = @[@"blue",@"orange",@"cyan",@"purple",@"yellow",@"red"];
    sub.image = [UIImage imageNamed:image[number%6]];
    [sub addSubview:content];
    return sub;
}
@end
