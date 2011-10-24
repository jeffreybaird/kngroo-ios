//
//  AssignmentViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/24/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HopViewController.h"
#import "Assignment.h"


@interface AssignmentViewController : HopViewController {
    
    Assignment* assignment;
    
}

@property (retain) Assignment* assignment;

@end
