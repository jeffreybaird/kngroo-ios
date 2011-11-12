//
//  BrandedNavigationBar.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/7/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "BrandedNavigationBar.h"

@implementation BrandedNavigationBar

- (id)initWithCoder:(NSCoder *)aDecoder
{    
    self = [super initWithCoder:aDecoder];
    self.tintColor = [UIColor colorWithRed:0.289 green:0.6875 blue:0.7852 alpha:1.0];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIImage* tImage = [UIImage imageNamed:@"nav-bg.png"];
    [tImage drawInRect:rect];
}

@end
