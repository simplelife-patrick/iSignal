//
//  ISLiteHelpViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISUIUtils.h"

@interface ISLiteHelpViewController : UIViewController 
{
    UIButton *backButton;
    UIButton *suggestButton;
    UITextView *textView;
}
@property (nonatomic, retain) IBOutlet UITextView *textView;

@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UIButton *suggestButton;

-(IBAction)switchToLiteView:(id)sender;
-(IBAction)onSuggest:(id)sender;

@end
