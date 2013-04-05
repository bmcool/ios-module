//
//  AudioToolkit.m
//  ios-module
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "AudioToolkit.h"

@implementation AudioToolkit

+ (void)playSound:(NSString *)soundPath ofType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:soundPath ofType:type];
    NSURL *pathURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
    AudioServicesPlaySystemSound(audioEffect);
//    AudioServicesDisposeSystemSoundID(audioEffect);
}

@end
