//
//  ISMapViewNavigationController.m
//  iSignal
//
//  Created by Patrick Deng on 12-3-5.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "ISMapViewNavigationController.h"

@implementation ISMapViewNavigationController

- (void)initTabBarItem
{
    //    UIImage* itemImage = [UIImage imageNamed:@"MyViewControllerImage.png"];
    UIImage* itemImage = nil;
    UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"STR_TAB_MAP", nil) image:itemImage tag:TABVIEW_INDEX_MAPVIEW];
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
