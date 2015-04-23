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

#define kid @"Pzx7wPZvymSnn5QnMp86SZzMDnRLgyc1v65Ap"
#define kaccesstoken @"cd5bffcb464c465058ff9ee2798d3949d2250e98cd36ab427f2c7d6139dd699217e6d67bb7625eb97a882a3f4310490e85e300438ce710a72898d7555ef1248dbc65a036cba5f42806ad894894b4ee23"

@interface TransactionViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSString *accessToken;
@property NSDictionary *transactionsDictionary;
//@property NSArray *transactions;
//@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
[self.client downloadTransactionsForAccessToken:kaccesstoken pending:NO account:kid sinceTransaction:nil gte:nil lte:nil success:^(NSURLSessionDataTask *task, NSArray *transactions) {
    NSLog(@"%@",transactions);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"Transaction Failed");
}

 ];
};






#pragma mark -UITableCell Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.transactionsDictionary allKeys] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionID"];

    NSArray *sortedKeys = [[self.transactionsDictionary allKeys]sortedArrayUsingSelector:@selector(compare:)];
    NSString *key = sortedKeys[indexPath.row];

    NSDictionary *accountDetails = self.transactionsDictionary[key];
    NSLog(@"test: %@", self.transactionsDictionary[@"_id"]);

    cell.textLabel.text = accountDetails[@"_id"];
    cell.detailTextLabel.text = accountDetails [@"_item"];
    return cell;
};


@end
