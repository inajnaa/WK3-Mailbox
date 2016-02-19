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
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var rescheduleImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var mailboxContainerView: UIView!
    
    
    var grayColor = UIColor(red: 229/255.0, green: 230/255.0, blue: 232/255.0, alpha:1.0)
    var yellowColor = UIColor(red: 247/255.0, green: 204/255.0, blue: 39/255.0, alpha:1.0)
    var brownColor = UIColor(red: 206/255.0, green: 150/255.0, blue: 98/255.0, alpha:1.0)
    var redColor = UIColor(red: 228/255.0, green: 61/255.0, blue: 38/255.0, alpha:1.0)
    var greenColor = UIColor(red: 98/255.0, green: 214/255.0, blue: 79/255.0, alpha:1.0)
    
    var messageOriginalCenter: CGPoint!
    var fixedLeftPosition: CGFloat!
    var offscreenLeftPosition: CGFloat!
    var offscreenRightPosition: CGFloat!
    
    var mailboxOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1370)
        fixedLeftPosition = messageImageView.center.x
        offscreenLeftPosition = messageImageView.center.x - 320
        offscreenRightPosition = messageImageView.center.x + 320
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "didEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        mailboxContainerView.addGestureRecognizer(edgeGesture)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        print("Edge pan is panning")
        
        if sender.state == UIGestureRecognizerState.Began {
            mailboxOriginalCenter = mailboxContainerView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            mailboxContainerView.center = CGPoint(x: mailboxOriginalCenter.x + translation.x, y: mailboxOriginalCenter.y)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                self.mailboxContainerView.center.x = self.mailboxOriginalCenter.x + 285
            } else {
                self.mailboxContainerView.center.x = self.mailboxOriginalCenter.x
            }
        }

    }
    
    @IBAction func didTapHamburger(sender: AnyObject) {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.mailboxContainerView.center.x = self.mailboxOriginalCenter.x
        }
        
    }
    
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
       
        print(translation.x)
        
        //BEGAN
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messageImageView.center
          
        //CHANGED
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageImageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
                // pan to right with gray background with archive icon
                if translation.x >= 0 && translation.x < 60 {
                    messageContainerView.backgroundColor = grayColor
                    laterIcon.alpha = 0
                    listIcon.alpha = 0
                    deleteIcon.alpha = 0
                    archiveIcon.alpha = 1
                }
                    
                // pan to right with green background with archive icon moving
                else if translation.x >= 60 && translation.x < 260 {
                    messageContainerView.backgroundColor = greenColor
                    laterIcon.alpha = 0
                    listIcon.alpha = 0
                    deleteIcon.alpha = 0
                    archiveIcon.alpha = 1
                    
                    archiveIcon.center.x = messageImageView.center.x - 190
                }
                
                // pan to right with red background with delete icon
                else if translation.x >= 260  {
                    messageContainerView.backgroundColor = redColor
                    laterIcon.alpha = 0
                    listIcon.alpha = 0
                    deleteIcon.alpha = 1
                    archiveIcon.alpha = 0
                    
                    deleteIcon.center.x = messageImageView.center.x - 190
                }
                    
                // pan to left with gray background with later icon
                else if translation.x <= 0 && translation.x > -60 {
                    messageContainerView.backgroundColor = grayColor
                    laterIcon.alpha = 1
                    listIcon.alpha = 0
                    deleteIcon.alpha = 0
                    archiveIcon.alpha = 0
                }
                    
                // pan to left with yellow background with later icon moving
                else if translation.x <= -60 && translation.x > -260 {
                    messageContainerView.backgroundColor = yellowColor
                    laterIcon.alpha = 1
                    listIcon.alpha = 0
                    deleteIcon.alpha = 0
                    archiveIcon.alpha = 0
                    
                    laterIcon.center.x = messageImageView.center.x + 190
                }
                    
                //pan to left with brown background with list icon
                else if translation.x <= -260 {
                    messageContainerView.backgroundColor = brownColor
                    laterIcon.alpha = 0
                    listIcon.alpha = 1
                    deleteIcon.alpha = 0
                    archiveIcon.alpha = 0
                    
                    listIcon.center.x = messageImageView.center.x + 190
                }

       
       //ENDED
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            // pan to right or left with gray background
            if translation.x < 60 && translation.x > -60 {
                self.messageImageView.center.x = self.fixedLeftPosition
                laterIcon.alpha = 0
            }
                
                // pan to right with green background
            else if translation.x >= 60 && translation.x < 260 {
                self.messageImageView.center.x = self.offscreenRightPosition
                archiveIcon.alpha = 0
                hideMessageView()
            }
                
                // pan to right with red background
            else if translation.x >= 260  {
                self.messageImageView.center.x = self.offscreenRightPosition
                deleteIcon.alpha = 0
                hideMessageView()
            }
                
                // pan to left with yellow background
            else if translation.x <= -60 && translation.x > -260{
                self.messageImageView.center.x = self.offscreenLeftPosition
                laterIcon.alpha = 0
                rescheduleImageView.alpha = 1
            }
                
                // pan to left with gray background
            else if translation.x <= 0 && translation.x > -60 {
                self.messageImageView.center.x = self.fixedLeftPosition
                archiveIcon.alpha = 0
            }
            
                // pan to left with brown background
            else if translation.x <= -260 {
                self.messageImageView.center.x = self.offscreenLeftPosition
                listIcon.alpha = 0
                listImageView.alpha = 1
            }
        }
    }

    @IBAction func didTapRescheduleIamge(sender: UITapGestureRecognizer) {
        rescheduleImageView.alpha = 0
        hideMessageView()
    }
    
    @IBAction func didTapListImage(sender: UITapGestureRecognizer) {
        listImageView.alpha = 0
        hideMessageView()
    }
    
    // custom function to animate message away
    func hideMessageView() {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.messageContainerView.alpha = 0
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.feedImageView.center.y = self.feedImageView.center.y - 86
            }, completion: nil)
        }
    
    // function to tap and reload message
    @IBAction func didTapToReload(sender: UITapGestureRecognizer) {
        self.messageContainerView.alpha = 1
        self.messageImageView.center = self.messageOriginalCenter
        
        UIView.animateWithDuration(0.6, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
             self.feedImageView.center.y = self.feedImageView.center.y + 86
            }, completion: nil)
        }
    }
