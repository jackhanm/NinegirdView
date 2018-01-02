//
//  YWscollviewcell.m
//  YWscrollview
//
//  Created by yuhao on 2017/8/3.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import "YWscollviewcell.h"
#import "Masonry.h"
#import "YWmeunObject.h"
#import "UIImageView+WebCache.h"
#define kScale(P)                ((P) * ([UIScreen mainScreen].bounds.size.width / 375.f))
#define kPageControlHeight       16
@interface YWscollviewcell ()


@end
@implementation YWscollviewcell
+ (void)initialize{
    
    YWscollviewcell *item = [self appearance];
    item.iconSize = kScale(40);
    item.iconCornerRadius = kScale(20);
    item.textColor = [UIColor darkTextColor];
    item.textFont = [UIFont systemFontOfSize:kScale(14)];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    
    return self;
    
}
#pragma mark - Getter&Setter
- (void)setIconSize:(CGFloat)iconSize{
    
    if (iconSize >= 0) {
        
        _iconSize = iconSize;
        
        [self updateIconConstraints];
    }
    
}
- (void)setIconCornerRadius:(CGFloat)iconCornerRadius{
    
    if (iconCornerRadius >= 0) {
        
        _iconCornerRadius = iconCornerRadius;
        
        self.icon.layer.cornerRadius = iconCornerRadius;
    }
}
- (void)setTextColor:(UIColor *)textColor{
    
    _textColor = textColor;
    
    self.label.textColor = textColor;
    
}
- (void)setTextFont:(UIFont *)textFont{
    
    _textFont = textFont;
    
    self.label.font = textFont;
    
}
- (void)setEdgeInsets:(YANEdgeInsets)edgeInsets{
    
    _edgeInsets = edgeInsets;
    
    [self updateItemEdgeInsets];
    
}
#pragma mark - Prepare UI
- (void)prepareUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.icon = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = self.iconCornerRadius;
        imageView;
    });
    
    self.label = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = self.textColor;
        label.font = self.textFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    });
    
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.label];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //The constraint of icon.
    [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.edgeInsets.top);
        make.centerX.mas_equalTo(self.contentView);
        make.height.width.mas_equalTo(self.iconSize);
    }];
    
    //The constraint of label.
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(self.edgeInsets.middle);
        make.left.mas_equalTo(self.edgeInsets.left);
        make.right.mas_equalTo(- self.edgeInsets.right);
        make.bottom.mas_equalTo(- self.edgeInsets.bottom);
    }];
    
}
- (void)updateIconConstraints{
    
    if (self.icon) {
        
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(self.iconSize);
        }];
    }
    
}
- (void)updateItemEdgeInsets{
    
    if (self.icon && self.label) {
        
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.edgeInsets.top);
        }];
        
        [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.icon.mas_bottom).offset(self.edgeInsets.middle);
            make.left.mas_equalTo(self.edgeInsets.left);
            make.right.mas_equalTo(- self.edgeInsets.right);
            make.bottom.mas_equalTo(- self.edgeInsets.bottom);
        }];
    }
}
#pragma mark - Customize
- (void)customizeItemWithObject:(id<YWmeunObject>)object{
    
    if (object == nil) return;
    
    self.label.text = object.text;
    
    if ([object.image isKindOfClass:[NSString class]]) {
        
        NSURL *url = [NSURL URLWithString:(NSString *)object.image];
        [self.icon sd_setImageWithURL:url placeholderImage:object.placeholderImage];
        
    }else if ([object.image isKindOfClass:[NSURL class]]){
        
        [self.icon sd_setImageWithURL:(NSURL *)object.image placeholderImage:object.placeholderImage];
        
    }else if ([object.image isKindOfClass:[UIImage class]]){
        
        self.icon.image = (UIImage *)object.image;
    }
}
#pragma mark - Identifier
+ (NSString *)identifier{
    
    return NSStringFromClass([self class]);
    
}


@end
