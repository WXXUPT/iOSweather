//
//  CityViewController.h
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityViewController.h"
NS_ASSUME_NONNULL_BEGIN
//@protocol CityViewDelegate <NSObject>
//
//- (void)CityName:(NSMutableArray *)cityName andLocationId:(NSMutableArray *)locationId;
//
//@end
@interface CityViewController : UIViewController
<UITableViewDelegate , UITableViewDataSource , NSURLSessionDelegate , SearchDelegate>
@property UITableView* tableView;
@property (nonatomic , strong) NSMutableArray* cityNameArr;
@property (nonatomic , strong) NSMutableArray* locationIdArr;
@property (nonatomic , strong) NSMutableData* data;
@property (nonatomic , strong) NSMutableArray* temperArr;
@property (nonatomic , strong) NSMutableArray* dayModelArr;
@property (nonatomic , strong) NSMutableArray* todayModelArr;
@property (nonatomic , strong) NSMutableArray* hourlyModelArr;
@property int i;
//@property id <CityViewDelegate> CityViewDelegate;
@end

NS_ASSUME_NONNULL_END
