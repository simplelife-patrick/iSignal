
//  ISSignalStrengthRealTimePlot.m
//  iSignal
//
//  Created by Patrick Deng on 12-6-14.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISSignalStrengthRealTimePlot.h"

const double kFrameRate			= 5.0;  // frames per second
const double kAlpha				= 0.25; // smoothing constant

NSString *kPlotIdentifier		= @"Real Time Signal Strength Plot";


@implementation ISSignalStrengthRealTimePlot

+ (void)load
{
	[super registerPlotItem:self];
}

- (id)init
{
	if ((self = [super init])) 
    {
		title	  = @"Real Time Signal Strength";
		plotData  = [[NSMutableArray alloc] initWithCapacity:kSignalStrengthPlotDataPoints];
		dataTimer = nil;
	}
    
	return self;
}

- (void)setTitleDefaultsForGraph:(CPTGraph *)graph withBounds:(CGRect)bounds
{
    [super setTitleDefaultsForGraph:graph withBounds:bounds];
}

- (void)killGraph
{
	[dataTimer invalidate];
	[dataTimer release];
	dataTimer = nil;
    
	[super killGraph];
}

- (void)generateData
{
	[plotData removeAllObjects];
	currentIndex = 0;
	[dataTimer release];
	dataTimer = [[NSTimer timerWithTimeInterval:1.0 / kFrameRate
										 target:self
									   selector:@selector(newData:)
									   userInfo:nil
										repeats:YES] retain];
	[[NSRunLoop mainRunLoop] addTimer:dataTimer forMode:NSDefaultRunLoopMode];
}

- (void)renderInLayer:(CPTGraphHostingView *)layerHostingView withTheme:(CPTTheme *)theme
{
	CGRect bounds = layerHostingView.bounds;
    
	CPTGraph *graph = [[[CPTXYGraph alloc] initWithFrame:bounds] autorelease];
	[self addGraph:graph toHostingView:layerHostingView];
	[self applyTheme:theme toGraph:graph withDefault:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    
//	[self setTitleDefaultsForGraph:graph withBounds:bounds];
	[self setPaddingDefaultsForGraph:graph withBounds:bounds];
    
	graph.plotAreaFrame.paddingTop	  = 5.0;
	graph.plotAreaFrame.paddingRight  = 5.0;
	graph.plotAreaFrame.paddingBottom = 55.0;
	graph.plotAreaFrame.paddingLeft	  = 50.0;
    
    // No border line for graph
    graph.plotAreaFrame.borderLineStyle = nil;
    graph.plotAreaFrame.cornerRadius = 0.0f;

	// Grid line styles
	CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
	majorGridLineStyle.lineWidth = 0.75;
	majorGridLineStyle.lineColor = [[CPTColor colorWithGenericGray:0.2] colorWithAlphaComponent:0.75];
    
	CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
	minorGridLineStyle.lineWidth = 0.25;
	minorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.1];
    
	// Axes
	// X axis
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
	x.labelingPolicy			  = CPTAxisLabelingPolicyAutomatic;
	x.orthogonalCoordinateDecimal = CPTDecimalFromUnsignedInteger(0);
	x.majorGridLineStyle		  = majorGridLineStyle;
	x.minorGridLineStyle		  = minorGridLineStyle;
	x.minorTicksPerInterval		  = 9;
	x.title						  = @"Time(seconds)";
	x.titleOffset				  = 35.0;
	NSNumberFormatter *labelFormatter = [[NSNumberFormatter alloc] init];
	labelFormatter.numberStyle = NSNumberFormatterNoStyle;
	x.labelFormatter		   = labelFormatter;
	[labelFormatter release];
    
	// Y axis
	CPTXYAxis *y = axisSet.yAxis;
	y.labelingPolicy			  = CPTAxisLabelingPolicyAutomatic;
	y.orthogonalCoordinateDecimal = CPTDecimalFromUnsignedInteger(0);
	y.majorGridLineStyle		  = majorGridLineStyle;
	y.minorGridLineStyle		  = minorGridLineStyle;
	y.minorTicksPerInterval		  = 3;
	y.labelOffset				  = 5.0;
	y.title						  = @"Signal Strength(dbm)";
	y.titleOffset				  = 30.0;
	y.axisConstraints			  = [CPTConstraints constraintWithLowerOffset:0.0];
    
	// Rotate the labels by 45 degrees, just to show it can be done.
	x.labelRotation = M_PI * 0.25;
    
	// Create the plot
	CPTScatterPlot *dataSourceLinePlot = [[[CPTScatterPlot alloc] init] autorelease];
	dataSourceLinePlot.identifier	  = kPlotIdentifier;
	dataSourceLinePlot.cachePrecision = CPTPlotCachePrecisionDouble;
    
	CPTMutableLineStyle *lineStyle = [[dataSourceLinePlot.dataLineStyle mutableCopy] autorelease];
	lineStyle.lineWidth				 = 3.0;
	lineStyle.lineColor				 = [CPTColor greenColor];
	dataSourceLinePlot.dataLineStyle = lineStyle;
    
	dataSourceLinePlot.dataSource = self;
	[graph addPlot:dataSourceLinePlot];
    
	// Plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = NO;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(0) length:CPTDecimalFromUnsignedInteger(kSignalStrengthPlotDataPoints - 1)];
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(0) length:CPTDecimalFromUnsignedInteger(1)];
}

- (void)dealloc
{
	[plotData release];
	[dataTimer invalidate];
	[dataTimer release];
    
	[super dealloc];
}

- (void)newData:(NSTimer *)theTimer
{
	CPTGraph *theGraph = [graphs objectAtIndex:0];
	CPTPlot *thePlot   = [theGraph plotWithIdentifier:kPlotIdentifier];
    
	if (thePlot) 
    {
		if (plotData.count >= kSignalStrengthPlotDataPoints) 
        {
			[plotData removeObjectAtIndex:0];
			[thePlot deleteDataInIndexRange:NSMakeRange(0, 1)];
		}
        
		CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)theGraph.defaultPlotSpace;
		NSUInteger location		  = (currentIndex >= kSignalStrengthPlotDataPoints ? currentIndex - kSignalStrengthPlotDataPoints + 1 : 0);
		plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(location)
														length:CPTDecimalFromUnsignedInteger(kSignalStrengthPlotDataPoints - 1)];
        
		currentIndex++;
		[plotData addObject:[NSNumber numberWithDouble:(1.0 - kAlpha) * [[plotData lastObject] doubleValue] + kAlpha * rand() / (double)RAND_MAX]];
		[thePlot insertDataAtIndex:plotData.count - 1 numberOfRecords:1];
	}
}

// Method of CPTPlotDataSource protocol
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
	return [plotData count];
}

// Method of CPTPlotDataSource protocol
- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	NSNumber *num = nil;
    
	switch (fieldEnum) 
    {
		case CPTScatterPlotFieldX:
			num = [NSNumber numberWithUnsignedInteger:index + currentIndex - plotData.count];
			break;
            
		case CPTScatterPlotFieldY:
			num = [plotData objectAtIndex:index];
			break;
            
		default:
			break;
	}
    
	return num;
}


@end
