//
//  CBCoreDataManager.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-9.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "CBModule.h"

#import "CBEnvironmentUtils.h"
#import "CBFetchedResultsControllerIdentifier.h"

#define MODULE_IDENTITY_COREDATA_MANAGER @"CoreDataManager"

#define DB_TABLE_SIGNALRECORD_CACHE @"SignalRecord_CoreData_Cache"
#define DB_TABLE_SIGNALRECORD @"SignalRecord"
#define DB_TABLE_SIGNALRECORD_FIELD_TIME @"time"
#define DB_TABLE_SIGNALRECORD_FIELD_ISSYNC @"isSync"
#define DB_TABLE_SIGNALRECORD_FIELD_LATITUDE @"latitude"
#define DB_TABLE_SIGNALRECORD_FIELD_LONGITUDE @"longitude"
#define DB_TABLE_SIGNALRECORD_FIELD_TAG @"tag"
#define DB_TABLE_SIGNALRECORD_FIELD_TYPE @"type"

#define DB_TABLE_SIGNALRECORD_VALUE_SIGNALLOSS 0
#define DB_FETCH_BTACH_SIZE 20
#define DB_ASCENDING NO

CBFetchedResultsControllerIdentifier* gFetchedResultsControllerIdentifier_signalRecord;

@interface CBCoreDataManager : NSObject <CBModule>

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) NSMutableDictionary* fetchResultsControllerMap;

-(NSFetchedResultsController*) getFetchedResultsController:(CBFetchedResultsControllerIdentifier*) identifier;

@end