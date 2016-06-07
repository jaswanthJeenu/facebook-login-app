//
//  ViewController.m
//  Facebook Login App
//
//  Created by Jaswanth Jeenu on 07/06/16.
//  Copyright © 2016 Facebook Login App. All rights reserved.
//

#import "FbLoginViewController.h"

@interface FbLoginViewController ()

@end

@implementation FbLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    [self getFacebookProfileInfos];
    loginButton.delegate = self;
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @abstract Sent to the delegate when the button was used to login.
 @param loginButton the sender
 @param result The results of the login
 @param error The error (if any) from the login
 */
- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {
    NSLog(@"loginButton:didCompleteWithResult:error");
    NSDictionary *temp = @{};
    [temp description];
//    NSLog(@"Result after login: %@", [result description]);        Using this, we cannot fetch the profile's details because the 'description' method in the Custom object - 'result' is not overridden y the frameworj developers in this version of SDK.
}

/*!
 @abstract Sent to the delegate when the button was used to logout.
 @param loginButton The button that was clicked.
 */
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"loginButtonDidLogOut");
}

- (IBAction)btnContWithFbClicked:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             [self getFacebookProfileInfos];
         }
     }];
}

-(void)getFacebookProfileInfos {
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:parameters];
    
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        NSLog(@"Result: %@", result);
        if(result)
        {
            if ([result objectForKey:@"email"]) {
                
                NSLog(@"Email: %@",[result objectForKey:@"email"]);
                
            }
            if ([result objectForKey:@"name"]) {
                
                NSLog(@"Name : %@",[result objectForKey:@"name"]);
                
            }
            if ([result objectForKey:@"id"]) {
                
                NSLog(@"User id : %@",[result objectForKey:@"id"]);
                
            }
            
        }
        
    }];
    
    [connection start];
}
@end
