//
//  SWUNewsCell.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SWUNewsModel;
@interface SWUNewsCell : UITableViewCell
@property (nonatomic,strong) SWUNewsModel *model;
@end

NS_ASSUME_NONNULL_END
