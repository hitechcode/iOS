//  Created by Hasith Ambegoda on 2015/08/06.

#import "EffectController.h"

@interface EffectController ()

@end

@implementation EffectController

#pragma mark initialize variables
-(void)initFilters{
   //filters
    filters = [[NSMutableArray alloc]initWithObjects:@"Original",
               @"CILinearToSRGBToneCurve",
               @"CIPhotoEffectChrome",
               @"CIPhotoEffectFade",
               @"CIPhotoEffectInstant",
               @"CIPhotoEffectMono",
               @"CIPhotoEffectNoir",
               @"CIPhotoEffectProcess",
               @"CIPhotoEffectTonal",
               @"CIPhotoEffectTransfer",
               @"CISRGBToneCurveToLinear",
               @"CIComicEffect",
               nil];
}

#pragma mark option button onclick listener
-(void)optButtonTapped:(id)sender{
    UIButton *tButton = (UIButton*)sender;
    int bTag = (int)tButton.tag;
    switch (bTag) {
        case 1:
             mainImageView.image = [effectController addImageEffect:originalImage Filter:[filters objectAtIndex:1]];
            break;
        default:
            break;
    }
}

#pragma mark save image
-(void)saveImageData{
    UIImage *outputImage = [self getOutputImage];
    UIImageWriteToSavedPhotosAlbum(outputImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}

#pragma mark image save completed callback
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        title = @"Effects";
        message = @"Image saved to the gallery!";
    } else {
        title = @"Failed to save image.";
        message = [error description];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark open camera view
-(void)openCameraView{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark open gallery
-(void)openImagePicker{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark image picker controller
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    mainImageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    originalImage = chosenImage;
}

#pragma mark image picker cancel callback
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
