//
//  Today2TableViewCell.m
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import "Today2TableViewCell.h"

@implementation Today2TableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _leftLabel = [UILabel new];
    _rightLabel = [UILabel new];
    _leftAnswerLabel = [UILabel new];
    _rightAnswerLabel = [UILabel new];
    
    [self.contentView addSubview:_leftAnswerLabel];
    [self.contentView addSubview:_rightAnswerLabel];
    [self.contentView addSubview:_leftLabel];
    [self.contentView addSubview:_rightLabel];
    
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _leftLabel.frame = CGRectMake(15, 10, 60, 13);
    _leftLabel.font = [UIFont systemFontOfSize:13];
    
    _rightLabel.frame = CGRectMake(215, 10, 60, 13);
    _rightLabel.font = [UIFont systemFontOfSize:13];
    
    _leftAnswerLabel.frame = CGRectMake(15, 30, 180, 50);
    _leftAnswerLabel.font = [UIFont systemFontOfSize:32];
    _leftAnswerLabel.textColor = [UIColor whiteColor];
    
    _rightAnswerLabel.frame = CGRectMake(215, 30, 170, 50);
    _rightAnswerLabel.font = [UIFont systemFontOfSize:32];
    _rightAnswerLabel.textColor = [UIColor whiteColor];
}
@end
