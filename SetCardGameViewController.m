//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Rich Chang on 9/17/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck{
    return [[SetCardDeck alloc]init];
}

- (NSMutableAttributedString *)titleForCard:(Card *)card{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:card.isChosen?card.contents:@"?"];
    
    return content;
}


@end
