//
//  WeatherAPI.m
//  module
//
//  Created by Lin Chi-Cheng on 13/3/27.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "OpenWeatherMap.h"

#import "Http.h"
#import "JSONKit.h"

@implementation OpenWeatherMap

static OpenWeatherMap *sharedInstance;

+ (id)sharedInstance
{
    if (!sharedInstance)
    {
        @synchronized(self)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDistanceFilter:kCLDistanceFilterNone];
        
        [self updateWeather];
        updateWeatherTimer = [NSTimer scheduledTimerWithTimeInterval:60*10 target:self selector:@selector(updateWeather) userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark -
#pragma mark - Public methods

- (void)updateWithLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude
{    
    _latitude = latitude;
    _longitude = longitude;
    
    NSString *response = [Http getWithUrl:[NSString stringWithFormat:@"http://openweathermap.org/data/2.1/find/city?lat=%f&lon=%f&cnt=1&APPID=ca16a39c4d442a6f2f589542f97c6708", latitude, longitude] encoding:NSUTF8StringEncoding];
    
    _cacheData = [response objectFromJSONString];
    
    _station = [[Station alloc] initWithDictionary:[[_cacheData objectForKey:@"list"] objectAtIndex:0]];
    [[NSNotificationCenter defaultCenter] postNotificationName:EventWeatherChanged object:nil];
}


- (BOOL)hasData
{
    if (_cacheData && self.station.city) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -
#pragma mark - Private methods

- (void)updateWeather
{
    canUpdate = YES;
    [locationManager startUpdatingLocation];
}

#pragma mark -
#pragma mark - CLLocationManagerDelegate methods

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (canUpdate) {
        canUpdate = NO;
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self updateWithLatitude:newLocation.coordinate.latitude Longitude:newLocation.coordinate.longitude];
            dispatch_async( dispatch_get_main_queue(), ^{
                [locationManager stopUpdatingLocation];
            });
        });
    }
    
}

@end
