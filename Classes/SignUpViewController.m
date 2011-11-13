//
//  SignUpViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "SignUpViewController.h"
#import "User.h"
#import "UITextField+PlaceholderColor.h"


@implementation SignUpViewController

@synthesize firstName, lastName, email, password;

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
    tUser.email = self.email;
    tUser.password = self.password;
    tUser.firstName = firstName.text;
    tUser.lastName = lastName.text;
    [[RKObjectManager sharedManager] postObject:tUser delegate:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // here, there be hacks!
    firstName.textColor = [UIColor whiteColor];
    lastName.textColor = [UIColor whiteColor];
//    [firstName setValue:[UIColor whiteColor] forKey:@"_placeholderLabel.textColor"];
//    [lastName setValue:[UIColor whiteColor] forKey:@"_placeholderLabel.textColor"];
    
    self.navigationItem.title = @"Create Account";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [firstName becomeFirstResponder];
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
        [firstName resignFirstResponder];
        [lastName resignFirstResponder];
        
        User* tUser = (User*)object;

        [[NSUserDefaults standardUserDefaults] setInteger:[tUser.userId intValue] forKey:@"UserId"];
        [[NSUserDefaults standardUserDefaults] setValue:tUser.apiToken forKey:@"ApiToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        RKObjectManager* tMgr = [RKObjectManager sharedManager];
        tMgr.client.username = tUser.apiToken;
        tMgr.client.password = @"x";
        tMgr.client.authenticationType = RKRequestAuthenticationTypeHTTPBasic;

        async_main(^{
            Alert(@"Account Created", @"You're ready to go.");
            [self.navigationController dismissModalViewControllerAnimated:YES];
        });
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionCreated" object:nil];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    [self hideHud];
    Alert(@"Unable to create account", [error localizedDescription]);
}

@end
