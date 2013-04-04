//
//  Station.m
//  module-test
//
//  Created by Lin Chi-Cheng on 13/3/28.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "Station.h"

@implementation Station

-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _cacheData = data;
        
        self.weather = [Weather new];
        
        [self setValuesForKeysWithDictionary:[_cacheData objectForKey:@"main"]];
        [self.weather setValuesForKeysWithDictionary:[[_cacheData objectForKey:@"weather"] objectAtIndex:0]];
    }
    return self;
}

-(CGFloat) tempC
{
    // just for normal environment
    return MAX(self.temp - 273.15, 0);
}

-(CGFloat) tempF
{
    // just for normal environment
    return MAX(self.temp * 9/5 - 459.67, 0);
}

@end
