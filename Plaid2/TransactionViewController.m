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

//#define kaccesstoken

@interface TransactionViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSString *kaccessToken;
@property NSDictionary *transactionsDictionary;
//@property NSArray *transactions;
//@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString *kaccesstoken = [defaults stringForKey:@"access_token"];

    /**
     *  Download Transactions From Bank
     *
     *  @param task         download account transactions
     *  @param transactions account withdrawal, purchase, and deposit transactions
     *
     *  @return transactions Array
     */
[self.client downloadTransactionsForAccessToken:kaccesstoken pending:NO account:nil sinceTransaction:nil gte:nil lte:nil success:^(NSURLSessionDataTask *task, NSArray *transactions) {
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
