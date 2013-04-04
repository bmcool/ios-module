//
//  Weather.m
//  module-test
//
//  Created by Lin Chi-Cheng on 13/3/28.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "Weather.h"

@implementation Weather

-(void) setIcon:(NSString *)icon
{
    _icon = icon;
    
    self.iconImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", icon]]]];
}

@end
