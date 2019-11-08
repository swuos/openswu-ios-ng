//
//  SWULibraryCell.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import <UIKit/UIKit.h>
#import "SWUPopularModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWULibraryCell : UITableViewCell
/** 模型数据  */
@property (nonatomic,strong) SWUPopularModel * model;
@end

NS_ASSUME_NONNULL_END
