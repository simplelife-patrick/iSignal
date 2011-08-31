//
//  ISConfigSwitchCell.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-28.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "ISConfigSwitcherCell.h"

@implementation ISConfigSwitcherCell

// Manual Codes Begin

@synthesize switcher;
@synthesize switcherLabel;

- (void)dealloc 
{
    [switcherLabel release];
    [switcher release];

    [super dealloc];
}

// Manual Codes End

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
