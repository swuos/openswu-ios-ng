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
#define TIME_HW 25
#define CELL_HW ((SCREEN_WIDTH - TIME_HW)/7.0)
#define WEEK_COUNTS 20
#define WEEK_SCROLLERVIEW_HEIGHT  40

//#define NAVBWidth (self.navigationController.navigationBar.frame.size.width)
#define NAVA_HEIGHT ((self.navigationController.navigationBar.frame.size.height))
#define NAVA_MAXY (CGRectGetMaxY(self.navigationController.navigationBar.frame))

#define SELECT_COLOR [UIColor colorWithRed:24/255.0 green:113/255.0 blue:245/255.0 alpha:1.0]
#define UNSELECT_COLOR [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

#endif /* Constants_h */
