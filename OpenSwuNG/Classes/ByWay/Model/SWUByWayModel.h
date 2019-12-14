//
//  SWUByWayModel.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWUByWayModel : NSObject
@property (nonatomic,copy) NSString *startStaName;//开始
@property (nonatomic,copy) NSString *endStaName;
@property (nonatomic,copy) NSString *transferStaDerict;//导航指路
@property (nonatomic,copy) NSString *transferLines;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *needTimeScope;
@property (nonatomic,copy) NSString *transferStaNames;//途径的站点
@property (nonatomic,copy) NSString *transferLinesColor;
@property (nonatomic,copy) NSString *latestReachTimes;//末班发车c时间
@property (nonatomic,strong) NSString *count;
/*
 abstracts = "";
 attachments =             (
 );
 createdBy = 1;
 createdDt = "2019-07-01 12:37:47";
 endStaName = "\U6c99\U576a\U575d";
 endsStaSid = 1179;
 entity = "";
 isValid = 1;
 latestReachTimes = "20:28";
 needTimeScope = 70;
 needTransferTimes = 0;
 platOrganizationEname = "";
 platOrganizationSid = "";
 price = 2;
 sid = 920997;
 skipGenerateSequence = 0;
 startStaName = "\U91cd\U5e86\U56fe\U4e66\U9986";
 startStaSid = 1137;
 status = 1;
 statusLable = "";
 sysOrganizationSid = "";
 transferLines = "\U73af\U7ebf";
 transferLinesColor = eae214;
 transferStaDerict = "\U6d77\U5ce1\U8def\U65b9\U54111\U7ad9";
 transferStaNames = "";
 updatedBy = "";
 updatedDt = "";
 version = 1;
 weekendLeatestReachTimes = "20:28";*/
@end

NS_ASSUME_NONNULL_END
