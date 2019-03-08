//
//  NSMutableDictionary+Parameters.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/3/6.
//

#import "NSMutableDictionary+Parameters.h"

@implementation NSMutableDictionary (Parameters)
+(NSMutableDictionary *)ParametersDic {
    NSDictionary * paraDic = @{
                               @"Content-Type":@"application/json",
                               @"appVersion":@"1.0.0",
                               @"sysVersion":@"9.0",
                               @"phoneModel":@"sony",
                               @"resolutionRatioHeight":@"1920",
                               @"resolutionRatioHeight":@"1080",
                               };
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    
    return dic;
}
@end
