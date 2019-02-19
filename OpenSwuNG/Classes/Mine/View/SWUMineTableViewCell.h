//
//  SWUMineTableViewCell.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SWUMineModel;

@interface SWUMineTableViewCell : UITableViewCell
/** cell的模型  */
@property (nonatomic,copy) SWUMineModel * swuMine;
@end

NS_ASSUME_NONNULL_END
