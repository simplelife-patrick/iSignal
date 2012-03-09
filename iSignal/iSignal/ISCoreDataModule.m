//
//  ISCoreDataModule.m
//  iSignal
//
//  Created by Patrick Deng on 11-9-9.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import "ISCoreDataModule.h"

@implementation ISCoreDataModule

// Manual Codes Begin

// Members of ISCoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsControllerMap = _fetchedResultsControllerMap;

// Static block
+(void) initialize
{
    gFetchedResultsControllerIdentifier_signalRecord = [[CBFetchedResultsControllerIdentifier alloc] initWithTableName:DB_TABLE_SIGNALRECORD fetchBatchSize:DB_TABLE_SIGNALRECORD_FETCH_BATCH_SIZE ascending:DB_TABLE_SIGNALRECORD_FETCH_ASCENDING descriptorName:DB_TABLE_SIGNALRECORD_FIELD_TIME tableCacheName:DB_TABLE_SIGNALRECORD_CACHE];
}

-(void) registerNSFetchedResultsControllerDelegate:(CBFetchedResultsControllerIdentifier*) frcIdentifier andDelegate:(NSObject<NSFetchedResultsControllerDelegate>*) delegate
{
    // Attach object reference of NSFetchedResultsController
    NSFetchedResultsController* _fetchedResultsController = [self obtainFetchedResultsController:gFetchedResultsControllerIdentifier_signalRecord];
    // Inject delegate(self) to NSFetchedResultsController object
    _fetchedResultsController.delegate = delegate;        
}

// Private method
- (void) insertNewSignalRecord:(NSNumber*) signalVal
{
    // Currently only no signal message will be saved into database.
    NSInteger intVal = [signalVal intValue];
    SIGNAL_QUALITY qualityGrade = [CBTelephonyUtils evaluateSignalQuality:intVal];
    if (qualityGrade != QUALITY_SIGNAL_NO) 
    {
        return;
    }
    
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];           
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSFetchedResultsController *fetchedResultsController = [self obtainFetchedResultsController:gFetchedResultsControllerIdentifier_signalRecord];
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSFetchRequest *fetchRequest = [fetchedResultsController fetchRequest];
    NSEntityDescription *entity = [fetchRequest entity];    
    
    // Create an Instance of the SignalRecord Entity
    NSManagedObjectModel *model = [entity managedObjectModel];
    NSEntityDescription *runEntity = [[model entitiesByName] objectForKey:DB_TABLE_SIGNALRECORD];
    SignalRecord *record = [[SignalRecord alloc] initWithEntity:runEntity insertIntoManagedObjectContext:context];   
    
    record.carrier = appDelegate.dummyTelephonyModule.carrier;    
    record.isSync = FALSE;
    record.time = [NSDate date];
    record.type = QUALITY_SIGNAL_NO;
    
    if([ISAppConfigs isLocationOn])
    {
        // TODO: A potential issue is if location module can not get the first location here, for example: the application just started.
        CLLocation *currentLocation = [appDelegate.locationModule obtainLocation];
        DLog(@"Current location is %@", currentLocation);
        if(currentLocation)
        {
            CLLocationDegrees latitude = currentLocation.coordinate.latitude;
            record.latitude = [NSNumber numberWithDouble:latitude];
            CLLocationDegrees longitude = currentLocation.coordinate.longitude;
            record.longitude = [NSNumber numberWithDouble:longitude];
        }
    }
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        /*
         TODO: Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }     
    
    [record release];
}

// Overrided Method of CBModuleAbstractImpl
-(void) initModule
{    
    [super initModule];
    
    [self setModuleIdentity:MODULE_ID_COREDATA];
    [self.serviceThread setName:MODULE_ID_COREDATA];
}

// Overrided Method of CBModuleAbstractImpl
-(void) releaseModule
{
    [super releaseModule];
    
    [_persistentStoreCoordinator release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_fetchedResultsControllerMap release];
}

// Overrided Method of CBModuleAbstractImpl
-(void) serviceWithCallingThread
{
    [super serviceWithCallingThread];
    [self listenSignalStrengthChanged];
    [NSFetchedResultsController deleteCacheWithName:DB_TABLE_SIGNALRECORD_CACHE];    
}

// Overrided Method of CBModuleAbstractImpl
-(void) stopService;
{
    [NSFetchedResultsController deleteCacheWithName:DB_TABLE_SIGNALRECORD_CACHE];
    
    [super stopService];
}

// Private method
-(void) listenSignalStrengthChanged
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSignalStrengthChanged:) name:
     NOTIFICATION_ID_SIGNALSTRENGTH_CHANGED object:nil];      
}

// Private method
-(void) onSignalStrengthChanged:(NSNotification *) notification
{
    NSValue *nsValue = [[notification userInfo] objectForKey:NOTIFICATION_KV_SIGNALSTRENGTH_CHANGED]; 
    NSNumber *signalVal = (NSNumber*)nsValue;
    [self performSelectorOnMainThread:@selector(insertNewSignalRecord:) withObject:(signalVal) waitUntilDone:YES];
}

- (NSMutableDictionary *) fetchedResultsControllerMap
{
    if (nil != _fetchedResultsControllerMap) 
    {
        return _fetchedResultsControllerMap;
    }
    
    _fetchedResultsControllerMap = [[NSMutableDictionary alloc] initWithCapacity:1];
    return _fetchedResultsControllerMap;
}

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
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:DB_ISIGNAL_MANAGEMENT_MODEL_NAME withExtension:DB_ISIGNAL_MANAGEMENT_MODEL_EXTENSION];
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
    
    NSURL *storeURL = [[CBEnvironmentUtils applicationDocumentsDirectory] URLByAppendingPathComponent:DB_ISIGNAL_PATH_COMPONENT];
    
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
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

-(NSFetchedResultsController*) obtainFetchedResultsController:(CBFetchedResultsControllerIdentifier *)identifier
{
    NSFetchedResultsController* frController = nil;
    
    if (nil != identifier)
    {
        frController = [self.fetchedResultsControllerMap objectForKey:identifier];
        
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
            frController = [tempController retain];
            
            [self.fetchedResultsControllerMap setObject:frController forKey:identifier];
            
            [tempController release];
            [fetchRequest release];
            [sortDescriptor release];
            [sortDescriptors release];
            
            NSError *error = nil;
            if (![frController performFetch:&error])
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
    
    return frController;
}

// Manual Codes End

@end
