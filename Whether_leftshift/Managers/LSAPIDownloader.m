//
//  WAAPIDownloader.m
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import "LSAPIDownloader.h"
#import "LSForecast.h"
#import "LSFileManager.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@implementation LSAPIDownloader

+ (LSAPIDownloader *)sharedInstance {
    static LSAPIDownloader *sharedInstance;
    @synchronized(self)
    {
        if (!sharedInstance)
            sharedInstance = [[LSAPIDownloader alloc] init];
        return sharedInstance;
    }
}

- (void) getSearchResultsForUrlString:(NSString *) urlString andWithSuccess:(SuccessBlock) success andFailure:(FailureBlock) failure {
  dispatch_async(kBgQueue, ^{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"Calling url= %@",urlString);
    NSData* responseData = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    NSError *error;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([responseData length] <= 0) {
      NSLog(@"Error-- Response length 0");
      failure([NSError errorWithDomain:@"NoData" code:404 userInfo:nil]);
      return;
    }
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions
                                                           error:&error];
    
    if (error == nil) {
      NSString *responseCode = [json objectForKey:@"cod"];
      if ([responseCode isEqualToString:@"200"]) {
        NSArray *listArray = [json objectForKey:@"list"];
        
        NSDictionary *cityInfo = [json objectForKey:@"city"];
        NSString *cityName = [cityInfo objectForKey:@"name"];
        NSMutableArray *locationArray = [[LSFileManager sharedInstance] getLocationArray];
        if (locationArray == nil) {
          locationArray = [[NSMutableArray alloc] init];
        }
        if (![locationArray containsObject:cityName]) {
          [locationArray addObject:cityName];
          [[LSFileManager sharedInstance] storeLocationArray:locationArray];
        }
        
        NSMutableArray *forecastArray = [[NSMutableArray alloc] initWithCapacity:[listArray count]];
        for (NSDictionary *eachDict in listArray) {
          LSForecast *singleForcast = [[LSForecast alloc] initWithForecastDictionary:eachDict];
          [forecastArray addObject:singleForcast];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
          success((NSArray *)forecastArray);
        });
      }
      else {
        dispatch_sync(dispatch_get_main_queue(), ^{
          NSLog(@"Error-- Response code not equal to 200");
          failure([NSError errorWithDomain:@"ErrorData" code:[responseCode integerValue] userInfo:nil]);
        });
      }
    }
    else {
      dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"Error-- %@",error);
        NSLog(@"JSON-- %@",json);
        failure(error);
      });
    }
  });
}

@end
