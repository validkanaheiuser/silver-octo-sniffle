#import <UIKit/UIKit.h>

%hook UIApplication

- (BOOL)application:(id)app didFinishLaunchingWithOptions:(id)opts {
    BOOL ret = %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController
            alertControllerWithTitle:@"Inject OK"
            message:@"dylib loaded successfully"
            preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
            style:UIAlertActionStyleDefault handler:nil]];
        UIViewController *root = UIApplication.sharedApplication.keyWindow.rootViewController;
        while (root.presentedViewController) root = root.presentedViewController;
        [root presentViewController:alert animated:YES completion:nil];
    });
    return ret;
}

%end
