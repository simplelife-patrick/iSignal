//
//  CBFetchedResultsControllerIdentifier.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-13.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBFetchedResultsControllerIdentifier : NSObject <NSCopying>

@property (nonatomic, retain) NSString* tableName;
@property (nonatomic) NSInteger fetchBatchSize;
@property (nonatomic) BOOL ascending;
@property (nonatomic, retain) NSString* descriptorName;
@property (nonatomic, retain) NSString* tableCacheName;
@property (nonatomic, retain) id<NSFetchedResultsControllerDelegate> delegate;

- (id)initWithTableName:(NSString*) table fetchBatchSize:(NSInteger) size ascending:(BOOL) isAscending descriptorName:(NSString*) descriptor tableCacheName:(NSString*) tableCache;

@end
