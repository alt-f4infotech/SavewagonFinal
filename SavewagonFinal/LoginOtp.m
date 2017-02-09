//
//  LoginOtp.m
//  SavewagonFinal
//
//  Created by Jay Shah on 05/01/17.
//  Copyright © 2017 Jay Shah. All rights reserved.
//

#import "LoginOtp.h"
//#import "verifyOtp.h"

@interface LoginOtp ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation LoginOtp
@synthesize responseData = _responseData;
- (IBAction)cancel:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self presentViewController:vc animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)hitSendOtpApi:(id)sender {
    if(self.mobileNumber.text == nil || [self.mobileNumber.text isEqualToString:@""]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please Enter Mobile Number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
    NSString *post = [NSString stringWithFormat:@"mobileNumber=%@",_mobileNumber.text];
    NSLog(@"%@", post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://www.savewagon.com/api/sendOTP.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
        
    } else {
        NSLog(@"Connection could not be made");
    }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSData *returnedData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://www.savewagon.com/api/sendOTP.php"]];
    
    if (returnedData) {
        NSLog(@"returnedData:%@", returnedData);
        
        NSDictionary *getResponse = [NSJSONSerialization JSONObjectWithData:returnedData options:kNilOptions error:Nil];
        NSLog(@"response:%@", getResponse);
        NSString *status = [getResponse objectForKey:@"status" ];
        NSLog(@"status:%@", status);
        if([status isEqualToString:@"1"]){
            NSLog(@"yes");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"OTP has been sent on this number." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            [alert show];
            
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"verifyOtp"];
            [self presentViewController:vc animated:YES completion:nil];
        }
      
        
        
    }
    else
        NSLog(@"Got Nothing");
    
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
