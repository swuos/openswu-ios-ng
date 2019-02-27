//
//  Constants.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#ifndef Constants_h
#define Constants_h

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define timeHW 25
#define cellHW ((SCREEN_WIDTH - timeHW)/7.0)
#define WeekCounts 20
#define weekScrollerViewH  40

#define NAVBWidth (self.navigationController.navigationBar.frame.size.width)
#define NAVAHeight (self.navigationController.navigationBar.frame.size.height)

#define selectColor [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0]
#define unSelectColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]


#import "SWULabel.h"
#import "Data.h"
#import "Weekitem.h"
#import "MJExtension.h"
#import "SWUAlertViewController.h"
#import "SWUCollectionViewCell.h"
#import "SWUNavTitleView.h"
#import "Masonry.h"

#endif /* Constants_h */
