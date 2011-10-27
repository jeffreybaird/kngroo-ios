//
//  Trophy.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/26/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hop.h"


@interface Trophy : NSObject {
    
    NSNumber* trophyId;
    NSNumber* userId;
    NSNumber* hopId;
    NSDate* createdAt;
    Hop* hop;
    
}

@property (retain) NSNumber* trophyId;
@property (retain) NSNumber* userId;
@property (retain) NSNumber* hopId;
@property (retain) NSDate* createdAt;
@property (retain) Hop* hop;


@end
