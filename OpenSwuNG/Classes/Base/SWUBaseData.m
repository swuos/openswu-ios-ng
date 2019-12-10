//
//  SWUBaseData.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/8.
//

#import "SWUBaseData.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@implementation SWUBaseData
+(void)loadDatawithMethod:(NSString *)method
                      url:(NSString *)url
                   params:(id)params
                  keyword:(NSString *)keyword
                    model:(id)model
                  success:(SuccessBlock)succesBlock
                  failure:(FailureBlock)failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    if ([url containsString:@"library"]) {
        [manager.requestSerializer setValue:params[@"cookieName"] forHTTPHeaderField:@"cookieName"];
    }
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([[method uppercaseString] isEqualToString:@"GET"]) {
            [manager GET:[NSString stringWithFormat:@"https://freegatty.swuosa.xenoeye.org/%@",url] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id baseDataArr = responseObject;
                if (keyword.length > 0) {
                    baseDataArr = responseObject[keyword];
                }
                if ([url containsString:@"queryLostFoundRecord"]) {
                    baseDataArr = [self convertToArray:responseObject[@"data"]];
                }
                NSArray * array = [model mj_objectArrayWithKeyValuesArray:baseDataArr];
                succesBlock(array);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }else {
            [manager POST:[NSString stringWithFormat:@"https://freegatty.swuosa.xenoeye.org/%@",url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *baseDataArr = responseObject;
                if (keyword.length > 0) {
                    baseDataArr = responseObject[keyword];
                }
                NSArray * array = [model mj_objectArrayWithKeyValuesArray:baseDataArr];
                succesBlock(array);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
    });
}

+(NSArray *)convertToArray:(NSDictionary *)Dic {
    NSMutableArray *dataArr = [NSMutableArray array];
    NSDictionary *dic = [NSDictionary dictionary];
    for (int i = 1; i < 21; i++) {
        dic = Dic[[NSString stringWithFormat:@"%d",i]];
        //        最后返回的不是20个
        if (dic == nil) {
            return dataArr;
        }
        [dataArr addObject:dic];
    }
    return dataArr;
}
@end
