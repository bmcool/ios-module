//
//  UIResponder+Facebook.m
//  ios-module
//
//  Created by Lin Chi-Cheng on 13/4/10.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "UIResponder+Facebook.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation UIResponder (Facebook)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [FBSession.activeSession close];
}


- (void)applicationDidBecomeActive:(UIApplication *)application	{
    [FBSession.activeSession handleDidBecomeActive];
}

@end
