//
//  CBFetchedResultsControllerIdentifier.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-13.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBFetchedResultsControllerIdentifier : NSObject <NSCopying>

@property (nonatomic, copy) NSString* tableName;
@property (nonatomic, copy) NSString* descriptorName;
@property (nonatomic, copy) NSString* tableCacheName;

@property (nonatomic) NSInteger fetchBatchSize;
@property (nonatomic) BOOL ascending;

@property (nonatomic, assign) id<NSFetchedResultsControllerDelegate> delegate;

- (id)initWithTableName:(NSString*) table fetchBatchSize:(NSInteger) size ascending:(BOOL) isAscending descriptorName:(NSString*) descriptor tableCacheName:(NSString*) tableCache;

@end
