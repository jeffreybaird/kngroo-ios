//
//  RKLoadable.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


//typedef void(^ArrayBlock)(NSArray*);
//typedef void(^ErrorBlock)(NSString*);


@protocol RKLoadable <NSObject>

+(void)initObjectLoader;

@end
