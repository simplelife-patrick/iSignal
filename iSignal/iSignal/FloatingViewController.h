//
//  FloatingViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-29.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

#define POINT_X_RETRACT 280
#define POINT_Y_RETRACT 0

#define POINT_X_POPUP 0
#define POINT_Y_POPUP 0

#define SIZE_WIDTH_NORAML 280
#define SIZE_HEIGHT_NORMAL 40

static CGPoint s_viewLocation_retract;
static CGPoint s_viewLocation_popup;

static CGSize s_viewSize_normal;

@interface FloatingViewController : UIViewController
{

    UIButton *toggleButton;
}

@property (nonatomic, retain) IBOutlet UIButton *toggleButton;

+ (void) initialize;

- (IBAction)onToggle:(id)sender;

@end
