//
//  SWUScoreCell.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SWUScoreModel;
@interface SWUScoreCell : UITableViewCell
/** 模型数据  */
@property (nonatomic,strong) SWUScoreModel * model;
@end

NS_ASSUME_NONNULL_END
