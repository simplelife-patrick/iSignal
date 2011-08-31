//
//  ISSwitchViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_SWITCHVIEW 0
#define TAG_LITE_VIEW 1
#define TAG_LITEHELP_VIEW 2
#define TAG_LITECONFIG_VIEW 3
#define COUNT_SUB_VIEW_TAG 3

@interface ISSwitchViewController : UIViewController
{
    UIViewController *isLiteViewController;
    UIViewController *isLiteHelpViewController;
    UIViewController *isLiteConfigViewController;
}

@property (nonatomic, retain) IBOutlet UIViewController *isLiteViewController;
@property (nonatomic, retain) IBOutlet UIViewController *isLiteHelpViewController;
@property (nonatomic, retain) IBOutlet UIViewController *isLiteConfigViewController;

-(void) switchView:(NSInteger) viewTag;

@end
