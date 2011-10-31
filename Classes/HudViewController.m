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
    self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.tabBarController.view] autorelease];
    hud.delegate = self;
    hud.labelText = aMessage;
    [self.navigationController.view addSubview:hud];
    [hud show:YES];
}

- (void)hideHud
{
    [hud hide:YES];
}

#pragma mark -
#pragma mark MBProgressHudDelegate

- (void)hudWasHidden:(MBProgressHUD *)aHud
{
    [hud removeFromSuperview];
    self.hud = nil;
}

@end
