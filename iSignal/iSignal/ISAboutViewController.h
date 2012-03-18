//
//  ISAboutViewController.h
//  iSignal
//
//  Created by Patrick Deng on 12-3-18.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISAboutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *aboutTableView;

@end
