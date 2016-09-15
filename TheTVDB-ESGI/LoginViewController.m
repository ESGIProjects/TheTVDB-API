//
//  LoginViewController.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <SafariServices/SafariServices.h>

#import "LoginViewController.h"
#import "TVDBApi.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation LoginViewController
@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Facilité pour tester : champ pré-rempli
    [self.passwordTextField setText:@"F3B58F92B55594B4"];
    
    // Couleur des placeholders
    self.usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Identifiant"
                                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                                                    ];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Identifiant"
                                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                                                    ];
}

#pragma mark - Actions

- (IBAction)login {
    // On vérifie si les champs sont pleins
    
    BOOL emptyTextFields = NO;
    
    if ([[self.usernameTextField text] isEqualToString:@""]) {
        emptyTextFields = YES;
    }
    
    if ([[self.passwordTextField text] isEqualToString:@""]) {
        emptyTextFields = YES;
    }
    
    if (emptyTextFields) {
        // Il manque un champ, on prévient
        UIAlertController* alertController = [UIAlertController
                                              alertControllerWithTitle:@"Champs manquants"
                                              message:@"Tous les champs doivent être remplis !"
                                              preferredStyle:UIAlertControllerStyleAlert
                                              ];
        
        [alertController addAction:[UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        // On lance la requête de connexion
        
        [TVDBApi
         authenticateWithUsername:[self.usernameTextField text]
         andUserKey:[self.passwordTextField text]
         completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
             if ([(NSHTTPURLResponse*)response statusCode] == 200) {
                 NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                 NSString* token = jsonData[@"token"];
                 NSLog(@"%@", token);
                 
                 if (token) {
                     NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                     [defaults setObject:token forKey:@"token"];
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [self performSegueWithIdentifier:@"homeSegue" sender:nil];
                     });
                     
                     
                 }
             }
             else {
                 NSLog(@"%@", error.localizedDescription);
             }
         }];    }
}

- (IBAction)register {
    NSURL* registerURL = [NSURL URLWithString:@"http://thetvdb.com/?tab=register"];
    
    if ([SFSafariViewController class]) {
        SFSafariViewController* safariViewController = [[SFSafariViewController alloc] initWithURL:registerURL];
        
        [self presentViewController:safariViewController animated:YES completion:nil];
    }
    else {
        [[UIApplication sharedApplication] openURL:registerURL];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else {
        [self login];
    }
    
    return YES;
}



@end
