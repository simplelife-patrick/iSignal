//
//  ISTableViewSegmentCell.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-20.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISTableViewSegmentCell.h"

@implementation ISTableViewSegmentCell
@synthesize segmentControl;
@synthesize segmentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc 
{
    [segmentControl release];
    [segmentLabel release];
    [super dealloc];
}
@end
