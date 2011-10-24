//
//  Assignment.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/23/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "Assignment.h"
#import "Hop.h"
#import "Venue.h"
#import "Checkin.h"


@implementation Assignment

@synthesize assignmentId, complete, hop;

+ (void)initObjectLoader
{
    RKObjectMapping* tAssignmentMapping = [RKObjectMapping mappingForClass:[Assignment class]];
    [tAssignmentMapping mapKeyPath:@"id" toAttribute:@"assignmentId"];
    [tAssignmentMapping mapKeyPath:@"complete" toAttribute:@"complete"];
    
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
	[tCheckinMapping mapKeyPath:@"assignment_id" toAttribute:@"assignmentId"];
    
    [tAssignmentMapping mapKeyPath:@"hop" toRelationship:@"hop" withMapping:tHopMapping];
	[tAssignmentMapping mapKeyPath:@"checkins" toRelationship:@"checkins" withMapping:tCheckinMapping];
    
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tAssignmentMapping forKeyPath:@"assignment"];
}

@end
