//
//  Session.h
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface Session : NSObject <RKLoadable> {
    
    NSString* email;
    NSString* password;
    NSNumber* userId;
    
}

@property (retain) NSString* email;
@property (retain) NSString* password;
@property (retain) NSNumber* userId;

+(Session*)sessionWithEmail:(NSString*)aEmail password:(NSString*)aPassword;

@end
