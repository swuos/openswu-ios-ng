//
//  SWUMainDataSource.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/9.
//

#import "SWUMainDataSource.h"

@interface SWUMainDataSource()
/**临时的数据数组*/
@property (nonatomic,strong) NSMutableArray *tmpArray;
//总的数据字典
@property (nonatomic,strong) NSMutableDictionary *totalDicData;
@end

@implementation SWUMainDataSource
-(void)addDataArray:(NSArray *)dataArray currentType:(NSString *)type{
    self.tmpArray = self.totalDicData[type];
    [self.tmpArray addObjectsFromArray:dataArray];
    self.totalDicData[type] = self.tmpArray;
    [self loadExistTypeData:type];
}

-(id)getCurrentTypeData:(NSString *)type{
    return self.totalDicData[type];
}
-(void)loadExistTypeData:(NSString *)type{
    self.tmpArray = self.totalDicData[type];
    [super addDataArray:self.tmpArray];
}

#pragma mark ------ lazyLoad -------
-(NSMutableArray *)tmpArray {
    if (!_tmpArray) {
        _tmpArray = [NSMutableArray array];
    }
    return _tmpArray;
}

-(NSMutableDictionary *)totalDicData {
    if (!_totalDicData) {
        _totalDicData = [NSMutableDictionary dictionary];
    }
    return _totalDicData;
}
@end
