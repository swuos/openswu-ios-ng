//
//  SWULabel.h
//  课程表scrollerview
//
//  Created by 张俊 on 2019/2/26.
//  Copyright © 2019年 zhangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Weekitem;
NS_ASSUME_NONNULL_BEGIN

@interface SWULabel : UILabel
/** 传递数据  */
@property (nonatomic,strong) Weekitem * weekitem;
@end

NS_ASSUME_NONNULL_END
