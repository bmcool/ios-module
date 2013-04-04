//
//  Station.h
//  module-test
//
//  Created by Lin Chi-Cheng on 13/3/28.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import "Weather.h"

@interface Station : NSObject {
    id _cacheData;
}

@property (assign, nonatomic) NSInteger humidity;
@property (assign, nonatomic) NSInteger pressure;
@property (assign, nonatomic) CGFloat temp;
@property (assign, nonatomic) CGFloat temp_max;
@property (assign, nonatomic) CGFloat temp_min;

@property (assign, nonatomic) CGFloat tempC;
@property (assign, nonatomic) CGFloat tempF;

@property (strong, nonatomic) Weather *weather;

-(id) initWithDictionary:(NSDictionary *)data;

@end
