//
//  WeatherAPI.h
//  module
//
//  Created by Lin Chi-Cheng on 13/3/27.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//
//  API source.
//  http://openweathermap.org/

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>

#import "JSONKit.h"

#import "Station.h"

@interface OpenWeatherMap : NSObject<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    NSTimer *updateWeatherTimer;
    
    BOOL canUpdate;
}

@property (assign, nonatomic, readonly) CGFloat latitude;
@property (assign, nonatomic, readonly) CGFloat longitude;

@property (strong, nonatomic, readonly) id cacheData;

@property (strong, nonatomic, readonly) Station *station;

+ (id)sharedInstance;
- (void)updateWithLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude;

@end
