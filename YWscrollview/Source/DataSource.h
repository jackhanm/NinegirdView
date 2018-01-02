//
//  DataSource.h
//  YANScrollMenu
//
//  Created by Yan. on 2017/7/4.
//  Copyright © 2017年 Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWscollview.h"

@interface DataSource : NSObject<YWmeunObject>
/**
 *  text
 */
@property (nonatomic, copy) NSString *text;
/**
 *  image(eg.NSURL ,NSString ,UIImage)
 */
@property (nonatomic, strong) id image;
/**
 *  placeholderImage
 */
@property (nonatomic, strong) UIImage *placeholderImage;


@end
