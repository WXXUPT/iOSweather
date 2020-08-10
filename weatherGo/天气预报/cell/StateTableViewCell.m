//
//  StateTableViewCell.m
//  天气预报
//
//  Created by 王旭 on 2020/8/6.
//  Copyright © 2020 王旭. All rights reserved.
//

#import "StateTableViewCell.h"

@implementation StateTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _stateLabel = [UILabel new];
    
    [self.contentView addSubview:_stateLabel];
    
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _stateLabel.frame = CGRectMake(15, 15, 370, 30);
    _stateLabel.font = [UIFont systemFontOfSize:20];
    _stateLabel.textColor = [UIColor whiteColor];
}
@end
