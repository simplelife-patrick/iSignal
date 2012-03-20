//
//  ISTableViewSegmentCell.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-20.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISTableViewSegmentCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (retain, nonatomic) IBOutlet UILabel *segmentLabel;

@end
