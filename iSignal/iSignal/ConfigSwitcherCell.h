//
//  ConfigSwitchCell.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-28.
//  Copyright 2011年 CodeAnimal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigSwitcherCell : UITableViewCell 
{
    UILabel *switcherLabel;
    UISwitch *switcher;
}

@property (nonatomic, retain) IBOutlet UISwitch *switcher;

@property (nonatomic, retain) IBOutlet UILabel *switcherLabel;

@end
