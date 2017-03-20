//
//  RFDFindCell.m
//  RolePlay
//
//  Created by Refordom on 17/3/17.
//  Copyright © 2017年 Refordom. All rights reserved.
//

#import "RFDFindCell.h"
@interface RFDFindCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UIImageView *subImageView;

@end
@implementation RFDFindCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _mainImageView = [[UIImageView alloc] init];
        [self addSubview:_mainImageView];
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    self.leftFreeSpace = self.frameWidth * 0.05;
    [super layoutSubviews];
    
    float spaceX = self.frameWidth * 0.05;
    float spaceY = self.frameHeight * 0.22;
    float imageWidth = self.frameHeight - spaceY * 2;
    [_mainImageView setFrame:CGRectMake(spaceX, spaceY, imageWidth, imageWidth)];
    
    float labelX = imageWidth + spaceX * 2;
    float labelWidth = self.frameWidth - labelX - spaceX * 1.5;
    [_titleLabel setFrame:CGRectMake(labelX, spaceY, labelWidth, imageWidth)];
}

- (void) setTitle:(NSString *)title
{
    [_titleLabel setText:title];
}

- (void) setImageName:(NSString *)imageName
{
    [_mainImageView setImage:[UIImage imageNamed:imageName]];
}


@end
