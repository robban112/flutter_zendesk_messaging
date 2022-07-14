import UIKit
import ZendeskSDKMessaging
import ZendeskSDKLogger

public class ZendeskMessaging: NSObject {
    
    let TAG = "[ZendeskMessaging]"
    
    private var zendeskPlugin: SwiftZendeskMessagingPlugin? = nil
    private var channel: FlutterMethodChannel? = nil
    private var navController: UINavigationController? = nil
    private var messagingVC: UIViewController? = nil
    private var rootViewController: UIViewController? = nil

    init(flutterPlugin: SwiftZendeskMessagingPlugin, channel: FlutterMethodChannel) {
        self.zendeskPlugin = flutterPlugin
        self.channel = channel
    }
    
    func initialize(channelKey: String) {
        print("\(self.TAG) - Channel Key - \(channelKey)\n")
        Messaging.initialize(channelKey: channelKey) { result in
            if case let .failure(error) = result {
                self.zendeskPlugin?.isInitialize = false
                print("\(self.TAG) - initialize failure - \(error.errorDescription ?? "")\n")
            } else {
                self.zendeskPlugin?.isInitialize = true
                print("\(self.TAG) - initialize success")
            }
        }
    }

    func show(rootViewController: UIViewController?) {
        let navController = UINavigationController()
        let messagingWrapperVC = MessagingWrapperController()
        navController.viewControllers = [messagingWrapperVC]
        
        navController.hidesBarsOnSwipe = false
        navController.isNavigationBarHidden = false
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor.blue
        
            navController.navigationBar.barTintColor = UIColor.blue
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            navController.navigationBar.scrollEdgeAppearance = appearance
            navController.navigationBar.standardAppearance = appearance
            navController.navigationBar.compactAppearance = appearance
            
        } else {
            // Fallback on earlier versions
        }
        DispatchQueue.main.async {
            // navController.modalPresentationStyle = .overCurrentContext
            rootViewController?.present(navController, animated: true, completion: nil)
        }
        
        print("\(self.TAG) - show")
        
    }
    
    @IBAction func popViewController(_ sender: UIBarButtonItem) {
        rootViewController?.dismiss(animated: true)
        messagingVC?.dismiss(animated: true, completion: nil)
        navController?.dismiss(animated: true)
        navController?.popToRootViewController(animated: true)
    }
}
