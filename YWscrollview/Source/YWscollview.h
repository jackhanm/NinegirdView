//
//  YWscollview.h
//  YWscrollview
//
//  Created by yuhao on 2017/8/3.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWmeunObject.h"

typedef struct YANEdgeInsets{
    
    CGFloat top;        //The top margin of icon
    CGFloat left;       //The left margin of label
    CGFloat middle;     //The margin between label and icon
    CGFloat right;      //The right margin of label
    CGFloat bottom;     //The bottom margin of label
    
}YANEdgeInsets;


/**
 Make YANEdgeInsets
 
 @param top       The top margin of icon
 @param left      The left margin of label
 @param middle    The margin between label and icon
 @param right     The right margin of label
 @param bottom    The bottom margin of label
 @return YANEdgeInsets
 */
UIKIT_STATIC_INLINE YANEdgeInsets YANEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat middle, CGFloat right, CGFloat bottom) {
    YANEdgeInsets insets = {top, left, middle, right,bottom};
    return insets;
}

@class YWscollview ;
/**
 *  @brief  YANScrollMenuProtocol(protocol)
 */
@protocol YWScrollMenuProtocol <NSObject>
/**
 Number of rows for each page.
 
 @param scrollMenu YANScrollMenu
 @return NSUInteger
 */
- (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YWscollview *)scrollMenu;
/**
 Number of items for each row.
 
 @param scrollMenu YANScrollMenu
 @return NSUInteger
 */
- (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YWscollview *)scrollMenu;
/**
 Number of menus (total).
 
 @param scrollMenu YANScrollMenu
 @return NSUInteger
 */
- (NSUInteger)numberOfMenusInScrollMenu:(YWscollview *)scrollMenu;
/**
 Object at index.
 
 @param scrollMenu YANScrollMenu
 @param indexPath NSIndexPath
 @return id<YANMenuObject>
 */
- (id<YWmeunObject>)scrollMenu:(YWscollview *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 实现次方法 定义在多视图 加载在cell上面，可使用此方法带回当前视图
 用于辨别当前视图是在哪一层cell，从而改变cell的样式
 */
-(void)YWscrollViewDidYWScrollView:(YWscollview *)YWScrollerView;

@optional
/**
 The edgeInsets of item.
 
 @param scrollMenu YANScrollMenu
 @return YANEdgeInsets
 */
- (YANEdgeInsets)edgeInsetsOfItemInScrollMenu:(YWscollview *)scrollMenu;
/**
 Did select at index.
 
 @param scrollMenu YANScrollMenu
 @param indexPath NSIndexPath
 */
- (void)scrollMenu:(YWscollview *)scrollMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface YWscollview : UIView

/**
 *  The delegate of YANScrollMenu
 */
@property (nonatomic, weak) id<YWScrollMenuProtocol> delegate;
/**
 *  The currentPageIndicatorTintColor of pageControl.
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;  //default is  [UIColor darkTextColor]
/**
 *  The pageIndicatorTintColor of pageControl.
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor; //default is  [UIColor groupTableViewBackgroundColor]
@property (nonatomic, assign)BOOL isShowpage;
/**
 Use to reload datasource and refresh UI.
 */
- (void)reloadData;

@end
