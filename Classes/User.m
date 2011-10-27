//
//  User.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "User.h"
#import "Trophy.h"


@implementation User

@synthesize userId, email, password, points, hops, trophies;

+ (void)initObjectLoader
{
    RKObjectMapping* tUserMapping = [RKObjectMapping mappingForClass:[User class]];
	[tUserMapping mapKeyPath:@"id" toAttribute:@"userId"];
	[tUserMapping mapKeyPath:@"email" toAttribute:@"email"];
	[tUserMapping mapKeyPath:@"password" toAttribute:@"password"];
	[tUserMapping mapKeyPath:@"points" toAttribute:@"points"];
    
    RKObjectMapping* tTrophyMapping = [RKObjectMapping mappingForClass:[Trophy class]];
    [tTrophyMapping mapKeyPath:@"id" toAttribute:@"trophyId"];
    [tTrophyMapping mapKeyPath:@"user_id" toAttribute:@"userId"];
    [tTrophyMapping mapKeyPath:@"hop_id" toAttribute:@"hopId"];
    [tTrophyMapping mapKeyPath:@"created_at" toAttribute:@"createdAt"];
    
    RKObjectMapping* tHopMapping = [RKObjectMapping mappingForClass:[Hop class]];
    [tHopMapping mapKeyPath:@"title" toAttribute:@"title"];
    
    [tTrophyMapping mapKeyPath:@"hop" toRelationship:@"hop" withMapping:tHopMapping];
    
    [tUserMapping mapKeyPath:@"trophies" toRelationship:@"trophies" withMapping:tTrophyMapping];

    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tUserMapping forKeyPath:@"user"];
}

@end
