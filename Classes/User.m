//
//  User.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize userId, email, password, points, hops;

+ (void)initObjectLoader
{
    RKObjectMapping* tUserMapping = [RKObjectMapping mappingForClass:[User class]];
	[tUserMapping mapKeyPath:@"id" toAttribute:@"userId"];
	[tUserMapping mapKeyPath:@"email" toAttribute:@"email"];
	[tUserMapping mapKeyPath:@"password" toAttribute:@"password"];
	[tUserMapping mapKeyPath:@"points" toAttribute:@"points"];

    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tUserMapping forKeyPath:@"user"];
}

@end
