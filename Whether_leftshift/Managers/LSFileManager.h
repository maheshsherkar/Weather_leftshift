//
//  LSFileManager.h
//  Whether_leftshift
//
//  Created by Shri on 03/05/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSFileManager : NSObject

+ (LSFileManager *)sharedInstance;

- (void) storeLocationArray:(NSMutableArray *) locArray;
- (NSMutableArray *) getLocationArray;

@end
