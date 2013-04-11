#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@interface UIView (Screenshot)

- (UIImage *)screenshot;
- (UIImage *)invertedScreenshot;

@end
