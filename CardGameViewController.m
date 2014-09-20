//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Rich Chang on 8/7/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame  *gameModel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchMode;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) NSMutableArray *resultHistory;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end


@implementation CardGameViewController

// Lazy initialization
- (CardMatchingGame *) gameModel {
    if (!_gameModel){
        _gameModel = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        
        [self touchSegmentedControl:self.matchMode];    // For fisrt/init value by sending (value change)method
    }
    return _gameModel;
}

// Lazy Initialization
- (NSMutableArray *) resultHistory{
    if (!_resultHistory){
        _resultHistory = [NSMutableArray array];
    }
    return _resultHistory;
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
}

// [Value Change]
- (IBAction)touchSegmentedControl:(id)sender {
    if (self.matchMode.selectedSegmentIndex == 0){
        self.gameModel.matchingCardsCount = 2;
    }
    else if (self.matchMode.selectedSegmentIndex == 1){
        self.gameModel.matchingCardsCount = 3;
    }
}

// [value change]
- (IBAction)changeSlider:(id)sender {
    NSInteger sliderValue = lround(self.historySlider.value);   // Find integer value
    [self.historySlider setValue:sliderValue animated:NO];      // Move/Set UI slider to value-position
    
    // I put most recent msg in most left (position 0) on slider.
    if ([self.resultHistory count]){
        self.resultLabel.alpha = (sliderValue == 0)? 1.0:0.6;
        self.resultLabel.text = self.resultHistory[[self.resultHistory count]-1-sliderValue];
    }
}

- (IBAction)touchResetButton:(UIButton *)sender {
    self.gameModel = nil;
    [self updateUI];
    
    self.matchMode.enabled = YES;
    self.resultHistory = nil;
}

// Let model handle what to do.
- (IBAction)touchCardButton:(UIButton *)sender {
    
    self.matchMode.enabled = NO;
    
    // To know what's index in Card array of touched button.
    int chosenBtnIndex = [self.cardButtons indexOfObject:sender];   // or say cardIndex
    [self.gameModel chooseCardAtIndex:chosenBtnIndex];
    [self updateUI];    // To sync the model with UI, which is what controller does.
}

- (void)updateUI{
    
    // Update all button status. Go thru all buttons, get that btn, look into the model spontaneously.
    for (UIButton *cardButton in self.cardButtons){
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.gameModel cardAtIndex:cardIndex];

        // Now we have card and button, so we can make sure if button reflects the card.
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    // Update score label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
    
    // Update last result description label
    if (self.gameModel){
        
        // To get lastChosenCards content and make with format
        NSString *descriptor=@"";
        if ([self.gameModel.lastChosenCards count]){
            NSMutableArray *cardsContent = [NSMutableArray array];
            for(Card *card in self.gameModel.lastChosenCards){
                [cardsContent addObject:card.contents];
            }
            descriptor = [cardsContent componentsJoinedByString:@" "];
        }
        
        // To format msg with score(if any).
        if (self.gameModel.lastScore > 0){
            descriptor = [NSString stringWithFormat:@"Matched %@ for %d points!", descriptor, self.gameModel.lastScore];
        }
        else if(self.gameModel.lastScore < 0){
            descriptor = [NSString stringWithFormat:@"%@ didn't match! %d points!", descriptor, self.gameModel.lastScore];
        }
        
        self.resultLabel.text = descriptor;
        self.resultLabel.alpha = 1.0;
        
        // To handle history msg array in slider
        if ([self.resultHistory count] > 10){
            [self.resultHistory removeAllObjects];
        }
        [self.resultHistory addObject:descriptor];
        [self.historySlider setMaximumValue:[self.resultHistory count]-1];
    }
}

- (NSMutableAttributedString *)titleForCard:(Card *)card{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:card.isChosen?card.contents:@""];
    return content;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback_suits"];
}

@end
