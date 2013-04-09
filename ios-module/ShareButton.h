//
//  ShareButton.h
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/9.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//


#import <FacebookSDK/FacebookSDK.h>
//  Step 1.
//  Add "FacebookAppID" : "[AppID]" to [project]-info.plist
//
//
//  Step 2.
//  Add "fb[AppID]" to "[Target] -> Info -> URL Types(+) -> URL Schemes"
//
//  Example : fb1234567890


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ShareButton : UIButton<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) UIViewController *delegate;

// For Twitter / Facebook Photo
@property (weak, nonatomic) UIImage *shareImage;
@property (weak, nonatomic) NSString *shareMessage;


// For Facebook Feed
@property (weak, nonatomic) NSString *feedMessage;
@property (weak, nonatomic) NSString *feedName;
@property (weak, nonatomic) NSString *feedCaption;
@property (weak, nonatomic) NSString *feedDescription;
@property (weak, nonatomic) NSString *feedLink;
@property (weak, nonatomic) NSString *feedPictureURL;

// For EMail
@property (weak, nonatomic) NSString *mailSubject;
@property (weak, nonatomic) NSString *mailMessage;
@property (weak, nonatomic) NSArray *mailRecipients;
@property (weak, nonatomic) UIImage *mailImage;

// For LINE
@property (weak, nonatomic) NSString *lineMessage;



@end
