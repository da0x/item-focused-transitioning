//
//  ViewController.m
//  Transistions
//
//  Created by Daher Alfawares on 1/17/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "ViewController.h"
#import "ItemFocusedTransitioning.h"

@interface ViewController ()

#pragma mark Item Focused Transitioning
@property IBOutlet UIImageView* viewForItemFocusedTransitioning;

@property IBOutlet UIImageView* keyItem1;
@property IBOutlet UIImageView* keyItem2;

@property ItemFocusedTransitioning* transitioning;
@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue.identifier isEqualToString:@"item1"] )
        self.viewForItemFocusedTransitioning = self.keyItem1;
    
    if( [segue.identifier isEqualToString:@"item2"] )
        self.viewForItemFocusedTransitioning = self.keyItem2;
}

- (IBAction)unwindToMainMenu:(UIStoryboardSegue*)sender
{
    self.presentingViewController.transitioningDelegate = self.transitioning = [[ItemFocusedTransitioning alloc] init];
    [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
}

@end
