//
//  NSObject+Swizzle.m
//  module
//
//  Created by Lin Chi-Cheng on 13/3/29.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import "MethodSwizzle.h"

@implementation NSObject (Swizzle)

+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel {
    NSLog(@"Attempting to swizzle in class '%@': swapping method '%s' with '%s'...",[self class], sel_getName(orig_sel), sel_getName(alt_sel));
	
    Swizzle([self class], orig_sel, alt_sel);
}

@end