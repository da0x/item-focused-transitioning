//
//  CustomAnimation.h
//  Transistions
//
//  Created by Daher Alfawares on 1/17/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemFocusedTransitionProtocol
@required
-(UIView*)viewForItemFocusedTransitioning;
@end

@interface ItemFocusedTransitioning : NSObject<UIViewControllerTransitioningDelegate>
@end

@interface ItemFocusedAnimationController : NSObject<UIViewControllerAnimatedTransitioning>
@end


@interface ItemFocusedDismissAnimationController : ItemFocusedAnimationController
@end