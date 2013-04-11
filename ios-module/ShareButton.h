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

@class ShareButton;

@protocol ShareButtonDelegate <NSObject>

@optional
- (void) shareButtonWillShare:(ShareButton *)shareButton;

@end



@interface ShareButton : UIButton<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) UIViewController <ShareButtonDelegate> *delegate;

// For Twitter / "Facebook Photo"
@property (strong, nonatomic) UIImage *shareImage;
@property (strong, nonatomic) NSString *shareMessage;


// For Facebook Feed
@property (strong, nonatomic) NSString *feedMessage;
@property (strong, nonatomic) NSString *feedName;
@property (strong, nonatomic) NSString *feedCaption;
@property (strong, nonatomic) NSString *feedDescription;
@property (strong, nonatomic) NSString *feedLink;
@property (strong, nonatomic) NSString *feedPictureURL;

// For EMail
@property (strong, nonatomic) NSString *mailSubject;
@property (strong, nonatomic) NSString *mailMessage;
@property (strong, nonatomic) NSArray *mailRecipients;
@property (strong, nonatomic) UIImage *mailImage;

// For LINE
@property (strong, nonatomic) NSString *lineMessage;



@end
