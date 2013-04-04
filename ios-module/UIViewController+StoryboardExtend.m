//
//  UIViewController+Addition.m
//  module
//
//  Created by Lin Chi-Cheng on 13/3/29.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "UIViewController+StoryboardExtend.h"
#import "NSObject+Swizzle.h"

#define isFileExists(path) [[NSFileManager defaultManager] fileExistsAtPath:path]
#define isXibExists(file_name_string) isFileExists([[NSBundle mainBundle] pathForResource:file_name_string ofType:@"nib"])

@implementation UIViewController (StoryboardExtend)

-(void) extendViewWillAppear
{
    for (UIView *v in [self.view subviews]) {
        // ex : _Class to Class
        NSString *c = [[v class] description];
        c = [c stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];
        if (isXibExists(c)) {
            if ([v respondsToSelector:@selector(viewWillAppear:)]) {
                [v performSelector:@selector(viewWillAppear:)];
            }
        }
    }
}

- (void)extendViewDidDisAppear
{
    for (UIView *v in [self.view subviews]) {
        NSString *c = [[v class] description];
        c = [c stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];
        if (isXibExists(c)) {
            if ([v respondsToSelector:@selector(viewDidDisappear:)]) {
                [v performSelector:@selector(viewDidDisappear:)];
            }
        }
    }
}

- (void)extendViewDidLoad
{
    for (UIView *v in [self.view subviews]) {
        NSString *c = [[v class] description];
        if (isXibExists(c)) {
            CGRect f = v.frame;
            [v removeFromSuperview];
            id view = [[[NSBundle mainBundle] loadNibNamed:c owner:self options:nil] objectAtIndex:0];
            
            [view setFrame:f];
            [self.view addSubview:view];
            
            NSString *property = [c stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[c substringToIndex:1] lowercaseString]];
            [self setValue:view forKey:property];
        }
    }
    
    
}

- (void) myViewWillAppear:(BOOL)animated
{
    [self myViewWillAppear:animated];
	[self extendViewWillAppear];
}

- (void) myViewDidDisappear:(BOOL)animated
{
    [self myViewDidDisappear:animated];
	[self extendViewDidDisAppear];
}

- (void) myViewDidLoad
{
    [self myViewDidLoad];
	[self extendViewDidLoad];
}

// The "+ load" method is called once, very early in the application life-cycle.
// It's called even before the "main" function is called. Beware: there's no
// autorelease pool at this point, so avoid Objective-C calls.
+(void) load
{
    [self swizzleMethod:@selector(myViewWillAppear:) withMethod:@selector(viewWillAppear:)];
    [self swizzleMethod:@selector(myViewDidDisappear:) withMethod:@selector(viewDidDisappear:)];
    [self swizzleMethod:@selector(myViewDidLoad) withMethod:@selector(viewDidLoad)];
}

@end
