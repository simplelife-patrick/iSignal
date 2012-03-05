//
//  CBTelephonyUtils.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-25.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

// Signal level from low to high(zero means no signal).
/*
        dbM             Signal Quality
    -60 or greater            5
    -61 to -73                4
    -74 to -85                3
    -86 to -98                2
    -99 to -110               1
    -111 or less              0 
 */
#define QUALITY_SIGNAL_0_UPPERLIMIT -111
#define QUALITY_SIGNAL_1_LOWERLIMIT -110
#define QUALITY_SIGNAL_1_UPPERLIMIT -99
#define QUALITY_SIGNAL_2_LOWERLIMIT -98
#define QUALITY_SIGNAL_2_UPPERLIMIT -86
#define QUALITY_SIGNAL_3_LOWERLIMIT -85
#define QUALITY_SIGNAL_3_UPPERLIMIT -74
#define QUALITY_SIGNAL_4_LOWERLIMIT -73
#define QUALITY_SIGNAL_4_UPPERLIMIT -61
#define QUALITY_SIGNAL_5_LOWERLIMIT -60

#define QUALITY_SIGNAL_0 0
#define QUALITY_SIGNAL_NO QUALITY_SIGNAL_0
#define QUALITY_SIGNAL_1 1
#define QUALITY_SIGNAL_2 2
#define QUALITY_SIGNAL_3 3
#define QUALITY_SIGNAL_4 4
#define QUALITY_SIGNAL_5 5
#define QUALITY_SIGNAL_BEST QUALITY_SIGNAL_5

#define QUALITY_SIGNAL_0_TEXT NSLocalizedString(@"STR_QUALITY_SIGNAL_0", nil)
#define QUALITY_SIGNAL_1_TEXT NSLocalizedString(@"STR_QUALITY_SIGNAL_1", nil)
#define QUALITY_SIGNAL_2_TEXT NSLocalizedString(@"STR_QUALITY_SIGNAL_2", nil)
#define QUALITY_SIGNAL_3_TEXT NSLocalizedString(@"STR_QUALITY_SIGNAL_3", nil)
#define QUALITY_SIGNAL_4_TEXT NSLocalizedString(@"STR_QUALITY_SIGNAL_4", nil)
#define QUALITY_SIGNAL_5_TEXT NSLocalizedString(@"STR_QUALITY_SIGNAL_5", nil)


typedef NSInteger SIGNAL_QUALITY;

@interface CBTelephonyUtils : NSObject

+(SIGNAL_QUALITY) evaluateSignalQuality:(NSInteger) signalStrength;

+(NSString*) signalQualityText:(SIGNAL_QUALITY) signalQuality;

@end
