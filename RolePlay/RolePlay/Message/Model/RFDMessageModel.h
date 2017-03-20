//
//  RFDMessageModel.h
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFDMessageModel : NSObject

@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) int messageCount;
@property (nonatomic, strong) NSURL *avatarURL;

@end
