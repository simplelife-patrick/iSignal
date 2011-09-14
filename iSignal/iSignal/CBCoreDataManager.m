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
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize fetchResultsControllerMap = _fetchResultsControllerMap;

+(void) initialize
{
    s_fetchedResultsControllerIdentifier_signalRecord = [[CBFetchedResultsControllerIdentifier alloc] initWithTableName:DB_TABLE_SIGNALRECORD fetchBatchSize:DB_FETCH_BTACH_SIZE ascending:DB_ASCENDING descriptorName:DB_TABLE_SIGNALRECORD_FIELD_TIME tableCacheName:DB_TABLE_SIGNALRECORD_CACHE];
}

// Methods derived from NSObject
- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        [self initModule];
        _fetchResultsControllerMap = [NSMutableDictionary dictionary];
    }
    
    return self;
}

-(void) dealloc
{
    [self releaseModule];
    
    [self.callbackDelegate release];
    [_persistentStoreCoordinator release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_fetchResultsControllerMap release];
    
    [super dealloc];
}

// Methods derived from CBModule protocol
-(void) initModule
{
    [self setModuleIdentity:MODULE_IDENTITY_COREDATA_MANAGER];
    [self.serviceThread setName:MODULE_IDENTITY_COREDATA_MANAGER];
    
    [self getFetchedResultsController:s_fetchedResultsControllerIdentifier_signalRecord];
    
    [self setKeepAlive:FALSE];    
}

-(void) releaseModule
{
    [self.serviceThread release];
    [self.moduleIdentity release];
}

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
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *) managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iSignal" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[CBEnvironmentUtils applicationDocumentsDirectory] URLByAppendingPathComponent:@"iSignal.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
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
        // TODO:
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

-(NSFetchedResultsController*) getFetchedResultsController:(CBFetchedResultsControllerIdentifier *)identifier
{
    NSFetchedResultsController* frController = nil;
    
    if (nil != identifier)
    {
        frController = [_fetchResultsControllerMap objectForKey:identifier];
        
        if (!frController) 
        {
            /*
             Set up the fetched results controller.
             */
            // Create the fetch request for the entity.
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            // Edit the entity name as appropriate.
            NSEntityDescription *entity = [NSEntityDescription entityForName:identifier.tableName inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            // Set the batch size to a suitable number.
            [fetchRequest setFetchBatchSize:identifier.fetchBatchSize];
            
            // Edit the sort key as appropriate.
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:identifier.descriptorName ascending:identifier.ascending];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            // Edit the section name key path and cache name if appropriate.
            // nil for section name key path means "no sections".
            NSFetchedResultsController *tempController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:identifier.tableCacheName];
            tempController.delegate = identifier.delegate;
            frController = tempController;
            
            [tempController release];
            [fetchRequest release];
            [sortDescriptor release];
            [sortDescriptors release];            
            
            [_fetchResultsControllerMap setObject:frController forKey:identifier];
            
            NSError *error = nil;
            if (![frController performFetch:&error])
            {
                /*
                 Replace this implementation with code to handle the error appropriately.
                 
                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
                 */
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }            
        } 
    }
    
    return frController;
}

// Manual Codes End

@end
