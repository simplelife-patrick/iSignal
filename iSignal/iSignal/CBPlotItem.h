//
//  CBPlotItem.h
//  iSignal
//
//  Created by Patrick Deng on 12-6-14.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPTGraph;
@class CPTTheme;

@interface CBPlotItem : NSObject
{
    CPTGraphHostingView *defaultLayerHostingView;
    NSMutableArray *graphs;
    NSString *title;
    
    CPTNativeImage *cachedImage;
}

@property (nonatomic, retain) CPTGraphHostingView *defaultLayerHostingView;
@property (nonatomic, retain) NSMutableArray *graphs;
@property (nonatomic, retain) NSString *title;


+ (void)registerPlotItem:(id)item;

- (void)renderInView:(UIView *)hostingView withTheme:(CPTTheme *)theme;

- (CPTNativeImage *)image;

- (void)renderInLayer:(CPTGraphHostingView *)layerHostingView withTheme:(CPTTheme *)theme;

- (void)setTitleDefaultsForGraph:(CPTGraph *)graph withBounds:(CGRect)bounds;
- (void)setPaddingDefaultsForGraph:(CPTGraph *)graph withBounds:(CGRect)bounds;

- (void)reloadData;
- (void)applyTheme:(CPTTheme *)theme toGraph:(CPTGraph *)graph withDefault:(CPTTheme *)defaultTheme;

- (void)addGraph:(CPTGraph *)graph;
- (void)addGraph:(CPTGraph *)graph toHostingView:(CPTGraphHostingView *)layerHostingView;
- (void)killGraph;

- (void)generateData;

- (NSComparisonResult)titleCompare:(CBPlotItem *)other;

@end
