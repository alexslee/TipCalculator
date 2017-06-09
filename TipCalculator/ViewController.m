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

@property (weak, nonatomic) IBOutlet UILabel *tipDisplay;

@property (strong, nonatomic)NSNumber *tip;

@property (strong, nonatomic)NSNumber *total;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tip = [[NSNumber alloc] init];
    self.total = [[NSNumber alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
    NSString *baseInput = self.billAmountField.text;
    NSNumber *baseCost = [NSNumber numberWithFloat:[baseInput floatValue]];
    
    self.tip = [NSNumber numberWithFloat:[baseCost floatValue] * 0.15 ];
    self.total = [NSNumber numberWithFloat:[baseCost floatValue] * 1.15];
    
    self.tipDisplay.text = [NSString stringWithFormat:@"$%.2lf",[self.tip floatValue]];
}

@end
