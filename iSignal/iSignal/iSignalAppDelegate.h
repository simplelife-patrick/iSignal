//
//  iSignalAppDelegate.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-20.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CBEnvironmentUtils.h"

#import "ISSplashViewController.h"

// Import module headers
#import "CBLocationManager.h"
#import "CBAVManager.h"
#import "ISDummyTelephony.h"
#import "ISCoreDataManager.h"

@interface iSignalAppDelegate : NSObject <UIApplicationDelegate>

// Manual Codes Begin

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ISSplashViewController *splashViewController;

@property (nonatomic, retain) CBAVManager* avModule;
@property (nonatomic, retain) CBLocationManager* locationModule;
@property (nonatomic, retain) ISDummyTelephony* dummyTelephonyModule;
@property (nonatomic, retain) ISCoreDataManager* coreDataModule;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Manual Codes End

@end