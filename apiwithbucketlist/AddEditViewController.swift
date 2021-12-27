//
//  AddEditViewController.swift
//  apiwithbucketlist
//
//  Created by admin on 25/12/2021.
//

import UIKit
protocol Addeditobj {
    func updateData()
}

class AddEditViewController: UIViewController {
    
    var oneobj : TheData?
    var id : IndexPath?
    var tasktoedit : NSDictionary?
    var delegate : Addeditobj?
    @IBOutlet weak var namefield: UITextField!
    
    @IBOutlet weak var thecreatedatlabel: UILabel!
    @IBOutlet weak var created_at: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if oneobj != nil {
            
            namefield.text = oneobj!.objective
            created_at.text = oneobj!.created_at
        }
        else
        {
            
            created_at.isHidden = true
            thecreatedatlabel.isHidden = true
        }
        
    }
    
    
    @IBAction func savedata(_ sender: UIButton) {
        guard let objective = namefield.text else { return  }
        
        if oneobj != nil {
            
            guard let id = oneobj?.id else {return }
            TaskModel.updatetask(objective: objective, id : id) { data, response, error in
                
                if data != nil {
                    
                    self.delegate?.updateData()
                    
                    //                        let _ = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [string: Any]
                    DispatchQueue.main.async {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            }
        }
        else if namefield.text != nil
        {
            TaskModel.addTaskWithObjective(objective: objective, completionHandler:{ data, response, error in
                if data != nil
                {do {
                    let  _ = try  JSONDecoder().decode(TheData.self, from: data!)
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                    self.delegate?.updateData()
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        //                        self.navigationController?.viewControllers.popLast()
                    }
                }catch{
                    print(error.localizedDescription)
                }}
                else {
                    print ("no response")
                }
            })
        }
        else {
            print("should write objective or return back")
            
        }
    }
    
}
