//
//  CityViewController.m
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import "CityViewController.h"
#import "AddCityViewController.h"
#import "CityTableViewCell.h"
#import "HomeViewController.h"
#import "TodayModel.h"
#import "HourlyModel.h"
#import "7dayModel.h"
@interface CityViewController ()

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cityNameArr = [NSMutableArray new];
    _locationIdArr = [NSMutableArray new];
    UIImage* backGround = [UIImage imageNamed:@"123456.jpg"];
    self.view.layer.contents = (id) backGround.CGImage;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 896) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UILabel* CFlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 820, 100, 30)];
    CFlabel.font = [UIFont systemFontOfSize:20];
    CFlabel.text = @"°C/°F";
    CFlabel.textColor = [UIColor whiteColor];
    
    UIImage* add = [UIImage imageNamed:@"更多1.png"];
    UIButton* addBtn = [[UIButton alloc] initWithFrame:CGRectMake(350, 820, 30, 30)];
    [addBtn setImage:add forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:CFlabel];
    [self.view addSubview:addBtn];
    
    [_tableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"city"];
    
    _temperArr = [NSMutableArray new];
    _hourlyModelArr = [NSMutableArray new];
    _todayModelArr = [NSMutableArray new];
    _dayModelArr = [NSMutableArray new];
}
- (void) pressAdd
{
    AddCityViewController* addCity = [AddCityViewController new];
    addCity.SearchDelegate = self;
    addCity.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:addCity animated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _temperArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"city"];
    if (!cell) {
        cell = [[CityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"city"];
    }
    cell.timeLabel.text = @"上午8,45";
    cell.cityLabel.text = _cityNameArr[indexPath.row];
    
    cell.tempLabel.text = _temperArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
- (void)CityName:(NSString *)cityName andLocationId:(NSString*)locationId
{
    _i = _i + 1;
    [_cityNameArr addObject:cityName];
    [_locationIdArr addObject:locationId];
    
    [self lodaTestData];
    [self lodaTestData7day];
    [self lodaTestDataToday];
    [self lodaTestDataHourly];
//    [self.tableView reloadData];
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    if(self.data == nil){
        self.data = [[NSMutableData alloc] init];
    } else {
        self.data.length = 0;
    }
    completionHandler(NSURLSessionResponseAllow);
}
- (void) URLSession:(NSURLSession *)session dataTask:( NSURLSessionDataTask *)dataTask didReceiveData:( NSData *)data
{
    [self.data appendData:data];
}
-(void)lodaTestData
{
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
            NSString *str = [NSString stringWithFormat:@"https://devapi.heweather.net/v7/weather/now?location=%@&key=2ae12002062e4bcf983d79c7149d118f",_locationIdArr[_i-1]];
             str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:str];
            //封装一个请求类
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error == nil)        {
                    NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        if(objc){
                            NSString * str = objc[@"now"][@"temp"];
                            if(str)
                               [_temperArr addObject:str];
                            }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_tableView reloadData];
                    });
                }
            }];
            [dataTask resume];
    });
}
-(void)lodaTestData7day
{
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
        NSString *str = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v1&appid=54931136&appsecret=ow4IrSuN&cityid=%@",_locationIdArr[_cityNameArr.count-1]];
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:str];
        //封装一个请求类
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)        {
            NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if(objc){
                    _dayModel* dayModel = [_dayModel new];
                    dayModel.dayStr1 = objc[@"data"][0][@"week"];
                    dayModel.dayStr2 = objc[@"data"][1][@"week"];
                    dayModel.dayStr3 = objc[@"data"][2][@"week"];
                    dayModel.dayStr4 = objc[@"data"][3][@"week"];
                    dayModel.dayStr5 = objc[@"data"][4][@"week"];
                    dayModel.dayStr6 = objc[@"data"][5][@"week"];
                    dayModel.dayStr7 = objc[@"data"][6][@"week"];
                    dayModel.maxStr1 = objc[@"data"][0][@"tem1"];
                    dayModel.maxStr2 = objc[@"data"][1][@"tem1"];
                    dayModel.maxStr3 = objc[@"data"][2][@"tem1"];
                    dayModel.maxStr4 = objc[@"data"][3][@"tem1"];
                    dayModel.maxStr5 = objc[@"data"][4][@"tem1"];
                    dayModel.maxStr6 = objc[@"data"][5][@"tem1"];
                    dayModel.maxStr7 = objc[@"data"][6][@"tem1"];
                    dayModel.minStr1 = objc[@"data"][0][@"tem2"];
                    dayModel.minStr2 = objc[@"data"][1][@"tem2"];
                    dayModel.minStr3 = objc[@"data"][2][@"tem2"];
                    dayModel.minStr4 = objc[@"data"][3][@"tem2"];
                    dayModel.minStr5 = objc[@"data"][4][@"tem2"];
                    dayModel.minStr6 = objc[@"data"][5][@"tem2"];
                    dayModel.minStr7 = objc[@"data"][6][@"tem2"];
                    dayModel.weatherStr1 = objc[@"data"][0][@"wea_img"];
                    dayModel.weatherStr2 = objc[@"data"][1][@"wea_img"];
                    dayModel.weatherStr3 = objc[@"data"][2][@"wea_img"];
                    dayModel.weatherStr4 = objc[@"data"][3][@"wea_img"];
                    dayModel.weatherStr5 = objc[@"data"][4][@"wea_img"];
                    dayModel.weatherStr6 = objc[@"data"][5][@"wea_img"];
                    dayModel.weatherStr7 = objc[@"data"][6][@"wea_img"];
                    [_dayModelArr addObject:dayModel];
                    }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
        [dataTask resume];
        });
//    }
}
-(void)lodaTestDataHourly
{
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
        NSString *str = [NSString stringWithFormat:@"https://www.tianqiapi.com/api/?version=v9&cityid=%@&appid=54931136&appsecret=ow4IrSuN",_locationIdArr[_cityNameArr.count-1]];
             str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:str];
            //封装一个请求类
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error == nil)        {
                    NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        if(objc) {
                            HourlyModel* hourlyModel = [HourlyModel new];
                            hourlyModel.time1Str1 = objc[@"data"][0][@"hours"][0][@"hours"];
                            hourlyModel.time1Str2 = objc[@"data"][0][@"hours"][1][@"hours"];
                            hourlyModel.time1Str3 = objc[@"data"][0][@"hours"][2][@"hours"];
                            hourlyModel.time1Str4 = objc[@"data"][0][@"hours"][3][@"hours"];
                            hourlyModel.time1Str5 = objc[@"data"][0][@"hours"][4][@"hours"];
                            hourlyModel.time1Str6 = objc[@"data"][0][@"hours"][5][@"hours"];
                            hourlyModel.time1Str7 = objc[@"data"][0][@"hours"][6][@"hours"];
                            hourlyModel.time1Str8 = objc[@"data"][0][@"hours"][7][@"hours"];
                            hourlyModel.time1Str9 = objc[@"data"][0][@"hours"][8][@"hours"];
                            hourlyModel.time1Str10 = objc[@"data"][0][@"hours"][9][@"hours"];
//                            hourlyModel.time1Str11 = objc[@"data"][0][@"hours"][10][@"hours"];
//                            hourlyModel.time1Str12 = objc[@"data"][0][@"hours"][11][@"hours"];
//                            hourlyModel.time1Str13 = objc[@"data"][0][@"hours"][12][@"hours"];
//                            hourlyModel.time1Str14 = objc[@"data"][0][@"hours"][13][@"hours"];
//                            hourlyModel.time1Str15 = objc[@"data"][0][@"hours"][14][@"hours"];
//                            hourlyModel.time1Str16 = objc[@"data"][0][@"hours"][15][@"hours"];
//                            hourlyModel.time1Str17 = objc[@"data"][0][@"hours"][16][@"hours"];
//                            hourlyModel.time1Str18 = objc[@"data"][0][@"hours"][17][@"hours"];
                            hourlyModel.time2Str1 = objc[@"data"][0][@"hours"][0][@"tem"];
                            hourlyModel.time2Str2 = objc[@"data"][0][@"hours"][1][@"tem"];
                            hourlyModel.time2Str3 = objc[@"data"][0][@"hours"][2][@"tem"];
                            hourlyModel.time2Str4 = objc[@"data"][0][@"hours"][3][@"tem"];
                            hourlyModel.time2Str5 = objc[@"data"][0][@"hours"][4][@"tem"];
                            hourlyModel.time2Str6 = objc[@"data"][0][@"hours"][5][@"tem"];
                            hourlyModel.time2Str7 = objc[@"data"][0][@"hours"][6][@"tem"];
                            hourlyModel.time2Str8 = objc[@"data"][0][@"hours"][7][@"tem"];
                            hourlyModel.time2Str9 = objc[@"data"][0][@"hours"][8][@"tem"];
                            hourlyModel.time2Str10 = objc[@"data"][0][@"hours"][9][@"tem"];
//                            hourlyModel.time2Str11 = objc[@"data"][0][@"hours"][10][@"tem"];
//                            hourlyModel.time2Str12 = objc[@"data"][0][@"hours"][11][@"tem"];
//                            hourlyModel.time2Str13 = objc[@"data"][0][@"hours"][12][@"tem"];
//                            hourlyModel.time2Str14 = objc[@"data"][0][@"hours"][13][@"tem"];
//                            hourlyModel.time2Str15 = objc[@"data"][0][@"hours"][14][@"tem"];
//                            hourlyModel.time2Str16 = objc[@"data"][0][@"hours"][15][@"tem"];
//                            hourlyModel.time2Str17 = objc[@"data"][0][@"hours"][16][@"tem"];
//                            hourlyModel.time2Str18 = objc[@"data"][0][@"hours"][17][@"tem"];
                            hourlyModel.weatherStr1 = objc[@"data"][0][@"hours"][0][@"wea_img"];
                            hourlyModel.weatherStr2 = objc[@"data"][0][@"hours"][1][@"wea_img"];
                            hourlyModel.weatherStr3 = objc[@"data"][0][@"hours"][2][@"wea_img"];
                            hourlyModel.weatherStr4 = objc[@"data"][0][@"hours"][3][@"wea_img"];
                            hourlyModel.weatherStr5 = objc[@"data"][0][@"hours"][4][@"wea_img"];
                            hourlyModel.weatherStr6 = objc[@"data"][0][@"hours"][5][@"wea_img"];
                            hourlyModel.weatherStr7 = objc[@"data"][0][@"hours"][6][@"wea_img"];
                            hourlyModel.weatherStr8 = objc[@"data"][0][@"hours"][7][@"wea_img"];
                            hourlyModel.weatherStr9 = objc[@"data"][0][@"hours"][8][@"wea_img"];
                            hourlyModel.weatherStr10 = objc[@"data"][0][@"hours"][9][@"wea_img"];
//                            hourlyModel.weatherStr11 = objc[@"data"][0][@"hours"][10][@"wea_img"];
//                            hourlyModel.weatherStr12 = objc[@"data"][0][@"hours"][11][@"wea_img"];
//                            hourlyModel.weatherStr13 = objc[@"data"][0][@"hours"][12][@"wea_img"];
//                            hourlyModel.weatherStr14 = objc[@"data"][0][@"hours"][13][@"wea_img"];
//                            hourlyModel.weatherStr15 = objc[@"data"][0][@"hours"][14][@"wea_img"];
//                            hourlyModel.weatherStr16 = objc[@"data"][0][@"hours"][15][@"wea_img"];
//                            hourlyModel.weatherStr17 = objc[@"data"][0][@"hours"][16][@"wea_img"];
//                            hourlyModel.weatherStr18 = objc[@"data"][0][@"hours"][17][@"wea_img"];
                            [_hourlyModelArr addObject:hourlyModel];
                            }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }
            }];
            [dataTask resume];
    });
    
}
-(void)lodaTestDataToday
{
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
        NSString *str = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v6&appid=54931136&appsecret=ow4IrSuN&cityid=%@",_locationIdArr[_cityNameArr.count-1]];
        NSLog(@"%@",str);
             str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:str];
            //封装一个请求类
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error == nil)        {
                    NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        if(objc){
                            TodayModel* todayModel = [TodayModel new];
                            todayModel.zhoujiStr = objc[@"week"];
                            todayModel.maxStr = objc[@"tem1"];
                            todayModel.minStr = objc[@"tem2"];
                            todayModel.xianzaiStr = objc[@"tem"];
                            todayModel.jiangshuiStr = objc[@"humidity"];
                            todayModel.shiduStr = objc[@"humidity"];
                            todayModel.fengStr = objc[@"win_meter"];
                            todayModel.nengjianduStr = objc[@"visibility"];
                            todayModel.tiganStr = objc[@"tem"];
                            todayModel.jiangshuiliangStr = @"0";
                            todayModel.qiyaStr = objc[@"pressure"];
                            todayModel.ziwaixianStr = @"3";
                            todayModel.richuStr = @"上午5:41";
                            todayModel.riluoStr = @"下午8:32";
                            todayModel.weaStr = objc[@"wea"];
                            [_todayModelArr addObject:todayModel];
                      
                            }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }
            }];
            [dataTask resume];
    });
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeViewController* home = [HomeViewController new];
    
    home.cityNameArr = _cityNameArr;
    home.locationIdArr = _locationIdArr;
    home.modalPresentationStyle = UIModalPresentationFullScreen;
    
    home.hourlyModelArr = _hourlyModelArr;
    home.dayModelArr = _dayModelArr;
    home.todayModelArr = _todayModelArr;
    
    home.pageControl = [[UIPageControl alloc]init];

    home.i = indexPath.row;

    [self presentViewController:home animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//https://devapi.heweather.net/v7/weather/now?location=%@&key=2ae12002062e4bcf983d79c7149d118f

@end
