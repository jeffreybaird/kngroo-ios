//
//  SignInViewController.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "SignInViewController.h"
#import "Session.h"


@implementation SignInViewController

- (void)cancelPressed
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)donePressed
{
    [email resignFirstResponder];
    [password resignFirstResponder];
    
    [self showHud:@"Signing In"];
    Session* tSession = [Session sessionWithEmail:email.text password:password.text];
    [[RKObjectManager sharedManager] postObject:tSession delegate:self];
}

#pragma mark -

- (id)init
{
    self = [super initWithNibName:@"SignInView" bundle:[NSBundle mainBundle]];
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sign In";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [email becomeFirstResponder];
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

#pragma mark -
#pragma mark RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
    [self hideHud];
    if( [object isKindOfClass:[Session class]] ) {
        Session* tSession = (Session*)object;
        [[NSUserDefaults standardUserDefaults] setInteger:[tSession.userId intValue] forKey:@"UserId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SessionCreated" object:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController dismissModalViewControllerAnimated:YES];
        });
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    [self hideHud];
    Alert(@"Unable to sign in", [error localizedDescription]);
}

@end
