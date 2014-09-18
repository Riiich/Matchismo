//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Rich Chang on 9/17/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init{
    
    self = [super init];
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]){
            for (NSString *color in [SetCard validColors]){
                for (NSString *shading in [SetCard validShadings]){
                    for (NSUInteger number=1;number<=[SetCard maxNumber];number++){
                        
                        SetCard *card = [[SetCard alloc]init];
                        card.number = number;
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                    }
                }
            }
        }
    }
    return self;
}

@end
