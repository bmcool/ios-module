//
//  ViewController+Addition.h
//  module
//
//  Created by Lin Chi-Cheng on 13/3/29.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

- (void)setButtonsEnable:(BOOL)enable;
- (void)setButtonsWithBlock:(void (^)(UIButton *btn))block;

@end
