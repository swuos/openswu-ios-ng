//
//  Data.h
//  课程表scrollerview
//
//  Created by 张俊 on 2019/2/26.
//  Copyright © 2019年 zhangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Data : NSObject
/** weekSort  */
@property (nonatomic,copy) NSString * weekSort;
/** weekitem  */
@property (nonatomic,copy) NSArray * weekitem;
@end

NS_ASSUME_NONNULL_END
