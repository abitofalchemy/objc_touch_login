//
//  ABALoginTVC.h
//  ABALoginView
//
//  Created by Salvador Aguinaga on 5/30/13.
//  Copyright (c) 2013 Salvador Aguinaga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABALoginTVC : UITableViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NSURLConnectionDelegate> {
    NSArray *loginSections;
    NSArray *loginFields;
    NSMutableArray *loginBtnLabel;
    UITextField *username;
    UITextField *password;
    UILabel     *loginLabel;
    BOOL        retVal;
    
}
@property(nonatomic, weak) NSArray *loginSections;
@property(nonatomic, weak) NSArray *loginFields;
@property(nonatomic, weak) NSMutableArray *loginBtnLabel;
@property(nonatomic, weak) IBOutlet UITextField *username;
@property(nonatomic, weak) IBOutlet UITextField *password;
@property(nonatomic, weak) IBOutlet UILabel *loginLabel;
@property(nonatomic, assign) BOOL retVal;


- (void) showListOfSubjects;
- (void) reloadSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation;
- (void) registerUserWithUserAccountDictNotification:(NSNotification *)notification;
- (NSString *) writeDictionary:(NSDictionary *)dict outToURL:(NSURL *)url;
- (NSString *)stringFromDict:(NSDictionary *)dict;


//- (void) registerNewAdminInBackgroundUsing:(NSString *)emailAddr andPassword:(NSString *)accountPass;

@end
