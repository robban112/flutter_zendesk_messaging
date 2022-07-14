//
//  MessagingWrapperController.swift
//  zendesk_messaging
//
//  Created by Robert Lorentz on 2022-07-12.
//

import Foundation
import ZendeskSDKMessaging

class MessagingWrapperController: UIViewController {
    
    override func viewDidLoad() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.popViewController(_ :)))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        if let zendeskChatVC = Messaging.instance?.messagingViewController() {
            //self.view = zendeskChatVC.view
            zendeskChatVC.navigationController?.setNavigationBarHidden(true, animated: false)
            zendeskChatVC.view.frame = view.frame
            addChild(zendeskChatVC)
            self.view.addSubview(zendeskChatVC.view)
            zendeskChatVC.didMove(toParent: self)
        }
    }
    
    @objc func popViewController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
