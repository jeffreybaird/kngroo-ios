//
//  Category.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/27/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKLoadable.h"


@interface Category : NSObject <RKLoadable> {
    
    NSString* categoryId;
    NSString* title;
    NSString* icon;
    
}

@property (retain) NSString* categoryId;
@property (retain) NSString* title;
@property (retain) NSString* icon;

@end
