//
//  UIViewController+Addition.m
//  module
//
//  Created by Lin Chi-Cheng on 13/3/29.
//  Copyright (c) 2013年 lifebaby. All rights reserved.
//

#import "UIViewController+StoryboardExtend.h"

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

@end
