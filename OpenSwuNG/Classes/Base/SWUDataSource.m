//
//  SWUDataSource.m
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/9.
//

#import "SWUDataSource.h"

@interface SWUDataSource()

@end

@implementation SWUDataSource
-(id)initWithIdentifier:(NSString *)identifier configBloc:(configCellBlock)configBlock {
    if (self = [super init]) {
        self.identifier = identifier;
        self.configCellBlock = configBlock;
    }
    return self;
    
}
-(void)addDataArray:(NSArray *)dataArray{
    if (!dataArray || dataArray.count < 0) {return;}
    if (dataArray.count >= 0) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:dataArray];
}
-(void)removeData:(id)data{
    [self.dataArray removeObject:data];
}
-(id)modelAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
}

#pragma mark ------ UITableViewDataSource -------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray <= 0 ? 0:self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier forIndexPath:indexPath];
    id model = [self modelAtIndexPath:indexPath];
    if (self.configCellBlock) {
        self.configCellBlock(cell, model, indexPath);
    }
    return cell;
}

#pragma mark ------ UICollectionDataSource -------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return !self.dataArray  ? 0: self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    id model = [self modelAtIndexPath:indexPath];
    
    if(self.configCellBlock) {
        self.configCellBlock(cell, model,indexPath);
    }
    
    return cell;
}


#pragma mark ------ lazyLoad -------
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
