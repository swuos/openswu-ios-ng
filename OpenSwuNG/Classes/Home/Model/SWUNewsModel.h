//
//  SWUHotNewsModel.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUNewsModel : NSObject
@property (nonatomic,copy) NSString *contents;
@property (nonatomic,copy) NSArray *imgUrl;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
