//
//  ISFloatingViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-29.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingViewController : UIViewController
{
    UIButton *toggleButton;

    BOOL isViewRetracted;
    
    CGRect retractRect;
    CGRect popupRect;
}

@property (nonatomic, retain) IBOutlet UIButton *toggleButton;

@property (nonatomic) BOOL isViewRected;

@property (nonatomic) CGRect retractRect;
@property (nonatomic) CGRect popupRect;

- (IBAction)onToggle:(id)sender;

@end
