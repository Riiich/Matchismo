//
//  Deck.m
//  Matchismo
//
//  Created by Rich Chang on 8/7/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "Deck.h"

@interface Deck()
// We need PRIVATE variable to storage and keep the card in, so declare here.
@property (strong, nonatomic) NSMutableArray *cards;    // of Card class
@end

@implementation Deck

// Declare a @property HERE(?) makes space in the instance of "pointer" ITSELF,
// but NOT allocate a space in the heap for the object the pointer points to.

// The place to put the nedded heap allocation is in the GETTER for the "@property cards"
- (NSMutableArray *)cards{
    // All pointer start out with the value of 0.(Called nil for pointers to objects)
    // So all we need to do is allocate and initialize the object if the pointer to it is nil.
    
    // This is called "lazy instantiation". It's the usefulness of a @property.
    if (!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    
    // So at least a empty mutable array, not nil.
    return _cards;
}

- (void)addCard:(Card *)card{
    [self addCard:card atTop:NO];
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop{
    if (atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

// This method simply grabs a crad from a random spot in our self.cards array.
- (Card *)drawRandomCard{
    Card *randomCard = nil;
    
    if ([self.cards count]){
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
