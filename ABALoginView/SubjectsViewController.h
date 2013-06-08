//
//  SubjectsViewController.h
//  ABALoginView
//
//  Created by Salvador Aguinaga on 5/19/13.
//  Copyright (c) 2013 Salvador Aguinaga. All rights reserved.
//

@interface SubjectsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *fieldLabels;
}

-(void)setAdmin:(NSMutableString*)adminuser;
@end
