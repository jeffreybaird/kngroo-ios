//
//  BrandedNavigationController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/12/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "BrandedNavigationController.h"


@implementation BrandedNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    self.navigationBar.tintColor = [UIColor colorWithRed:0.289 green:0.6875 blue:0.7852 alpha:1.0];
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
