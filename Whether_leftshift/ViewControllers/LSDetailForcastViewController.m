//
//  LSDetailForcastViewController.m
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import "LSDetailForcastViewController.h"
#import "LSAPIDownloader.h"
#import "LSFileManager.h"

#define kWeatherCityAPI @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=14&units=metric&APPID=ce72dd0c04db65348c6de8271b277152&q="
#define kWeatherLocationAPI @"http://api.openweathermap.org/data/2.5/forecast/daily?cnt=14&mode=json&units=metric&APPID=ce72dd0c04db65348c6de8271b277152"

@interface LSDetailForcastViewController ()

@end

@implementation LSDetailForcastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    forecastArray = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)viewDidLoad
{
  
  [super viewDidLoad];
  
  NSString *urlString;
  
  if ([self.cityName length] > 0) {
    urlString=[NSString stringWithFormat:@"%@%@",kWeatherCityAPI , self.cityName];
  }
  else if ([self.latitude length] > 0 && [self.longitude length] > 0) {
    urlString=[NSString stringWithFormat:@"%@&lat=%@&lon=%@",kWeatherLocationAPI, self.latitude, self.longitude];
  }
  else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Something went wrong.. Please go back and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    return;
  }
  
  BOOL isMetric = [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
  if (!isMetric) {
    urlString = [urlString stringByReplacingOccurrencesOfString:@"metric" withString:@"imperial"];
  }
  
  spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  [spinner setCenter:self.view.center];
  [self.view addSubview:spinner];
  [spinner startAnimating];
  
  [[LSAPIDownloader sharedInstance] getSearchResultsForUrlString:urlString andWithSuccess:^(NSArray *resultArray) {
    forecastArray = [NSMutableArray arrayWithArray:resultArray];
    [spinner stopAnimating];
    [whetherDetailTable reloadData];
  } andFailure:^(NSError *error) {
    [spinner stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"There was an error downloading content." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
  }];
  
  whetherDetailTable.tableFooterView=[[UIView alloc]init];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark TableViewDelegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [forecastArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  static NSString *CellIdentifier = @"LSCustomTableViewCell";
  
  LSCustomTableViewCell *cell = (LSCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[LSCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  
  [cell updateCellWithForecast:[forecastArray objectAtIndex:indexPath.row]];
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return 90;
}


@end
