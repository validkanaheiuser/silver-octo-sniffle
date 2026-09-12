#import <UIKit/UIKit.h>

%ctor {
    NSLog(@"[InjectTest] dylib loaded in %@", NSBundle.mainBundle.bundleIdentifier);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        NSLog(@"[InjectTest] dispatch fired, looking for root VC");

        UIWindow *keyWindow = nil;
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if ([scene isKindOfClass:NSClassFromString(@"UIWindowScene")]) {
                for (UIWindow *w in [(id)scene windows]) {
                    if (w.isKeyWindow) { keyWindow = w; break; }
                }
            }
        }
        UIViewController *root = keyWindow.rootViewController;
        while (root.presentedViewController) root = root.presentedViewController;

        NSLog(@"[InjectTest] root=%@", root);
        if (!root) return;

        NSLog(@"[InjectTest] presenting alert...");
        UIAlertController *alert = [UIAlertController
            alertControllerWithTitle:@"Inject OK"
            message:NSBundle.mainBundle.bundleIdentifier
            preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
            style:UIAlertActionStyleDefault handler:nil]];
        [root presentViewController:alert animated:YES completion:nil];
    });
}
