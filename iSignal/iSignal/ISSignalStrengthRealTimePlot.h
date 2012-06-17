//
//  ISSignalStrengthRealTimePlot.h
//  iSignal
//
//  Created by Patrick Deng on 12-6-14.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "CBPlotItem.h"

@interface ISSignalStrengthRealTimePlot : CBPlotItem <CPTPlotDataSource>
{
	NSMutableArray *plotData;
	NSUInteger currentIndex;
	NSTimer *dataTimer;
}

-(void)newData:(NSTimer *)theTimer;

@end
