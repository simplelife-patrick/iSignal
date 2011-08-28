//
//  ISLiteConfigViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISUIUtils.h"

#import "ConfigSwitcherCell.h"

@interface ISLiteConfigViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIButton *backButton;
    NSArray *configItemArray;
    NSArray *configSectionArray;
}

@property (nonatomic, retain) IBOutlet UIButton *backButton;

@property (nonatomic, retain) NSArray *configItemArray;
@property (nonatomic, retain) NSArray *configSectionArray;

-(IBAction)switchToLiteView:(id)sender;

@end
