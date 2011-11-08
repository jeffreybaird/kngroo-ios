//
//  BrandedNavigationBar.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/7/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "BrandedNavigationBar.h"

@implementation BrandedNavigationBar

- (void)drawRect:(CGRect)rect
{
    UIImage* tImage = [UIImage imageNamed:@"nav-bg.png"];
    [tImage drawInRect:rect];
}

@end
