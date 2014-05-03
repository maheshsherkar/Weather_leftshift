//
//  LSMainViewController.h
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKReverseGeocoder.h>
#import "MapKit/MKPlacemark.h"
#import "LSDetailForcastViewController.h"

@interface LSMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
  
  NSMutableArray *locationArray;
  BOOL shouldShowDetailsView;
  
}

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, weak) IBOutlet UITableView *locationTable;
@property(nonatomic, weak) IBOutlet UITextField *cityTextField;

@end
