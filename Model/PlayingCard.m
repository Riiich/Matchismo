//
//  PlayingCard.m
//  Matchismo
//
//  Created by Rich Chang on 8/8/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// Re-write matchCards inherts from Card class.
- (int)matchCards:(NSArray *)otherCards{
    int score =0;
    
    /*
    if (otherCards.count == 1){
        id card = [otherCards firstObject]; // firstObject is just like objectAtIndex:0, but it will NOT crash if array is empty. (it will just return nil)
        if ([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *otherCard = (PlayingCard *)card;
            if (otherCard.rank == self.rank){
                score += 4;
            }
            else if ([otherCard.suit isEqualToString:otherCard.suit]){
                score += 1;
            }
        }
    }
    */
    
    for (PlayingCard *otherCard in otherCards){
        if (otherCard.rank == self.rank){
            score += 4;
        }
        else if ([otherCard.suit isEqual:self.suit]){
            score += 1;
        }
    }
    
    return score;
}

// Re-write the getter of argument "contents" in base-class "Card"
// To make sure it contains only what we want for playing cards, not any format string.
- (NSString *)contents{
    
    NSArray *rankString = [PlayingCard rankStrings];
    
    return [rankString[self.rank] stringByAppendingString:self.suit];
    //return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
}

// Re-write the getter. Return string @"?" if _suit is nil. Or return the @string.
@synthesize suit = _suit;   // MUST!!! For re-write BOTH setter and getter.
- (NSString *)suit{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

+ (NSArray *)validSuits{
    return @[@"♠︎",@"♥︎",@"♦︎",@"♣︎"];
}

// Leave it PRIVATE, so don't declare in .h file
+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSInteger)maxRank{
    // Always return the number, 13. (Based in the array count of rankStrings)
    return [[self rankStrings] count]-1;
}

// Re-write the SETTER of rank.
- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
