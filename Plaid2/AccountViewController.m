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
@property (strong, nonatomic) NSDictionary *UserAccounts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *accounts;
@property (strong, nonatomic) NSArray *transactions;

@property PlaidHTTPClient *client;

@property Accounts *accountModel;
@property Transactions *transactionModel;
@property Balance *balanceModel;

@property NSString *accesstoken;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@" id %@", self.accountModel.id);
    //[self accountSelection];
    //[self accountInfo];
//NSLog(@"%@", accounts)

}


-(void)accountSelection
{
 self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
  //  NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    [CredentialStore getValueWithKey:@"accesstoken"];
    //self.transactions= [Transactions arrayOfModelsFromData:responseObject error:nil];
  


}


-(void)accountInfo
{
    NSLog(@"%@", self.accesstoken);
    [self.client downloadAccountDetailsForAccessToken:self.accesstoken account:[self.accountModel.accounts objectAtIndex:0] success:^(NSURLSessionDataTask *task, NSDictionary *accountDetails) {
        NSLog(@"Yahoooo... %@", self.accesstoken);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Noooo");
    }];

}


#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"TableView Count %li", (long)self.accountModel.accounts.count);
    return self.accountModel.accounts.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountID"];
    Accounts *accountInfo = self.accountModel.accounts[indexPath.row];
    NSLog(@"Index contents: %@", self.accountModel.accounts[indexPath.row]);
    cell.textLabel.text = accountInfo.accounts[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lf", self.balanceModel.current];
    return cell;
}
   @end
