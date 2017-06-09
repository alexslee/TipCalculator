//
//  ViewController.m
//  TipCalculator
//
//  Created by Alex Lee on 2017-06-08.
//  Copyright © 2017 Alex Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountField;

@property (weak, nonatomic) IBOutlet UISlider *tipSlider;

@property (weak, nonatomic) IBOutlet UILabel *tipPercentDisplay;

@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;

@property (strong, nonatomic)NSNumber *tip;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tip = [[NSNumber alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrameNotificationHandler:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (IBAction)tapHandler:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    if (sender == self.tipSlider) {
        self.tipPercentDisplay.text = [NSString stringWithFormat:@"%.0lf%%",floor(self.tipSlider.value)];
        
        [self updateTipAmount];
    }
}

- (void)updateTipAmount;
{
    float tipRawNum = floor(self.tipSlider.value);
    float tipPercent = (tipRawNum == 0) ? 0.15 : tipRawNum / 100;
    
    NSString *baseInput = self.billAmountField.text;
    NSNumber *baseCost = [NSNumber numberWithFloat:[baseInput floatValue]];
    
    self.tip = [NSNumber numberWithFloat:[baseCost floatValue] * tipPercent ];
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2lf",[self.tip floatValue]];
}

- (void)keyboardDidChangeFrameNotificationHandler:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSLog(@"Keyboard changed frame!!");
    
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    NSLog(@"Height: %f", keyboardHeight);
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = keyboardHeight;
        self.scrollView.contentInset = insets;
        self.scrollView.scrollIndicatorInsets = insets;
    }];
}


@end
