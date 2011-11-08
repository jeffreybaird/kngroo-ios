//
//  VenueCell.h
//  Kngroo
//
//  Created by Aubrey Goodman on 11/7/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell {
    
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* titleLabel;
    IBOutlet UILabel* distanceLabel;
    
}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* titleLabel;
@property (retain) UILabel* distanceLabel;

@end
