//
//  AudioToolkit.h
//  ios-module
//
//  Created by Lin Chi-Cheng on 13/4/5.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

SystemSoundID audioEffect;

@interface AudioToolkit : NSObject

+ (void)playSound:(NSString *)soundPath ofType:(NSString *)type;

@end
