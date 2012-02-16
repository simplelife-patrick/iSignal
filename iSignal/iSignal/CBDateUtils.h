//
//  CBDateUtils.h
//  iSignal
//
//  Created by Patrick Deng on 12-2-15.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STANDARD_DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"

@interface CBDateUtils : NSObject

+(NSString*) dateString:(NSTimeZone*) timeZone andFormat:(NSString*) format andDate:(NSDate*) date;

+(NSString*) dateStringInLocalTimeZone:(NSString*) format andDate:(NSDate*) date;

+(NSString*) dateStringInLocalTimeZoneWithStandardFormat:(NSDate*) date;

+(NSString*) dateStringInLocalTimeZoneWithStandardFormat:(NSDate*) date;

+(NSDate *) dateFromStringWithFormat:(NSString *)dateString andFormat:(NSString *) formatString;

@end
