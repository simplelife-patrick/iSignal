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
    return [tableName hash] ^ fetchBatchSize ^ ascending ^[descriptorName hash] ^ [tableCacheName hash] ^ [(NSObject*)delegate hash]; // TODO: How to clear this warning?
}

- (BOOL) isEqual:(id)object
{
    if (!object && [object isKindOfClass:[CBFetchedResultsControllerIdentifier class]]) 
    {
        CBFetchedResultsControllerIdentifier *identifier = (CBFetchedResultsControllerIdentifier*)object;
        if ([self.tableCacheName isEqual:identifier.tableCacheName] && (self.fetchBatchSize == identifier.fetchBatchSize) && (self.ascending == identifier.ascending) && [self.descriptorName isEqual:identifier.descriptorName] && [self.tableCacheName isEqual:identifier.tableCacheName] && (self.delegate == identifier.delegate))
        {
            return YES;
        }
    }
    
    return NO;
}

// Manual Codes End

@end
