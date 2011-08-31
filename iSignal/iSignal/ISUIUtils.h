//
//  ISUIUtils.h
//  iSignal
//
//  Created by Patrick Deng on 11-8-22.
//  Copyright 2011 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ISUIUtils : NSObject
{
    
}

+(UIViewController*) getViewControllerFromView:(UIView*) view;

+(UIWindow*) getWindow:(UIView*) view;

@end
