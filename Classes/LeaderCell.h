//
//  LeaderCell.h
//  Kngroo
//
//  Created by Aubrey Goodman on 11/12/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderCell : UITableViewCell {
    
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* pointsLabel;
    IBOutlet UIImageView* rankImage;
    
}

@property (retain) UIImageView* imageView;
@property (retain) UILabel* nameLabel;
@property (retain) UILabel* pointsLabel;
@property (retain) UIImageView* rankImage;


@end
