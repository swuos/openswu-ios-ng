//
//  SWUPopularModel.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUPopularModel : NSObject
@property (nonatomic,copy) NSString * author;
@property (nonatomic,copy) NSString * bookId;
@property (nonatomic,copy) NSString * bookName;
/**已经借阅次数*/
@property (nonatomic,copy) NSString * borrowTime;
@property (nonatomic,copy) NSString * publisher;
@end

NS_ASSUME_NONNULL_END
