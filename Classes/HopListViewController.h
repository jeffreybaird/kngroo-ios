//
//  HopListViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HopListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,RKObjectLoaderDelegate> {

	IBOutlet UITableView* tableView;
	
	NSArray* hops;
	
}

@property (retain) UITableView* tableView;
@property (retain) NSArray* hops;

@end
