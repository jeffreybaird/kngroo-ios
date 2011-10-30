//
//  Attempt.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface Attempt : NSObject <RKLoadable> {
    
    NSNumber* attemptId;
    NSNumber* triviaId;
    NSNumber* correctAnswer;
    
}

@property (retain) NSNumber* attemptId;
@property (retain) NSNumber* triviaId;
@property (retain) NSNumber* correctAnswer;

@end
