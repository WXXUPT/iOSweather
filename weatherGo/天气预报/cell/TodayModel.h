//
//  TodayModel.h
//  天气预报
//
//  Created by 王旭 on 2020/8/6.
//  Copyright © 2020 王旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayModel : NSObject
@property (nonatomic , copy) NSString* zhoujiStr;
@property (nonatomic , copy) NSString* xianzaiStr;
@property (nonatomic , copy) NSString* weaStr;
@property (nonatomic , copy) NSString* maxStr;
@property (nonatomic , copy) NSString* minStr;
@property (nonatomic , copy) NSString* richuStr;
@property (nonatomic , copy) NSString* riluoStr;
@property (nonatomic , copy) NSString* jiangshuiStr;
@property (nonatomic , copy) NSString* shiduStr;
@property (nonatomic , copy) NSString* fengStr;
@property (nonatomic , copy) NSString* tiganStr;
@property (nonatomic , copy) NSString* jiangshuiliangStr;
@property (nonatomic , copy) NSString* qiyaStr;
@property (nonatomic , copy) NSString* nengjianduStr;
@property (nonatomic , copy) NSString* ziwaixianStr;
@end

NS_ASSUME_NONNULL_END
