//
//  ViewController+Addition.m
//  module
//
//  Created by Lin Chi-Cheng on 13/3/29.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (void) setButtonsEnable:(BOOL)enable
{
    [self setButtonsWithBlock:^(UIButton *btn) {
        [btn setEnabled:enable];
    }];
}

- (void)setButtonsWithBlock:(void (^)(UIButton *btn))block
{
    for (UIButton *view in [self subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            block(view);
        }
    }
    
}

@end
