//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Rich Chang on 8/12/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// Designated initailizer
// 1. Want to know: how many cards are we playing with?
// 2. Need a deck of these certain count of cards to deal out.
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

// index must be between 0 to count for cards to be choosed.
- (void)chooseCardAtIndex:(NSInteger)index;

// Status of a card, to be choosen or not. Could iterate all cards to update the status or get particular index one.
- (Card *)cardAtIndex:(NSUInteger)index;

// readonly: no PUBLIC setter, make it READONLY publicly.
@property (nonatomic, readonly)NSInteger score;

@property (nonatomic)NSUInteger otherCardsCount;
@property (nonatomic, readonly)NSArray *lastChosenCards;
@property (nonatomic, readonly)NSInteger lastScore;

@end
