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
    NSNumber* points;
	NSArray* hops;
	
}

@property (retain) NSNumber* userId;
@property (retain) NSString* email;
@property (retain) NSString* password;
@property (retain) NSNumber* points;
@property (retain) NSArray* hops;

@end
