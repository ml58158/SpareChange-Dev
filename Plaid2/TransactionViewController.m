//
//  TransactionViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "PlaidHTTPClient.h"
#import "TransactionViewController.h"
#import "USAAViewController.h"
#import "Accounts.h"
#import "Transactions.h"
#import "Balance.h"


@interface TransactionViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSDictionary *transactionsDictionary;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property Transactions *transactionsModel;
@property NSDictionary *transactionDict;
@property NSArray *transactionsArray;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
    NSLog(@"Account model in Trans: %@", self.accountModel);
    [self downloadTransactions];
}

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
    [self.client downloadTransactionsForAccessToken:self.accesstoken pending:NO account:self.accountModel.id sinceTransaction:nil gte:nil lte:nil success:^(NSURLSessionDataTask *task, NSArray *transactions) {
        NSLog(@"TransactionsArray contains: %@", transactions); //returns sucessful
//        NSArray *transactionsArray = transactions; //populates correctly
//        transactions = [self.transactionDict allKeys];
//        NSLog(@"Transaction Array %@", transactionsArray);
//        //self.transactionsModel = [[Transactions alloc] initWithDictionary:self.accountDict[@"transactions"]];
//        NSLog(@" Transaction Successful %@", self.transactionsArray);
//        NSLog(@"%li", (long) self.transactionDict.count);



//        //gabe
//        self.transactionsArray = [NSMutableArray arrayWithArray:transactions];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:transactions];
        for (NSDictionary *dict in temp) {
            Transactions *transactions = [[Transactions alloc] initWithDictionary:dict];
            [temp addObject:transactions];
        }




        self.transactionsModel = [[Transactions alloc] initWithDictionary:self.accountDict[@"transactions"]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Transaction Failed");

    }];
[self.tableView reloadData];
}



#pragma mark -UITableCell Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.transactionsArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionID"];
    self.transactionsModel = self.transactionDict[@"_id"][indexPath.row];
    //NSLog(@"Transactions: %@", [self.transactionsArray objectAtIndex:1]);
    cell.textLabel.text = [self.transactionsArray objectAtIndex:10];
    cell.detailTextLabel.text = [self.transactionsArray objectAtIndex:1];
    return cell;
};

@end
