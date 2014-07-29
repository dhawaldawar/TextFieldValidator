//
//  ViewController.m
//  TextFieldValidationDemo
//
//  Created by Dhawal.Dawar on 05/06/14.
//  Copyright (c) 2014 Dhawal.Dawar. All rights reserved.
//

#import "ViewController.h"
#import "TextFieldValidator.h"
#import "SecondViewController.h"

#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"

@interface ViewController (){
    IBOutlet TextFieldValidator *txtUserName;
    IBOutlet TextFieldValidator *txtEmail;
    IBOutlet TextFieldValidator *txtPassword;
    IBOutlet TextFieldValidator *txtConfirmPass;
    IBOutlet TextFieldValidator *txtPhone;
    SecondViewController *secondViewController;
}
- (IBAction)btnSubmit:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupAlerts];
}

-(void)setupAlerts{
    [txtUserName addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    [txtUserName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    txtUserName.validateOnResign=NO;
    
    [txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    [txtConfirmPass addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    
    [txtPhone addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
    txtPhone.isMandatory=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSubmit:(id)sender {
    if([txtUserName validate] & [txtEmail validate] & [txtPassword validate] & [txtConfirmPass validate] & [txtPhone validate]){
        secondViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondViewController"];
        [self.navigationController pushViewController:secondViewController animated:YES];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
