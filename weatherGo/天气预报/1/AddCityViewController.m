//
//  AddCityViewController.m
//  天气预报
//
//  Created by 王旭 on 2020/8/4.
//  Copyright © 2020 王旭. All rights reserved.
//

#import "AddCityViewController.h"

@interface AddCityViewController ()

@end

@implementation AddCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIImage* backGround = [UIImage imageNamed:@"背景1.jpg"];
    self.view.layer.contents = (id) backGround.CGImage;
    self.view.backgroundColor = [UIColor clearColor];
    
    _searchTextField = [[UITextField alloc] init];
    _searchTextField.delegate = self;
    _searchTextField.frame = CGRectMake(25, 80, 310, 40);
    [self.view addSubview:_searchTextField];
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextField.keyboardType = UIKeyboardTypeDefault;
    _searchTextField.placeholder = @"搜索";
    
    UIImageView* fadajing = [UIImageView new];
    fadajing.image = [UIImage imageNamed:@"放大镜1"];
    fadajing.frame = CGRectMake(10, 10, 30, 30);

    _searchTextField.leftView = fadajing;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.layer.cornerRadius = 10.0;
    
    UILabel* label = [UILabel new];
    label.text = @"输入城市、邮政编码或机场位置";
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectMake(100, 50, 200, 15);
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UIButton* cancel = [[UIButton alloc] initWithFrame:CGRectMake(340, 85, 70, 30)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchDown];
    cancel.tintColor = [UIColor whiteColor];
    [self.view addSubview:cancel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(25, 150, 310, 500) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] init];
    _tableView.tableFooterView = view;

}
-(void)lodaTestData
{
    
    
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
            //NSString * str1 = _searchTextField.text;
//            NSLog(@"%@", Citystr);
            
        NSString *str = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=2ae12002062e4bcf983d79c7149d118f",_searchTextField.text];

             str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:str];
           
            //封装一个请求类
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error == nil)        {
                    NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    _cityArr = [[NSMutableArray alloc] init];
                    _IdArr = [[NSMutableArray alloc] init];
                    NSArray * arry = [NSArray array];
                    arry = objc[@"location"];
                    for (int i = 0; i < arry.count; i++) {
                        if(objc){
                            NSString * str = objc[@"location"][i][@"name"];
                            NSString* str2 = objc[@"location"][i][@"id"];
                            NSLog(@"%@---%@",str,str2);
                            
                            if(str)
                                [_cityArr addObject:str];
                                [_IdArr addObject:str2];
                            }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_tableView reloadData];
                    });
                }
            }];
            [dataTask resume];
            
    });
    
   
}

-(void)lodaTestData :(NSString *) Citystr
{
    
    
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
            
            NSString *str = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=2ae12002062e4bcf983d79c7149d118f",Citystr ];

             str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:str];
           
            //封装一个请求类
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(error == nil)        {
                    NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    _cityArr = [[NSMutableArray alloc] init];
                    _IdArr = [[NSMutableArray alloc] init];
                    NSArray * arry = [NSArray array];
                    arry = objc[@"location"];
                    for (int i = 0; i < arry.count; i++) {
                        if(objc){
                            NSString * str = objc[@"location"][i][@"name"];
                            NSString* str2 = objc[@"location"][i][@"id"];
                            NSLog(@"%@---%@",str,str2);
                            
                            if(str)
                                [_cityArr addObject:str];
                                [_IdArr addObject:str2];
                            }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_tableView reloadData];
                    });
                }
            }];
            [dataTask resume];
            
    });
    
   
}


- (void) pressCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(string!=nil&&_searchTextField.text!=NULL)
    {
        NSString * str = [_searchTextField.text stringByAppendingString:string];
       //[self lodaTestData:str];
        [self performSelector:@selector(lodaTestData) withObject:nil afterDelay:0.1];
         NSLog(@"%@",str);
    }
    _cityArr = [[NSMutableArray alloc] init];
    return YES;
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


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self lodaTestData:_searchTextField.text];
    return YES;
}
- (void) URLSession:(NSURLSession *)session dataTask:( NSURLSessionDataTask *)dataTask didReceiveData:( NSData *)data
{
    [self.data appendData:data];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
    }
    if(indexPath.row < _cityArr.count)
    cell.textLabel.text = _cityArr[indexPath.row];

    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cityArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchTextField endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _searchTextField.text = _cityArr[indexPath.row];
    [_SearchDelegate CityName:_searchTextField.text andLocationId:_IdArr[indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//https://geoapi.heweather.net/v2/city/lookup?location=%@&key=2ae12002062e4bcf983d79c7149d118f
@end
