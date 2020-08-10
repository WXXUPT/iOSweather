//
//  TodayTableViewCell.h
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel* day1Label;
@property (nonatomic , strong) UILabel* day2Label;
@property (nonatomic , strong) UILabel* maxLabel;
@property (nonatomic , strong) UILabel* minLabel;
@property (nonatomic , strong) UILabel* cityNameLabel;
@property (nonatomic , strong) UILabel* weatherLabel;
@property (nonatomic , strong) UILabel* tempLabel;

@end

NS_ASSUME_NONNULL_END
