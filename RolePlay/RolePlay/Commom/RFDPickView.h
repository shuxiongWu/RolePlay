//
//  RFDPickView.h
//  RolePlay
//
//  Created by Refordom on 17/3/30.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFDPickView : UIView
@property (nonatomic, copy) void(^selectCateSuccessCallBack)(NSString *);
@end
