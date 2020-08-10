//
//  OtherDayTableViewCell.m
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import "OtherDayTableViewCell.h"

@implementation OtherDayTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _dayLabel = [UILabel new];
    _weatherImageView = [UIImageView new];
    _maxLabel = [UILabel new];
    _minLabel = [UILabel new];
    
    [self.contentView addSubview:_dayLabel];
    [self.contentView addSubview:_weatherImageView];
    [self.contentView addSubview:_maxLabel];
    [self.contentView addSubview:_minLabel];
    
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _dayLabel.frame = CGRectMake(15, 7, 100, 20);
    _dayLabel.font = [UIFont systemFontOfSize:20];
    _dayLabel.textColor = [UIColor whiteColor];
    
    _weatherImageView.frame = CGRectMake(170, 3, 30, 30);
    
    _maxLabel.frame = CGRectMake(300, 7, 50, 20);
    _maxLabel.font = [UIFont systemFontOfSize:19];
    _maxLabel.textColor = [UIColor whiteColor];
    
    _minLabel.frame = CGRectMake(360, 7, 50, 20);
    _minLabel.font = [UIFont systemFontOfSize:19];
    _minLabel.textColor = [UIColor whiteColor];
}
@end
