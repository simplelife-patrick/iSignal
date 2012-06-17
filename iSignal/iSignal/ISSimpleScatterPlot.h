//
//  ISSimpleScatterPlot.h
//  iSignal
//
//  Created by Patrick Deng on 12-6-17.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "CBPlotItem.h"

@interface ISSimpleScatterPlot : CBPlotItem <CPTPlotSpaceDelegate,
                                                CPTPlotDataSource,
                                                CPTScatterPlotDelegate>
{
	CPTPlotSpaceAnnotation *symbolTextAnnotation;
    
	NSArray *plotData;
}


@end

