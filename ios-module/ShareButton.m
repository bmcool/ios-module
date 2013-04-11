//
//  ShareButton.m
//  pedotoys
//
//  Created by Lin Chi-Cheng on 13/4/9.
//  Copyright (c) 2013年 bmcool. All rights reserved.
//

#import "ShareButton.h"

#import <Twitter/Twitter.h>

@implementation ShareButton

- (void) awakeFromNib
{
    [self addTarget:self action:@selector(socialShare) forControlEvents:UIControlEventTouchUpInside];
}

+(BOOL)isSocialFrameworkAvailable
{
    return NSClassFromString(@"SLComposeViewController") != nil;
}

- (void) socialShare
{
    if ([self.delegate respondsToSelector:@selector(shareButtonWillShare:)]) {
        [self.delegate shareButtonWillShare:self];
    }
    
    if ([ShareButton isSocialFrameworkAvailable]) {
        NSMutableArray *activityItems = [NSMutableArray new];
        if (self.shareMessage != nil) {
            [activityItems addObject:self.shareMessage];
        }
        if (self.shareImage != nil) {
            [activityItems addObject:self.shareImage];
        }
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        [self.delegate presentViewController:activityVC animated:YES completion:nil];
    } else {
//        UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Mail", @"LINE", nil];
        UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Mail", nil];

        [shareActionSheet showInView:self.delegate.view];
    }
}

#pragma mark -
#pragma mark - iOS 5 Share methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex == 0) {
            if (self.shareImage) {
                [self facebookPostPhoto];
            } else if (self.feedMessage) {
                [self facebookPostFeed];
            }
        } else if (buttonIndex == 1) {
            [self twitterShare];
        } else if (buttonIndex == 2) {
            [self emailShare];
        } else if (buttonIndex == 3) {
            [self lineShare];
        }
    }
}

#pragma mark - LINE share methods

- (void) lineShare
{
    NSString *urlString = [[NSString stringWithFormat:@"line://msg/text/%@", self.lineMessage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - Email share methods

- (void) emailShare
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        [mailController setMailComposeDelegate:self];
        [mailController setSubject:self.mailSubject];
        [mailController setMessageBody:self.mailMessage isHTML:NO];
        [mailController setToRecipients:self.mailRecipients];
        
        if (self.mailImage) {
            NSData *data = UIImageJPEGRepresentation(self.mailImage, 1.0);
            [mailController addAttachmentData:data mimeType:@"image/jpg" fileName:@"image"];
        }
        
        [self.delegate presentModalViewController:mailController animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please check Email setting." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Succes!" message:@"Sent succesfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else if (result == MFMailComposeResultFailed) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Mail was not sent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else if (result == MFMailComposeResultCancelled || result == MFMailComposeResultSaved) {
        
    }
    [self.delegate dismissModalViewControllerAnimated:YES];
}

#pragma mark - Twitter share methods

- (void) twitterShare
{
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    [twitter setInitialText:self.shareMessage];
    [twitter addImage:self.shareImage];
    
    [self.delegate presentViewController:twitter animated:YES completion:nil];
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {
        if(res == TWTweetComposeViewControllerResultDone) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Succes!" message:@"Posted succesfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        } else if (res == TWTweetComposeViewControllerResultCancelled) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Tweet was not posted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        
        [self.delegate dismissModalViewControllerAnimated:YES];
    };
}

#pragma mark - Facebook share methods

- (void)facebookShowAlertWithError:(NSError *)error
{
    NSString *alertMsg;
    NSString *alertTitle;
    
    if (error) {
        alertTitle = @"Error";
        alertMsg = @"Operation failed due to a connection problem, retry later.";
        alertMsg = [error description];
    } else {
        alertTitle = @"Success";
        alertMsg = @"Successfully posted on Facebook.";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void) performPublishAction:(void (^)(void)) action
{
    if (FBSession.activeSession.isOpen) {
        if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
            [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends completionHandler:^(FBSession *session, NSError *error) {
                if (!error) {
                    action();
                }
            }];
        } else {
            action();
        }
    } else {
        [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if (!error && status == FBSessionStateOpen) {
                action();
            }
        }];
    }

}

- (void) facebookPostFeed
{
    [self performPublishAction:^{
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        
        if (self.feedName != nil) {
            [params setObject:self.feedName forKey:@"name"];
        }
        if (self.feedCaption != nil) {
            [params setObject:self.feedCaption forKey:@"caption"];
        }
        if (self.feedDescription != nil) {
            [params setObject:self.feedDescription forKey:@"description"];
        }
        if (self.feedMessage != nil) {
            [params setObject:self.feedMessage forKey:@"message"];
        }
        if (self.feedPictureURL != nil) {
            [params setObject:self.feedPictureURL forKey:@"picture"];
        }
        if (self.feedLink != nil) {
            [params setObject:self.feedLink forKey:@"link"];
        }
        
        [FBRequestConnection startWithGraphPath:@"me/feed" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            [self facebookShowAlertWithError:error];
        }];
    }];
    
}

- (void) facebookPostPhoto
{
    [self performPublishAction:^{
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        
        if (self.shareMessage != nil) {
            [params setObject:self.shareMessage forKey:@"message"];
        }
        [params setObject:self.shareImage forKey:@"picture"];
        
        [FBRequestConnection startWithGraphPath:@"me/photos" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            [self facebookShowAlertWithError:error];
        }];
    }];

}

- (void)facebookPickFriends
{
    FBFriendPickerViewController *friendPickerController = [[FBFriendPickerViewController alloc] init];
    friendPickerController.title = @"Pick Friends";
    [friendPickerController loadData];
    
    // Use the modal wrapper method to display the picker.
    [friendPickerController presentModallyFromViewController:self.delegate animated:YES handler:^(FBViewController *sender, BOOL donePressed) {
        
        if (!donePressed) {
            return;
        }
        
        NSString *message;
        
        if (friendPickerController.selection.count == 0) {
            message = @"<No Friends Selected>";
        } else {
            NSMutableString *text = [[NSMutableString alloc] init];
            
            // we pick up the users from the selection, and create a string that we use to update the text view
            // at the bottom of the display; note that self.selection is a property inherited from our base class
            for (id<FBGraphUser> user in friendPickerController.selection) {
                if ([text length]) {
                    [text appendString:@", "];
                }
                [text appendString:user.name];
            }
            message = text;
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Picked:" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
     }];
}

- (void)facebookPickPlace
{
    FBPlacePickerViewController *placePickerController = [[FBPlacePickerViewController alloc] init];
    placePickerController.title = @"Pick a Seattle Place";
    placePickerController.locationCoordinate = CLLocationCoordinate2DMake(47.6097, -122.3331);
    [placePickerController loadData];
    
    // Use the modal wrapper method to display the picker.
    [placePickerController presentModallyFromViewController:self.delegate animated:YES handler:^(FBViewController *sender, BOOL donePressed) {
        
        if (!donePressed) {
            return;
        }
        
        NSString *placeName = placePickerController.selection.name;
        if (!placeName) {
            placeName = @"<No Place Selected>";
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Picked:" message:placeName delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}

@end
