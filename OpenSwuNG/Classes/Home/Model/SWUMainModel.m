//
//  SWUMainModel.m
//  OpenSwuNG
//
//  Created by 501 on 2019/2/26.
//

#import "SWUMainModel.h"

@implementation SWUMainModel
+(SWUMainModel*)dicToModel:(NSMutableDictionary*)array{
    SWUMainModel* model=[[SWUMainModel alloc]init];
    [model setValuesForKeysWithDictionary:array];
    return model;
}
@end

