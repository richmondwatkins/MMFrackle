//
//  ViewController.m
//  Farkle
//
//  Created by Richmond on 10/8/14.
//  Copyright (c) 2014 Richmond. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"
@interface ViewController ()<DieLabelDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet DieLabel *die1;
@property (strong, nonatomic) IBOutlet DieLabel *die2;
@property (strong, nonatomic) IBOutlet DieLabel *die3;
@property (strong, nonatomic) IBOutlet DieLabel *die4;
@property (strong, nonatomic) IBOutlet DieLabel *die5;
@property (strong, nonatomic) IBOutlet DieLabel *die6;
@property NSMutableArray *dieLabels;
@property NSMutableArray *dice;
@property int score;
@property int roundScore;
@property NSMutableArray *currentBoard;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property BOOL isPlayerOne;
@property (strong, nonatomic) IBOutlet UILabel *playerTwoScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *playerOneScoreLabel;
@property int playerOneScore;
@property int playerTwoScore;
@property NSMutableArray *allLabels;
@end

@implementation ViewController

- (void)viewDidLoad {    [super viewDidLoad];
    self.die1.delegate = self;
    self.die2.delegate = self;
    self.die3.delegate = self;
    self.die4.delegate = self;
    self.die5.delegate = self;
    self.die6.delegate = self;

    self.dieLabels = [NSMutableArray arrayWithObjects:self.die1,
                      self.die2,
                      self.die3,
                      self.die4,
                      self.die5,
                      self.die6,
                      nil];
    self.dice =  [[NSMutableArray alloc]init];
     self.roundScore = 0;
     self.score = 0;
    self.currentBoard = [[NSMutableArray alloc] init];
    self.allLabels = [[NSMutableArray alloc]init];
    self.isPlayerOne = YES;
}

-(void)holdDice:(DieLabel *)dieLabel{
    dieLabel.backgroundColor = [UIColor grayColor];

    [self.allLabels addObject:dieLabel];
    [self.dice addObject:dieLabel];
    [self.dieLabels removeObject:dieLabel];
    [self accumulateScore];
}


- (IBAction)onRollButtonPressed:(id)sender {
    [self.dice removeAllObjects];
    self.roundScore = 0;
    for(DieLabel *die in self.dieLabels){
      [self.currentBoard addObject:[NSNumber numberWithInt:[die roll]]];
    }
    if ([self checkFrackle] == YES) {
        self.score = 0;
        [self alertFrackle];
    }
}


-(BOOL)checkFrackle{
    BOOL isFrackle = YES;
    NSArray *diceNums = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    NSMutableArray *checkForScore = [[NSMutableArray alloc] init];
    for(NSString *num in diceNums){
        for(NSNumber *die in self.currentBoard){
            if ([die intValue] == num.intValue) {
                [checkForScore addObject:die];
            }

        }
        if (checkForScore.count) {
            NSNumber *dieNum = checkForScore[0];
            if (checkForScore.count == 3) {
                switch ([dieNum intValue]) {
                    case 1:
                        isFrackle = NO;
                        break;
                    case 2:
                        isFrackle = NO;
                        break;
                    case 3:
                        isFrackle = NO;
                        break;
                    case 4:
                        isFrackle = NO;
                        break;
                    case 5:
                        isFrackle = NO;
                        break;
                    case 6:
                        isFrackle = NO;
                        break;
                    default:
                        break;
                }
            }

            if (checkForScore.count < 3) {
                switch ([dieNum intValue]) {
                    case 1:
                        isFrackle = NO;
                        break;
                    case 5:
                        isFrackle = NO;
                        break;
                    default:
                        break;
                }
            }
        }
        [checkForScore removeAllObjects];
    }
    [self.currentBoard removeAllObjects];
    return isFrackle;
}

-(void)alertFrackle{
    (self.isPlayerOne) ? self.isPlayerOne = NO : (self.isPlayerOne = YES);
    UIAlertView *alertFrackle = [[UIAlertView alloc]init];
    alertFrackle.delegate = self;
    alertFrackle.title = @"Farkled!";
    alertFrackle.message = @"There are no moves on the board!";
    [alertFrackle addButtonWithTitle:@"Next Turn"];
    [alertFrackle show];
}

-(void)accumulateScore{
    self.score = self.score - self.roundScore;
    self.roundScore = 0;
    NSArray *diceNums = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    NSMutableArray *checkForScore = [[NSMutableArray alloc] init];
    for(NSString *num in diceNums){
        for(DieLabel *die in self.dice){
            if (die.text.integerValue == num.integerValue) {
                [checkForScore addObject:die];
            }

        }
        if (checkForScore.count) {
            if (checkForScore.count == 3) {
                DieLabel *dieNum = checkForScore[0];
                switch (dieNum.text.integerValue) {
                    case 1:
                        self.roundScore += 1000;
                        break;
                    case 2:
                        self.roundScore+= 200;
                        break;
                    case 3:
                        self.roundScore += 300;
                        break;
                    case 4:
                        self.roundScore += 400;
                        break;
                    case 5:
                        self.roundScore += 500;
                        break;
                    case 6:
                        self.roundScore += 600;
                        break;
                    default:
                        self.roundScore += 0;
                        break;
                }
            }

            if (checkForScore.count < 3) {
                DieLabel *dieNum = checkForScore[0];
                switch (dieNum.text.integerValue) {
                    case 1:
                        self.roundScore += (int)checkForScore.count * 100;
                        break;
                    case 5:
                        self.roundScore += (int)checkForScore.count * 50;
                        break;
                    default:
                        self.roundScore += 0;
                        break;
                }
            }

        }
        [checkForScore removeAllObjects];
    }

    self.score += self.roundScore;
    self.scoreLabel.text = @(self.score).description;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%li", (long)buttonIndex);

    [self changePlayer];
}

- (IBAction)onPressBankScoreButton:(id)sender {
    [self changePlayer];
}

-(void)changePlayer{
    if([self.whichPlayerLabel.text isEqualToString:@"Player 1"]){
        self.isPlayerOne = NO;
        self.whichPlayerLabel.text = @"Player 2";
        self.playerOneScore += self.score;
        self.playerOneScoreLabel.text = @(self.playerOneScore).description;
    }else{
        self.isPlayerOne = YES;
        self.whichPlayerLabel.text = @"Player 1";
        self.playerTwoScore += self.score;
        self.playerTwoScoreLabel.text = @(self.playerTwoScore).description;
    }

    if (self.playerTwoScore >= 1000 || self.playerOneScore >= 1000) {
        [self alertWinner];
    }

    for(DieLabel *die in  self.allLabels){
        [die resetBoard];
        [die roll];
    }

    self.score = 0;
    self.roundScore = 0;
    [self.dice removeAllObjects];
    self.scoreLabel.text = @(self.score).description;
}

-(void)alertWinner{
    UIAlertView *alertWinner = [[UIAlertView alloc]init];
    alertWinner.delegate = self;
    alertWinner.title = @"Winner!";
    if (self.isPlayerOne) {
        alertWinner.message = [NSString stringWithFormat:@"%@ is the winner!", @"Player 1"];
    }else{
        alertWinner.message = [NSString stringWithFormat:@"%@ is the winner!", @"Player 2"];
    }
    self.playerOneScore = 0;
    self.playerOneScoreLabel.text = @(0).description;
    self.playerTwoScore = 0;
    self.playerTwoScoreLabel.text = @(0).description;

    [alertWinner addButtonWithTitle:@"Play Again"];
    [alertWinner show];

}


@end
