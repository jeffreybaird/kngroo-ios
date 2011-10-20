//
//  HopViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hop.h"


@interface HopViewController : UIViewController <UITableViewDataSource,UITabBarDelegate,RKObjectLoaderDelegate> {

    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* descriptionLabel;
    IBOutlet UITableView* tableView;
    
    Hop* hop;
    
}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* titleLabel;
@property (retain) UILabel* descriptionLabel;
@property (retain) UITableView* tableView;
@property (retain) Hop* hop;

-(IBAction)startThisHop:(id)sender;
-(IBAction)showMap:(id)sender;

@end
