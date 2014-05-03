//
//  LSFileManager.m
//  Whether_leftshift
//
//  Created by Shri on 03/05/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import "LSFileManager.h"

@implementation LSFileManager

+ (LSFileManager *)sharedInstance {
  static LSFileManager *sharedInstance;
  @synchronized(self) {
    if (!sharedInstance)
      sharedInstance = [[LSFileManager alloc] init];
    return sharedInstance;
  }
}

- (void) storeLocationArray:(NSMutableArray *) locArray {
 
  NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Data.plist"];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:path] == NO) {
    [fileManager createFileAtPath:path contents:nil attributes:nil];
  }
  [locArray writeToFile:path atomically:YES];
}

- (NSMutableArray *) getLocationArray {

  NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Data.plist"];

  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:path] == NO) {
    return nil;
  }
  NSMutableArray *locationArray=[NSMutableArray arrayWithContentsOfFile:path];
  return locationArray;
}

@end
