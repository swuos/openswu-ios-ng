//
//  SWUCollectionViewCell.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/26.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class SWUScrollview;
@interface SWUCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)  SWUScrollview * scrollerView;
@end

NS_ASSUME_NONNULL_END
