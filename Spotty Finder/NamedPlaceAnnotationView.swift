//
//  NamedPlaceAnnotationView.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 25.11.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import MapKit


class NamedPlaceAnnotationView: MKAnnotationView {
    
    var imageView: UIImageView = UIImageView()
    var bubbleView: UIView = UIView()
    //var reuseIdentifier: String! = "pin"
    let frameForButton: CGRect = CGRect(x: 0.0, y: 0.0, width: 45.0, height: 45.0)
    let frameForAnnotationView: CGRect = CGRect(x: 0.0, y: 0.0, width: 45.0, height: 45.0)
    
    override init(annotation: MKAnnotation, reuseIdentifier: String) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.draggable = true
        let imageButton = UIButton(frame: frameForButton)
        let image = (annotation as NamedPlace).image
        imageButton.setBackgroundImage(image, forState:.Normal)
        imageButton.layer.cornerRadius = 10.0
        imageButton.clipsToBounds = true
        self.leftCalloutAccessoryView = imageButton
        
        
        self.image = image
        self.frame = frameForAnnotationView
        //self.calloutOffset = CGPointMake(100.0, 100.0)
        self.canShowCallout = true //annotation.isKindOfClass(NamedPlace)
        self.enabled = true
        self.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIButton

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let iView: UIImageView = UIImageView(frame: frameForAnnotationView)
        // keeps the image dimensions correct
        // so if you have a rectangle image, it will show up as a rectangle,
        // instead of being resized into a square
        iView.contentMode = UIViewContentMode.ScaleAspectFit;
        iView.layer.cornerRadius = 10.0
        iView.clipsToBounds = true
        
        self.imageView = iView;
        
        self.addSubview(iView)
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
        (self.leftCalloutAccessoryView as UIButton).setBackgroundImage(image, forState: .Normal)
        (annotation as NamedPlace).image = image
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        println("\(selected)")
        /*
        
        if (selected) {
            bubbleView = createCalloutView()
            
            /*
[calloutView setFrame:CGRectMake(-24, 35, 0, 0)];
[calloutView sizeToFit];

[self animateCalloutAppearance];
[self addSubview:calloutView];
*/
            //self.superview!.addSubview(bubbleView)
            self.addSubview(bubbleView)
            self.userInteractionEnabled = true
        } else {
            bubbleView.removeFromSuperview()
        }

*/
    }
    
    override func didAddSubview(subview: UIView) {
        if subview.description == "UICalloutView" {
            subview.removeFromSuperview()
        }
    }
    
    func createCalloutView() -> UIView {
        let view = UIView(frame: CGRect(x: -100.0, y: -50.0, width: 200.0, height: 45.0))
        view.backgroundColor = UIColor.whiteColor()
        let iView: UIImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 45.0, height: 45.0))
        iView.image = (annotation as NamedPlace).image
        view.addSubview(iView)
        
        let iTitleLabel = UILabel(frame: CGRect(x: 50.0, y: 0.0, width: 45.0, height: 45.0))
        iTitleLabel.textColor = UIColor.darkTextColor()
        iTitleLabel.text = (annotation as NamedPlace).title
        iTitleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(iTitleLabel)
        
        let iSubtitleLabel = UILabel(frame: CGRect(x: 50.0, y: 20.0, width: 45.0, height: 45.0))
        iSubtitleLabel.text = (annotation as NamedPlace).title
        iSubtitleLabel.textColor = UIColor.darkTextColor()
        iSubtitleLabel.adjustsFontSizeToFitWidth = true
        //view.addSubview(iSubtitleLabel)
        
        let txtField: UITextField = UITextField()
        txtField.frame = CGRectMake(50, 70, 200, 30)
        txtField.backgroundColor = UIColor.grayColor()
        txtField.text = (annotation as NamedPlace).title
        //view.addSubview(txtField)
        
        let imageButton = UIButton(frame: frameForButton)
        let image = (annotation as NamedPlace).image
        imageButton.setBackgroundImage(image, forState:.Normal)
        imageButton.addTarget(self, action: "leftCalloutAction:", forControlEvents: .TouchUpInside)
        view.addSubview(imageButton)
        
        let disclosureButton = UIButton.buttonWithType(.DetailDisclosure) as UIButton
        disclosureButton.frame = CGRect(x: 150.0, y: 0.0, width: 35.0, height: 35.0)
        //disclosureButton.setBackgroundImage(image, forState:.Normal)
        disclosureButton.addTarget(self, action: "rightCalloutAction:", forControlEvents: .TouchUpInside)
        //disclosureButton.setType(.DetailDisclosure)
        view.addSubview(disclosureButton)
        view.userInteractionEnabled = true
        
        
        return view
    }
    
    @IBAction func leftCalloutAction(button: UIButton) {
        println("leftCalloutAction")
    }
    
    @IBAction func rightCalloutAction(button: UIButton) {
        println("rightCalloutAction")
    }
    
    /*
    
- (void)animateCalloutAppearance {
CGFloat scale = 0.001f;
calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);

[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
CGFloat scale = 1.1f;
calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
} completion:^(BOOL finished) {
[UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
CGFloat scale = 0.95;
calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
} completion:^(BOOL finished) {
[UIView animateWithDuration:0.075 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
CGFloat scale = 1.0;
calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
} completion:nil];
}];
}];
}*/

    /*
from controller http://stackoverflow.com/questions/16252764/how-to-create-custom-mkannotationview-and-custom-annotation-title-and-subtitle
[mapView deselectAnnotation:view.annotation animated:YES];

DetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsPopover"];
controller.annotation = view.annotation; // it's useful to have property in your view controller for whatever data it needs to present the annotation's details

self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
self.popover.delegate = self;

[self.popover presentPopoverFromRect:view.frame
inView:view.superview
permittedArrowDirections:UIPopoverArrowDirectionAny
animated:YES];
    
*/
    
    /* from nib http://stackoverflow.com/questions/17772108/custom-mkannotation-callout-bubble-with-button
    
    - (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"callOutView" owner:self options:nil] objectAtIndex:0];
    
    
    }

*/

}
