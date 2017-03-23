//
//  UIView+RFDAlertView.h
//  RolePlay
//
//  Created by Refordom on 17/3/23.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RFDAlertView)
+ (void) addRFDNotifierWithText : (NSString* ) text dismissAutomatically : (BOOL) shouldDismiss;
+ (void) dismissRFDNotifier;
@end
