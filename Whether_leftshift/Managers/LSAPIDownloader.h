//
//  WAAPIDownloader.h
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSArray *);
typedef void(^FailureBlock)(NSError *);

@interface LSAPIDownloader : NSObject

+ (LSAPIDownloader *)sharedInstance;

- (void) getSearchResultsForUrlString:(NSString *) urlString andWithSuccess:(SuccessBlock) success andFailure:(FailureBlock) failure;
@end
