//
//  User.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface User : NSObject <RKLoadable> {

	NSNumber* userId;
	NSString* email;
	NSString* password;
	NSString* firstName;
	NSString* lastName;
    NSNumber* points;
	NSArray* hops;
    NSArray* trophies;
    NSString* apiToken;
	
}

@property (retain) NSNumber* userId;
@property (retain) NSString* email;
@property (retain) NSString* password;
@property (retain) NSString* firstName;
@property (retain) NSString* lastName;
@property (retain) NSNumber* points;
@property (retain) NSArray* hops;
@property (retain) NSArray* trophies;
@property (retain) NSString* apiToken;

@end
