//
//  HomeViewController.h
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CityViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
<UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>
@property (nonatomic , strong) UIPageControl* pageControl;
//@property (nonatomic , strong) UITableView* tableView;
@property (nonatomic , strong) UIScrollView* scrollView;
@property (nonatomic , strong) NSMutableArray* cityNameArr;
@property (nonatomic , strong) NSMutableArray* locationIdArr;
@property (nonatomic , strong) NSMutableArray* dayModelArr;
@property (nonatomic , strong) NSMutableArray* todayModelArr;
@property (nonatomic , strong) NSMutableArray* hourlyModelArr;
@property int i;
@property NSInteger *number;
@property int isBegin;
@end

NS_ASSUME_NONNULL_END
