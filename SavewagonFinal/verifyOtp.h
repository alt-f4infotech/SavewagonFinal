//
//  verifyOtp.h
//  SavewagonFinal
//
//  Created by Jay Shah on 05/01/17.
//  Copyright © 2017 Jay Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface verifyOtp : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, retain) NSString *data;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *verify;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UITextField *otp;

@end
