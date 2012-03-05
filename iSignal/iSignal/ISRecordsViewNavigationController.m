//
//  ISRecordsViewNavigationController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-5.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISRecordsViewNavigationController.h"

@implementation ISRecordsViewNavigationController

- (void)initTabBarItem
{
    //    UIImage* itemImage = [UIImage imageNamed:@"MyViewControllerImage.png"];
    UIImage* itemImage = nil;
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_RECORDS", nil) image:itemImage tag:TAG_RECORDSVIEW];
    self.tabBarItem = theItem;
    [theItem release];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initTabBarItem];
    }
    return self;
}

- (void)dealloc 
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBarHidden:TRUE];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end
