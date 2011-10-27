//
//  Hop.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "Hop.h"
#import "Venue.h"
#import "Checkin.h"


@implementation Hop

@synthesize hopId, categoryId, title, venues, points, featured;

+ (void)initObjectLoader
{
    RKObjectMapping* tHopMapping = [RKObjectMapping mappingForClass:[Hop class]];
	[tHopMapping mapKeyPath:@"id" toAttribute:@"hopId"];
	[tHopMapping mapKeyPath:@"category_id" toAttribute:@"categoryId"];
	[tHopMapping mapKeyPath:@"title" toAttribute:@"title"];
    [tHopMapping mapKeyPath:@"points" toAttribute:@"points"];
    [tHopMapping mapKeyPath:@"featured" toAttribute:@"featured"];

    RKObjectMapping* tVenueMapping = [RKObjectMapping mappingForClass:[Venue class]];
	[tVenueMapping mapKeyPath:@"id" toAttribute:@"venueId"];
	[tVenueMapping mapKeyPath:@"name" toAttribute:@"name"];
	[tVenueMapping mapKeyPath:@"address" toAttribute:@"address"];
	[tVenueMapping mapKeyPath:@"lat" toAttribute:@"lat"];
	[tVenueMapping mapKeyPath:@"lng" toAttribute:@"lng"];

	[tHopMapping mapKeyPath:@"venues" toRelationship:@"venues" withMapping:tVenueMapping];

    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tHopMapping forKeyPath:@"hop"];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ venues:%d points:%@ featured:%@",title,venues.count,points,featured];
}

@end
