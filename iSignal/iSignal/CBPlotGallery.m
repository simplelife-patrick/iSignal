//
//  CBPlotGallery.m
//  iSignal
//
//  Created by Patrick Deng on 12-6-14.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "CBPlotGallery.h"

static CBPlotGallery *sharedPlotGallery = nil;

@implementation CBPlotGallery

+ (CBPlotGallery *)sharedPlotGallery
{
	@synchronized(self)
	{
		if (nil == sharedPlotGallery) 
        {
			sharedPlotGallery = [[self alloc] init];
		}
	}
	return sharedPlotGallery;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self)
	{
		if (nil == sharedPlotGallery) 
        {
			return [super allocWithZone:zone];
		}
	}
	return sharedPlotGallery;
}

- (id)init
{
	Class thisClass = [self class];
    
	@synchronized(thisClass)
	{
		if (nil == sharedPlotGallery) 
        {
			if ( (self = [super init]) ) 
            {
				sharedPlotGallery = self;
				plotItems = [[NSMutableArray alloc] init];
			}
		}
	}
    
	return sharedPlotGallery;
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain
{
	return self;
}

- (NSUInteger)retainCount
{
	return UINT_MAX;
}

- (oneway void)release
{
}

- (id)autorelease
{
	return self;
}

- (void)addPlotItem:(CBPlotItem *)plotItem
{
	[plotItems addObject:plotItem];
}

- (NSUInteger)count
{
	return [plotItems count];
}

- (CBPlotItem *)objectAtIndex:(NSUInteger)index
{
	return [plotItems objectAtIndex:index];
}

- (void)sortByTitle
{
	[plotItems sortUsingSelector:@selector(titleCompare:)];
}

@end
