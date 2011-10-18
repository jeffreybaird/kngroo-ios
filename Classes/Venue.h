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
	NSNumber* lat;
	NSNumber* lng;
	
}

@property (retain) NSNumber* venueId;
@property (retain) NSString* name;
@property (retain) NSNumber* lat;
@property (retain) NSNumber* lng;

@end
