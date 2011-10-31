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

@synthesize assignmentId, complete, hopId, hop, checkins;

+ (void)initObjectLoader
{
    RKObjectMapping* tAssignmentMapping = [RKObjectMapping mappingForClass:[Assignment class]];
    [tAssignmentMapping mapKeyPath:@"id" toAttribute:@"assignmentId"];
    [tAssignmentMapping mapKeyPath:@"complete" toAttribute:@"complete"];
    [tAssignmentMapping mapKeyPath:@"hop_id" toAttribute:@"hopId"];
    
    RKObjectMapping* tHopMapping = [RKObjectMapping mappingForClass:[Hop class]];
	[tHopMapping mapKeyPath:@"id" toAttribute:@"hopId"];
	[tHopMapping mapKeyPath:@"title" toAttribute:@"title"];
    [tHopMapping mapKeyPath:@"points" toAttribute:@"points"];
    
    RKObjectMapping* tVenueMapping = [RKObjectMapping mappingForClass:[Venue class]];
	[tVenueMapping mapKeyPath:@"id" toAttribute:@"venueId"];
	[tVenueMapping mapKeyPath:@"name" toAttribute:@"name"];
	[tVenueMapping mapKeyPath:@"lat" toAttribute:@"lat"];
	[tVenueMapping mapKeyPath:@"lng" toAttribute:@"lng"];
    
	[tHopMapping mapKeyPath:@"venues" toRelationship:@"venues" withMapping:tVenueMapping];
    
    RKObjectMapping* tCheckinMapping = [RKObjectMapping mappingForClass:[Checkin class]];
	[tCheckinMapping mapKeyPath:@"id" toAttribute:@"checkinId"];
	[tCheckinMapping mapKeyPath:@"venue_id" toAttribute:@"venueId"];
	[tCheckinMapping mapKeyPath:@"created_at" toAttribute:@"createdAt"];
    
    [tAssignmentMapping mapKeyPath:@"hop" toRelationship:@"hop" withMapping:tHopMapping];
	[tAssignmentMapping mapKeyPath:@"checkins" toRelationship:@"checkins" withMapping:tCheckinMapping];
    
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tAssignmentMapping forKeyPath:@"assignment"];
    
    RKObjectMapping* tAssignmentSerialization = [RKObjectMapping mappingForClass:[Assignment class]];
    [tAssignmentSerialization mapKeyPath:@"hopId" toAttribute:@"hop_id"];
    tAssignmentSerialization.rootKeyPath = @"assignment";
    
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:tAssignmentSerialization forClass:[Assignment class]];
    
    [[RKObjectManager sharedManager].router routeClass:[Assignment class] toResourcePath:@"/user/assignments" forMethod:RKRequestMethodPOST];
    [[RKObjectManager sharedManager].router routeClass:[Assignment class] toResourcePath:@"/user/assignments/:assignmentId" forMethod:RKRequestMethodDELETE];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"hop:%@ complete:%@",hop,complete];
}

@end
