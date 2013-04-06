//
//  NSObject+JSONKIT.m
//  ios-module
//
//  Created by Lin Chi-Cheng on 13/4/6.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "NSObject+JSONKit.h"
#import "JSONKit.h"

@implementation NSObject (JSONKit)

+ (id)dataFromJSONFileNamed:(NSString *)filepath
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resource = [bundle pathForResource:filepath ofType:@"json"];
    
    if (NSClassFromString(@"NSJSONSerialization")) {
        NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:resource];
        [inputStream open];
        
        return [NSJSONSerialization JSONObjectWithStream:inputStream options:0 error:nil];
    } else {
        NSData *jsonData = [NSData dataWithContentsOfFile:resource];
        return [jsonData objectFromJSONData];
    }
}

@end