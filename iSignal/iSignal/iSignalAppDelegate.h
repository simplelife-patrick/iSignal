//
//  iSignalAppDelegate.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-20.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ISSplashViewController.h"
#import "ISDummyTelephony.h"
#import "CBLocationDelegate.h"

@interface iSignalAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Manual Codes Begin

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ISSplashViewController *splashViewController;

@property (nonatomic, retain) ISDummyTelephony* dummnyTelephonyModule;
@property (nonatomic, retain) CBLocationDelegate* locationModule;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Manual Codes End

@end