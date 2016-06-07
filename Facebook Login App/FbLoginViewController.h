//
//  ViewController.h
//  Facebook Login App
//
//  Created by Jaswanth Jeenu on 07/06/16.
//  Copyright © 2016 Facebook Login App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FbLoginViewController : UIViewController<FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

- (IBAction)btnContWithFbClicked:(id)sender;

-(void)getFacebookProfileInfos;

@end

