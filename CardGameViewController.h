//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Rich Chang on 8/7/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardGameViewController : UIViewController

- (NSMutableAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (void)updateUI;

@end
