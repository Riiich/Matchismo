//
//  PlayingCard.h
//  Matchismo
//
//  Created by Rich Chang on 8/8/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "Card.h"

// This class represents a subclass of Card specific to a playing card.(e.g. A♣︎).
@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

// Create Class-methods, use +
// Create Instance-methods, use -
+ (NSArray *)validSuits;
+ (NSInteger)maxRank;

@end
