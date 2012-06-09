//
//  ISMonitorScatterPlotTheme.m
//  iSignal
//
//  Created by Patrick Deng on 12-6-8.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISMonitorScatterPlotTheme.h"

@implementation ISMonitorScatterPlotTheme

+(NSString*) name
{
    return THEME_MONITOR_SCATTER_PLOT;
}

-(id)init
{
	if ((self = [super init])) 
    {
		self.graphClass = [CPTXYGraph class];
	}
	return self;
}

-(void)applyThemeToAxis:(CPTXYAxis *)axis usingMajorLineStyle:(CPTLineStyle *)majorLineStyle
		 minorLineStyle:(CPTLineStyle *)minorLineStyle majorGridLineStyle:majorGridLineStyle textStyle:(CPTTextStyle *)textStyle
{

}

-(void)applyThemeToBackground:(CPTXYGraph *)graph
{

}

-(void)applyThemeToPlotArea:(CPTPlotAreaFrame *)plotAreaFrame
{

}

-(void)applyThemeToAxisSet:(CPTXYAxisSet *)axisSet
{

}

@end
