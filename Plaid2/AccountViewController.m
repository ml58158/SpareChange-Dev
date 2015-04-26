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

@interface AccountViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *accountNameButton;
@property (strong, nonatomic) NSDictionary *UserAccounts;

@property PlaidHTTPClient *client;

//@property NSMutableArray *AccountName;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//NSLog(@"%@", accounts)

}

NSArray* models = [Accounts arrayOfModelsFromDictionaries: Accounts.Accounts];

-(void)accountSelection
{
 self.client = [PlaidHTTPClient sharedPlaidHTTPClient];
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    NSString *kaccesstoken = [defaults stringForKey:@"access_token"];

    [self.client downloadAccountDetailsForAccessToken:kaccesstoken account:Accounts.id success:^(NSURLSessionDataTask *task, NSDictionary *accountDetails) {
        <#code#>
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        <#code#>
    }];

}


#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    return cell;
}

   @end
