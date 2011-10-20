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

@synthesize hopId, title, venues, points, checkins;

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

    RKObjectMapping* tCheckinMapping = [RKObjectMapping mappingForClass:[Checkin class]];
	[tCheckinMapping mapKeyPath:@"id" toAttribute:@"checkinId"];
	[tCheckinMapping mapKeyPath:@"hop_id" toAttribute:@"hopId"];
	[tCheckinMapping mapKeyPath:@"venue_id" toAttribute:@"venueId"];
    
	[tHopMapping mapKeyPath:@"checkins" toRelationship:@"checkins" withMapping:tCheckinMapping];

    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tHopMapping forKeyPath:@"hop"];
}

- (BOOL)isComplete
{
    BOOL tComplete = YES;
    for (Venue* venue in venues) {
        BOOL tVenueMatch = NO;
        for (Checkin* checkin in checkins) {
            if( [checkin.venueId intValue]==[venue.venueId intValue] ) {
                tVenueMatch = YES;
                break;
            }
        }
        if( !tVenueMatch ) {
            tComplete = NO;
            break;
        }
    }
    return tComplete;
}

@end
