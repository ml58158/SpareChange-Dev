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
#import "Accounts.h"
#import "CredentialStore.h"

#define kaccesstoken @"access_token"


@interface AccountViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *accountNameButton;
@property (strong, nonatomic) NSDictionary *userAccounts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *accounts;
@property (strong, nonatomic) NSArray *transactions;
@property (strong, nonatomic) NSDictionary *accountDict;

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

        accountDetails = self.accountDict;

        if (task) {
            NSLog(@"Task");
        } else if (accountDetails) {
            NSLog(@"Account Details");
        }
    } failure:nil];

    [self.tableView reloadData];

}


-(void)accountSelection
{
 self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
  //  NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    [CredentialStore getValueWithKey:@"accesstoken"];
    //self.transactions= [Transactions arrayOfModelsFromData:responseObject error:nil];
  


}




#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Count %lu", (unsigned long)[self.accountDict[@"id"]count]);
    return [self.accountDict[@"id"]count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountID"];
    Accounts *accountInfo = self.accountDict[@"id"][indexPath.row];
    Balance *balance = self.balanceModel;
    NSLog(@"Index contents: %@", self.accountDict[@"id"]);
    cell.textLabel.text = accountInfo.id;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lf", balance.current];
    return cell;
}
   @end
