//
//  NSDate+Extensions.m
//  Whether_leftshift
//
//  Created by Mahesh on 29/04/14.
//  Copyright (c) 2014 Mahesh. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

-(NSString *) getSimpleString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-LLL-yyyy"];
    return [dateFormatter stringFromDate:self];
}

@end
