//
//  Card.m
//  Matchismo
//
//  Created by Rich Chang on 8/7/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "Card.h"

@implementation Card

// Method (match) is going to return a score which says how good a match the passed (card) is
// to the (Card) that is receiving this message.
// 0 means "no matched", higher numbers mean a better match.
- (int) matchCard:(Card *)card{
    int score=0;
    
    if ([card.contents isEqual:self.contents]){
        score = 1;
    }
    return score;
}

-(int) matchCards:(NSArray *)otherCards{
    int score=0;
    
    for (Card *card in otherCards){
        if ([card.contents isEqual:self.contents]){
            score = 1;
        }
    }
    return score;
}

// re-write the getter. For matching card, at least 2 cards to be matched.
- (NSUInteger) numberOfMatchingCard{
    if (!_numberOfMatchingCard){
        _numberOfMatchingCard = 2;
    }
    return _numberOfMatchingCard;
}

/*
@synthesize contents = _contents;
- (NSString*) contents{
    return _contents;
}
- (void) setContents:(NSString *)contents{
    _contents = contents;
    // Also it can be represented by "." notation, for example.
    //Card *card;
    //card.contents = contents;
}

@synthesize chosen = _chosen;
- (BOOL) chosen{
    return _chosen;
}
- (void) setChosen:(BOOL)chosen{
    _chosen = chosen;
}

@synthesize matched = _matched;
- (BOOL) isMatched{
    return _matched;
}
- (void) setMatched:(BOOL)matched{
    _matched = matched;
}
*/

@end
