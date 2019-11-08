//
//  SWUFactory.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/11/6.
//

#import "SWUFactory.h"
#import "MJExtension.h"
#import "Weekitem.h"
#import "Constants.h"


@implementation SWUFactory

+(NSArray *)getScheduleData{
    NSArray * array = [Weekitem mj_objectArrayWithFile:DOCUMENT_PATH(@"schedule.plist")];
    return array;
}
+(AFHTTPSessionManager *)SWUFactoryManage {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return manager;
}
+(NSArray *)getData:(NSArray *)dataArray model:(id)model{
    NSArray * array = [model mj_objectArrayWithKeyValuesArray:dataArray];
    return array;
}
@end
