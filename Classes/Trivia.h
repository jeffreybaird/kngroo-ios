//
//  Trivia.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface Trivia : NSObject <RKLoadable> {
    
    NSNumber* triviaId;
    NSString* question;
    NSString* answer;
    NSNumber* numericAnswer;
    NSArray* wrongAnswers;
    
}

@property (retain) NSNumber* triviaId;
@property (retain) NSString* question;
@property (retain) NSString* answer;
@property (retain) NSNumber* numericAnswer;
@property (retain) NSArray* wrongAnswers;

@end
