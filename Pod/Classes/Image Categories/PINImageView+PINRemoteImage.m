//
//  UIImageView+PINRemoteImage.m
//  Pods
//
//  Created by Garrett Moon on 8/17/14.
//
//

#import "PINImageView+PINRemoteImage.h"
#import <objc/runtime.h>

static void * PinRemoteVoidKey = &PinRemoteVoidKey;

@interface WeakObjectContainer : NSObject
@property (nonatomic, readonly, weak) id object;
@end

@implementation WeakObjectContainer
- (instancetype) initWithObject:(id)object
{
    if (!(self = [super init]))
        return nil;
    
    _object = object;
    
    return self;
}
@end

@implementation PINImageView (PINRemoteImage)

- (id)weakObject {
    return [objc_getAssociatedObject(self, PinRemoteVoidKey) object];
}

- (void)setWeakObject:(id)object {
    objc_setAssociatedObject(self, &PinRemoteVoidKey, [[WeakObjectContainer alloc] initWithObject:object], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)pin_setImageFromURL:(NSURL *)url placeholderImage:(PINImage *)placeholderImage
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURL:url placeholderImage:placeholderImage];
}

- (void)pin_setImageFromURL:(NSURL *)url completion:(PINRemoteImageManagerImageCompletion)completion
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURL:url completion:completion];
}

- (void)pin_setImageFromURL:(NSURL *)url placeholderImage:(PINImage *)placeholderImage completion:(PINRemoteImageManagerImageCompletion)completion
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURL:url placeholderImage:placeholderImage completion:completion];
}

- (void)pin_setImageFromURL:(NSURL *)url processorKey:(NSString *)processorKey processor:(PINRemoteImageManagerImageProcessor)processor
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURL:url processorKey:processorKey processor:processor];
}

- (void)pin_setImageFromURL:(NSURL *)url placeholderImage:(PINImage *)placeholderImage processorKey:(NSString *)processorKey processor:(PINRemoteImageManagerImageProcessor)processor
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURL:url placeholderImage:placeholderImage processorKey:processorKey processor:processor];
}

- (void)pin_setImageFromURL:(NSURL *)url processorKey:(NSString *)processorKey processor:(PINRemoteImageManagerImageProcessor)processor completion:(PINRemoteImageManagerImageCompletion)completion
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURL:url processorKey:processorKey processor:processor completion:completion];
}

- (void)pin_setImageFromURL:(NSURL *)url placeholderImage:(PINImage *)placeholderImage processorKey:(NSString *)processorKey processor:(PINRemoteImageManagerImageProcessor)processor completion:(PINRemoteImageManagerImageCompletion)completion
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURLs:url?@[url]:nil placeholderImage:placeholderImage processorKey:processorKey processor:processor completion:completion];
}

- (void)pin_setImageFromURLs:(NSArray <NSURL *> *)urls
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURLs:urls];
}

- (void)pin_setImageFromURLs:(NSArray <NSURL *> *)urls placeholderImage:(PINImage *)placeholderImage
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURLs:urls placeholderImage:placeholderImage];
}

- (void)pin_setImageFromURLs:(NSArray <NSURL *> *)urls placeholderImage:(PINImage *)placeholderImage completion:(PINRemoteImageManagerImageCompletion)completion
{
    [self setWeakObject:[self superview]];
    [PINRemoteImageCategoryManager setImageOnView:self fromURLs:urls placeholderImage:placeholderImage completion:completion];
}

- (void)pin_cancelImageDownload
{
    [PINRemoteImageCategoryManager cancelImageDownloadOnView:self];
}

- (NSUUID *)pin_downloadImageOperationUUID
{
    return [PINRemoteImageCategoryManager downloadImageOperationUUIDOnView:self];
}

- (void)pin_setDownloadImageOperationUUID:(NSUUID *)downloadImageOperationUUID
{
    [PINRemoteImageCategoryManager setDownloadImageOperationUUID:downloadImageOperationUUID onView:self];
}

- (BOOL)pin_updateWithProgress
{
    return [PINRemoteImageCategoryManager updateWithProgressOnView:self];
}

- (void)setPin_updateWithProgress:(BOOL)updateWithProgress
{
    [PINRemoteImageCategoryManager setUpdateWithProgressOnView:updateWithProgress onView:self];
}

- (void)pin_setPlaceholderWithImage:(PINImage *)image
{
    self.image = image;
}

- (void)pin_updateUIWithImage:(PINImage *)image animatedImage:(FLAnimatedImage *)animatedImage
{
#if PIN_TARGET_IOS
    if ([self weakObject] == nil){
        return;
    }
#endif
    if (image) {
        self.image = image;
        
#if PIN_TARGET_IOS
        [self setNeedsLayout];
#elif PIN_TARGET_MAC
        [self setNeedsLayout:YES];
#endif
    }
}

- (void)pin_clearImages
{
    self.image = nil;
    
#if PIN_TARGET_IOS
    [self setNeedsLayout];
#elif PIN_TARGET_MAC
    [self setNeedsLayout:YES];
#endif
}

- (BOOL)pin_ignoreGIFs
{
    return YES;
}

@end

