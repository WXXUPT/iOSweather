//
//  HomeViewController.m
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//https://www.tianqiapi.com/api/?version=v9&city=北京&appid=79567236&appsecret=rx49NMQY

#import "HomeViewController.h"
#import "CityViewController.h"
#import "TodayTableViewCell.h"
#import "Today2TableViewCell.h"
#import "OtherDayTableViewCell.h"
#import "StateTableViewCell.h"
#import "7dayModel.h"
#import "HourlyModel.h"
#import "TodayModel.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isBegin = 1;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 414, 896)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*_cityNameArr.count, 896) ;
    [_scrollView setContentOffset:CGPointMake(_i * 414, 0)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    

    for (int i = 0; i<_cityNameArr.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(414*i, 0, 414, 896) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
            UIImageView* imageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 896)];
            imageVIew.image =[UIImage imageNamed:@"12345.jpg"];
            tableView.backgroundView = imageVIew;
        tableView.tag = i;
        tableView.backgroundView = imageVIew;
        [_scrollView addSubview:tableView];
    }
    [self scrollViewDidScroll:_scrollView];
    
    UIImage* more = [UIImage imageNamed:@"更多.png"];
    UIButton* addBtn = [[UIButton alloc] initWithFrame:CGRectMake(350, 820, 30, 30)];
    [addBtn setImage:more forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:addBtn];
    
    _pageControl.numberOfPages = _cityNameArr.count;
    _pageControl.currentPage =_i;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    _pageControl.frame = CGRectMake((self.view.frame.size.width/2-10*_pageControl.numberOfPages), 865, 12*_pageControl.numberOfPages, 10);

    [self.view addSubview:_pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isBegin != 0) {
        int temp;
        temp = _scrollView.contentOffset.x / 414;
        if (temp != _pageControl.currentPage) {
            _pageControl.currentPage = temp;
        }
    }
}
- (void) pressAdd
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 7;
    } else if (section == 4) {
        return 5;
    } else {
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_todayModelArr count] == 0) {
        return 0;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 400;
    } else if (indexPath.section == 1) {
        return 120;
    } else if (indexPath.section == 2) {
        return 30;
    } else if (indexPath.section == 3) {
        return 45;
    } else if (indexPath.section == 4) {
        return 100;
    }
    return 1;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(int i =0;i<_cityNameArr.count;i++) {
        if(tableView.tag == i){
    if (indexPath.section == 0) {
        TodayTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"today"];
        if (!cell) {
            cell = [[TodayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"today"];
        }
        TodayModel *tmodel = [[TodayModel alloc] init];
        tmodel = _todayModelArr[i];
        cell.cityNameLabel.text = _cityNameArr[i];
        cell.day1Label.text = tmodel.zhoujiStr;
        cell.day2Label.text = @"今天";
        cell.maxLabel.text = tmodel.maxStr;
        cell.minLabel.text = tmodel.minStr;
        cell.weatherLabel.text = tmodel.weaStr;
        cell.tempLabel.text = tmodel.xianzaiStr;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        HourlyModel* houlyModel = [HourlyModel new];
        houlyModel = _hourlyModelArr[i];
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"hourly"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hourly"];
        }
        NSMutableArray* timeArr = [[NSMutableArray alloc] initWithObjects:houlyModel.time1Str1,houlyModel.time1Str2,houlyModel.time1Str3,houlyModel.time1Str4,houlyModel.time1Str5,houlyModel.time1Str1,houlyModel.time1Str6,houlyModel.time1Str7,houlyModel.time1Str8,houlyModel.time1Str9,houlyModel.time1Str10, nil];
        
        NSMutableArray* pictArr = [[NSMutableArray alloc] initWithObjects:houlyModel.weatherStr1,houlyModel.weatherStr2,houlyModel.weatherStr3,houlyModel.weatherStr4,houlyModel.weatherStr5,houlyModel.weatherStr6,houlyModel.weatherStr7,houlyModel.weatherStr8,houlyModel.weatherStr9,houlyModel.weatherStr10, nil];
        
        NSMutableArray* temperArr = [[NSMutableArray alloc] initWithObjects:houlyModel.time2Str1,houlyModel.time2Str2,houlyModel.time2Str3,houlyModel.time2Str4,houlyModel.time2Str5,houlyModel.time2Str6,houlyModel.time2Str7,houlyModel.time2Str8,houlyModel.time2Str9,houlyModel.time2Str10, nil];
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 414, 120)];
        scrollView.contentSize = CGSizeMake(810, 0);
        for (int temp = 0; temp < 10; temp++) {
            UILabel* timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+temp*80, 10, 60, 20)];
            NSString* timeStr = timeArr[temp];
            timeLabel.text = timeStr;
            timeLabel.textColor = [UIColor whiteColor];
            timeLabel.font = [UIFont systemFontOfSize:19];
            [scrollView addSubview:timeLabel];
            
            UIImageView* pictImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+temp*80, 40, 40, 40)];
            NSString* pictStr = pictArr[temp];
            pictImageView.image = [UIImage imageNamed:pictStr];
            [scrollView addSubview:pictImageView];
            
            UILabel* temperLabel = [[UILabel alloc] initWithFrame:CGRectMake(12+temp*80, 90, 60, 20)];
            NSString* temperStr = temperArr[temp];
            temperLabel.text = temperStr;
            temperLabel.textColor = [UIColor whiteColor];
            temperLabel.font = [UIFont systemFontOfSize:19];
            [scrollView addSubview:temperLabel];
        }
        [cell.contentView addSubview:scrollView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else if (indexPath.section == 2) {
        OtherDayTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"otherDay"];
        if (!cell) {
            cell = [[OtherDayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"otherDay"];
        }
        _dayModel* dModel = [_dayModel new];
        dModel = _dayModelArr[i];
        if (indexPath.row   == 0) {
            cell.dayLabel.text = dModel.dayStr1;
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", dModel.weatherStr1]];
            cell.maxLabel.text = dModel.maxStr1;
            cell.minLabel.text = dModel.minStr1;
        } else if (indexPath.row == 1) {
            cell.dayLabel.text = dModel.dayStr2;
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", dModel.weatherStr2]];
            cell.maxLabel.text = dModel.maxStr2;
            cell.minLabel.text = dModel.minStr2;
        } else if (indexPath.row == 2) {
            cell.dayLabel.text = dModel.dayStr3;
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", dModel.weatherStr3]];
            cell.maxLabel.text = dModel.maxStr3;
            cell.minLabel.text = dModel.minStr3;
        } else if (indexPath.row == 3) {
            cell.dayLabel.text = dModel.dayStr4;
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", dModel.weatherStr4]];
            cell.maxLabel.text = dModel.maxStr4;
            cell.minLabel.text = dModel.minStr4;
        } else if (indexPath.row == 4) {
            cell.dayLabel.text = dModel.dayStr5;
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", dModel.weatherStr5]];
            cell.maxLabel.text = dModel.maxStr5;
            cell.minLabel.text = dModel.minStr5;
        } else if (indexPath.row == 5) {
            cell.dayLabel.text = dModel.dayStr6;
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", dModel.weatherStr6]];
            cell.maxLabel.text = dModel.maxStr6;
            cell.minLabel.text = dModel.minStr6;
        } else if (indexPath.row == 6) {
            cell.dayLabel.text = dModel.dayStr7;
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", dModel.weatherStr7]];
            cell.maxLabel.text = dModel.maxStr7;
            cell.minLabel.text = dModel.minStr7;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else if (indexPath.section == 3) {
        StateTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"state"];
        if (!cell) {
            cell = [[StateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"state"];
        }
        TodayModel* tmodel = [TodayModel new];
        tmodel = _todayModelArr[i];
        cell.stateLabel.text = [NSString stringWithFormat:@"今天:今日%@天.当前气温%@;最高温度%@",tmodel.weaStr, tmodel.xianzaiStr, tmodel.maxStr];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 4) {
        Today2TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"today"];
        if (!cell) {
            cell = [[Today2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"today"];
        }
        TodayModel* tmodel = [TodayModel new];
        tmodel = _todayModelArr[i];
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"日出";
            cell.leftLabel.textColor = [UIColor grayColor];
            cell.rightLabel.text = @"日落";
            cell.rightLabel.textColor = [UIColor grayColor];
            cell.leftAnswerLabel.text = tmodel.richuStr;
            cell.rightAnswerLabel.text = tmodel.riluoStr;
        } else if (indexPath.row == 1) {
            cell.leftLabel.text = @"降水概率";
            cell.leftLabel.textColor = [UIColor grayColor];
            cell.rightLabel.text = @"湿度";
            cell.rightLabel.textColor = [UIColor grayColor];
            cell.leftAnswerLabel.text = tmodel.jiangshuiStr;
            cell.rightAnswerLabel.text = tmodel.shiduStr;
        } else if (indexPath.row == 2) {
            cell.leftLabel.text = @"风";
            cell.leftLabel.textColor = [UIColor grayColor];
            cell.rightLabel.text = @"体感温度";
            cell.rightLabel.textColor = [UIColor grayColor];
            cell.leftAnswerLabel.text = tmodel.fengStr;
            cell.rightAnswerLabel.text = tmodel.tiganStr;
        } else if (indexPath.row == 3) {
            cell.leftLabel.text = @"降水量";
            cell.leftLabel.textColor = [UIColor grayColor];
            cell.rightLabel.text = @"气压";
            cell.rightLabel.textColor = [UIColor grayColor];
            cell.leftAnswerLabel.text = tmodel.jiangshuiliangStr;
            cell.rightAnswerLabel.text = tmodel.qiyaStr;
        } else if (indexPath.row == 4) {
            cell.leftLabel.text = @"能见度";
            cell.leftLabel.textColor = [UIColor grayColor];
            cell.rightLabel.text = @"紫外线";
            cell.rightLabel.textColor = [UIColor grayColor];
            cell.leftAnswerLabel.text = tmodel.nengjianduStr;
            cell.rightAnswerLabel.text = tmodel.ziwaixianStr;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
        }
    }
    return nil;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
