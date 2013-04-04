//
//  ViewController.h
//  Pedometer
//
//  Created by Peter de Tagyos on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MotionViewController.h"

@protocol ShakeDelegate

@optional
-(void) incrShakeCount;

@end

@interface ShakeViewController : MotionViewController <ShakeDelegate> {
    CMMotionManager *motionManager;
    
    float px;
    float py;
    float pz;

    BOOL isChange;
    BOOL isSleeping;
}

@property (assign, nonatomic) int shakeCount;

@end
