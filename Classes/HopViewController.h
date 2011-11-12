//
//  HopViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/19/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hop.h"
#import "HudViewController.h"


@interface HopViewController : HudViewController <UITableViewDataSource,UITabBarDelegate,RKObjectLoaderDelegate,CLLocationManagerDelegate> {

    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* descriptionLabel;
    IBOutlet UITableView* tableView;
    IBOutlet UIButton* startButton;
    IBOutlet UILabel* progressLabel;
    IBOutlet UIProgressView* progressView;
    
    Hop* hop;
    BOOL active;
    
}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* titleLabel;
@property (retain) UILabel* descriptionLabel;
@property (retain) UITableView* tableView;
@property (retain) UIButton* startButton;
@property (retain) UILabel* progressLabel;
@property (retain) UIProgressView* progressView;
@property (retain) Hop* hop;
@property BOOL active;

-(IBAction)startThisHop:(id)sender;
-(IBAction)showMap:(id)sender;

@end
