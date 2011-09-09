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

#define MODULE_IDENTITY_COREDATA_MANAGER @"CoreDataManager"

@interface CBCoreDataManager : NSObject <CBModule>

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
