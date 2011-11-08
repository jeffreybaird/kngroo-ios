//
//  HudViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "HudViewController.h"

@implementation HudViewController

@synthesize hud;

- (void)showHud:(NSString *)aMessage
{
    if( self.navigationController.tabBarController ) {
        self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.tabBarController.view] autorelease];
        hud.delegate = self;
        hud.labelText = aMessage;
        [self.navigationController.tabBarController.view addSubview:hud];
        [hud show:YES];
    }else{
        self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
        hud.delegate = self;
        hud.labelText = aMessage;
        [self.navigationController.view addSubview:hud];
        [hud show:YES];
    }
}

- (void)hideHud
{
    [hud hide:YES];
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.289 green:0.6875 blue:0.7852 alpha:1.0];
}

#pragma mark -
#pragma mark MBProgressHudDelegate

- (void)hudWasHidden:(MBProgressHUD *)aHud
{
    [hud removeFromSuperview];
    self.hud = nil;
}

@end
