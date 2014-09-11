//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Rich Chang on 8/7/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#define NSLog if(0) NSLog

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;   //HW-1
@property (nonatomic) int flipCount;                        //HW-1
//@property (strong, nonatomic) Deck *deck;                   //HW-1
@property (strong, nonatomic) CardMatchingGame  *gameModel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchMode;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation CardGameViewController

/*
//--Begin of HW1
// Lazy initialization
-(Deck *)deck{
    if(!_deck){
        _deck = [self createDeck];
    }
    return _deck;
}
//--ENF of HW1
*/

// Lazy initialization
-(CardMatchingGame *) gameModel {
    if (!_gameModel){
        _gameModel = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        
        [self touchSegmentedControl:self.matchMode];    // For fisrt/init value by sending (value change)method
    }
    return _gameModel;
}

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
}

// Setter
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"FlipCount: %d", self.flipCount];
    NSLog(@"flipcount changed to: %d", self.flipCount);
}

// [Value Change]
- (IBAction)touchSegmentedControl:(id)sender {
    if (self.matchMode.selectedSegmentIndex == 0){
        self.gameModel.otherCardsCount = 1;
    }
    else if (self.matchMode.selectedSegmentIndex == 1){
        self.gameModel.otherCardsCount = 2;
    }
}

- (IBAction)touchResetButton:(UIButton *)sender {
    /*if (_gameModel){
        _gameModel = nil;
        _gameModel = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }*/
    self.gameModel = nil;
    [self updateUI];
    
    self.matchMode.enabled = YES;
}

// Let model handle what to do.
- (IBAction)touchCardButton:(UIButton *)sender {
    
    self.matchMode.enabled = NO;
    
    // To know what's index in Card array of touched button.
    int chosenBtnIndex = [self.cardButtons indexOfObject:sender];   // or say cardIndex
    //[self.gameModel chooseCardAtIndex:chosenBtnIndex];
    [self.gameModel chooseCardAtIndexWithMatchMethod:chosenBtnIndex];
    [self updateUI];    // To sync the model with UI, which is what controller does.
    
    /*
    //-- Begin of HW1
    if ([sender.currentTitle length]){
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else{
        Card *card = [self.deck drawRandomCard];
        if (card){
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
        }
    }
    self.flipCount++;
    //-- End of HW1
    */
}

// Go thru all buttons, get that btn, look into the model spontaneously.
- (void)updateUI{
    
    for (UIButton *cardButton in self.cardButtons){
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.gameModel cardAtIndex:cardIndex];

        // Now we have card and button, so we can make sure if button reflects the card.
        
        //NSLog(@"updateUI(), %d=%@, Chosen/Matched=%d/%d", cardIndex, card.contents, card.isChosen, card.isMatched);
        
        [cardButton setTitle:[self titileForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
    self.resultLabel.text = self.gameModel.resultDescription;
}

-(NSString *)titileForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end