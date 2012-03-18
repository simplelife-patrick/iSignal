//
//  ISVersionHistoryViewController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-18.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISVersionHistoryViewController.h"

@interface ISVersionHistoryViewController ()

@end

@implementation ISVersionHistoryViewController

@synthesize versionHistoryTableView;

// Method of TableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

// Method of TableViewDataSource protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setVersionHistoryTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [versionHistoryTableView release];
    [super dealloc];
}
@end
