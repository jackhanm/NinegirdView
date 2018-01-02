//
//  DataSource.m
//  YANScrollMenu
//
//  Created by Yan. on 2017/7/4.
//  Copyright © 2017年 Yan. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNull class]]||[value isEqual:[NSNull null]] || value == nil) {
        
        [self setValue:@"" forKey:key];
        return;
    }
    NSLog(@"------%@",value);
    [super setValue:value forKey:key];
    
}
@end
