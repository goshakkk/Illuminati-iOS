//
//  SecretsViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

let kSecretCellID = "secretCell"

class SecretsViewController: UITableViewController {
    
    lazy var secrets = Secret.all()
    
    var firstTime = true
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Illuminati"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .Plain, target: self, action: "signOut")
        
        tableView.separatorStyle = .None
        tableView.registerClass(SecretTableViewCell.classForCoder(), forCellReuseIdentifier: kSecretCellID)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstTime {
            // scroll to last position only when appearing for the first time
            scrollToLastPosition()
            
            firstTime = false
        }
        
        checkUser()
    }
    
    func scrollToLastPosition() {
        tableView.scrollToRowAtIndexPath(lastSeenItemIndex(), atScrollPosition: .Top, animated: false)
    }
    
    func lastSeenItemIndex() -> NSIndexPath {
        return NSIndexPath(forRow: 2, inSection: 0)
    }
    
    func signOut() {
        UsersService.sharedService.signOut()
        checkUser()
    }
    
    func checkUser() {
        if !UsersService.sharedService.currentUser {
            let signIn = SignInViewController(style: .Grouped)            
            let nav = UINavigationController(rootViewController: signIn)
            nav.modalPresentationStyle = .FormSheet
            
            self.navigationController.presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return secrets.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let secret = secrets[indexPath.item]
        
        var cell = tableView.dequeueReusableCellWithIdentifier(kSecretCellID, forIndexPath: indexPath) as SecretTableViewCell
        cell.bindSecret(secret)
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let secret = secrets[indexPath.item]
        
        let secretVC = SecretViewController(secret: secret)
        let nav = UINavigationController(rootViewController: secretVC)
        nav.modalPresentationStyle = .FullScreen
        
        self.navigationController.presentViewController(nav, animated: true, completion: nil)
    }

}

