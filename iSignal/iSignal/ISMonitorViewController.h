//
//  ISMonitorViewController.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-12.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBPlotItem.h"

#import "ISMonitorScatterPlotTheme.h"
#import "ISSimpleScatterPlot.h"
#import "ISSignalStrengthRealTimePlot.h"

@interface ISMonitorViewController : UIViewController
{
    CBPlotItem *detailItem;
}

@property (nonatomic, retain) CBPlotItem *detailItem;
@property (nonatomic, retain) IBOutlet UIView *hostingView;

@end
