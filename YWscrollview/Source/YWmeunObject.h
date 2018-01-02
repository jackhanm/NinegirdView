//
//  YWmeunObject.h
//  YWscrollview
//
//  Created by yuhao on 2017/8/3.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol YWmeunObject<NSObject>
/**
 *  文字
 */
@property (nonatomic, copy) NSString *text;
/**
 *  图片 (eg.NSURL,NSString,UIImage)
 */
@property (nonatomic, strong) id image;
/**
 *  占位图.
 */
@property (nonatomic, strong) UIImage *placeholderImage;

@end

@interface YWmeunObject : NSObject

@end
