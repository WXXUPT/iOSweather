//
//  CityTableViewCell.h
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel* timeLabel;
@property (nonatomic , strong) UILabel* cityLabel;
@property (nonatomic , strong) UILabel* tempLabel;
@end

NS_ASSUME_NONNULL_END
