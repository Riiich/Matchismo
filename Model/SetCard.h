//
//  SetCard.h
//  Matchismo
//
//  Created by Rich Chang on 9/17/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number; // of symbols
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;

@property (strong, nonatomic) NSDictionary *symbols;
@property (strong, nonatomic) NSDictionary *colors;
@property (strong, nonatomic) NSDictionary *shadings;

+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;

@end
