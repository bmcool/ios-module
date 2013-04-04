//
//  MotionViewController.h
//  module
//
//  Created by Lin Chi-Cheng on 13/3/26.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface MotionViewController : UIViewController<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@end
