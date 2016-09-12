//
//  LoginViewController.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "LoginViewController.h"
#import "TVDBApi.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_passwordTextField setText:@"F3B58F92B55594B4"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login {
    // On vérifie si les champs sont pleins
    
    BOOL emptyTextFields = NO;
    
    if ([[_usernameTextField text] isEqualToString:@""]) {
        emptyTextFields = YES;
    }
    
    if ([[_passwordTextField text] isEqualToString:@""]) {
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
          authenticateWithUsername:[_usernameTextField text]
         andUserKey:[_passwordTextField text]
         ];
        
        NSLog(@"Tout est OK");
    }
}

@end
