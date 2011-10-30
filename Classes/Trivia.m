//
//  Trivia.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "Trivia.h"

@implementation Trivia

@synthesize triviaId, question, answer, numericAnswer, wrongAnswers;

+ (void)initObjectLoader
{
    RKObjectMapping* tTriviaMapping = [RKObjectMapping mappingForClass:[Trivia class]];
    [tTriviaMapping mapKeyPath:@"id" toAttribute:@"triviaId"];
    [tTriviaMapping mapKeyPath:@"question" toAttribute:@"question"];
    [tTriviaMapping mapKeyPath:@"answer" toAttribute:@"answer"];
    [tTriviaMapping mapKeyPath:@"numeric_answer" toAttribute:@"numericAnswer"];

    [[RKObjectManager sharedManager].mappingProvider setMapping:tTriviaMapping forKeyPath:@"trivia"];
}

@end
