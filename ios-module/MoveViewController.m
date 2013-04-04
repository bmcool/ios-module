//
//  MoveViewController.m
//  module
//
//  Created by Lin Chi-Cheng on 13/3/26.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "MoveViewController.h"

#define kDetectLocationUpdateStatusFrequency 5.0

@interface MoveViewController ()

@end

@implementation MoveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    lastUpdateTime = [NSDate date];
    
    detectLocationUpdateStatusTimer = [NSTimer scheduledTimerWithTimeInterval:kDetectLocationUpdateStatusFrequency target:self selector:@selector(detectLocationUpdateStatus) userInfo:nil repeats:YES];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [detectLocationUpdateStatusTimer invalidate];
}

#pragma mark -
#pragma mark - Private methods

- (void) detectLocationUpdateStatus
{    
    if ([[NSDate date] timeIntervalSinceDate:lastUpdateTime] >= kDetectLocationUpdateStatusFrequency) {
        [self locationLongTimeNoUpdate];
    }
}

#pragma mark -
#pragma mark - CLLocationManagerDelegate methods

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation.horizontalAccuracy > 0)
    {
        CLLocationDistance distance = [newLocation distanceFromLocation:oldLocation];
        
        if (distance > 0 && newLocation.speed > 0) {
            lastUpdateTime = newLocation.timestamp;
            
            NSTimeInterval timeInterval = [lastUpdateTime timeIntervalSinceDate:oldLocation.timestamp];
            [self locationUpdate:newLocation distance:distance timeInterval:timeInterval];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self locationError:error];
}

#pragma mark -
#pragma mark - MoveDelegate methods

-(void) locationUpdate:(CLLocation *)location distance:(CLLocationDistance)distance timeInterval:(NSTimeInterval)timeInterval
{
    NSLog(@"Not Implemented %s", __PRETTY_FUNCTION__);
}

-(void) locationError:(NSError *)error
{
    NSLog(@"Not Implemented %s", __PRETTY_FUNCTION__);
}

-(void) locationLongTimeNoUpdate
{
    NSLog(@"Not Implemented %s", __PRETTY_FUNCTION__);
}

@end
