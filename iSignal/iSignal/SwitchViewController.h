//
//  SwitchViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_LITEVIEW 0
#define TAG_LITEHELPVIEW 1
#define TAG_LITECONFIGVIEW 2
#define COUNT_VIEW_TAG 3

@interface SwitchViewController : UIViewController
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
