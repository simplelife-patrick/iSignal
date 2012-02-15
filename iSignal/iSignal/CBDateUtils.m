//
//  CBDateUtils.m
//  iSignal
//
//  Created by Patrick Deng on 12-2-15.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "CBDateUtils.h"

@implementation CBDateUtils

+(NSString*) dateString:(NSTimeZone*) timeZone andFormat:(NSString*) format andDate:(NSDate*) date
{
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:STANDARD_DATE_FORMAT];
    
    timeZone = (nil != timeZone) ? timeZone : [NSTimeZone defaultTimeZone];
    [formatter setTimeZone:timeZone];
    
    NSString *localTime = [formatter stringFromDate:date];
    
    [formatter release];
    
    return localTime;
}

+(NSString*) dateStringWithLocalTimeZone:(NSString*) format andDate:(NSDate*) date
{
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    return [CBDateUtils dateString: localTimeZone andFormat:STANDARD_DATE_FORMAT andDate: date];
}

+(NSString*) dateStringWithStandardFormatAndLocalTimeZone:(NSDate*) date
{
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    return [CBDateUtils dateString:localTimeZone andFormat:STANDARD_DATE_FORMAT andDate:date];
}

@end
