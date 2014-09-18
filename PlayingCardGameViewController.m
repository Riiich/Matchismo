//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Rich Chang on 9/17/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
}

@end
