//
//  ABALoginTVC.m
//  ABALoginView
//
//  Created by Salvador Aguinaga on 5/30/13.
//  Copyright (c) 2013 Salvador Aguinaga. All rights reserved.
//

#import "ABALoginTVC.h"
#import "SubjectsViewController.h"
#import <Foundation/Foundation.h>

static NSString *const REGISTER_URL         = @"http://10.0.0.18/tremcam/putuserregister.php";


@interface ABALoginTVC ()

@end

@implementation ABALoginTVC
@synthesize loginSections   = _loginSections;
@synthesize loginFields     = _loginFields;
@synthesize loginBtnLabel   = _loginBtnLabel;
@synthesize username        = _username;
@synthesize password        = _password;
@synthesize loginLabel      = _loginLabel;
@synthesize retVal          = _retVal;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    loginSections = [[NSArray alloc] initWithObjects:@"Welcome", @"", nil];
    loginFields   = [[NSArray alloc] initWithObjects:@"email", @"password", nil];
    loginBtnLabel = [[NSMutableArray alloc] initWithObjects:@"Login", @"Register", nil];
    
    [self.navigationController.navigationBar setHidden:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [loginSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return [loginFields count];
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if ( indexPath.section == 0) {
        
        
        if (indexPath.row == 0) {
            username = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
            NSString *myString = [loginFields objectAtIndex:0];
            username .placeholder = myString;
            username .autocorrectionType = UITextAutocorrectionTypeNo;
            username.keyboardType = UIKeyboardTypeEmailAddress;
            [username setClearButtonMode:UITextFieldViewModeWhileEditing];
            username.delegate = self;
            cell.accessoryView = username;
        }
        if (indexPath.row == 1) {
            password = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];
            NSString *myString = [loginFields objectAtIndex:1];
            password.placeholder = myString;
            password.secureTextEntry = YES;
            password.autocorrectionType = UITextAutocorrectionTypeNo;
            [password setClearButtonMode:UITextFieldViewModeWhileEditing];
            //password.delegate = self;
            cell.accessoryView = password;
            
        }
    } else /*if (indexPath.section == 1)*/ {
        if (indexPath.row == 0) {
            NSString *myString = [loginBtnLabel objectAtIndex:0];
            cell.textLabel.text = myString;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.accessoryView = loginLabel;
        }
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 )
        return 85;
    else
        return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        lbl.textAlignment = NSTextAlignmentCenter;
        NSString *myString = [loginSections objectAtIndex:0];
        
        [lbl setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:18.]];
        //lbl.font = [UIFont systemFontOfSize:16];
        lbl.text = myString;//@"Welcome\nAdmin Sign In";
        lbl.numberOfLines = 2;
        lbl.backgroundColor = [UIColor clearColor];
        return lbl;
    } else
        return nil ;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
#pragma mark - TextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.username resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *nameTextField;
    
    nameTextField = username.text;
    //NSLog(@"nameTextField:%@",nameTextField);
    if ( [self isUsernameNew:username.text]){
        NSLog(@"keep button as login");
    }else{
        [loginBtnLabel replaceObjectAtIndex:0 withObject:@"Register"];
        //[self.tableView reloadData];
        //self.tableView set[username setText:nameTextField];
        [self reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        NSLog(@"change button to register");
    }
}

- (BOOL) isUserInNSUserDefaults: (NSString *)user havingPassword: (NSString *)pass
{
    BOOL returnVal = NO;
    // look for the saved search location in NSUserDefaults
    //NSLog(@"isUserInNSUserDefuaults");
    NSUserDefaults *userInLocal = [NSUserDefaults standardUserDefaults];
    NSString *adminKey = [userInLocal objectForKey:@"adminID"];
    NSString *passwKey = [userInLocal objectForKey:@"adminPass"];
    
    if (adminKey == nil || passwKey == nil) {
        returnVal = NO;
    } else {
        
        NSLog(@"*** Admin ID: %@ ***",adminKey);
        if (![adminKey isEqualToString:user] )
        {
            returnVal = NO;
        } else if (![passwKey isEqualToString:pass]){
            returnVal = NO;
        } else {
            
            //if ([adminKey isEqualToString:user] && [passwKey isEqualToString:pass]) {
            NSLog(@"*** in NSUserDefaults and a match ***");
            returnVal = YES;
        }
        /*else {
        NSLog(@"It looks like this is a new user");
        if (![self registerAdminUser:user userEmail:user userPassword:pass]){
            // Something prevented us from registering new user
            // We should default to guest account?
            NSLog(@"An error occurred");
        }
        [userInLocal setObject:user forKey:@"adminID"];
        [userInLocal setObject:pass forKey:@"adminPass"];
        [userInLocal synchronize];
        NSLog(@"Data saved");
        return YES;
         */
    }
    return returnVal;
}

- (BOOL) isUsernameNew: (NSString *)userStr
{   // is username (admin) text entered a new user?
    
    NSUserDefaults *userInLocal = [NSUserDefaults standardUserDefaults];
    NSString *adminKey = [userInLocal objectForKey:@"adminID"];
    NSLog(@"*** adminKey: %@ ***",adminKey);
    if ([adminKey isEqualToString:userStr] )
    {
        return YES;
    } else
        return NO; // user must be new
}
- (BOOL)registerAdminUser:(NSString *)userNm userEmail:(NSString *)email userPassword:(NSString *)passWrd
    /* https://gist.github.com/vksaini13/4509465 a gist
     * http://www.theappcodeblog.com/2011/05/16/nsnotificationcenter-tutorial-using-the-notification-center-in-your-iphone-app/
     * */
{
    NSLog(@"*** registerAdminUser ***");
    _retVal = NO;
    
    if ([self validUsername:email andPassword:passWrd]){
        // validate user email and password
        NSMutableDictionary *newUserDict = [[NSMutableDictionary alloc] init] ;
        [newUserDict setObject:userNm  forKey:@"user_name"];
        [newUserDict setObject:email   forKey:@"user_email"];
        [newUserDict setObject:passWrd forKey:@"user_passw"];
        
        // From the iOS6 book hardcoding
        NSString *urlAsString = REGISTER_URL;   //@"http://10.0.0.18/tremcam/putuserregister.php";
        urlAsString = [urlAsString stringByAppendingString:@"?email="];
        urlAsString = [urlAsString stringByAppendingString:email];
        urlAsString = [urlAsString stringByAppendingString:@"&name="];
        urlAsString = [urlAsString stringByAppendingString:userNm];
        urlAsString = [urlAsString stringByAppendingString:@"&passwrd="];
        urlAsString = [urlAsString stringByAppendingString:passWrd];
        
        NSURL *url = [NSURL URLWithString:urlAsString];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        [urlRequest setTimeoutInterval:30.0f];
        [urlRequest setHTTPMethod:@"POST"];
        
//        NSString *body = @"bodyParam1=BodyValue1&bodyParam2=BodyValue2";
//        [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:queue
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *error) {
                                               if ([data length] >0 && error == nil){
                                                   NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                   NSLog(@"HTML = %@", html);
                                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Response from server"
                                                                                                       message:html
                                                                                                      delegate:nil
                                                                                             cancelButtonTitle:@"OK"
                                                                                             otherButtonTitles:nil];
                                                   
                                                   //[alertView show];
                                                   [alertView performSelectorOnMainThread:@selector(show)
                                                                               withObject:nil
                                                                            waitUntilDone:YES];
                                                   
                                               }
                                               else if ([data length] == 0 && error == nil){
                                                   NSLog(@"Nothing was downloaded.");
                                                   
                                               }
                                               else if (error != nil){
                                                   NSLog(@"Error happened = %@", error);
                                                   
                                               }
                                           }];
        
        /*   or can we use :
         NSString *str = [self stringFromDict:dict];
         NSLog(@"from: writeDictionary:%@",str);
         NSData *myRequestData = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
         
        [[NSNotification ]removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newsfeedFetchCompleted:) name:kNewsfeedFetchCompleted object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"RegisterUserWithUserAccountDictNotification" object:self userInfo:newUserDict]];
        [[NSNotification defaultCenter]removeObserver:self];
        NSLog(@"Notification with dict: %@", newUserDict);
         */
        
        return _retVal = YES;
    }else
        return _retVal;
}

-(BOOL)validUsername:(NSString *)usr andPassword:(NSString *)pass{
    // here we need to check for more that just empty fields
    if (([usr length]==0) || ([pass length]==0)) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Username and Password fields must be completed."
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }else
        return YES;
    
}

-(void)registerUserWithUserAccountDictNotification:(NSNotification *)notification{
    
    NSLog(@"notification: %@", notification);
    
    NSMutableDictionary *accountDict = [notification object];
    NSString *emailStr = [accountDict objectForKey:@"user_email"];
    
    NSString *responseStr = [self writeDictionary:accountDict outToURL:[NSURL URLWithString:REGISTER_URL]];
    
    if ([responseStr isEqualToString:@"User Created"]) {
        
        NSString *alertViewStr =[NSString stringWithFormat:@"User: %@ created!", emailStr];
        NSString *message = @"Login to start updating your profile.";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewStr message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
        //        [alertView release];
    }
    else{
        if ([responseStr isEqualToString:@"User Taken"]) {
            NSString *alertViewStr =[NSString stringWithFormat:@"User: %@ taken.", emailStr];
            NSString *message = @"Choose a different email address";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewStr message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
            //            [alertView release];
            
        }
        else{ // the response string is malformed or reads error
            NSString *alertViewStr =[NSString stringWithFormat:@"Error"];
            NSString *message = @"The server could not create this username. Make sure you are connected to the internet or try again later.";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewStr message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
            //            [alertView release];
        }
        
    }
}
-(NSString *)writeDictionary:(NSDictionary *)dict outToURL:(NSURL *)url{
    /*  resources
     http://homepages.ius.edu/RWISMAN/C490/html/chapter22.htm
     http://stackoverflow.com/questions/1571336/sending-post-data-from-iphone-over-ssl-https
     http://stackoverflow.com/questions/3245191/send-nsmutablearray-as-json-using-json-framework?rq=1
     http://stackoverflow.com/questions/11527231/how-to-pass-nsarray-which-is-part-of-nsdictionary-in-http-get-method
     http://blogs.captechconsulting.com/blog/nathan-jones/getting-started-json-ios5
     
     */
    // HERE WE POST THE SENSOR DATA ARRAYS TO MYSQL
    
    //    NSArray * myA = [dict allKeys];
    //    NSString *key = [myA objectAtIndex:1];
    //    if ([key hasSuffix:@"axis"])//([key isKindOfClass:[NSMutableArray class]])
    //        str = [self stringFromDictWithArray:dict];
    //    else
    
    
    NSString *str = [self stringFromDict:dict];
    NSLog(@"from: writeDictionary:%@",str);
    NSData *myRequestData = [str dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: myRequestData];
    
    NSError *err;
    
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding] ;
    
    NSLog(@"Response string from writedict... is : %@",responseStr);
    return responseStr;
    
}
-(NSString *)stringFromDict:(NSDictionary *)dict{
    //NSLog(@"stringFromDict %d", dict.count);
    NSArray * myA = [dict allKeys];
    NSString *key;
    NSString *val;
    NSString *fullstr =@"";
    for (int i = 0; i < dict.count; i++) {
        key = [myA objectAtIndex:i];
        val = [dict objectForKey:key];
        fullstr = [fullstr stringByAppendingString:key];
        fullstr =  [fullstr stringByAppendingString:@"="];
        if ( [key hasSuffix:@"axis"] || [key hasPrefix:@"time"])
            fullstr  =[fullstr stringByAppendingString:[NSString stringWithFormat:@"=%@",val]];
        else
            fullstr  =[fullstr stringByAppendingString:val];
        if (i != (dict.count -1)) {
            fullstr = [fullstr stringByAppendingString:@"&"];
        }
    }
    return fullstr;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (indexPath.section == 1){
        // spinner in case? In this cell? -- no, autocomplete
        // IS INPUT OK  ?
        // IS INPUT IN NSPREFERENCES?
        if ( [self isUserInNSUserDefaults: username.text havingPassword:password.text]){
            NSLog(@"Already Stored Locally");
            [self showListOfSubjects];
        } else { // we are going to register the user in background
            NSLog(@"*** 1 looks like this is a new user ***");
            /*
            if (![self registerAdminUser:user userEmail:user userPassword:pass]){
                // Something prevented us from registering new user
                // We should default to guest account?
                NSLog(@"An error occurred");
                returnVal = NO;
            }else {
                [userInLocal setObject:user forKey:@"adminID"];
                [userInLocal setObject:pass forKey:@"adminPass"];
                [userInLocal synchronize];
                NSLog(@"*** Data saved to NSUserDefaults ***");
                returnVal = YES;
            }
            */

            NSArray* parts = [username.text componentsSeparatedByString: @"@"];
            //NSLog(@"%@",[parts objectAtIndex:0]);
            //NSLog(@"%@",username.text);
//            [self registerAdminUser:[parts objectAtIndex:0]
//                          userEmail:username.text
//                       userPassword:password.text];

            if (![self registerAdminUser:[parts objectAtIndex:0]
                               userEmail:username.text
                            userPassword:password.text])
            {
                // Something prevented us from registering new user
                // We should default to guest account?
                NSLog(@"An error occurred");
            }else {
                NSUserDefaults *userInLocal = [NSUserDefaults standardUserDefaults];
                [userInLocal setObject:username.text forKey:@"adminID"];
                [userInLocal setObject:password.text forKey:@"adminPass"];
                [userInLocal synchronize];
                NSLog(@"*** Data saved to NSUserDefaults ***");
            }

            //[self registerNewAdminInBackgroundUsing:username.text andPassword:password.text ];
            //NSLog(@"Encountered an error!");
            /* if All ok, then save user locally & proceed to subjects list with approved subjects*/
            [self showListOfSubjects];
        }
        
    }

}

- (void) reloadSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation {
    NSRange range = NSMakeRange(section, 1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.tableView reloadSections:sectionToReload withRowAnimation:rowAnimation];
}


- (void) showListOfSubjects
{
    //    NSMutableString *nsmstr = [NSMutableString stringWithString:username.text];
    //    [segue.destinationViewController setAdmin:nsmstr];
    //    [self  performSegueWithIdentifier:@"subjectsViewer" sender:self.view];
    //    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
    //                                    bundle:nil];
    //    SubjectsViewController  *controller = (SubjectsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"subjectsViewer"];
    //    controller.dataThatINeedFromTheFirstViewController = self.theDataINeedToPass;
    UIViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"subjectsViewer"];
    [self.navigationController pushViewController: myController animated:YES];
}


@end
