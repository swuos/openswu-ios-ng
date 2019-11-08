//
//  SWULibraryCollectModel.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWULibraryCollectModel : NSObject
@property (nonatomic,copy) NSString * bookName;
@property (nonatomic,copy) NSString * isbn;
@property (nonatomic,copy) NSString * author;
@property (nonatomic,copy) NSString * collectTime;
@end

NS_ASSUME_NONNULL_END
