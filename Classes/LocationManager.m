//
//  LocationManager.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (CLLocationManager*)sharedManager
{
    static CLLocationManager* sInstance;
    if( sInstance==nil ) {
        sInstance = [[CLLocationManager alloc] init];
    }
    return sInstance;
}

@end
