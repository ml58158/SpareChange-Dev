//
//  AccountViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "AccountViewController.h"
#import "PlaidHTTPClient.h"
#import "USAAViewController.h"
#import "TransactionViewController.h"
#import "Accounts.h"
#import "CredentialStore.h"

#define kaccesstoken @"access_token"


@interface AccountViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *accountNameButton;
@property (strong, nonatomic) NSDictionary *userAccounts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) NSArray *accounts;
@property (strong, nonatomic) NSArray *transactions;
@property (strong, nonatomic) NSDictionary *accountDict;
@property NSMutableArray *accountArray;

@property PlaidHTTPClient *client;

@property Transactions *transactionModel;
@property Balance *balanceModel;

@end



@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self accountSelection];
//    [self accountInfo];
//    NSLog(@"Access Token: %@", self.accesstoken);
//NSLog(@"%@", accounts)

    [self.client downloadAccountDetailsForAccessToken:self.accesstoken account:self.accountModel.id success:^(NSURLSessionDataTask *task, NSDictionary *accountDetails) {
        NSLog(@"Account Details: %@", accountDetails);
        NSLog(@"Account ID %@", self.accountModel.id);
        self.accountDict = accountDetails;
        self.balanceModel = [[Balance alloc] initWithDictionary:self.accountDict[@"balance"]];

        [self.tableView reloadData];
        
    } failure:nil];


}


-(void)accountSelection
{
 self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
  //  NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    [CredentialStore getValueWithKey:@"accesstoken"];
    //self.transactions= [Transactions arrayOfModelsFromData:responseObject error:nil];
  


}
/**
 *  Passes Account Data to TransactionViewController
 *
 *  @param segue  TransactionViewController
 *  @param sender AccountSelectionViewController
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TransactionSegue"]) {

    TransactionViewController *tvc = segue.destinationViewController;
    tvc.accesstoken = self.accesstoken;
    tvc.accountModel = self.accountModel;
    tvc.balanceModel = self.balanceModel;
    tvc.accountDict = self.accountDict;
}

}
#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"Count %lu", self.accountDict.count);
    return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountID"];
    self.accountModel = self.accountDict[@"id"][indexPath.row];
    NSLog(@"Index contents: %@", self.accountDict[@"meta"][@"name"]);
    NSLog(@"Balance: %f", self.balanceModel.available);
    cell.textLabel.text = self.accountDict[@"meta"][@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", self.balanceModel.available];
    return cell;
}
   @end
