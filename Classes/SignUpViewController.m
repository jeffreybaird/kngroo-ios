//
//  SignUpViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "SignUpViewController.h"
#import "User.h"


@implementation SignUpViewController

@synthesize email, password;

- (id)init
{
    self = [super initWithNibName:@"SignUpView" bundle:[NSBundle mainBundle]];
    return self;
}

- (void)cancelPressed
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)donePressed
{
    [self showHud:@"Creating Account"];
    User* tUser = [[[User alloc] init] autorelease];
    tUser.email = email.text;
    tUser.password = password.text;
    [[RKObjectManager sharedManager] postObject:tUser delegate:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Create Account";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [email becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    [self hideHud];
    if( [object isKindOfClass:[User class]] ) {
        [email resignFirstResponder];
        [password resignFirstResponder];
        
        User* tUser = (User*)object;
        [[NSUserDefaults standardUserDefaults] setInteger:[tUser.userId intValue] forKey:@"UserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionCreated" object:nil];

        dispatch_async(dispatch_get_main_queue(), ^{
            Alert(@"Account Created", @"You're ready to go.");
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    [self hideHud];
    Alert(@"Unable to create account", [error localizedDescription]);
}

@end
