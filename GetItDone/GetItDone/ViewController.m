//
//  ViewController.m
//  GetItDone
//
//  Created by Oscar on 9/29/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ToDos.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AppDelegate  *appDelegate;

@end

@implementation ViewController

#pragma mark - Interactivity Methods

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Row to delete: %li",indexPath.row);
        ToDos *toDoToDelete = _toDoArray[indexPath.row];
        [_managedObjectContext deleteObject:toDoToDelete];
        [_appDelegate saveContext];
        _toDoArray = [self fetchToDos];
        [_toDoTableView reloadData];
    }
}

#pragma mark - Core Data Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _toDoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    ToDos *selectedToDo = _toDoArray[indexPath.row];
    cell.textLabel.text = [selectedToDo toDoName];
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    myDateFormatter.dateFormat = @"MMMM d, yyyy  h:mma";
    
    cell.detailTextLabel.text = [myDateFormatter stringFromDate:selectedToDo.toDoDueDate];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    return cell;
}

// This takes whatever was selected from the first controller and puts it in the Label
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"segueEditToDo"]) {
        NSIndexPath *indexPath = [_toDoTableView indexPathForSelectedRow];
        ToDos *selectedToDo = _toDoArray[indexPath.row];
        destController.selectedToDo = selectedToDo;
    }
    else if ([[segue identifier] isEqualToString:@"segueAddToDo"]) {
        destController.selectedToDo = nil;
    }
    
}

- (void)tempAddRecords {
    ToDos *newToDo = (ToDos *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDos" inManagedObjectContext:_managedObjectContext];
    // the user will enter this through a text field; we just hardcoded this for now
    newToDo.toDoName = @"ToDo Item";
    newToDo.toDoDescription = @"Here is the description";
    newToDo.toDoPriority = @"!!";
    newToDo.toDoCompleteDone = false;
    newToDo.dateEntered = [NSDate date];
    newToDo.userID = @"System";
    // this should only occur when the user hits the 'Save' button or when a new record is added
    [_appDelegate saveContext];
}

- (NSArray *)fetchToDos {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDos" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResults;
}

#pragma - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _toDoArray = [[NSArray alloc] init];
//    [self tempAddRecords];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _toDoArray = [self fetchToDos];
    [_toDoTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
