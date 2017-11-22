//
//  ViewController.swift
//  Checklists
//
//  Created by Jan Marek on 2017-11-16.
//  Copyright © 2017 MonnioTechnologies. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    var items: [ChecklistItem]
    
    @IBAction func addItem(_ sender: Any) {
        
        let newRowIndex = items.count
        
        var titles = [String]()
        for i in items {
            titles.append(i.text)
        }
        
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        let title = titles[Int(randomNumber)]
        
        let item = ChecklistItem()
        item.text = title
        item.checked = true
        
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        let row0Item = ChecklistItem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)
        
        
        let row1Item = ChecklistItem()
        row1Item.text = "Brush Teeth"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = ChecklistItem()
        row2Item.text = "Learn iOS development"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = ChecklistItem()
        row3Item.text = "Soccer Practice"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = ChecklistItem()
        row4Item.text = "Eat Ice Cream"
        row4Item.checked = false
        items.append(row4Item)
        
        let row5Item = ChecklistItem()
        row5Item.text = "Compleete TableView Tutorial"
        row5Item.checked = false
        items.append(row5Item)
        
        let row6Item = ChecklistItem()
        row6Item.text = "Rewire Computers"
        row6Item.checked = false
        items.append(row6Item)
        
        let row7Item = ChecklistItem()
        row7Item.text = "Take stuff to storage"
        row7Item.checked = false
        items.append(row7Item)
        
        super.init(coder: aDecoder)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = " "
        }
    }

}

