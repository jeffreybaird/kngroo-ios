//
//  Hop.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Hop : NSObject {

	NSNumber* hopId;
	NSString* title;
	NSArray* venues;
	NSNumber* points;
	
}

@property (retain) NSNumber* hopId;
@property (retain) NSString* title;
@property (retain) NSArray* venues;
@property (retain) NSNumber* points;

@end
