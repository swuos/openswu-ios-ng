//
//  SWUAFN.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/8.
//

#import "SWUAFN.h"

@implementation SWUAFN
+(AFHTTPSessionManager *)swuAfnManage {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"appVersion"];
    [manager.requestSerializer setValue:@"8.0" forHTTPHeaderField:@"sysVersion"];
    [manager.requestSerializer setValue:@"mi 6" forHTTPHeaderField:@"phoneModel"];
    [manager.requestSerializer setValue:@"1920" forHTTPHeaderField:@"resolutionRatioHeight"];
    [manager.requestSerializer setValue:@"1080" forHTTPHeaderField:@"resolutionRatioHeight"];
    
    return manager;
    
}
@end
