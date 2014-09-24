//
//  SetCard.m
//  Matchismo
//
//  Created by Rich Chang on 9/17/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

// re-write getter of <contents>, which is delcared in Card class.
- (NSString *)contents{
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.symbol, self.color, self.shading, self.number];
}

static const unsigned int NUMBER_OF_A_SET = 3;
// Guessing re-write getter also works.
- (id)init{
    self = [super init];
    if (self){
        self.numberOfMatchingCard = NUMBER_OF_A_SET;
    }
    return self;
}
/*
 // re-write getter of <numberOfMatchingCard>, which is delcared in Card class.
 - (NSUInteger)numberOfMatchingCard{
 return NUMBER_OF_A_SET;
 }
 */

@synthesize symbol = _symbol;
- (NSString *)symbol{
    return _symbol ? _symbol : @"";
}
- (void)setSymbol:(NSString *)symbol{
    if ([[SetCard validSymbols] containsObject:symbol]){
        _symbol = symbol;
    }
}

@synthesize color = _color;
- (NSString *)color{
    return _color ? _color : @"";
}
- (void)setColor:(NSString *)color{
    if ([[SetCard validColors] containsObject:color]){
        _color = color;
    }
}

@synthesize shading = _shading;
- (NSString *)shading{
    return _shading ? _shading : @"";
}
- (void)setShading:(NSString *)shading{
    if ([[SetCard validShadings] containsObject:shading]){
        _shading = shading;
    }
}

- (void)setNumber:(NSUInteger)number{
    if (number > [SetCard maxNumber]){
        number = [SetCard maxNumber];
    }
    _number = number;
}

+ (NSUInteger)maxNumber{
    return 3;
}

+ (NSArray *)validSymbols{
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validColors{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShadings{
    return @[@"solid", @"stripe", @"open"];
}

- (int)matchCards:(NSArray *)otherCards{
    int score = 0;
    
    if ([otherCards count] == self.numberOfMatchingCard){
    
        NSMutableArray *setNumbers = [[NSMutableArray alloc]init];
        NSMutableArray *setSymbols = [[NSMutableArray alloc]init];
        NSMutableArray *setColors = [[NSMutableArray alloc]init];
        NSMutableArray *setShadings = [[NSMutableArray alloc]init];
    
        [setNumbers addObject:@(self.number)];
        [setSymbols addObject:self.symbol];
        [setColors addObject:self.color];
        [setShadings addObject:self.shading];
    
        for (id otherCard in otherCards){                       // Learn how to use (id)
            if ([otherCard isKindOfClass:[SetCard class]]){     // Learn how to use (id)
                SetCard *otherSetCard = (SetCard *)otherCard;   // Learn how to use (id)
            
                if (![setNumbers containsObject:@(otherSetCard.number)]){
                    [setNumbers addObject:@(otherSetCard.number)];
                }
                if (![setSymbols containsObject:otherSetCard.symbol]){
                    [setSymbols addObject:otherSetCard.symbol];
                }
                if (![setColors containsObject:otherSetCard.color]){
                    [setColors addObject:otherSetCard.color];
                }
                if (![setShadings containsObject:otherSetCard.shading]){
                    [setShadings addObject:otherSetCard.shading];
                }
            }
        }
    
        if (([setNumbers count] == 1 || [setNumbers count] == 3) &&
            ([setSymbols count] == 1 || [setSymbols count] == 3) &&
            ([setColors count] == 1 || [setColors count] == 3) &&
            ([setShadings count] == 1 || [setShadings count] == 3)){
            score = 4;
        }
    }
    
    return score;
}

@end
