//
//  SignalRecord.h
//  iSignal
//
//  Created by Patrick Deng on 11-9-5.
//  Copyright (c) 2011年 CodeBeaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SignalRecord : NSManagedObject 
{
@private
}

@property (nonatomic, retain) NSNumber * isSync;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * type;

@end
