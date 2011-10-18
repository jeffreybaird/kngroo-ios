//
//  Hop.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "Hop.h"
#import "Venue.h"


@implementation Hop

@synthesize hopId, title, venues, points;

+ (void)initObjectLoader
{
    RKObjectMapping* tHopMapping = [RKObjectMapping mappingForClass:[Hop class]];
	[tHopMapping mapKeyPath:@"id" toAttribute:@"hopId"];
	[tHopMapping mapKeyPath:@"title" toAttribute:@"title"];
    [tHopMapping mapKeyPath:@"points" toAttribute:@"points"];

    RKObjectMapping* tVenueMapping = [RKObjectMapping mappingForClass:[Venue class]];
	[tVenueMapping mapKeyPath:@"id" toAttribute:@"venueId"];
	[tVenueMapping mapKeyPath:@"name" toAttribute:@"name"];

	[tHopMapping mapKeyPath:@"venues" toRelationship:@"venues" withMapping:tVenueMapping];
    
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tHopMapping forKeyPath:@"hop"];
}

@end
