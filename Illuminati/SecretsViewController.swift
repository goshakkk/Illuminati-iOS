//
//  SecretsViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretsViewController: UITableViewController {
    
    @lazy var secrets = Secret.all()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Illuminati"
        
        tableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.checkUser()
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
        let cellID = "secretCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? SecretViewCell
        
        if !cell {
            let secret = secrets[indexPath.item]
            let newCell = SecretViewCell(secret: secret, style: .Default, reuseIdentifier: cellID)
            
            cell = newCell
        }
        
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

