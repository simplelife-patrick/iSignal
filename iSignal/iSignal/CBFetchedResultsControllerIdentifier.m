//
//  CBFetchedResultsControllerIdentifier.m
//  iSignal
//
//  Created by Patrick Deng on 11-9-13.
//  Copyright 2011年 CodeBeaver. All rights reserved.
//

#import "CBFetchedResultsControllerIdentifier.h"

@implementation CBFetchedResultsControllerIdentifier

@synthesize tableName;
@synthesize fetchBatchSize;
@synthesize ascending;
@synthesize descriptorName;
@synthesize tableCacheName;
@synthesize delegate;

// Manual Codes Begin

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithTableName:(NSString*) table fetchBatchSize:(NSInteger) size ascending:(BOOL) isAscending descriptorName:(NSString*) descriptor tableCacheName:(NSString*) tableCache
{
    self.tableName = table;
    self.fetchBatchSize = size;
    self.ascending = isAscending;
    self.descriptorName = descriptor;
    self.tableCacheName = tableCache;
    
    return [self init];
}

- (void) dealloc
{
    [self.tableName release];
    [self.descriptorName release];
    [self.tableCacheName release];
    [(NSObject*)self.delegate release]; // TODO: How to clear this warning?
    
    [super dealloc];
}

- (NSUInteger) hash
{
    return [tableName hash] ^ fetchBatchSize ^ ascending ^[descriptorName hash] ^ [tableCacheName hash];
}

- (BOOL) isEqual:(id)object
{
    if (!object && [object isKindOfClass:[CBFetchedResultsControllerIdentifier class]]) 
    {
        CBFetchedResultsControllerIdentifier *identifier = (CBFetchedResultsControllerIdentifier*)object;
        if ([self.tableCacheName isEqual:identifier.tableCacheName] && (self.fetchBatchSize == identifier.fetchBatchSize) && (self.ascending == identifier.ascending) && [self.descriptorName isEqual:identifier.descriptorName] && [self.tableCacheName isEqual:identifier.tableCacheName])
        {
            return YES;
        }
    }
    
    return NO;
}

// Method of NSCopying protocol
- (id)copyWithZone:(NSZone *)zone
{
    CBFetchedResultsControllerIdentifier *copy = [[[self class] allocWithZone: zone] init];
    copy.tableName = [[self.tableName copyWithZone:zone] autorelease];
    copy.fetchBatchSize = self.fetchBatchSize;
    copy.ascending = self.ascending;
    copy.descriptorName = [[self.descriptorName copyWithZone:zone] autorelease];
    copy.tableCacheName = [[self.tableCacheName copyWithZone:zone] autorelease];
    copy.delegate = self.delegate; 
    
    return copy;
}

// Manual Codes End

@end
