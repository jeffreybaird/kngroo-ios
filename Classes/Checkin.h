//
//  Checkin.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/20/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface Checkin : NSObject <RKLoadable> {
    
    NSNumber* checkinId;
    NSNumber* assignmentId;
    NSNumber* venueId;
    NSDate* createdAt;
    NSNumber* trophyAwarded;
    
}

@property (retain) NSNumber* checkinId;
@property (retain) NSNumber* assignmentId;
@property (retain) NSNumber* venueId;
@property (retain) NSDate* createdAt;
@property (retain) NSNumber* trophyAwarded;

@end
