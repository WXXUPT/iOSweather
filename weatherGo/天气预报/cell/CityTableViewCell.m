//
//  CityTableViewCell.m
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _timeLabel = [UILabel new];
    _cityLabel = [UILabel new];
    _tempLabel = [UILabel new];
    
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_cityLabel];
    [self.contentView addSubview:_tempLabel];
    
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _timeLabel.frame = CGRectMake(20, 14, 100, 15);
    _timeLabel.font = [UIFont systemFontOfSize:14];
    
    _cityLabel.frame = CGRectMake(17, 40, 100, 40);
    _cityLabel.font = [UIFont systemFontOfSize:30];
    
    _tempLabel.frame = CGRectMake(320, 16, 70, 70);
    _tempLabel.font = [UIFont systemFontOfSize:55];
}
@end
