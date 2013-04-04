//
//  NSArray+Addition.m
//  module
//
//  Created by Lin Chi-Cheng on 13/3/28.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray (Addition)

- (BOOL)containsString:(NSString *)string
{
    BOOL (^predicate)(id obj, NSUInteger idx, BOOL *stop) = ^ BOOL(id obj, NSUInteger idx, BOOL *stop)
    {
        return [obj isEqualToString:string];
    };
    
    return ([self indexOfObjectPassingTest:predicate] != NSNotFound);
}

@end
