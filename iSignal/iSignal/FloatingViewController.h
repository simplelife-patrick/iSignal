//
//  FloatingViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-29.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingViewController : UIViewController
{

    UIButton *toggleButton;
}

@property (nonatomic, retain) IBOutlet UIButton *toggleButton;

- (IBAction)onToggle:(id)sender;

@end
