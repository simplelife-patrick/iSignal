//
//  CBQuartzView.m
//  iSignal
//
//  Created by Patrick Deng on 12-4-7.
//  Copyright (c) 2012年 CodeBeaver. All rights reserved.
//

#import "CBQuartzView.h"

@implementation CBQuartzView

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if(self != nil)
	{
		self.backgroundColor = [UIColor blackColor];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = YES;
	}
	return self;
}

-(void) drawInContext:(CGContextRef)context
{
	// Default is to do nothing!
}

-(void) drawRect:(CGRect)rect
{
	// Since we use the CGContextRef a lot, it is convienient for our demonstration classes to do the real work
	// inside of a method that passes the context as a parameter, rather than having to query the context
	// continuously, or setup that parameter for every subclass.
	[self drawInContext:UIGraphicsGetCurrentContext()];
}

@end
