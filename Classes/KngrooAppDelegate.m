//
//  KngrooAppDelegate.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import "KngrooAppDelegate.h"
#import "DDTTYLogger.h"
#import "User.h"
#import "Hop.h"
#import "Venue.h"
#import "Assignment.h"
#import "Checkin.h"


@implementation KngrooAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)initObjectLoader
{
    [User initObjectLoader];
    [Hop initObjectLoader];
    [Venue initObjectLoader];
    [Assignment initObjectLoader];
    [Checkin initObjectLoader];
}

- (void)assignmentCreated:(NSNotification*)notif
{
    UITabBarItem* tAssignmentsItem = [tabBarController.tabBar.items objectAtIndex:0];
    [tAssignmentsItem setBadgeValue:@"1"];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
	// init logger
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
		
//	RKObjectManager* tMgr = [RKObjectManager objectManagerWithBaseURL:@"http://local:3000"];
	RKObjectManager* tMgr = [RKObjectManager objectManagerWithBaseURL:@"http://kngroo-sandbox.heroku.com"];
	tMgr.client.username = @"109c63f22d";
	tMgr.client.password = @"x";
	tMgr.client.authenticationType = RKRequestAuthenticationTypeHTTPBasic;
    tMgr.serializationMIMEType = RKMIMETypeJSON;
	
	[self initObjectLoader];
    
    // Add the tab bar controller's view to the window and display.
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    // app-level event triggers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(assignmentCreated:) name:@"AssignmentCreated" object:nil];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

- (void)tabBarController:(UITabBarController *)aTabBarController didSelectViewController:(UIViewController *)viewController 
{
    if( [aTabBarController selectedIndex]==0 && [[aTabBarController.tabBar.items objectAtIndex:0] badgeValue]!=nil ) {
        [[aTabBarController.tabBar.items objectAtIndex:0] setBadgeValue:nil];
    }
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

