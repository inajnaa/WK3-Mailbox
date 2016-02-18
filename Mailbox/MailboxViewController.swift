//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Anjani Bhargava on 2/16/16.
//  Copyright © 2016 Anjani Bhargava. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    

    @IBOutlet weak var messagesBackground: UIView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messagesView: UIView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    
    
    var grayColor = UIColor(red: 229/255.0, green: 230/255.0, blue: 232/255.0, alpha:1.0)
    var yellowColor = UIColor(red: 247/255.0, green: 204/255.0, blue: 39/255.0, alpha:1.0)
    var brownColor = UIColor(red: 206/255.0, green: 150/255.0, blue: 98/255.0, alpha:1.0)
    var redColor = UIColor(red: 228/255.0, green: 61/255.0, blue: 38/255.0, alpha:1.0)
    var greenColor = UIColor(red: 98/255.0, green: 214/255.0, blue: 79/255.0, alpha:1.0)
    
    var messageOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView.contentSize = CGSize(width: 320, height: 1284)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        

        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messagesView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messagesView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
                // pan to right with gray background
                if translation.x >= 0 && translation.x < 60 {
                    messagesBackground.backgroundColor = grayColor
                }
                    
                // pan to right with green background
                else if translation.x >= 60 && translation.x < 260 {
                    messagesBackground.backgroundColor = greenColor
                }
                
                // pan to right with red background
                else if translation.x >= 260  {
                    messagesBackground.backgroundColor = redColor
                }
                    
                // pan to left with gray background
                else if translation.x <= 0 && translation.x > -60 {
                    messagesBackground.backgroundColor = grayColor
                    laterIcon.alpha = 1
                }
                    
                // pan to left with yellow background
                else if translation.x <= -60 && translation.x > -260 {
                    messagesBackground.backgroundColor = yellowColor
                }
                else if translation.x <= -260 {
                    messagesBackground.backgroundColor = brownColor
                }

       
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
        }

        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
