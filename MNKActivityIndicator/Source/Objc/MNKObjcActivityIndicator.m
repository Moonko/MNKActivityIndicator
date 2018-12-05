#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MNKObjcActivityIndicator.h"

static const CFTimeInterval kAnimationDuration = 1.0;

static const NSUInteger kPetalCount = 12;
static const CGSize kPetalSize = { 3, 9 };
static const CGFloat kPetalCornerRadius = 1;

@interface MNKObjcActivityIndicator()

@property(nonatomic, readwrite) BOOL animating;

@property(nonatomic, readwrite) CAShapeLayer *petalLayer;
@property(nonatomic, readwrite) CAReplicatorLayer *replicatorLayer;

@end

@implementation MNKObjcActivityIndicator

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    [self setupLayers];
    [self updateHiddenState];
}

- (CGSize)intrinsicContentSize {
    CGFloat sizeLength = kPetalSize.height * 4;
    return CGSizeMake(sizeLength, sizeLength);
}

- (void)setupLayers {
    _petalLayer = [[CAShapeLayer alloc] init];
    _petalLayer.opacity = 0.0;
    _petalLayer.fillColor = UIColor.grayColor.CGColor;

    _replicatorLayer = [[CAReplicatorLayer alloc] init];
    _replicatorLayer.instanceCount = kPetalCount;
    CGFloat angle = (2.0 * M_PI) / kPetalCount;
    _replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    _replicatorLayer.instanceDelay = kAnimationDuration / kPetalCount;

    [_replicatorLayer addSublayer:_petalLayer];
    [self.layer addSublayer:_replicatorLayer];
}

- (void)updateHiddenState {
    [self setHidden:!self.isAnimating];
}

- (void)setColor:(UIColor *)color {
    if (color) {
        self.petalLayer.fillColor = color.CGColor;
    } else {
        self.petalLayer.fillColor = UIColor.clearColor.CGColor;
    }
}

- (UIColor *)color {
    CGColorRef currentColor = self.petalLayer.fillColor;
    if (currentColor) {
        return [[UIColor alloc] initWithCGColor:currentColor];
    } else {
        return UIColor.clearColor;
    }
}

- (void)startAnimating {
    [self setAnimating:YES];

    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"opacity";
    animation.duration = kAnimationDuration;
    animation.fromValue = @1.0;
    animation.toValue = @0.0;
    animation.repeatCount = HUGE_VALF;
    [self.petalLayer addAnimation:animation forKey:nil];
}

- (void)stopAnimating {
    [self setAnimating:NO];

    [self.petalLayer removeAllAnimations];
}

- (void)setAnimating:(BOOL)animating {
    _animating = animating;

    [self updateHiddenState];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.replicatorLayer.frame = self.bounds;
    CGRect petalFrame = CGRectMake(self.replicatorLayer.bounds.size.width / 2 - kPetalSize.width / 2,
                                   self.replicatorLayer.bounds.size.height / 2 - kPetalSize.height * 2,
                                   kPetalSize.width,
                                   kPetalSize.height);
    self.petalLayer.frame = petalFrame;
    self.petalLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.petalLayer.bounds
                                                       cornerRadius:kPetalCornerRadius].CGPath;
}

@end
