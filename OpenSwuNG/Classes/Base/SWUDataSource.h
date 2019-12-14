//
//  SWUDataSource.h
//  OpenSwuNG
//
//  Created by canoejun on 2019/12/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^configCellBlock) (id _Nullable cell,id _Nullable model,NSIndexPath * _Nullable indexPath);
NS_ASSUME_NONNULL_BEGIN

@interface SWUDataSource : NSObject <UITableViewDataSource,UICollectionViewDataSource>

@property (nonatomic,copy) configCellBlock configCellBlock;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *identifier;

-(id)initWithIdentifier:(NSString *)identifier configBloc:(configCellBlock)configBlock;
-(void)addDataArray:(NSArray *)dataArray;
-(void)removeData:(id)data;
-(id)modelAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
