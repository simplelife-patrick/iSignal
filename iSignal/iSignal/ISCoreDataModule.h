//
//  ISCoreDataModule.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-9.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "CBModuleAbstractImpl.h"

#import "CBEnvironmentUtils.h"
#import "CBFetchedResultsControllerIdentifier.h"

#import "CBDateUtils.h"

#define MODULE_IDENTITY_COREDATA_MANAGER @"CoreDataManager"

#define DB_ISIGNAL_PATH_COMPONENT @"iSignal.sqlite"
#define DB_ISIGNAL_MANAGEMENT_MODEL_NAME @"iSignal"
#define DB_ISIGNAL_MANAGEMENT_MODEL_EXTENSION @"momd"
#define DB_TABLE_SIGNALRECORD_CACHE @"SignalRecord_CoreData_Cache"
#define DB_TABLE_SIGNALRECORD @"SignalRecord"
#define DB_TABLE_SIGNALRECORD_FIELD_DURATION @"duration"
#define DB_TABLE_SIGNALRECORD_FIELD_TIME @"time"
#define DB_TABLE_SIGNALRECORD_FIELD_ISSYNC @"isSync"
#define DB_TABLE_SIGNALRECORD_FIELD_LATITUDE @"latitude"
#define DB_TABLE_SIGNALRECORD_FIELD_LONGITUDE @"longitude"
#define DB_TABLE_SIGNALRECORD_FIELD_TAG @"tag"
#define DB_TABLE_SIGNALRECORD_FIELD_TYPE @"type"

#define DB_TABLE_SIGNALRECORD_VALUE_NOSIGNAL QUALITY_SIGNAL_NO
#define DB_TABLE_SIGNALRECORD_VALUE_NULL @"N/A"
#define DB_FETCH_BTACH_SIZE 20
#define DB_ASCENDING NO

CBFetchedResultsControllerIdentifier* gFetchedResultsControllerIdentifier_signalRecord;

@interface ISCoreDataModule : CBModuleAbstractImpl

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) NSMutableDictionary* fetchedResultsControllerMap;

-(NSFetchedResultsController*) obtainFetchedResultsController:(CBFetchedResultsControllerIdentifier*) identifier;

-(void) registerNSFetchedResultsControllerDelegate:(CBFetchedResultsControllerIdentifier*) frcIdentifier andDelegate:(NSObject<NSFetchedResultsControllerDelegate>*) delegate;

@end
