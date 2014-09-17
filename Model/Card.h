//
//  Card.h
//  Matchismo
//
//  Created by Rich Chang on 8/7/14.
//  Copyright (c) 2014 Rich.Chang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
// It's possible to change the name of getter generated.
// In boolean getter, the code will be "read" nicer by "isMatched".

- (int) matchCard:(Card *)card;
- (int) matchCards:(NSArray *)otherCards;

@property (nonatomic) NSUInteger numberOfMatchingCard;

@end
