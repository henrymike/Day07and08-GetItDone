//
//  DetailViewController.m
//  GetItDone
//
//  Created by Oscar on 9/29/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField        *selectedToDoTextField;
@property (nonatomic, weak) IBOutlet UISwitch           *completedSwitch;
@property (nonatomic, weak) IBOutlet UISegmentedControl *prioritySegment;
@property (nonatomic, weak) IBOutlet UIDatePicker       *dueDatePicker;

@end

@implementation DetailViewController

#pragma mark - Interactivity Methods

- (IBAction)toDoTextFieldChanged:(UITextField *)textFieldChanged {
    NSLog(@"Title is %@",_selectedToDoTextField.text);
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
    _selectedToDoTextField.text = [_selectedToDo toDoName];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
