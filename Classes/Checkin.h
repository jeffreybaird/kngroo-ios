//
//  Checkin.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/20/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checkin : NSObject {
    
    NSNumber* checkinId;
    NSNumber* hopId;
    NSNumber* venueId;
    
}

@property (retain) NSNumber* checkinId;
@property (retain) NSNumber* hopId;
@property (retain) NSNumber* venueId;

@end
