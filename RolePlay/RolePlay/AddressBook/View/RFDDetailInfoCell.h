//
//  RFDDetailInfoCell.h
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDTableViewCell.h"
typedef NS_ENUM(NSInteger, TLDetailInfoCellType) {
    TLDetailInfoCellLeft,
    TLDetailInfoCellRight,
};

@interface RFDDetailInfoCell : RFDTableViewCell

@property (nonatomic, assign) TLDetailInfoCellType cellType;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *beforeSubImage;
@property (nonatomic, strong) NSString *afterSubImage;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) NSArray *imagesArray;


@end
