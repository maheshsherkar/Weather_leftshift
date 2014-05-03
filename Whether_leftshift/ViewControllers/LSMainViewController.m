//
//  LSMainViewController.m
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import "LSMainViewController.h"
#import "LSFileManager.h"

@interface LSMainViewController ()

@end

@implementation LSMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

-(void)viewWillAppear:(BOOL)animated
{
  self.cityTextField.text=@"";
  locationArray = [[LSFileManager sharedInstance] getLocationArray];
  [self.locationTable reloadData];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.title=@"Location";
  self.locationTable.tableFooterView=[[UIView alloc]init];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark IBActions

-(IBAction) searchButtonPressed:(id)sender
{
  if (self.cityTextField.text.length > 0) {
    [self.cityTextField resignFirstResponder];
    LSDetailForcastViewController *detailForcast=[[LSDetailForcastViewController alloc] initWithNibName:@"LSDetailForcastViewController" bundle:nil];
    detailForcast.cityName=self.cityTextField.text;
    [self.navigationController pushViewController:detailForcast animated:YES];
    detailForcast=nil;
  }
  
}

-(IBAction)locationButtonPressed:(id)sender
{
  if (!self.locationManager) {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLLocationAccuracyKilometer;
  }
  shouldShowDetailsView = YES;
  [self.locationManager startUpdatingLocation];
}

#pragma mark
#pragma mark CLlocationManager Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  [manager stopUpdatingLocation];
  if (shouldShowDetailsView) {
    LSDetailForcastViewController *detailForcast=[[LSDetailForcastViewController alloc] initWithNibName:@"LSDetailForcastViewController" bundle:nil];
    detailForcast.latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    detailForcast.longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    [self.navigationController pushViewController:detailForcast animated:YES];
    detailForcast=nil;
  }
  shouldShowDetailsView = NO;
}

// this delegate method is called if an error occurs in locating your current location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  shouldShowDetailsView = NO;
  NSLog(@"locationManagerLLLLLLLL :%@ didFailWithError:%@", manager, error);
  UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:nil   message:NSLocalizedString(@"Error in finding current location", nil)  delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
  [myAlert show];
}


#pragma mark
#pragma mark TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [locationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.font= [UIFont systemFontOfSize:17.0f];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
  }
  cell.textLabel.text=[locationArray objectAtIndex:indexPath.row];
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  LSDetailForcastViewController *detailForcast=[[LSDetailForcastViewController alloc] initWithNibName:@"LSDetailForcastViewController" bundle:nil];
  detailForcast.cityName=[locationArray objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:detailForcast animated:YES];
  detailForcast=nil;
}
@end
