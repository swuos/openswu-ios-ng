//
//  SWUMainDataSource.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/9.
//

#import <Foundation/Foundation.h>
#import "SWUDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWUMainDataSource : SWUDataSource

-(void)addDataArray:(NSArray *)dataArray currentType:(NSString *)type;
-(id)getCurrentTypeData:(NSString *)type;
-(void)loadExistTypeData:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
