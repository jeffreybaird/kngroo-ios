//
//  Venue.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "Venue.h"


@implementation Venue

@synthesize venueId, name, address, lat, lng, phone, summary;

+ (void)initObjectLoader
{
    RKObjectMapping* tVenueMapping = [RKObjectMapping mappingForClass:[Venue class]];
	[tVenueMapping mapKeyPath:@"id" toAttribute:@"venueId"];
	[tVenueMapping mapKeyPath:@"name" toAttribute:@"name"];
	[tVenueMapping mapKeyPath:@"address" toAttribute:@"address"];
	[tVenueMapping mapKeyPath:@"lat" toAttribute:@"lat"];
	[tVenueMapping mapKeyPath:@"lng" toAttribute:@"lng"];
	[tVenueMapping mapKeyPath:@"phone" toAttribute:@"phone"];
    [tVenueMapping mapKeyPath:@"description" toAttribute:@"summary"];
    
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tVenueMapping forKeyPath:@"venue"];
}

@end
