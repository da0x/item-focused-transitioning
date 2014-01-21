//
//  CustomAnimation.m
//  Transistions
//
//  Created by Daher Alfawares on 1/17/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "ItemFocusedTransitioning.h"

@implementation ItemFocusedTransitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [ItemFocusedAnimationController new];
}

@end


@interface ItemFocusedAnimationController()
@property CGRect originalSourceRect;
@end

@implementation ItemFocusedAnimationController

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController<ItemFocusedTransitionProtocol>* sourceViewController      = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController<ItemFocusedTransitionProtocol>* destinationViewController = (id)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView*       container = [transitionContext containerView];
    
        // TODO: add safe checks.
    UIView* sourceView      = [sourceViewController viewForItemFocusedTransitioning];
    UIView* destinationView = [destinationViewController viewForItemFocusedTransitioning];
    
        // get destination frame.
    CGRect destinationRect = [self rectForView:destinationView inViewController:destinationViewController];
    CGRect sourceRect      = [self rectForView:sourceView inViewController:sourceViewController];

    [UIView animateWithDuration:.5 animations:^{
        sourceView.frame = destinationRect;
    } completion:^(BOOL finished) {
    

        [container addSubview:destinationViewController.view];
        [destinationViewController.view setAlpha:0];
        
        [UIView animateWithDuration:.5 animations:^{
            [destinationViewController.view setAlpha:1];
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:true];
        }];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

#pragma mark helpers


-(CGRect)rectForView:(UIView*)view inViewController:(UIViewController*)viewController
{
        // get destination frame.
    CGRect rect;
    
        // Assume that destinationView is not always a direct subview of destinationViewController.view.
    if( viewController.view != view.superview )
    {
        rect = [viewController.view convertRect:view.frame fromView:view];
    }
    else
    {
        rect = view.frame;
    }
    
    return rect;
}

@end



