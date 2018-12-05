#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNKObjcActivityIndicator : UIView

@property(nonatomic, readonly, getter=isAnimating) BOOL animating;

@property (nonatomic, null_resettable) UIColor *color;

- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
