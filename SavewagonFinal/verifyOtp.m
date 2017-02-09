//
//  verifyOtp.m
//  SavewagonFinal
//
//  Created by Jay Shah on 05/01/17.
//  Copyright © 2017 Jay Shah. All rights reserved.
//

#import "verifyOtp.h"

@interface verifyOtp ()

@end

@implementation verifyOtp

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)verify:(id)sender {
    NSString *post = [NSString stringWithFormat:@"mobileNumber=9860323444&otp=%@",_otp.text];
    NSLog(@"%@", post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://www.savewagon.com/api/matchOTP.php"]];
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSData *returnedData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://www.savewagon.com/api/matchOTP.php"]];
    
    if (returnedData) {
        NSLog(@"returnedData:%@", returnedData);
        
        NSDictionary *getResponse = [NSJSONSerialization JSONObjectWithData:returnedData options:kNilOptions error:Nil];
        NSLog(@"response:%@", getResponse);
        NSString *status = [getResponse objectForKey:@"status" ];
        NSLog(@"ststus:%@", status);
        if([status isEqualToString:@"1"]){
            NSLog(@"yes");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"OTP has been verified." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                        [alert show];
            
          
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
