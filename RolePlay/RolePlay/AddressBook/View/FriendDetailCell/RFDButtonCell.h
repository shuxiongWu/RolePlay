//
//  RFDButtonCell.h
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewCell.h"

@interface RFDButtonCell : RFDTableViewCell

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, assign) UIColor *buttonTitleColor;
@property (nonatomic, assign) UIColor *buttonBackgroundGColor;

- (void) addTarget:(id)target action:(SEL)action;
@end
