//
//  SWUScheduleViewController.m
//  OpenSwuNG
//
//  Created by 张俊 on 2019/2/27.
//

#import "SWUScheduleViewController.h"
#import "Constants.h"
#import "SWUWeekSelectView.h"

@interface SWUScheduleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 判断collectionview是左右滑动  */
@property (nonatomic,assign) CGFloat  startContentOffsetX;
/** 课程表页面的标题  */
@property (nonatomic,strong) SWUNavTitleView * navTitleView;
/** 标题图片是否下拉  */
@property (nonatomic,assign) BOOL  isOpen;
/** uicollectionview  */
@property (nonatomic,strong) UICollectionView * collectionView;
/** SWUWeekSelectView * weekScrollerView  */
@property (nonatomic,strong) SWUWeekSelectView * weekScrollerView ;
/** 当前是第几周  */
@property (nonatomic,assign) NSInteger  currentWeek;
/** 选中的button  */
@property (nonatomic,strong) SWULabel * selectBtn;
@end

@implementation SWUScheduleViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUIAndAddGesture];
}

-(void)setUpUIAndAddGesture {
    self.isOpen = true;
    self.currentWeek = 5;
    [self addObserver:self forKeyPath:@"currentWeek" options:NSKeyValueObservingOptionNew context:nil];
    //    添加collectionview
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVAHeight+20, SCREEN_WIDTH, SCREEN_HEIGHT-NAVAHeight-20) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[SWUCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    //    添加修改周课表的scrollerview
    self.weekScrollerView = [[SWUWeekSelectView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.collectionView.frame)-weekScrollerViewH, SCREEN_WIDTH, weekScrollerViewH)];
    for (UIView * view in _weekScrollerView.subviews) {
        if ([view isKindOfClass:[SWULabel class]]) {
            SWULabel * weekBtn = (SWULabel *)view;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnBackGroundSelected:)];
            [weekBtn addGestureRecognizer:tap];
        }
    }
    [self.view addSubview:_weekScrollerView];
    
    
    //    设置导航栏标题
    self.navTitleView = [[SWUNavTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, NAVAHeight)];
    self.navigationItem.titleView = _navTitleView;
    //    给导航栏的下拉图片添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showWeekSelectView)];
    [_navTitleView.weekDeirView addGestureRecognizer:tap];
    
}
//显示出来周的选择视图
-(void)showWeekSelectView {
    if (_isOpen) {
        _isOpen = false;
        [UIView animateWithDuration:0.3 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, weekScrollerViewH);
            self->_navTitleView.weekDeirView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else {
        _isOpen = true;
        [UIView animateWithDuration:0.3 animations:^{
            self->_navTitleView.weekDeirView.transform = CGAffineTransformIdentity;
            self.view.transform = CGAffineTransformIdentity;
        }];
    }
    self.selectBtn = [self.weekScrollerView viewWithTag:self.currentWeek];
    self.selectBtn.backgroundColor = selectColor;
}
//响应点击手势
-(void)btnBackGroundSelected:(UITapGestureRecognizer *)sender {
    self.currentWeek = sender.view.tag;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeCurrentReference];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return WeekCounts;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWUCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark ------ UICollectionViewDelegate ------
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.startContentOffsetX = self.collectionView.contentOffset.x;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if  (self.collectionView.contentOffset.x > _startContentOffsetX) {
        //                NSLog(@"右滑");
        ++self.currentWeek;
    }else if (self.collectionView.contentOffset.x < _startContentOffsetX) {
        //                NSLog(@"左滑");
        --self.currentWeek;
    }else {
        //                NSLog(@"到达开头或者结尾");
    }
    
}


#pragma mark ------ UICollectionViewDelegateFlowLayout ------
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark ------ KVO ------
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self changeCurrentReference];
}


-(void)changeCurrentReference {
    //    被选中的按钮消除颜色
    if (_selectBtn) {
        _selectBtn.backgroundColor = unSelectColor;
    }
    //    更改被选中的按钮
    self.selectBtn = [self.weekScrollerView viewWithTag:self.currentWeek];
    self.selectBtn.backgroundColor = selectColor;
    
    _navTitleView.titleLabel.text = [NSString stringWithFormat:@"第%ld周",self.currentWeek];
    [self.collectionView setContentOffset:CGPointMake((self.currentWeek-1)*SCREEN_WIDTH, 0) animated:YES];
    
    CGFloat offset = _selectBtn.center.x - self.weekScrollerView.frame.size.width*0.5;
    if (offset < 0){
        offset = 0;
    }
    //处理右边的区域
    CGFloat maxOffset = self.weekScrollerView.contentSize.width - self.weekScrollerView.frame.size.width;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.weekScrollerView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

@end
