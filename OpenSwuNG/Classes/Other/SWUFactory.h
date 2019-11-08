//
//  SWUFactory.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWUFactory : NSObject
+(AFHTTPSessionManager *)SWUFactoryManage;
+(NSArray *)getScheduleData;
+(NSArray *)getData:(NSArray *)dataArray model:(id)model;

@end

NS_ASSUME_NONNULL_END
