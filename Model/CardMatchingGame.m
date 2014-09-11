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

@property (strong, nonatomic, readwrite) NSString *resultDescription;
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
                self.cards[i] = card;
                //[self.cards addObject:card];    // or doing this way
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

// Lazy Initialization
- (NSUInteger)otherCardsCount{
    if (_otherCardsCount < 1){
        _otherCardsCount = 1;
    }
    return _otherCardsCount;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    // To prevent if <index> greater then <count>
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY=2;
static const int MATCH_BONUS=4;
static const int COST_TO_MATCH=1;

// Here is where "matching: happen !!! Heart of this App
- (void)chooseCardAtIndex:(NSInteger)index{
    
    Card *card = [self cardAtIndex:index];
    
    //--- Doing the MATCHING ---//
    
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
            self.score -= COST_TO_MATCH;
            card.chosen = YES;
        }
    }
    else{
        // Do nothing if this card is already matched with the other one.
    }
}

- (void)chooseCardAtIndexWithMatchMethod:(NSInteger)index{
    
    self.resultDescription = nil;
    
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            self.resultDescription = @"Flip OFF card";
        }
        else{
            NSMutableArray  *otherCards = [NSMutableArray array];
            for(Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    [otherCards addObject:(otherCard)];
                    
                    //--- other thinking, to move this if() out of for() also works.
                    if ([otherCards count] == self.otherCardsCount){   // matching until choose N cards.
                        int matchScore = [card matchCards:otherCards];
                        
                        if (matchScore){
                            self.score += matchScore;//*MATCH_BONUS;
                            
                            NSString *matchedCardsString = [NSString stringWithFormat:@"%@", card.contents];
                            
                            // If any matching, (take out)/disable ALL cards by mark MATCHED.
                            card.matched = YES;
                            for (Card *matchedCard in otherCards){
                                matchedCard.matched = YES;
                                
                                // For update result string
                                NSString *temp=matchedCard.contents;
                                matchedCardsString = [matchedCardsString stringByAppendingString:@" "];
                                matchedCardsString = [matchedCardsString stringByAppendingString:temp];
                            }
                            
                            self.resultDescription = [NSString stringWithFormat:@"Matched %@ for %d points.", matchedCardsString, matchScore];
                        }
                        else{
                            //self.score -= matchScore*MISMATCH_PENALTY;
                            
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
            card.chosen = YES;
            
            if (!self.resultDescription)
                self.resultDescription = [NSString stringWithFormat:@"%@", card.contents];
        }
    }
    else{
    }
}

@end
