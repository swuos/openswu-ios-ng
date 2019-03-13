//
//  SWUMainModel.h
//  OpenSwuNG
//
//  Created by 501 on 2019/2/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SWUMainModel : NSObject
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
+(SWUMainModel*)dicToModel:(NSMutableDictionary*)array;
@end

NS_ASSUME_NONNULL_END
