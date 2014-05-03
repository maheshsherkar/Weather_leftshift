//
//  LSCustomTableViewCell.h
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSForecast.h"

@interface LSCustomTableViewCell : UITableViewCell {
  
}

@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *description;
@property (nonatomic, weak) UILabel *minLabel;
@property (nonatomic, weak) UILabel *maxLabel;
@property (nonatomic, weak) UILabel *humidityLabel;
@property (nonatomic, weak) UILabel *windLabel;
@property (nonatomic, weak) UIImageView *forcastImage;

-(void) updateCellWithForecast:(LSForecast *) foreCast;
@end
