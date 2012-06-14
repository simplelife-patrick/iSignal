//
//  CBPlotGallery.h
//  iSignal
//
//  Created by Patrick Deng on 12-6-14.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBPlotItem.h"

@interface CBPlotGallery : NSObject
{
	NSMutableArray *plotItems;
}

+ (CBPlotGallery *)sharedPlotGallery;

- (void)addPlotItem:(CBPlotItem *)plotItem;

- (void)sortByTitle;
- (NSUInteger)count;
- (CBPlotItem *)objectAtIndex:(NSUInteger)index;

@end
