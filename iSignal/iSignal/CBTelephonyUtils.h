//
//  CBTelephonyEvaluater.h
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
#define QUALITY_SIGNAL_LOSS QUALITY_SIGNAL_0
#define QUALITY_SIGNAL_1 1
#define QUALITY_SIGNAL_2 2
#define QUALITY_SIGNAL_3 3
#define QUALITY_SIGNAL_4 4
#define QUALITY_SIGNAL_5 5
#define QUALITY_SIGNAL_BEST QUALITY_SIGNAL_5

typedef NSInteger SIGNAL_QUALITY;

@interface CBTelephonyUtils : NSObject

+(SIGNAL_QUALITY) evaluateSignalQuality:(NSInteger) signalStrength;

@end
