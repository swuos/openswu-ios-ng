//
//  SWULibraryBorrowingModel.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWULibraryBorrowingModel : NSObject
@property (nonatomic,copy) NSString* bookName;
@property (nonatomic,copy) NSString* author;
@property (nonatomic,copy) NSString* fromTime;
@property (nonatomic,copy) NSString* toTime;
@property (nonatomic,copy) NSString* renewInfo;

@end

NS_ASSUME_NONNULL_END
