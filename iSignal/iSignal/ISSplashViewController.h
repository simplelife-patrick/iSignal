//
//  ISSplashViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-26.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISFloatingViewController.h"

@interface ISSplashViewController : UIViewController
{
    UIViewController *switchViewController;
    UIImageView *splashImageView;
    NSTimer *timer;
    ISFloatingViewController *floatingViewController;
}

@property (nonatomic, retain) IBOutlet ISFloatingViewController *floatingViewController;
@property (nonatomic, retain) IBOutlet UIViewController *switchViewController;
@property (nonatomic, retain) IBOutlet UIImageView *splashImageView;

@property (nonatomic, retain) NSTimer *timer;

-(void) loadAnyNecessaryStuff;

@end