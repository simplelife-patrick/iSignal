//
//  iSignalAppDelegate.m
//  iSignal
//
//  Created by Patrick Deng on 11-8-20.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import "iSignalAppDelegate.h"

@implementation iSignalAppDelegate

@synthesize window = _window;

// Manual Codes Begin

@synthesize splashViewController;

@synthesize dummnyTelephonyModule;
@synthesize locationModule;
@synthesize coreDataModule;

- (void)dealloc
{
    [self.splashViewController release];
    
    [self.dummnyTelephonyModule release];
    [self.locationModule release];
    [self.coreDataModule release];
    
    [_window release];

    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // UI load
    self.window.rootViewController = splashViewController.switchViewController;
    [self.window addSubview:splashViewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    
    // TODO: Stop all modules' serive here.
    
    // ISDummyTelephony module stops
    [self.dummnyTelephonyModule stopService];
    // CBLocation module stops 
    [self.locationModule stopService];
    // ISCoreDataManager stops
    [self.coreDataModule stopService];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    //    // Run a Finity-Long background task
    //    UIApplication*    app = [UIApplication sharedApplication];
    //    
    //    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
    //        [app endBackgroundTask:bgTask];
    //        bgTask = UIBackgroundTaskInvalid;
    //    }];
    //    
    //    // Start the long-running task and return immediately.
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        
    //        // Do the work associated with the task.
    //        
    //        [app endBackgroundTask:bgTask];
    //        bgTask = UIBackgroundTaskInvalid;
    //    });    
}

// Manual Codes End

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.coreDataModule.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [CBEnvironmentUtils applicationDocumentsDirectory];
}

@end
