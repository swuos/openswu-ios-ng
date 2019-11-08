//
//  SWUScoreModel.h
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUScoreModel : NSObject
/** credit学分  */
@property (nonatomic,copy) NSString * credit;
/** lessonType学科类型  */
@property (nonatomic,copy) NSString * lessonType;
/**  绩点 */
@property (nonatomic,copy) NSNumber *  gradePoint;
/** 课程名称  */
@property (nonatomic,copy) NSString * lessonName;
/** 分数  */
@property (nonatomic,copy) NSString * score;


@end

NS_ASSUME_NONNULL_END
