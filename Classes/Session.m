//
//  Session.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "Session.h"

@implementation Session

@synthesize email, password, userId, apiToken;

+ (Session*)sessionWithEmail:(NSString*)aEmail password:(NSString*)aPassword
{
    Session* tSession = [[[Session alloc] init] autorelease];
    tSession.email = aEmail;
    tSession.password = aPassword;
    return tSession;
}

+ (void)initObjectLoader
{
    RKObjectMapping* tSessionMapping = [RKObjectMapping mappingForClass:[Session class]];
    [tSessionMapping mapKeyPath:@"user_id" toAttribute:@"userId"];
    [tSessionMapping mapKeyPath:@"api_token" toAttribute:@"apiToken"];
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tSessionMapping forKeyPath:@"session"];
    
    RKObjectMapping* tSessionSerialization = [RKObjectMapping mappingForClass:[Session class]];
    [tSessionSerialization mapKeyPath:@"email" toAttribute:@"email"];
    [tSessionSerialization mapKeyPath:@"password" toAttribute:@"password"];
    tSessionSerialization.rootKeyPath = @"session";
    
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:tSessionSerialization forClass:[Session class]];
    
    [[RKObjectManager sharedManager].router routeClass:[Session class] toResourcePath:@"/session" forMethod:RKRequestMethodPOST];
    [[RKObjectManager sharedManager].router routeClass:[Session class] toResourcePath:@"/session" forMethod:RKRequestMethodDELETE];
}

@end
