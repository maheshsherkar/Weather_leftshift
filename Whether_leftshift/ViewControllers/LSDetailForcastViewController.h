//
//  LSDetailForcastViewController.h
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSForecast.h"
#import "LSCustomTableViewCell.h"

@interface LSDetailForcastViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
  IBOutlet UITableView *whetherDetailTable;
  NSMutableArray *forecastArray;
  LSForecast *forecastObject;
  
  UIActivityIndicatorView *spinner;
}

@property(strong,nonatomic) NSString *cityName;
@property (nonatomic, strong) NSString* latitude;
@property (nonatomic, strong) NSString* longitude;

@end
