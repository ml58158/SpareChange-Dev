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
#import "Transactions.h"
#import "Balance.h"

#define kaccesstoken


@interface TransactionViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSString *kaccessToken;
@property NSDictionary *transactionsDictionary;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property Accounts *accountsModel;
@property Transactions *transactionsModel;
@property Balance *balanceModel;




@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    //self.accountsModel.accessToken= [defaults stringForKey:kaccesstoken];
    NSLog(@" account populate test %@", self.accountsModel.id);
    //NSLog(@"Current Credentials are: %@", kaccesstoken.);
 //  [self populateAccountInformation];
 //   [self downloadTransactions];
}

-(void)populateAccountInformation {

[_client downloadAccountDetailsForAccessToken:self.accountsModel.accessToken account:self.accountsModel.id success:^(NSURLSessionDataTask *task, NSDictionary *accountDetails) {
    NSLog(@" account populate test @%@%lu", _id, (unsigned long)accountDetails.count);
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"Failed... :(");
}

 ];
};

    /**
     *  Download Transactions From Bank
     *
     *  @param task         download account transactions
     *  @param transactions account withdrawal, purchase, and deposit transactions
     *
     *  @return transactions Array
     */

-(void)downloadTransactions
{
    [self.client downloadTransactionsForAccessToken:self.accountsModel.accessToken pending:NO account:self.accountsModel.id sinceTransaction:nil gte:nil lte:nil success:^(NSURLSessionDataTask *task, NSArray *transactions) {
        NSLog(@" Transaction Successful %@", self.accountsModel.accessToken);
        NSLog(@"%li", (long) transactions.count);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Transaction Failed");
    }];
}



#pragma mark -UITableCell Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count %lu", (unsigned long)self.accountsModel.transactions.count);
    return 5;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionID"];


    Accounts *account = self.accountsModel.transactions[indexPath.row];
    NSLog(@"tableview test: %@", account.institutionType);
    cell.textLabel.text = account.institutionType;
    cell.detailTextLabel.text = account.Item;
    return cell;
};


@end
