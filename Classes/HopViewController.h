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
    IBOutlet UIButton* startButton;
    IBOutlet UIProgressView* progressView;
    
    Hop* hop;
    BOOL active;
    
}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* titleLabel;
@property (retain) UILabel* descriptionLabel;
@property (retain) UITableView* tableView;
@property (retain) UIButton* startButton;
@property (retain) UIProgressView* progressView;
@property (retain) Hop* hop;
@property BOOL active;

-(IBAction)startThisHop:(id)sender;
-(IBAction)showMap:(id)sender;

@end
