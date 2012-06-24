
//  ISSignalStrengthRealTimePlot.m
//  iSignal
//
//  Created by Patrick Deng on 12-6-14.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISSignalStrengthRealTimePlot.h"

@implementation ISSignalStrengthRealTimePlot

+ (void)load
{
	[super registerPlotItem:self];
}

- (id)init
{
	if ((self = [super init])) 
    {
		title	  = PLOT_ID_REALTIME_SIGNALSTRENGTH;
		plotData  = [[NSMutableArray alloc] initWithCapacity:kSignalStrengthPlotDataPoints];
	}
    
	return self;
}

- (void)setTitleDefaultsForGraph:(CPTGraph *)graph withBounds:(CGRect)bounds
{
//    [super setTitleDefaultsForGraph:graph withBounds:bounds];
}

- (void)setPaddingDefaultsForGraph:(CPTGraph *)graph withBounds:(CGRect)bounds
{
//    [super setPaddingDefaultsForGraph:graph withBounds:bounds];
}

- (void)killGraph
{
    
	[super killGraph];
}

- (void)generateData
{
	[plotData removeAllObjects];
	currentIndex = 0;

//    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate]; 
//    NSNumber *firstVal = [NSNumber numberWithInt:[appDelegate.dummyTelephonyModule signalStrength]];
//    [self updateSignalStrength:firstVal];
    
    [self listenSignalStrengthChanged];
}

- (void)renderInLayer:(CPTGraphHostingView *)layerHostingView withTheme:(CPTTheme *)theme
{

	CGRect bounds = layerHostingView.bounds;
    
	CPTGraph *graph = [[[CPTXYGraph alloc] initWithFrame:bounds] autorelease];
	[self addGraph:graph toHostingView:layerHostingView];
	[self applyTheme:theme toGraph:graph withDefault:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    
	[self setTitleDefaultsForGraph:graph withBounds:bounds];
	[self setPaddingDefaultsForGraph:graph withBounds:bounds];
    
	// Create the plot
	CPTScatterPlot *dataSourceLinePlot = [[[CPTScatterPlot alloc] init] autorelease];
	dataSourceLinePlot.identifier	  = PLOT_ID_REALTIME_SIGNALSTRENGTH;
	dataSourceLinePlot.cachePrecision = CPTPlotCachePrecisionDouble;
    
	CPTMutableLineStyle *lineStyle = [[dataSourceLinePlot.dataLineStyle mutableCopy] autorelease];
	lineStyle.lineWidth				 = 3.0;
	lineStyle.lineColor				 = [CPTColor greenColor];
	dataSourceLinePlot.dataLineStyle = lineStyle;
    
	dataSourceLinePlot.dataSource = self;
    
	[graph addPlot:dataSourceLinePlot];
    
	// Plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(0) length:CPTDecimalFromUnsignedInteger(kSignalStrengthPlotDataPoints - 1)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(CELLULAR_SIGNALSTRENGTH_LOWEST) length:CPTDecimalFromFloat(CELLULAR_SIGNALSTRENGTH_HIGHEST - CELLULAR_SIGNALSTRENGTH_LOWEST)];
    
    // Plot symbol
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill = [CPTFill fillWithColor:[CPTColor blueColor]];
    CPTMutableLineStyle *symbolLineStyle = [[CPTMutableLineStyle alloc] autorelease];
    symbolLineStyle.lineColor = [CPTColor blackColor];
    plotSymbol.lineStyle = symbolLineStyle;
    plotSymbol.size = CGSizeMake(6, 6);
    dataSourceLinePlot.plotSymbol = plotSymbol;    
}

- (void)dealloc
{
	[plotData release];

	[super dealloc];
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

// Private Method
- (void)listenSignalStrengthChanged
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSignalStrengthChanged:) name:
     NOTIFICATION_ID_SIGNALSTRENGTH_CHANGED object:nil];      
}

// Private Method
- (void)onSignalStrengthChanged:(NSNotification *) notification
{
    NSValue *nsValue = [[notification userInfo] objectForKey:NOTIFICATION_KV_SIGNALSTRENGTH_CHANGED]; 
    NSNumber *signalVal = (NSNumber*)nsValue;
    [self performSelectorOnMainThread:@selector(updateSignalStrength:) withObject:(signalVal) waitUntilDone:NO];
}

// Private Method
- (void)updateSignalStrength:(NSNumber*) signalVal
{
    if (nil != signalVal)
    {
        CPTGraph *theGraph = [graphs objectAtIndex:0];
        CPTPlot *thePlot   = [theGraph plotWithIdentifier:PLOT_ID_REALTIME_SIGNALSTRENGTH];

        NSInteger intVal = [signalVal intValue];
        SIGNAL_QUALITY qualityGrade = [CBTelephonyUtils evaluateSignalQuality:intVal];
        if (qualityGrade == QUALITY_SIGNAL_NO) 
        {
            signalVal = [NSNumber numberWithInt:CELLULAR_SIGNALSTRENGTH_LOWEST];
        }
        
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
            
            currentIndex = currentIndex + 1;
            [plotData addObject:signalVal];
            [thePlot insertDataAtIndex:plotData.count - 1 numberOfRecords:1];
        }        
    }
    else
    {
        DLog(@"Can not update scatter plot with nil value.");
    }
}

@end
