//
//  Venue.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface Venue : NSObject <RKLoadable> {

	NSNumber* venueId;
	NSString* name;
    NSString* address;
	NSNumber* lat;
	NSNumber* lng;
    NSString* summary;
	
}

@property (retain) NSNumber* venueId;
@property (retain) NSString* name;
@property (retain) NSString* address;
@property (retain) NSNumber* lat;
@property (retain) NSNumber* lng;
@property (retain) NSString* summary;

@end
