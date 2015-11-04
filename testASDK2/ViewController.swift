//
//  ViewController.swift
//  testASDK2
//
//  Created by Jason Yu on 10/30/15.
//  Copyright © 2015 Ruguo. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate {
    var textArray = ["test", "test", "test", "test", "test", "test", "test", "test", "test", "test"]
    
    let tableView = ASTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
    }
    
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        let cellNode = TestNode(text: self.textArray[indexPath.row])
        return cellNode
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let insertArray = ["test",
        "very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long very long ", "test"]
        self.textArray = insertArray + self.textArray
        
        // The following row will cause cells(in lower part of the table) contents to disappear
        self.tableView.insertRowsAtIndexPaths([0, 1, 2].map { NSIndexPath(forRow: $0, inSection: 0) }, withRowAnimation: .None)
        
        // Reload directly is fine.
//        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.textArray.count
    }
}

class TestNode: ASCellNode {
    let textNode: ASTextNode
    
    init(text: String) {
        textNode = ASTextNode()
        textNode.flexShrink = true
        textNode.attributedString = NSAttributedString(string: text, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(30)])
        
        super.init()
        
        self.addSubnode(textNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        let stack = ASStackLayoutSpec()
        stack.direction = .Horizontal
        stack.setChildren([textNode])
        
        let inset = ASInsetLayoutSpec()
        inset.insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        inset.setChild(stack)
        
        return inset
    }
}
