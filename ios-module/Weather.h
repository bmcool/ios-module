//
//  Weather.h
//  module-test
//
//  Created by Lin Chi-Cheng on 13/3/28.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Weather : NSObject

@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *main;

@property (strong, nonatomic) UIImage *iconImage;

@end
