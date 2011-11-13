//
//  Trophy.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/26/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "Trophy.h"

@implementation Trophy

@synthesize trophyId, userId, hopId, createdAt, hop;

+ (void)initObjectLoader
{
    RKObjectMapping* tTrophyMapping = [RKObjectMapping mappingForClass:[Trophy class]];
	[tTrophyMapping mapKeyPath:@"id" toAttribute:@"trophyId"];
	[tTrophyMapping mapKeyPath:@"user_id" toAttribute:@"userId"];
	[tTrophyMapping mapKeyPath:@"hop_id" toAttribute:@"hopId"];
    
    RKObjectMapping* tHopMapping = [RKObjectMapping mappingForClass:[Hop class]];
	[tHopMapping mapKeyPath:@"id" toAttribute:@"hopId"];
	[tHopMapping mapKeyPath:@"category_id" toAttribute:@"categoryId"];
	[tHopMapping mapKeyPath:@"title" toAttribute:@"title"];
    [tHopMapping mapKeyPath:@"points" toAttribute:@"points"];
    [tHopMapping mapKeyPath:@"featured" toAttribute:@"featured"];
    [tHopMapping mapKeyPath:@"description" toAttribute:@"summary"];
    [tHopMapping mapKeyPath:@"stamp_url" toAttribute:@"stampUrl"];
    [tHopMapping mapKeyPath:@"stamp_name" toAttribute:@"stampName"];

    [tTrophyMapping mapKeyPath:@"hop" toRelationship:@"hop" withMapping:tHopMapping];
    
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:tTrophyMapping forKeyPath:@"trophy"];
}

@end
