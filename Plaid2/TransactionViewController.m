//
//  TransactionViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "TransactionViewController.h"
#import "PlaidHTTPClient.h"
#import "USAAViewController.h"
#import "Accounts.h"

#define kid @"xjBZYDZBBZI16xVzz50As3axbZaKY3uLyK8Dd"
#define kaccesstoken @"cd5bffcb464c465058ff9ee2798d3949d2250e98cd36ab427f2c7d6139dd699217e6d67bb7625eb97a882a3f4310490e85e300438ce710a72898d7555ef1248dbc65a036cba5f42806ad894894b4ee23"

@interface TransactionViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSString *accessToken;
//@property NSArray *transactions;
//@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
[_client downloadAccountDetailsForAccessToken:kaccesstoken account:kid success:^(NSURLSessionDataTask *task, NSDictionary *accountDetails) {
    NSLog(@"%@", accountDetails);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"Failure %@",error);
}];

}
#pragma mark -UITableCell Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.transactions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionID"];
    cell.textLabel.text = @"Name";
    cell.detailTextLabel.text = @"Amount";
    return cell;
};


@end
