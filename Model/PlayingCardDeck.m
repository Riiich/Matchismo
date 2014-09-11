//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Rich Chang on 8/11/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

// No public API, but overwrite the initialization inherited from NSObject->Deck, called init.
// init will contains everything necessary to initalization a PlayingCardDeck.
- (instancetype)init{
    // First, to make sure it inits from super class successfully, not nil.
    self = [super init];
    
    if (self){
        for (NSString *suit in [PlayingCard validSuits]) {
            for(NSUInteger rank=1;rank<=[PlayingCard maxRank];rank++){
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

// That's it ! We inherit everything else we need to be a deck of cards (Like the ability to drawRandomCard) form our superclass, Deck.

@end
