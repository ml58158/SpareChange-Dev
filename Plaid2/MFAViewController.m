//
//  MFAViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/16/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "MFAViewController.h"

@interface MFAViewController ()
@property (strong, nonatomic) IBOutlet UILabel *mfaQuestionLabel;
@property (strong, nonatomic) IBOutlet UITextField *mfaResponseTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;



@end

@implementation MFAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mfaResponseTextField.text = self.MFAResponseText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
