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

@synthesize userId, email, password, points, hops, trophies, apiToken;

+ (void)initObjectLoader
{
    RKObjectMapping* tUserMapping = [RKObjectMapping mappingForClass:[User class]];
	[tUserMapping mapKeyPath:@"id" toAttribute:@"userId"];
	[tUserMapping mapKeyPath:@"email" toAttribute:@"email"];
	[tUserMapping mapKeyPath:@"password" toAttribute:@"password"];
	[tUserMapping mapKeyPath:@"points" toAttribute:@"points"];
	[tUserMapping mapKeyPath:@"api_token" toAttribute:@"apiToken"];
    
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

    RKObjectMapping* tUserSerialization = [RKObjectMapping mappingForClass:[User class]];
    [tUserSerialization mapKeyPath:@"email" toAttribute:@"email"];
    [tUserSerialization mapKeyPath:@"password" toAttribute:@"password"];
    tUserSerialization.rootKeyPath = @"user";
    
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:tUserSerialization forClass:[User class]];
    
    [[RKObjectManager sharedManager].router routeClass:[User class] toResourcePath:@"/users" forMethod:RKRequestMethodPOST];
    [[RKObjectManager sharedManager].router routeClass:[User class] toResourcePath:@"/user" forMethod:RKRequestMethodGET];
    [[RKObjectManager sharedManager].router routeClass:[User class] toResourcePath:@"/user" forMethod:RKRequestMethodPUT];
}

@end
