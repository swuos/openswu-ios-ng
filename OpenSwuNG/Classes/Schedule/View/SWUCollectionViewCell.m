//
//  SWUCollectionViewCell.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/26.
//

#import "SWUCollectionViewCell.h"
#import "SWUScrollview.h"

@interface SWUCollectionViewCell ()
/**  SWUScrollview * scrollerView  */
@property (nonatomic,strong)  SWUScrollview * scrollerView;
@end

@implementation SWUCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.scrollerView = [[SWUScrollview alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_scrollerView];
    }
    return self;
}

//调整cell中dscrollerview的偏移
-(void)prepareForReuse {
    self.scrollerView.contentOffset = CGPointMake(0, 0);
}


@end
