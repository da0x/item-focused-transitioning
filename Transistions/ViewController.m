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
@property ItemFocusedTransitioning* customTransitioning;

#pragma mark Item Focused Transitioning
@property IBOutlet UIImageView* viewForItemFocusedTransitioning;
@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.customTransitioning = [[ItemFocusedTransitioning alloc] init];
    self.transitioningDelegate = self.customTransitioning;
}

-(IBAction)present:(id)sender
{
    UIViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"vc1"];
    viewController.transitioningDelegate = self.customTransitioning;
    [self presentViewController:viewController animated:true completion:nil];
}

-(IBAction)dismiss:(id)sender
{
    self.presentingViewController.transitioningDelegate = self.customTransitioning;
    [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
}

@end
