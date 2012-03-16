//
//  ISHelpViewController.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-21.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBUIUtils.h"

@interface ISHelpViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *helpTableView;

@property (retain, nonatomic) IBOutlet UIViewController *detailViewController;

@property (retain, nonatomic) IBOutlet UITextView *aboutTextView;

@end
