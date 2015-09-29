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

@property (nonatomic, strong) AppDelegate                       *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext            *managedObjectContext;
@property (nonatomic, strong) NSArray                           *toDoArray;
@property (nonatomic, weak)   IBOutlet  UITableView             *toDoTableView;

@end

@implementation ViewController

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
    cell.detailTextLabel.text = [selectedToDo toDoPriority];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// This takes whatever was selected from the first controller and puts it in the Label
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    NSIndexPath *indexPath = [_toDoTableView indexPathForSelectedRow];
    ToDos *selectedToDo = _toDoArray[indexPath.row];
    destController.selectedToDo = selectedToDo;
}

- (void)tempAddRecords {
    ToDos *newToDo = (ToDos *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDos" inManagedObjectContext:_managedObjectContext];
    // the user will enter this through a text field; we just hardcoded this for now
    newToDo.toDoName = @"ToDo Item";
    newToDo.toDoDescription = @"Here is the description";
    newToDo.dateEntered = [NSDate date];
    newToDo.toDoCompleteDone = false;
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
    [self tempAddRecords];
    _toDoArray = [self fetchToDos];
    NSLog(@"Count: %li",_toDoArray.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
