//
//  ViewController.h
//  GetItDone
//
//  Created by Oscar on 9/29/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray                           *toDoArray;
@property (nonatomic, weak)   IBOutlet  UITableView             *toDoTableView;
@property (nonatomic, strong) NSManagedObjectContext            *managedObjectContext;

@end

