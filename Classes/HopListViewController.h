//
//  HopListViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/18/11.
//  Copyright 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HopListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {

	NSArray* hops;
	
}

@property (retain) NSArray* hops;

@end
