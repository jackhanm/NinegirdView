//
//  YWscollviewcell.h
//  YWscrollview
//
//  Created by yuhao on 2017/8/3.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWmeunObject.h"
#import "YWscollview.h"

@interface YWscollviewcell : UICollectionViewCell
+ (NSString *)identifier;
/**
*  The size of icon.
*/
@property (nonatomic, assign) CGFloat iconSize  UI_APPEARANCE_SELECTOR ; //defaul is 40;
/**
 *  The cornerRadius of icon.
 */
@property (nonatomic, assign) CGFloat iconCornerRadius UI_APPEARANCE_SELECTOR; //defaul is 20;
/**
 *  The color of label.
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR ; //defaul is [UIColor darkTextColor];
/**
 *  The font of label.
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR; //defaul is [UIFont systemFontOfSize:14];

/**
 *  The icon.
 */
@property (nonatomic, strong) UIImageView *icon;
/**
 *  The label.
 */
@property (nonatomic, strong) UILabel *label;
/**
 *  The edge of item.
 */
@property (nonatomic, assign) YANEdgeInsets edgeInsets; //default is {5,0,5,0,5}
- (void)customizeItemWithObject:(id<YWmeunObject>)object;

@end
