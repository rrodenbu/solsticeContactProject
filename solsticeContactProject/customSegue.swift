//
//  customSegue.swift
//  solsticeContactProject
//
//  Created by Riley Rodenburg on 2/14/16.
//  Copyright © 2016 Riley Rodenburg. All rights reserved.
//

import UIKit

/*Custom Segue for transition from splash screen to table */
/*Scaling animation*/
class customSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let sourceVC = self.sourceViewController
        let destinationVC = self.destinationViewController
        
        sourceVC.view!.addSubview(destinationVC.view)
        
        /*Start the table screen really small*/
        destinationVC.view!.transform = CGAffineTransformMakeScale(0.05, 0.05)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            /*End size of the table screen 1:1*/
            destinationVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            
            }) { (finished) -> Void in
                
                destinationVC.removeFromParentViewController()
                /*Setting the duration of the animation*/
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.001 * Double(NSEC_PER_SEC)))
                /*Remove old view, and only have present view*/
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    sourceVC.presentViewController(destinationVC, animated: false, completion: nil)
                })
                
        }
    }
}
