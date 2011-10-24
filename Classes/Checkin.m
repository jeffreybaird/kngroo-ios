//
//  Checkin.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/20/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "Checkin.h"

@implementation Checkin

@synthesize checkinId, assignmentId, venueId, createdAt, trophyAwarded;

+ (void)initObjectLoader
{
    RKObjectRouter* tRouter = [RKObjectManager sharedManager].router;
    [tRouter routeClass:[Checkin class] toResourcePath:@"/user/assignments/:assignmentId/venues/:venueId/checkins" forMethod:RKRequestMethodPOST];
    
    RKObjectMapping* tCheckinSerialization = [RKObjectMapping mappingForClass:[Checkin class]];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:tCheckinSerialization forClass:[Checkin class]];
    
    RKObjectMapping* tCheckinMapping = [RKObjectMapping mappingForClass:[Checkin class]];
    [tCheckinMapping mapKeyPath:@"id" toAttribute:@"checkinId"];
    [tCheckinMapping mapKeyPath:@"assignment_id" toAttribute:@"assignmentId"];
    [tCheckinMapping mapKeyPath:@"venue_id" toAttribute:@"venueId"];
    [tCheckinMapping mapKeyPath:@"trophy_awarded" toAttribute:@"trophyAwarded"];
    [[RKObjectManager sharedManager].mappingProvider setMapping:tCheckinMapping forKeyPath:@"checkin"];
}

@end
