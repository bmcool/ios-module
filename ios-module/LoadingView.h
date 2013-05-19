//
//  LoadingView.h
//  somen
//
//  Created by Lin Chi-Cheng on 12/9/27.
//  Copyright (c) 2012年 COEVO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+(void) startLoadingWithView:(UIView *)view;
+(void) startLoadingWithView:(UIView *)view withFrame:(CGRect)frame;
+(void) stopLoadingWithView:(UIView *)view;

@end
