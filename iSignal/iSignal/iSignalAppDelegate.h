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

#import "ISDummyTelephonyModule.h"
#import "ISCoreDataModule.h"
#import "ISAudioModule.h"
#import "ISUILocalNotificationModule.h"

@interface iSignalAppDelegate : NSObject <UIApplicationDelegate>

// Manual Codes Begin

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ISSplashViewController *splashViewController;

@property (nonatomic, retain) CBLocationManager* locationModule;

@property (nonatomic, retain) ISDummyTelephonyModule* dummyTelephonyModule;
@property (nonatomic, retain) ISCoreDataModule* coreDataModule;
@property (nonatomic, retain) ISAudioModule* audioModule;
@property (nonatomic, retain) ISUILocalNotificationModule* uiLocalNotificationModule;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Manual Codes End

@end