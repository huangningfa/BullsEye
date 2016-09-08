//
//  ViewController.m
//  BullsEye
//
//  Created by HNF's wife on 16/9/8.
//  Copyright © 2016年 huangningfa@163.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;

@end

@implementation ViewController{
    NSInteger _currentValue;
    NSInteger _targetValue;
    NSInteger _round;
    NSInteger _score;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startNewGame];
    
    [self updateLabel];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageNormal forState:(UIControlStateNormal)];
    [self.slider setThumbImage:thumbImageHighlighted forState:(UIControlStateHighlighted)];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 14, 0, 14);
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] resizableImageWithCapInsets:insets];
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] resizableImageWithCapInsets:insets];
    [self.slider setMinimumTrackImage:trackLeftImage forState:(UIControlStateNormal)];
    [self.slider setMaximumTrackImage:trackRightImage forState:(UIControlStateNormal)];
    
}
- (IBAction)showAlert:(UIButton *)sender {
    NSInteger diffrence = labs(_targetValue - _currentValue);
    NSInteger points = 100 - diffrence;
    NSString *title;
    if (diffrence == 0) {
        title = @"Perfect";
        points += 100;
        
    } else if (diffrence < 5){
        title = @"You almost had it!";
        if (diffrence == 1) {
            points += 50;
        }
    }else if (diffrence < 10){
        title = @"Pretty good!";
        
    }else {
        title = @"Not even close...";
    }
    
    _score += points;
    
    NSString *message = [[NSString alloc] initWithFormat:@"You scored %ld points", points];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self startNewRound];
        [self updateLabel];
    }];
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)sliderValueChange:(UISlider *)sender {
    _currentValue = lroundf(sender.value);
}

- (IBAction)startOver:(id)sender {
    [self startNewGame];
    [self updateLabel];
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = kCATransitionFade;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.duration = 1;
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (void)startNewGame {
    _round = 0;
    _score = 0;
    [self startNewRound];
}

- (void)startNewRound {
    _round += 1;
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    self.slider.value = _currentValue;
    
}

- (void)updateLabel {
    self.targetLabel.text = [[NSString alloc] initWithFormat:@"%ld", _targetValue];
    self.scoreLabel.text = [[NSString alloc] initWithFormat:@"%ld", _score];
    self.roundLabel.text = [[NSString alloc] initWithFormat:@"%ld", _round];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
