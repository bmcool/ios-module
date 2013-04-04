//
//  ViewController.m
//  Pedometer
//
//  Created by Peter de Tagyos on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShakeViewController.h"

#define kUpdateFrequency 60.0

@implementation ShakeViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    motionManager = [[CMMotionManager alloc] init];
    [motionManager setAccelerometerUpdateInterval:1.0 / kUpdateFrequency];
    [motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [self performSelectorOnMainThread:@selector(updateAccelerometerInfo:) withObject:accelerometerData waitUntilDone:NO];
    }];
    
    px = py = pz = 0;
    _shakeCount = 0;
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
    [motionManager stopAccelerometerUpdates];
    
    motionManager = nil;
}

#pragma mark -
#pragma mark - Orientation methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark - Update accelerometer info methods

-(void) updateAccelerometerInfo:(CMAccelerometerData *)accelerometerData
{
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    float xx = acceleration.x;
    float yy = acceleration.y;
    float zz = acceleration.z;
    
    float dot = (px * xx) + (py * yy) + (pz * zz);
    float a = ABS(sqrt(px * px + py * py + pz * pz));
    float b = ABS(sqrt(xx * xx + yy * yy + zz * zz));
    
    dot /= (a * b);
    
    // original 0.82
    if (dot <= 0.85) {
        if (!isSleeping) {
            isSleeping = YES;
            [self performSelector:@selector(wakeUp) withObject:nil afterDelay:0.3];
            [self incrShakeCount];
        }
    }
    
    px = xx; py = yy; pz = zz;
}

#pragma mark -
#pragma mark - Private methods

- (void)wakeUp {
    isSleeping = NO;
}

#pragma mark -
#pragma mark - Public methods

-(void) resetShakeCount
{
    _shakeCount = 0;
}

#pragma mark -
#pragma mark - ShakeDelegate optional methods

-(void) incrShakeCount
{
    _shakeCount += 1;
}

@end
