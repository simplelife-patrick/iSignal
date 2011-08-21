//
//  SwitchViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchViewController : UIViewController
{
    UIViewController *isLiteViewController;
    UIViewController *isLiteHelpViewController;
    UIViewController *isLiteConfigViewController;
}

@property (nonatomic, retain) IBOutlet UIViewController *isLiteViewController;
@property (nonatomic, retain) IBOutlet UIViewController *isLiteHelpViewController;
@property (nonatomic, retain) IBOutlet UIViewController *isLiteConfigViewController;

-(void) switchView:(id) sender andViewId:NSInteger;

@end
