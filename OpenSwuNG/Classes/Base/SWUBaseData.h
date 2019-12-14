//
//  SWUBaseData.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SuccessBlock) (NSArray *dataArray);
typedef void(^FailureBlock) (id error);
@interface SWUBaseData : NSObject
+(void)loadDatawithMethod:(NSString *)method
                      url:(NSString *)url
                   params:(id)params
                  keyword:(NSString *)keyword
                    model:(id)model
                  success:(SuccessBlock)succesBlock
                  failure:(FailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
