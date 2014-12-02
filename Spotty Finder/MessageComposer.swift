//
//  MessageComposer.swift
//  Spotty Finder
//
//  Created by Тимур Татаршаов on 02.12.14.
//  Copyright (c) 2014 Timur Tatarshaov. All rights reserved.
//

import Foundation
import MessageUI


class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    var messageBody = "pattern"
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(messageBody setMessageBody: String? = nil) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        //messageComposeVC.recipients = [""] in case for pre set user
        if let messageBody = setMessageBody {
            messageComposeVC.body = messageBody
        } else {
            messageComposeVC.body = messageBody
        }
        return messageComposeVC
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}