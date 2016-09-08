//
//  AboutViewController.m
//  BullsEye
//
//  Created by HNF's wife on 16/9/8.
//  Copyright © 2016年 huangningfa@163.com. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSURL *baseURL = [NSURL URLWithString:[NSBundle mainBundle].bundlePath];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
}

- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
