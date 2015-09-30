//
//  DetailViewController.h
//  GetItDone
//
//  Created by Oscar on 9/29/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDos.h"

@interface DetailViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) ToDos *selectedToDo;

@end
