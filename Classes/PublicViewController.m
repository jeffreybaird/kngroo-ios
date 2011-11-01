//
//  PublicViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "PublicViewController.h"
#import "SignInViewController.h"


@implementation PublicViewController

- (id)init
{
    self = [super initWithNibName:@"PublicView" bundle:[NSBundle mainBundle]];
    return self;
}

- (void)signUpPressed
{
    Alert(@"TODO", @"show sign up view");
//    SignUpViewController* tSignUpView = [[[SignUpViewController alloc] init] autorelease];
//    UINavigationController* tNav = [[[UINavigationController alloc] initWithRootViewController:tSignUpView] autorelease];
//    [self.navigationController presentModalViewController:tNav animated:YES];
}

- (void)signInPressed
{
    SignInViewController* tSignInView = [[[SignInViewController alloc] init] autorelease];
    UINavigationController* tNav = [[[UINavigationController alloc] initWithRootViewController:tSignInView] autorelease];
    [self.navigationController presentModalViewController:tNav animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Sign Up" style:UIBarButtonItemStylePlain target:self action:@selector(signUpPressed)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonItemStyleDone target:self action:@selector(signInPressed)] autorelease];
}

//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
