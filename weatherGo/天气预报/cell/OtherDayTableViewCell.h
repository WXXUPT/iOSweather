//
//  OtherDayTableViewCell.h
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OtherDayTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel* dayLabel;
@property (nonatomic , strong) UIImageView* weatherImageView;
@property (nonatomic , strong) UILabel* maxLabel;
@property (nonatomic , strong) UILabel* minLabel;
@end

NS_ASSUME_NONNULL_END
