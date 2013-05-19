//
//  LoadingView.m
//  somen
//
//  Created by Lin Chi-Cheng on 12/9/27.
//  Copyright (c) 2012年 COEVO. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

+(void) startLoadingWithView:(UIView *)view
{
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:view.bounds];
    
    UIActivityIndicatorView *loadingAnimation = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [loadingAnimation setFrame:CGRectMake(view.frame.size.width/2-19, view.frame.size.height/2-19, 37, 37)];
    [loadingAnimation startAnimating];
    [loadingView addSubview:loadingAnimation];
    
    UILabel *loadingLabel = [[UILabel alloc] init];
    loadingLabel.text = @"Loading";
    [loadingLabel setTextColor:[UIColor whiteColor]];
    [loadingLabel setBackgroundColor:[UIColor clearColor]];
    [loadingLabel setFrame:CGRectMake(0, view.frame.size.height/2+25, view.frame.size.width, 30)];
    [loadingLabel setTextAlignment:UITextAlignmentCenter];
    [loadingView addSubview:loadingLabel];
    
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:0.8];
    
    [view addSubview:loadingView];
}

+(void) startLoadingWithView:(UIView *)view withFrame:(CGRect)frame
{
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:frame];
    
    UIActivityIndicatorView *loadingAnimation = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [loadingAnimation setFrame:CGRectMake(loadingView.frame.size.width/2-19, loadingView.frame.size.height/2-19, 20, 20)];
    [loadingAnimation startAnimating];
    [loadingView addSubview:loadingAnimation];
    
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:0.8];
    
    [view addSubview:loadingView];
}

+(void) stopLoadingWithView:(UIView *)view
{
    for (UIView *subview in [view subviews]) {
        if ([subview isKindOfClass:[LoadingView class]]) {
            [subview removeFromSuperview];
        }
    }
}

@end
