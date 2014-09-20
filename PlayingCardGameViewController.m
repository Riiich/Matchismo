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

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
}

- (NSMutableAttributedString *)titleForCard:(Card *)card{
    
    NSMutableAttributedString *title;
    NSMutableAttributedString *suit;
    
    if (card.isChosen){
        NSRange suitRange;
        if ([card.contents length] == 3){       // For rank is one unit. (e.g. 1,2..9,J,Q,K)
            suitRange = NSMakeRange(1, 1);
        }
        else if ([card.contents length] == 4){  // For rank is two unit. (e.g. 10)
            suitRange = NSMakeRange(2, 1);
        }
        
        suit = [[NSMutableAttributedString alloc] initWithString:[card.contents substringWithRange:suitRange]];
        [suit setAttributes:self.suitColors range:NSMakeRange(0, 1)];
        
        title = [[NSMutableAttributedString alloc] initWithString:[card.contents substringWithRange:NSMakeRange(0,1)]]; // init with RANK only.
        [title appendAttributedString:suit];    // title, which is only RANK, appends with SUIT.
    }
    else{
        title = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    return title;
}

- (NSDictionary *)suitColors{
    return @{@"♠︎" : [UIColor blackColor],
             @"♥︎" : [UIColor redColor],
             @"♦︎" : [UIColor redColor],
             @"♣︎" : [UIColor blackColor]};
}

@end
