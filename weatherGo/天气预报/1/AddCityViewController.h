//
//  AddCityViewController.h
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchDelegate <NSObject>

- (void)CityName:(NSString *)cityName andLocationId:(NSString*)locationId;

@end
@interface AddCityViewController : UIViewController
<UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate , NSURLSessionDelegate>
@property (nonatomic , strong) UITableView* tableView;
@property (nonatomic , strong) UITextField* searchTextField;
@property (nonatomic , strong) NSMutableData* data;
@property (nonatomic , strong) NSMutableArray* cityArr;
@property (nonatomic , strong) NSMutableArray* IdArr;
@property id<SearchDelegate> SearchDelegate;
@end

NS_ASSUME_NONNULL_END
