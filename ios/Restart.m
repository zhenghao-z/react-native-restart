#import "Restart.h"

@implementation Restart

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(RNRestart)

- (void)loadBundle
{
    [_bridge reload];
}

RCT_EXPORT_METHOD(Restart) {
    dispatch_async(dispatch_get_main_queue(), ^{
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray * paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
              NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径

             NSString * bundlepath = [NSString stringWithFormat:@"%@/index.ios.bundle",documentsDirectory];
            BOOL exist = [fileManager fileExistsAtPath:bundlepath];

            if (exist){
                [self->_bridge setValue:[NSURL URLWithString:bundlepath] forKey:@"bundleURL"];
            }else{
                [self->_bridge setValue:[[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"] forKey:@"bundleURL"];
            }

            [self loadBundle];
        });
    return;
}

@end
