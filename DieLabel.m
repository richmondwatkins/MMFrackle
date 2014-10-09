//
//  DieLabel.m
//  Farkle
//
//  Created by Richmond on 10/8/14.
//  Copyright (c) 2014 Richmond. All rights reserved.
//

#import "DieLabel.h"
@interface DieLabel ()
//@property int rollNumber;

@end

@implementation DieLabel

-(IBAction)onTapped:(UITapGestureRecognizer *)sender{
    [self.delegate holdDice:self];
}

-(int)roll{
    int randomNumber = arc4random_uniform(6) + 1;
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    img.image=[UIImage imageNamed:[NSString stringWithFormat:@"%iDie", randomNumber]];
    [self addSubview:img];

    self.text = @(randomNumber).description;

    return randomNumber;
}

-(void)resetBoard{
    self.backgroundColor = [UIColor whiteColor];
}

@end