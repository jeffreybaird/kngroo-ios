//
//  Hop.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface Hop : NSObject <RKLoadable> {

	NSNumber* hopId;
	NSString* title;
	NSArray* venues;
	NSNumber* points;
    NSNumber* completed;
	
}

@property (retain) NSNumber* hopId;
@property (retain) NSString* title;
@property (retain) NSArray* venues;
@property (retain) NSNumber* points;
@property (retain) NSNumber* completed;

@end
