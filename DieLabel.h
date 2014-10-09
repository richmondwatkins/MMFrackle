//
//  DieLabel.h
//  Farkle
//
//  Created by Richmond on 10/8/14.
//  Copyright (c) 2014 Richmond. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate
-(void)holdDice:(UILabel *)dieLabel;
@end

@interface DieLabel : UILabel

-(int)roll;
-(void)resetBoard;
@property id<DieLabelDelegate> delegate;

@end
