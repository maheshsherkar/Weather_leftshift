//
//  LSForecast.m
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import "LSForecast.h"

@implementation LSForecast

-(id) initWithForecastDictionary:(NSDictionary *) dict {
    
    if (self == [super init]) {
        self.date = [[dict objectForKey:@"dt"] longValue];
        self.pressure = [[dict objectForKey:@"pressure"] doubleValue];
        self.humidity = [[dict objectForKey:@"humidity"] doubleValue];
        self.speed = [[dict objectForKey:@"speed"] doubleValue];
        
        self.tempDay = [[[dict objectForKey:@"temp"] objectForKey:@"day"] doubleValue];
        self.tempMin = [[[dict objectForKey:@"temp"] objectForKey:@"min"] doubleValue];
        self.tempMax = [[[dict objectForKey:@"temp"] objectForKey:@"max"] doubleValue];
        
        self.weatherDesc = [[[dict objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
        self.weatherIcon = [[[dict objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"icon"];

    }
    return self;
}
@end
