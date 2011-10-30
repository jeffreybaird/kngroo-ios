//
//  Attempt.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "Attempt.h"

@implementation Attempt

@synthesize attemptId, triviaId, correctAnswer;

+ (void)initObjectLoader
{
    RKObjectMapping* tAttemptMapping = [RKObjectMapping mappingForClass:[Attempt class]];
    [tAttemptMapping mapKeyPath:@"id" toAttribute:@"attemptId"];
    [tAttemptMapping mapKeyPath:@"trivia_id" toAttribute:@"triviaId"];
    [tAttemptMapping mapKeyPath:@"correct_answer" toAttribute:@"correctAnswer"];
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tAttemptMapping forKeyPath:@"attempt"];
    
    RKObjectMapping* tAttemptSerialization = [RKObjectMapping mappingForClass:[Attempt class]];
    [tAttemptSerialization mapKeyPath:@"triviaId" toAttribute:@"trivia_id"];
    [tAttemptSerialization mapKeyPath:@"correctAnswer" toAttribute:@"correct_answer"];
    tAttemptSerialization.rootKeyPath = @"attempt";
    
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:tAttemptSerialization forClass:[Attempt class]];
    
    [[RKObjectManager sharedManager].router routeClass:[Attempt class] toResourcePath:@"/user/attempts" forMethod:RKRequestMethodPOST];
}

@end
