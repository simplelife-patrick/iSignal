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

@synthesize locationModule;
@synthesize dummyTelephonyModule;
@synthesize coreDataModule;
@synthesize audioModule;
@synthesize uiLocalNotificationModule;

- (void)dealloc
{
    [_window release];

    [super dealloc];
}

// In charge of checking two condition: is app "suspended in the background" or "frontmost"
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (notification) 
    {
        NSString* notificationType = [[notification userInfo] objectForKey:NOTIFICATION_TYPE];
        if ([notificationType isEqualToString: NOTIFICATION_NOSIGNAL]) 
        {
            ISSwitchViewController *switchController = self.splashViewController.switchViewController;
            [switchController setSelectedViewController:switchController.recordsViewController];
        }
    }
}

// In charge of checking another condition: app isn't running
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    application.applicationIconBadgeNumber = 0; 
    
    // UI load
    self.window.rootViewController = self.splashViewController.switchViewController;
    [self.window addSubview:self.splashViewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    
    // TODO: Stop all modules' serive here.
    [self.dummyTelephonyModule stopService];
    [self.uiLocalNotificationModule stopService];    
    [self.locationModule stopService];
    [self.coreDataModule stopService];
    [self.audioModule stopService];
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

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.coreDataModule.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             TODO: Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
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

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [CBEnvironmentUtils applicationDocumentsDirectory];
}

@end
