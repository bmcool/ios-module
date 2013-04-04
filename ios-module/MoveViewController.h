//
//  MoveViewController.h
//  module
//
//  Created by Lin Chi-Cheng on 13/3/26.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "MotionViewController.h"

@protocol MoveDelegate

@required
- (void)locationUpdate:(CLLocation *)location distance:(CLLocationDistance)distance timeInterval:(NSTimeInterval)timeInterval;

@optional
- (void)locationError:(NSError *)error;
- (void)locationLongTimeNoUpdate;

@end

@interface MoveViewController : MotionViewController<MoveDelegate> {
    NSTimer *detectLocationUpdateStatusTimer;
    NSDate *lastUpdateTime;
}

@end
