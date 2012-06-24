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

-(void)applyThemeToBackground:(CPTXYGraph *)graph
{    
    graph.paddingLeft = 5.0f;
    graph.paddingRight = 5.0f;
    graph.paddingTop = 5.0f;
    graph.paddingBottom = 10.0f;
}

-(void)applyThemeToPlotArea:(CPTPlotAreaFrame *)plotAreaFrame
{
//	plotAreaFrame.paddingTop	  = 5.0;
//	plotAreaFrame.paddingRight  = 5.0;
	plotAreaFrame.paddingBottom = 60.0;
	plotAreaFrame.paddingLeft	  = 20.0;
    
    // No border line for graph
    plotAreaFrame.borderLineStyle = nil;
    plotAreaFrame.cornerRadius = 0.0f;
    
//    CPTColor *beginningColor = [CPTColor colorWithComponentRed:0.0 green:1.0 blue:0.0 alpha:0.8];
//    CPTColor *endingColor = [CPTColor colorWithComponentRed:1.0 green:0.0 blue:0.0 alpha:0.8];
//    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:beginningColor endingColor:endingColor];
//    areaGradient.angle = -90.0f;
//    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
//    plotAreaFrame.fill = areaGradientFill;   
}

-(void)applyThemeToAxisSet:(CPTXYAxisSet *)axisSet
{    
	CPTMutableLineStyle *majorLineStyle = [CPTMutableLineStyle lineStyle];
	majorLineStyle.lineCap	 = kCGLineCapSquare;
	majorLineStyle.lineColor = [CPTColor blackColor];
	majorLineStyle.lineWidth = 2.0f;
    
	CPTMutableLineStyle *minorLineStyle = [CPTMutableLineStyle lineStyle];
	minorLineStyle.lineCap	 = kCGLineCapSquare;
	minorLineStyle.lineColor = [CPTColor blackColor];
	minorLineStyle.lineWidth = 1.0f;
    
	CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
	majorGridLineStyle.lineWidth = 0.75;
	majorGridLineStyle.lineColor = [[CPTColor colorWithGenericGray:0.2] colorWithAlphaComponent:0.75];
    
	CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
	minorGridLineStyle.lineWidth = 0.25;
	minorGridLineStyle.lineColor = [[CPTColor colorWithGenericGray:0.1] colorWithAlphaComponent:0.5];

	CPTMutableTextStyle *whiteTextStyle = [[[CPTMutableTextStyle alloc] init] autorelease];
	whiteTextStyle.color	= [CPTColor blackColor];
	whiteTextStyle.fontSize = 14.0f;
    
    CPTMutableLineStyle *xAxisLineStyle = [[CPTMutableLineStyle alloc] autorelease];
    xAxisLineStyle.lineWidth = 2.0; 
    xAxisLineStyle.lineColor = [CPTColor redColor]; 
    
    CPTMutableLineStyle *yAxisLineStyle = [[CPTMutableLineStyle alloc] autorelease];
	yAxisLineStyle.lineWidth				 = 2.0;
	yAxisLineStyle.lineColor				 = [CPTColor blackColor];

    CPTXYAxis *x = axisSet.xAxis;
	x.labelingPolicy			  = CPTAxisLabelingPolicyNone;
	x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(CELLULAR_SIGNALSTRENGTH_LOWEST);
	x.majorGridLineStyle		  = majorGridLineStyle;
	x.minorGridLineStyle		  = minorGridLineStyle;
	x.minorTicksPerInterval		  = 9;
	x.title						  = @"Time: ";
	x.titleOffset				  = 5.0;
    x.axisLineStyle = xAxisLineStyle;
    
//	NSNumberFormatter *labelFormatter = [[NSNumberFormatter alloc] init];
//	labelFormatter.numberStyle = NSNumberFormatterNoStyle;
//	x.labelFormatter		   = labelFormatter;
//	[labelFormatter release];
//    x.labelRotation = M_PI * 0.25;
    
	// Y axis
	CPTXYAxis *y = axisSet.yAxis;
	y.labelingPolicy			  = CPTAxisLabelingPolicyAutomatic;
	y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0);
	y.majorGridLineStyle		  = majorGridLineStyle;
	y.minorGridLineStyle		  = minorGridLineStyle;
	y.minorTicksPerInterval		  = 9;
//	y.labelOffset				  = 5.0;
    y.title						  = @"Signal Strength(dbm)";
    y.titleOffset				  = 5.0;
    y.axisLineStyle = yAxisLineStyle;
    y.labelExclusionRanges = [NSArray arrayWithObjects:
                              [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1000) length:CPTDecimalFromFloat(2000)],
                              nil];
    y.axisConstraints			  = [CPTConstraints constraintWithLowerOffset:0.0];
//    y.delegate = self;
}

@end
