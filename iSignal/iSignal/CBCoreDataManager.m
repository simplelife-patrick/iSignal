//
//  CBCoreDataManager.m
//  iSignal
//
//  Created by Patrick Deng on 11-9-9.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import "CBCoreDataManager.h"

@implementation CBCoreDataManager

// Manual Codes Begin

// Members of CBMoudle protocol.
@synthesize keepAlive;
@synthesize serviceThread;
@synthesize moduleIdentity;
@synthesize callbackDelegate;

// Members of CBCoreDataManager.
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

// Methods derived from NSObject
- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        [self setModuleIdentity:MODULE_IDENTITY_COREDATA_MANAGER];
        [self.serviceThread setName:MODULE_IDENTITY_COREDATA_MANAGER];
        
        [self setKeepAlive:FALSE];        
    }
    
    return self;
}

-(void) dealloc
{
    [self.serviceThread release];
    [self.callbackDelegate release];
    
    [self.persistentStoreCoordinator release];
    [self.managedObjectContext release];
    [self.managedObjectModel release];
    
    [super dealloc];
}

// Methods derived from CBModule protocol
-(void) startService
{
    DLog(@"Module:%@ is going to start.", self.moduleIdentity);
}

-(void) processService;
{
    DLog(@"Module:%@ is processing.", self.moduleIdentity);    
}

-(void) stopService;
{
    DLog(@"Module:%@ is going to stop.", self.moduleIdentity);    
}

// Methods derived from CBCoreDataManager
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *) managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iSignal" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[CBEnvironmentUtils applicationDocumentsDirectory] URLByAppendingPathComponent:@"iSignal.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

// Manual Codes End

@end
