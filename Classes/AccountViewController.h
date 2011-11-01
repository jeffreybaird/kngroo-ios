//
//  AccountViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/26/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "HudViewController.h"


@interface AccountViewController : HudViewController <UITableViewDataSource,UITableViewDelegate,RKObjectLoaderDelegate,UIActionSheetDelegate> {
    
    IBOutlet UISegmentedControl* modeSelect;
    IBOutlet UIView* personalView;
    IBOutlet UILabel* emailLabel;
    IBOutlet UILabel* pointsLabel;
    IBOutlet UILabel* trophiesLabel;
    IBOutlet UITableView* tableView;
    
    User* user;
    
}

@property (retain) UISegmentedControl* modeSelect;
@property (retain) UIView* personalView;
@property (retain) UITableView* tableView;
@property (retain) User* user;

@end
