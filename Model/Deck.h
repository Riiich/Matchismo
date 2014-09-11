//
//  Deck.h
//  Matchismo
//
//  Created by Rich Chang on 8/7/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

// This class represents a deck of cards.
@interface Deck : NSObject

// This mwthod has two arguments. The name of method is called "addCard:atTop:"
// 2 arguments are separated by internal SPACE.
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
// Every method is individual and separated, no overlapped with different arguments.

- (Card *)drawRandomCard;

@end
