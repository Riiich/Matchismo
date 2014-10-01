//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Rich Chang on 9/17/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck{
    return [[SetCardDeck alloc]init];
}

- (NSMutableAttributedString *)titleForCard:(Card *)card{
    NSMutableAttributedString *content;// = [[NSMutableAttributedString alloc] initWithString:card.isChosen?card.contents:@"?"];
    
    //if (card.isChosen){
        
        if ([card isKindOfClass:[SetCard class]]){
            SetCard *setCard = (SetCard *)card;
            
            NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
            NSString *title=@"?";
            
            // Symbol
            if ([setCard.symbol isEqualToString:@"diamond"])   title=@"▲";
            if ([setCard.symbol isEqualToString:@"squiggle"])   title=@"●";
            if ([setCard.symbol isEqualToString:@"oval"])   title=@"■";
            
            // Number with Font size
            title = [title stringByPaddingToLength:setCard.number withString:title startingAtIndex:0];
            if (setCard.number == 1){
                [attribute setObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
            }
            else if (setCard.number == 2){
                [attribute setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
            }
            else if (setCard.number == 3){
                [attribute setObject:[UIFont systemFontOfSize:10] forKey:NSFontAttributeName];
            }
            
            // Color
            if ([setCard.color isEqualToString:@"red"]){
                //[content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                [attribute setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
            }
            else if ([setCard.color isEqualToString:@"green"]){
                [attribute setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
            }
            else if ([setCard.color isEqualToString:@"purple"]){
                [attribute setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
            }
            
            // Shading
            if ([setCard.shading isEqualToString:@"solid"]){
                //[content addAttribute:NSStrokeWidthAttributeName value:@-5 range:NSMakeRange(0, 1)];
                [attribute setObject:@-5 forKey:NSStrokeWidthAttributeName];
            }
            else if ([setCard.shading isEqualToString:@"stripe"]){
                [attribute addEntriesFromDictionary:@{NSStrokeWidthAttributeName:@-5,
                                                      NSStrokeColorAttributeName:attribute[NSForegroundColorAttributeName],
                                                      NSForegroundColorAttributeName : [attribute[NSForegroundColorAttributeName] colorWithAlphaComponent:0.3]  // Internal filled up with same color, plus alpha.
                                                      }];
            }
            else if ([setCard.shading isEqualToString:@"open"]){
                [attribute setObject:@5 forKey:NSStrokeWidthAttributeName];
            }
            
            content = [[NSMutableAttributedString alloc] initWithString:title attributes:attribute];
        }
    //}
    //else{
    //    content = [[NSMutableAttributedString alloc] initWithString:@""];
    //}
    return content;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"setCardSelected" : @"setCard"];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [self updateUI];
}

@end
