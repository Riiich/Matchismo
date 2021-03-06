//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Rich Chang on 8/12/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#define NSLog if(1) NSLog

#import "CardMatchingGame.h"

// PRIVATE interface
@interface CardMatchingGame()

// Basically default property is "readwrite". But use it ONLY if "re-define" PUBLIC variable.(Maybe with diff property)
@property (nonatomic, readwrite) NSInteger score;

// Internal usage/storage of cards, just need a array of cards.
@property (nonatomic, strong) NSMutableArray *cards; // of card

@property (nonatomic, strong)NSArray *lastChosenCards;
@property (nonatomic, readwrite)NSInteger lastScore;
@end

@implementation CardMatchingGame

// Lazy initialization
- (NSMutableArray *)cards{
    if (!_cards){
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

// Lazy Initialization
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super init];
    
    if (self){
        // TODO: Pull the <count> number of cards out of <deck>, and put them into internal data structure, <score> and <card>
        for (int i=0;i<count;i++){
            Card * card = [deck drawRandomCard];
            if (card){
                self.cards[i] = card;       //[self.cards addObject:card];
            }else{ // run out of cards
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (instancetype)init{
    return nil;
}

// (getter) Lazy Initialization
- (NSUInteger)matchingCardsCount{
    Card *card = [self.cards firstObject];
    if (_matchingCardsCount < card.numberOfMatchingCard){
        _matchingCardsCount = card.numberOfMatchingCard;
    }
    return _matchingCardsCount;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;      // To prevent if <index> greater then <count>
}

static const int MISMATCH_PENALTY=2;
static const int MATCH_BONUS=4;
static const int COST_TO_CHOOSE=1;

// Here is where "matching: happen !!! Heart of this App
- (void)chooseCardAtIndex:(NSInteger)index{
    
#ifdef  MATCH_ONE
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            // if the card is already chosen, toggle chosen status of the card
            // flip OFF the card
            card.chosen = NO;
        }else{
            // So looking for OTHER that are unmatched and already chosen.
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card matchCards:@[otherCard]];    // Make array on the fly by using @[]
                    if (matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        
                        // if matched, mark BOTH matched cards MATCHED.
                        card.matched = YES;
                        otherCard.matched = YES;
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;  // Only matching 2 cards for NOW. If found the chosen card matched, break the FOR loop.
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    else{
        // Do nothing if this card is already matched with the other one.
    }
#else
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
        }
        else{
            NSMutableArray  *otherCards = [NSMutableArray array];
            
            self.lastScore = 0;
            self.lastChosenCards = @[card]; // Show only self to result msg
            
            for(Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    [otherCards addObject:(otherCard)];
                    
                    if ([otherCards count] == self.matchingCardsCount-1){                    // matching until choose N cards.
                        
                        self.lastChosenCards = [otherCards arrayByAddingObject:card];   // otherCards and (self)card.
                        
                        int matchScore = [card matchCards:otherCards];
                        if (matchScore){
                            self.lastScore = matchScore*MATCH_BONUS;
                            
                            // If any matching, (take out)/disable ALL cards by mark MATCHED.
                            card.matched = YES;
                            for (Card *matchedCard in otherCards){
                                matchedCard.matched = YES;
                            }
                        }
                        else{
                            self.lastScore = 0 - MISMATCH_PENALTY;
                            
                            //If no matching, only otherCards flip OFF.
                            for (Card *matchedCard in otherCards){
                                matchedCard.chosen = NO;
                            }
                        }
                        break;
                    }else{
                        // Not yet choose N cards, so do nothing.(ONLY do matching until choose N cards.)
                    }
                }
            }
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    else{
        // Do nothing if this card is already matched with the other one.
    }
#endif
}

@end
