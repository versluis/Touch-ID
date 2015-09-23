//
//  ViewController.m
//  Touch ID
//
//  Created by Jay Versluis on 23/09/2015.
//  Copyright © 2015 Pinkstone Pictures LLC. All rights reserved.
//

#import "ViewController.h"
@import LocalAuthentication;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authenticateTouchID {
    
    // create a context and error object
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    NSString *reason = @"We want to authenticate your fingerprints";
    
    // check if the device supports Touch ID
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        NSLog(@"Device supports Touch ID");
        
        // authenticate the user
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            
            // it worked!
            if (success) {
                NSLog(@"Successfully authenticated the user via Touch ID. HUZZAH!");
            } else {
                NSLog(@"Could not authenticate the user via Touch ID. \nReason: %@ \nError Code: %ld", error.localizedDescription, error.code);
                
                // if the user chooses the password option
                if (error.code == -3) {
                    // handle password input here
                    NSLog(@"Let's ask for your password instead");
                }
            }
        }];
        
    } else {
        // Touch ID is not available
        NSLog(@"Touch ID is not available.");
    }
}




@end
