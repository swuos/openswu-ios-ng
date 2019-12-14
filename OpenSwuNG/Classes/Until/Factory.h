//
//  Factory.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Factory : NSObject
+ (UIImage*)createImageWithColor:(UIColor*)color;
@end

NS_ASSUME_NONNULL_END
