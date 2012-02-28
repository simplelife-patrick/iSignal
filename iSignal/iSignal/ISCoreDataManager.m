	//
//  ISCoreDataManager.m
//  iSignal
//
//  Created by Patrick Deng on 11-9-9.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import "ISCoreDataManager.h"

@implementation ISCoreDataManager

// Manual Codes Begin

// Members of CBModule protocol
@synthesize moduleIdentity;
@synthesize serviceThread;
@synthesize keepAlive;
@synthesize delegateList;

// Members of ISCoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsControllerMap = _fetchedResultsControllerMap;

// Static block
+(void) initialize
{
    gFetchedResultsControllerIdentifier_signalRecord = [[CBFetchedResultsControllerIdentifier alloc] initWithTableName:DB_TABLE_SIGNALRECORD fetchBatchSize:DB_FETCH_BTACH_SIZE ascending:DB_ASCENDING descriptorName:DB_TABLE_SIGNALRECORD_FIELD_TIME tableCacheName:DB_TABLE_SIGNALRECORD_CACHE];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

-(void) dealloc
{
    [self releaseModule];
    
    [_persistentStoreCoordinator release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_fetchedResultsControllerMap release];
    
    [super dealloc];
}

// Deprecated, instead of -(void) insertNewSignalRecord
- (void) insertNewManagedObject
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSFetchedResultsController *fetchedResultsController = [self obtainFetchedResultsController:gFetchedResultsControllerIdentifier_signalRecord];
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSFetchRequest *fetchRequest = [fetchedResultsController fetchRequest];
    NSEntityDescription *entity = [fetchRequest entity];
    
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];           
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    [newManagedObject setValue:0 forKey:DB_TABLE_SIGNALRECORD_FIELD_DURATION];
    [newManagedObject setValue:FALSE forKey:DB_TABLE_SIGNALRECORD_FIELD_ISSYNC];
    
    NSDate *time = [NSDate date];
    [newManagedObject setValue:time forKey:DB_TABLE_SIGNALRECORD_FIELD_TIME];
    
    [newManagedObject setValue:DB_TABLE_SIGNALRECORD_VALUE_NULL forKey:DB_TABLE_SIGNALRECORD_FIELD_TAG];
    [newManagedObject setValue:DB_TABLE_SIGNALRECORD_VALUE_SIGNALLOSS forKey:DB_TABLE_SIGNALRECORD_FIELD_TYPE];
    
    if([ISAppConfigs isLocationOn])
    {
        CLLocation *currentLocation = [appDelegate.locationModule currentLocation];
        
        CLLocationDegrees latitude = currentLocation.coordinate.latitude;
        CLLocationDegrees longitude = currentLocation.coordinate.longitude;
        [newManagedObject setValue:[NSNumber numberWithDouble:latitude] forKey:DB_TABLE_SIGNALRECORD_FIELD_LATITUDE];
        [newManagedObject setValue:[NSNumber numberWithDouble:longitude] forKey:DB_TABLE_SIGNALRECORD_FIELD_LONGITUDE];
    }    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }      
}

- (void) insertNewSignalRecord
{
    iSignalAppDelegate *appDelegate = (iSignalAppDelegate*)[CBUIUtils getAppDelegate];           
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSFetchedResultsController *fetchedResultsController = [self obtainFetchedResultsController:gFetchedResultsControllerIdentifier_signalRecord];
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSFetchRequest *fetchRequest = [fetchedResultsController fetchRequest];
    NSEntityDescription *entity = [fetchRequest entity];    
    
    // Create an Instance of the SignalRecord Entity
    //
    NSManagedObjectModel *model = [entity managedObjectModel];
    NSEntityDescription *runEntity = [[model entitiesByName] objectForKey:DB_TABLE_SIGNALRECORD];
    SignalRecord *record = [[SignalRecord alloc] initWithEntity:runEntity insertIntoManagedObjectContext:context];   
    
    record.duration = 0;
    record.isSync = FALSE;
    record.time = [NSDate date];
    record.tag = DB_TABLE_SIGNALRECORD_VALUE_NULL;
    record.type = DB_TABLE_SIGNALRECORD_VALUE_SIGNALLOSS;
    
    if([ISAppConfigs isLocationOn])
    {
        CLLocation *currentLocation = appDelegate.locationModule.currentLocation;
        if(currentLocation)
        {
            CLLocationDegrees latitude = currentLocation.coordinate.latitude;
            record.latitude = [NSNumber numberWithDouble:latitude];
            CLLocationDegrees longitude = currentLocation.coordinate.longitude;
            record.longitude = [NSNumber numberWithDouble:longitude];
        }
        else
        {
            DLog(@"Current location is %@", currentLocation);
        }
    }
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }      
}


// Method of CBModule protocol
-(void) initModule
{    
    [self setModuleIdentity:MODULE_IDENTITY_COREDATA_MANAGER];
    [self.serviceThread setName:MODULE_IDENTITY_COREDATA_MANAGER];
    [self setKeepAlive:FALSE];
}

// Method of CBModule protocol
-(void) releaseModule
{
    [self.serviceThread release];
    [self.moduleIdentity release];
}

// Method of CBModule protocol
-(void) startService
{
    DLog(@"Module:%@ is going to start.", self.moduleIdentity);
    [NSFetchedResultsController deleteCacheWithName:DB_TABLE_SIGNALRECORD_CACHE];    
}

// Method of CBModule protocol
-(void) processService;
{
    DLog(@"Module:%@ is processing.", self.moduleIdentity);    
}

// Method of CBModule protocol
-(void) stopService;
{
    DLog(@"Module:%@ is going to stop.", self.moduleIdentity);
    [NSFetchedResultsController deleteCacheWithName:DB_TABLE_SIGNALRECORD_CACHE];
}

// Method of CBModule protocol
-(void) registerDelegate:(id<CBListenable>) delegate
{
    if(nil == delegate)
    {
        DLog(@"The delegate to be registered can not be nil.");
        return;
    }
    
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        if (tmpDelegate == delegate) 
        {
            DLog(@"The delegate: %@ is already in registered list.", delegate);
            return;
        }
    }
    
    [self.delegateList addObject:delegate];
}

// Method of CBModule protocol
-(void) unregisterDelegate:(id<CBListenable>) delegate
{
    if(nil == delegate)
    {
        DLog(@"The delegate to be registered can not be nil.");
        return;
    }
    
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        if (tmpDelegate == delegate) 
        {
            [self.delegateList removeObject:delegate];
            DLog(@"The delegate: %@ has been removed out from registered list.", delegate);
            return;
        }
    }    
}

// Method of CBModule protocol
-(void) unregisterAllDelegates
{
    [self.delegateList removeAllObjects];
}

// Method of CBModule protocol
-(void) notifyAllDelegates:(id) message
{
    for (id<CBListenable> tmpDelegate in self.delegateList)
    {
        [tmpDelegate messageCallback: message];
    }
}

// Method of CBModule protocol
-(void) messageCallback:(id) message
{
    if (nil == message)
    {
        return;
    }
    
    NSNumber *signalVal = (NSNumber*)message;
    SIGNAL_QUALITY qualityGrade = [CBTelephonyUtils evaluateSignalQuality:[signalVal intValue]];
    if (qualityGrade == QUALITY_SIGNAL_LOSS) 
    {
        [self performSelectorOnMainThread:@selector(insertNewSignalRecord) withObject:nil waitUntilDone:TRUE];
    }
}

// Methods derived from ISCoreDataManager
- (NSMutableDictionary *) fetchedResultsControllerMap
{
    if (nil != _fetchedResultsControllerMap) 
    {
        return _fetchedResultsControllerMap;
    }
    
//    _fetchResultsControllerMap = [NSMutableDictionary dictionary];
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
                 Replace this implementation with code to handle the error appropriately.
                 
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
