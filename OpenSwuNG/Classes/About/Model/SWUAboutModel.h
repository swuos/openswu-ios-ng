//
//  SWUAboutModel.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUAboutModel : NSObject
/** symbol  */
@property (nonatomic,copy) NSString * symbol;
/** content  */
@property (nonatomic,copy) NSString * content;
/** controller  */
@property (nonatomic,copy) NSString * controller;
@end

NS_ASSUME_NONNULL_END
