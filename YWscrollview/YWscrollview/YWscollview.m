//
//  YWscollview.m
//  YWscrollview
//
//  Created by yuhao on 2017/8/3.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import "YWscollview.h"
#import "YWmeunObject.h"
#import "YWscollviewcell.h"
#import "Masonry.h"

#define kScale(P)                ((P) * ([UIScreen mainScreen].bounds.size.width / 375.f))
#define kPageControlHeight       16
/**********************  YANMenuSectionProtocol ***************************/
@class YANMenuSection;

@protocol YWMenuSectionProtocol <NSObject>
/**
 Size of items.
 
 @param menuSection YANMenuSection
 @return CGSize
 */
- (CGSize)sizeOfItemsInMenuSection:(YANMenuSection *)menuSection;
/**
 Number of items.
 
 @param menuSection YANMenuSection
 @return NSUInteger
 */
- (NSUInteger)numberOfItemsInMenuSection:(YANMenuSection *)menuSection;
/**
 Object at indexPath.
 
 @param menuSection YANMenuSection
 @param indexPath NSIndexPath
 @return id<YANMenuObject>
 */
- (id<YWmeunObject>)menuSection:(YANMenuSection *)menuSection objectAtIndexPath:(NSIndexPath *)indexPath;



@optional
/**
 EdgeInsets of item.
 
 @param menuSection YANMenuSection
 @return YANEdgeInsets
 */
- (YANEdgeInsets)edgeInsetsOfItemMenuSection:(YANMenuSection *)menuSection;
/**
 Did select item at indexPath.
 
 @param menuSection YANMenuSection
 @param indexPath NSIndexPath
 */
- (void)menuSection:(YANMenuSection *)menuSection didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end




/**********************  YANMenuSection ***************************/
NS_CLASS_AVAILABLE_IOS(8_0) @interface YANMenuSection : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  The collectionView.
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  The delegate.
 */
@property (nonatomic, weak) id<YWMenuSectionProtocol> delegate;
/**
 *  The section.
 */
@property (nonatomic, assign) NSUInteger section;

@end

@implementation YANMenuSection
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
        
    }
    return self;
}
#pragma mark - Getter&Setter
- (void)setDelegate:(id<YWScrollMenuProtocol>)delegate{
    
    _delegate = delegate;
    
    if (self.collectionView) {
        [self.collectionView reloadData];
    }
}
#pragma mark - Prepare UI
- (void)prepareUI{
    
    
    self.collectionView = ({
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        
        [collectionView registerClass:[YWscollviewcell class] forCellWithReuseIdentifier:[YWscollviewcell identifier]];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView;
        
    });
    
    [self.contentView addSubview:self.collectionView];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark - Identifier
+ (NSString *)identifier{
    
    return NSStringFromClass([self class]);
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sizeOfItemsInMenuSection:)]) {
        
        return [self.delegate sizeOfItemsInMenuSection:self];
    }
    
    return CGSizeZero;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfItemsInMenuSection:)]) {
        
        return [self.delegate numberOfItemsInMenuSection:self];
    }
    
    return 0;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    YWscollviewcell *item = [collectionView dequeueReusableCellWithReuseIdentifier:[YWscollviewcell identifier] forIndexPath:indexPath];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetsOfItemMenuSection:)]) {
        item.edgeInsets = [self.delegate edgeInsetsOfItemMenuSection:self];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuSection:objectAtIndexPath:)]) {
        
        id<YWmeunObject> object = [self.delegate menuSection:self objectAtIndexPath:indexPath];
        [item customizeItemWithObject:object];
    }
    
    return item;
    
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuSection:didSelectItemAtIndexPath:)]) {
        
        [self.delegate menuSection:self didSelectItemAtIndexPath:indexPath];
    }
}

@end
@interface YWscollview ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YWMenuSectionProtocol>
/**
 *  The collectionView.
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  The pageControl.
 */
@property (nonatomic, strong) UIPageControl *pageControl;

@end
@implementation YWscollview
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    return self;
}
#pragma mark - Getter&Setter
- (void)setDelegate:(id<YWScrollMenuProtocol>)delegate{
    
    _delegate = delegate;
    
    if (self.collectionView) {
        
        [self.collectionView reloadData];
    }
    
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
    if (self.pageControl) {
        
        self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    }
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
    if (self.pageIndicatorTintColor) {
        
        self.pageIndicatorTintColor = pageIndicatorTintColor;
    }
}
#pragma mark - Prepare UI
- (void)prepareUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.collectionView = ({
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        
        [collectionView registerClass:[YANMenuSection class] forCellWithReuseIdentifier:[YANMenuSection identifier]];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"log"];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView;
        
    });
    
    self.pageControl = ({
        UIPageControl * pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        pageControl.currentPageIndicatorTintColor = [UIColor darkTextColor];
        pageControl.pageIndicatorTintColor =  [UIColor groupTableViewBackgroundColor];
        [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        pageControl;
    });
    
    
    
    
    [self addSubview:self.collectionView];
    
    [self addSubview:self.pageControl];
    
    
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    if (_isShowpage) {
        [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(kPageControlHeight);
        }];
        
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.pageControl.mas_top);
        }];
    }else{
        [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(0);
        }];
        self.pageControl.hidden = YES;
        
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.pageControl.mas_top);
        }];
        
    }
    
    
    
    
}
#pragma mark - UICollectionViewDelegateFlowLayout



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(YWscrollViewDidYWScrollView:)]) {
        [self.delegate YWscrollViewDidYWScrollView:self];
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)]) {
        
        NSUInteger rows = [self.delegate numberOfRowsForEachPageInScrollMenu:self];
        
        CGFloat height = (CGRectGetHeight(self.frame) - kPageControlHeight)/rows;
        
        return CGSizeMake(CGRectGetWidth(self.frame), height);
        
    }
    return CGSizeZero;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfItemsForEachRowInScrollMenu:)] && [self.delegate respondsToSelector:@selector(numberOfMenusInScrollMenu:)]) {
        
        NSUInteger total = [self.delegate numberOfMenusInScrollMenu:self];
        
        NSUInteger items = [self.delegate numberOfItemsForEachRowInScrollMenu:self];
        
        CGFloat rows = (CGFloat)total * 1.f /items;
        
        if ([self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)]) {
            
            NSUInteger rows = [self.delegate numberOfRowsForEachPageInScrollMenu:self];
            
            NSUInteger numberOfPages = ceil(total*1.f/(rows * items));
            
            self.pageControl.numberOfPages = numberOfPages;
            if (numberOfPages == 1 ||numberOfPages ==0) {
                self.pageControl.hidden = YES;
            }
            
        }
        
        return ceil(rows);
    }
    
    return 0;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    YANMenuSection *section = [collectionView dequeueReusableCellWithReuseIdentifier:[YANMenuSection identifier] forIndexPath:indexPath];
    section.section = indexPath.row;
    section.delegate = self;
    return section;
}
#pragma mark - YANMenuSectionProtocol
- (CGSize)sizeOfItemsInMenuSection:(YANMenuSection *)menuSection{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)] && [self.delegate respondsToSelector:@selector(numberOfItemsForEachRowInScrollMenu:)]) {
        
        NSUInteger rows = [self.delegate numberOfRowsForEachPageInScrollMenu:self];
        
        CGFloat height = (CGRectGetHeight(self.frame) - kPageControlHeight)/rows;
        
        NSUInteger items = [self.delegate numberOfItemsForEachRowInScrollMenu:self];
        
        CGFloat width =  CGRectGetWidth(self.frame)/items;
        
        return CGSizeMake(width, height);
        
    }
    
    return CGSizeZero;
    
}
- (NSUInteger)numberOfItemsInMenuSection:(YANMenuSection *)menuSection{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfMenusInScrollMenu:)] && [self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)]) {
        
        NSUInteger total = [self.delegate numberOfMenusInScrollMenu:self];
        
        NSUInteger items = [self.delegate numberOfItemsForEachRowInScrollMenu:self];
        
        NSUInteger number = total - items * menuSection.section;
        
        
        return MIN(number, items);
        
    }
    
    return 0;
}
- (id<YWmeunObject>)menuSection:(YANMenuSection *)menuSection objectAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenu:objectAtIndexPath:)]) {
        
        NSIndexPath *idx = [NSIndexPath indexPathForRow:indexPath.row inSection:menuSection.section];
        
        return [self.delegate scrollMenu:self objectAtIndexPath:idx];
    }
    
    return nil;
}
- (void)menuSection:(YANMenuSection *)menuSection didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenu:didSelectItemAtIndexPath:)]) {
        
        NSIndexPath *idx = [NSIndexPath indexPathForRow:indexPath.row inSection:menuSection.section];
        
        [self.delegate scrollMenu:self didSelectItemAtIndexPath:idx];
    }
    
}
- (YANEdgeInsets)edgeInsetsOfItemMenuSection:(YANMenuSection *)menuSection{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetsOfItemInScrollMenu:)]) {
        
        return [self.delegate edgeInsetsOfItemInScrollMenu:self];
    }
    
    return YANEdgeInsetsMake(kScale(5), 0, kScale(5), 0, kScale(5));
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageControl setCurrentPage:offset.x / bounds.size.width];
}
#pragma mark - PageCotrolTurn
- (void)pageTurn:(UIPageControl*)sender{
    
    CGSize viewSize = self.collectionView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.collectionView scrollRectToVisible:rect animated:YES];
    
}
#pragma mark - Public
- (void)reloadData{
    
    if (self.collectionView) {
        
        [self.collectionView reloadData];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
