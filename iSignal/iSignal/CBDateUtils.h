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

+(NSString*) dateStringWithLocalTimeZone:(NSString*) format andDate:(NSDate*) date;

+(NSString*) dateStringWithStandardFormatAndLocalTimeZone:(NSDate*) date;

@end
