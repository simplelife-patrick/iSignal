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


CBFetchedResultsControllerIdentifier* gFetchedResultsControllerIdentifier_signalRecord;

@interface ISCoreDataModule : CBModuleAbstractImpl

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) NSMutableDictionary* fetchedResultsControllerMap;

-(NSFetchedResultsController*) obtainFetchedResultsController:(CBFetchedResultsControllerIdentifier*) identifier;

-(void) registerNSFetchedResultsControllerDelegate:(CBFetchedResultsControllerIdentifier*) frcIdentifier andDelegate:(NSObject<NSFetchedResultsControllerDelegate>*) delegate;

@end
