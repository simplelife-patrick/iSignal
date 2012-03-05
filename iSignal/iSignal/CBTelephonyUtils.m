//
//  CBTelephonyEvaluater.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-25.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "CBTelephonyUtils.h"

@implementation CBTelephonyUtils

// Manual Codes Begin

+(SIGNAL_QUALITY) evaluateSignalQuality:(NSInteger) signalStrength;
{
    SIGNAL_QUALITY quality = QUALITY_SIGNAL_5;
    if(QUALITY_SIGNAL_0_UPPERLIMIT >= signalStrength)
    {
        quality = QUALITY_SIGNAL_0;
    }
    else if((QUALITY_SIGNAL_1_UPPERLIMIT >= signalStrength) && (signalStrength >= QUALITY_SIGNAL_1_LOWERLIMIT))
    {
        quality = QUALITY_SIGNAL_1;
    }
    else if((QUALITY_SIGNAL_2_UPPERLIMIT >= signalStrength) && (signalStrength >=QUALITY_SIGNAL_2_LOWERLIMIT))
    {
        quality = QUALITY_SIGNAL_2;
    }
    else if((QUALITY_SIGNAL_3_UPPERLIMIT >= signalStrength) && (signalStrength >= QUALITY_SIGNAL_3_LOWERLIMIT))
    {
        quality = QUALITY_SIGNAL_3;
    }
    else if((QUALITY_SIGNAL_4_UPPERLIMIT >= signalStrength) && (signalStrength >= QUALITY_SIGNAL_4_LOWERLIMIT))
    {
        quality = QUALITY_SIGNAL_4;
    }

    return quality;
}

+(NSString*) signalQualityText:(SIGNAL_QUALITY) signalQuality
{
    switch (signalQuality) 
    {
        case QUALITY_SIGNAL_0:
            return QUALITY_SIGNAL_0_TEXT;
        case QUALITY_SIGNAL_1:
            return QUALITY_SIGNAL_1_TEXT;
        case QUALITY_SIGNAL_2:
            return QUALITY_SIGNAL_2_TEXT;
        case QUALITY_SIGNAL_3:
            return QUALITY_SIGNAL_3_TEXT;
        case QUALITY_SIGNAL_4:
            return QUALITY_SIGNAL_4_TEXT;
        case QUALITY_SIGNAL_5:
            return QUALITY_SIGNAL_5_TEXT;            
        default:
            // TODO: Need replace a "N/A" marco definition with below one
            return QUALITY_SIGNAL_0_TEXT;
    }
}

// Manual Codes End

@end
