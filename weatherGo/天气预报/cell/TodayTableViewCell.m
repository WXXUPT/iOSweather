//
//  TodayTableViewCell.m
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import "TodayTableViewCell.h"

@implementation TodayTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    _day1Label = [UILabel new];
    _day2Label = [UILabel new];
    _maxLabel = [UILabel new];
    _minLabel = [UILabel new];
    _cityNameLabel = [UILabel new];
    _weatherLabel = [UILabel new];
    _tempLabel = [UILabel new];
    
    [self.contentView addSubview:_day1Label];
    [self.contentView addSubview:_day2Label];
    [self.contentView addSubview:_maxLabel];
    [self.contentView addSubview:_minLabel];
    [self.contentView addSubview:_cityNameLabel];
    [self.contentView addSubview:_weatherLabel];
    [self.contentView addSubview:_tempLabel];
    
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _day1Label.frame = CGRectMake(15, 370, 100, 20);
    _day1Label.font = [UIFont systemFontOfSize:21];
    _day1Label.textColor = [UIColor whiteColor];
    
    _day2Label.frame = CGRectMake(100, 370, 40, 20);
    _day2Label.font = [UIFont systemFontOfSize:17];
    _day2Label.text = @"今天";
    _day2Label.textColor = [UIColor whiteColor];
    
    _maxLabel.frame = CGRectMake(300, 370, 30, 20);
    _maxLabel.font = [UIFont systemFontOfSize:19];
    _maxLabel.textColor = [UIColor whiteColor];
    
    _minLabel.frame = CGRectMake(360, 370, 30, 20);
    _minLabel.font = [UIFont systemFontOfSize:20];
    _minLabel.textColor = [UIColor whiteColor];
    
    _cityNameLabel.frame = CGRectMake(107, 135, 200, 40);
    _cityNameLabel.font = [UIFont systemFontOfSize:35];
    _cityNameLabel.textAlignment = NSTextAlignmentCenter;
    _cityNameLabel.textColor = [UIColor whiteColor];
    
    _weatherLabel.frame = CGRectMake(107, 180, 200, 25);
    _weatherLabel.font = [UIFont systemFontOfSize:20];
    _weatherLabel.textAlignment = NSTextAlignmentCenter;
    _weatherLabel.textColor = [UIColor whiteColor];
    
    _tempLabel.frame = CGRectMake(107, 200, 200, 60);
    _tempLabel.font = [UIFont systemFontOfSize:50];
    _tempLabel.textAlignment = NSTextAlignmentCenter;
    _tempLabel.textColor = [UIColor whiteColor];
}
@end
