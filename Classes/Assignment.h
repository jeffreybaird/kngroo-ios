//
//  Assignment.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/23/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hop.h"


@interface Assignment : NSObject <RKLoadable> {
    
    NSNumber* assignmentId;
    NSNumber* complete;
    NSNumber* hopId;
    Hop* hop;
    NSArray* checkins;
    
}

@property (retain) NSNumber* assignmentId;
@property (retain) NSNumber* complete;
@property (retain) NSNumber* hopId;
@property (retain) Hop* hop;
@property (retain) NSArray* checkins;

@end
