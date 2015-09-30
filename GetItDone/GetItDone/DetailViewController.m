//
//  DetailViewController.m
//  GetItDone
//
//  Created by Oscar on 9/29/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "ToDos.h"
#import "AppDelegate.h"


@interface DetailViewController ()

@property (nonatomic, strong)          AppDelegate              *appDelegate;
@property (nonatomic, strong)          NSManagedObjectContext   *managedObjectContext;
@property (nonatomic, weak)   IBOutlet UITextField              *selectedToDoTextField;
@property (nonatomic, weak)   IBOutlet UITextView               *selectedToDoTextView;
@property (nonatomic, weak)   IBOutlet UISegmentedControl       *prioritySegment;
@property (nonatomic, weak)   IBOutlet UISwitch                 *completedSwitch;
@property (nonatomic, weak)   IBOutlet UIDatePicker             *dueDatePicker;

@end

@implementation DetailViewController

#pragma mark - Interactivity Methods

- (void)saveAndPop {
    [_appDelegate saveContext];
    // The navigation controller is boss. Pop means 'get rid of' and removes views one at a time
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)saveButtonPressed:(id)sender {
    _selectedToDo.toDoName = _selectedToDoTextField.text;
    _selectedToDo.toDoDescription = _selectedToDoTextView.text;
    _selectedToDo.toDoPriority = [_prioritySegment titleForSegmentAtIndex:_prioritySegment.selectedSegmentIndex];
    _selectedToDo.toDoCompleteDone = [NSNumber numberWithBool:_completedSwitch.isOn];
    _selectedToDo.toDoDueDate = _dueDatePicker.date;
    _selectedToDo.dateUpdated = [NSDate date];
    _selectedToDo.userID = @"System";
    [self saveAndPop];
}

- (IBAction)deleteToDo:(id)sender {
    [_managedObjectContext deleteObject:_selectedToDo];
    [self saveAndPop];
    NSLog(@"Delete button hit");
}

- (void)todoTextViewChanged:(UITextView *)textViewChanged {
    NSLog(@"Description is %@",textViewChanged.text);
}

- (IBAction)toDoComplete:(UISwitch *)completeSwitch {
    NSLog(@"Complete switch %i",completeSwitch.isOn);
}

- (IBAction)prioritySet:(UISegmentedControl *)prioritySeg {
    NSString *nameString = [_prioritySegment titleForSegmentAtIndex:prioritySeg.selectedSegmentIndex];
    NSLog(@"Set the priority to %@",nameString);
}

- (IBAction)dueDateChanged:(UIDatePicker *)datePicker {
    NSLog(@"Date %@",datePicker.date);
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_selectedToDo != nil) {
        NSLog(@"EDIT");
        _selectedToDoTextField.text = _selectedToDo.toDoName;
        _selectedToDoTextView.text = _selectedToDo.toDoDescription;
        if ([_selectedToDo.toDoPriority isEqualToString:@"!"]) {
            [_prioritySegment setSelectedSegmentIndex:0];
        } else if ([_selectedToDo.toDoPriority isEqualToString:@"!!"]) {
            [_prioritySegment setSelectedSegmentIndex:1];
        } else if ([_selectedToDo.toDoPriority isEqualToString:@"!!!"]) {
            [_prioritySegment setSelectedSegmentIndex:2];
        }
        _completedSwitch.on = [_selectedToDo.toDoCompleteDone boolValue];
        _dueDatePicker.date = _selectedToDo.toDoDueDate;
        
    } else {
        NSLog(@"NEW");
        ToDos *newToDo = (ToDos *)[NSEntityDescription insertNewObjectForEntityForName:@"ToDos" inManagedObjectContext:_managedObjectContext];
        newToDo.dateEntered = [NSDate date];
        _selectedToDo = newToDo;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
