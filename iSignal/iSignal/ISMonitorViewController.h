//
//  ISMonitorViewController.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-12.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISMonitorViewController : UIViewController

@property (retain, nonatomic) NSMutableArray *plotData;
@property NSUInteger currentIndex;
@property (retain, nonatomic) NSTimer *dataTimer;

@end
