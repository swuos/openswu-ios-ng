//
//  SWUScheduleModel.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUScheduleModel : NSObject
/** success  */
//@property (nonatomic,copy)  NSString* success;
///** result  */
//@property (nonatomic,copy) NSDictionary * result;
@property (nonatomic,copy)  NSString* code;
@property (nonatomic,copy)  NSString* message;
/** result  */
@property (nonatomic,copy) NSArray * data;

@end

NS_ASSUME_NONNULL_END
