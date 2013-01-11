/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options];
    }
}

#if NS_BLOCKS_AVAILABLE
- (void)setImageWithURL:(NSURL *)url success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;
{
    [self setImageWithURL:url placeholderImage:nil success:success failure:failure];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;
{
    [self setImageWithURL:url placeholderImage:placeholder options:0 success:success failure:failure];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options success:success failure:failure];
    }
}
#endif

- (void)cancelCurrentImageLoad
{
    @synchronized(self)
    {
        [self hideActivity];

        [[SDWebImageManager sharedManager] cancelForDelegate:self];
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didProgressWithPartialImage:(UIImage *)image forURL:(NSURL *)url
{
    [self hideActivity];

    self.image = image;
    [self setNeedsLayout];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    [self hideActivity];

    self.image = image;
    [self setNeedsLayout];
}

#pragma mark - Add UIActivityIndicatorView
#define kActivityViewTag 55404
- (void)showActivityWithStyle:(UIActivityIndicatorViewStyle)style
{
    [self hideActivity];

    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    aiView.tag = kActivityViewTag;
    aiView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    aiView.hidesWhenStopped = YES;
    aiView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [aiView startAnimating];
    [self addSubview:aiView];
    SDWIRelease(aiView);
}

- (void)hideActivity
{
    UIActivityIndicatorView *aiView = (UIActivityIndicatorView *)[self viewWithTag:kActivityViewTag];
    if (aiView && [aiView isKindOfClass:[UIActivityIndicatorView class]]) {
        [aiView removeFromSuperview];
    }
}

- (void)setImageWithURL:(NSURL *)url userInfo:(NSDictionary *)userInfo
{
    [self setImageWithURL:url placeholderImage:nil userInfo:userInfo];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder userInfo:(NSDictionary *)userInfo
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cancelForDelegate:self];
    self.image = placeholder;
    if (url) {
        [manager downloadWithURL:url delegate:self options:0 userInfo:userInfo];
    }
}

- (void)setImageWithURL:(NSURL *)url style:(UIActivityIndicatorViewStyle)style
{
    [self setImageWithURL:url placeholderImage:nil style:style];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
                  style:(UIActivityIndicatorViewStyle)style
{
    [self setImageWithURL:url
         placeholderImage:placeholder
                    style:style
                  options:0];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
                  style:(UIActivityIndicatorViewStyle)style
                options:(SDWebImageOptions)options
{
    if (style != NSNotFound) {
        [self showActivityWithStyle:style];
    } else {
        [self hideActivity];
    }

    [self setImageWithURL:url placeholderImage:placeholder options:options];
}

- (void)setImageWithURL:(NSURL *)url
                  style:(UIActivityIndicatorViewStyle)style
                success:(SDWebImageSuccessBlock)success
                failure:(SDWebImageFailureBlock)failure
{
    if (style != NSNotFound) {
        [self showActivityWithStyle:style];
    } else {
        [self hideActivity];
    }

    [self setImageWithURL:url success:success failure:failure];
}

@end
