//
//  UIView+RFDExtension.h
//  RolePlay
//
//  Created by Refordom on 17/3/20.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RFDExtension)
/** X */
@property (nonatomic, assign) CGFloat x;

/** Y */
@property (nonatomic, assign) CGFloat y;

/** Width */
@property (nonatomic, assign) CGFloat width;

/** Height */
@property (nonatomic, assign) CGFloat height;

/** size */
@property (nonatomic, assign) CGSize size;

/** centerX */
@property (nonatomic, assign) CGFloat centerX;

/** centerY */
@property (nonatomic, assign) CGFloat centerY;

/** tag */
@property (nonatomic, copy) NSString *tagStr;

- (BOOL)isShowingOnKeyWindow;
@end

