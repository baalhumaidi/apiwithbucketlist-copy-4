//
//  ViewController.swift
//  apiwithbucketlist
//
//  Created by admin on 25/12/2021.
//

import UIKit

class ViewController: UIViewController {
    var  allObjectives = [TheData]()
    var indexPath : IndexPath?
    var names = [String]()
    @IBOutlet weak var tableView: UITableView!
    // URL = https://dojo-recipes.herokuapp.com/test
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        
    }
    
    func getData()
    {
        TaskModel.getAllTasks() {
            data, response, error in
            do {
                self.allObjectives = try  JSONDecoder().decode([TheData].self, from: data!)
                
                //     if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String : Any]] {
                //                if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
                //                    print(tasks)
                //                    for task in tasks {
                //                        let name = task["name"] as? String
                //                        self.names.append(name!)
                //     self.parstdata(tasks: task)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //   }
                
            } catch {
                print("Something went wrong")
            }
        }
    }
//    func parstdata(tasks: [String:Any] ){
//        let objective = (tasks["objective"] as? String)!
//        let created_at = tasks["created_at"] as? String
//        let oneperson = TheData(objective: objective, created_at: created_at!)
//        self.allObjectives.append(oneperson)
//        
//    }
    @IBAction func tonextPage(_ sender: UIBarButtonItem) {
        
        gotonextScreen(info: nil)
        
    }
    
    func gotonextScreen(info:TheData?) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "AddEditViewController") as! AddEditViewController
        destination.delegate = self
        destination.oneobj = info
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource, Addeditobj {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allObjectives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath)
      
        cell.textLabel?.text = String("objective: \(allObjectives[indexPath.row].objective)")
        cell.detailTextLabel?.text = String("created_at: \(allObjectives[indexPath.row].created_at)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/6
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        // performSegue(withIdentifier: "ToEdit", sender: allObjectives[indexPath.row])
        
        
        gotonextScreen(info: allObjectives[indexPath.row])
    }
    
    
        //       let destination = self.storyboard?.instantiateViewController(withIdentifier: "AddEditViewController") as! AddEditViewController
        //       // destination.id = allObjectives[indexPath.row].id
        //        destination.oneobj = allObjectives[indexPath.row]
        //        self.navigationController?.pushViewController(destination, animated: true)

    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let vc = segue.destination as! AddEditViewController
    //        vc.delegate = self
    //        if let oneobj = sender as? TheData {
    ////            vc.id = self.indexPath
    //            vc.oneobj = oneobj
    //
    //        }
    //    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if  let id = allObjectives[indexPath.row].id
        {
            print("id= \(id)")
         
            TaskModel.deleteTask(id: id) { data, response, error in
                if error != nil {
                    print(error)
                }
                
                if data != nil {
                    
                    self.getData()}
                //        TaskModel.deleteTask(id: id!) { data, response, error in
                //            let result = try JSONDecoder().decode([Task].self, from: data!)
                //            if error != nil {
                //                print(error)
                //            }else
                //            {
                //                do{
                //                   // let oneobj = try JSONDecoder().decode(TheData.self, from: data!)
                //                    DispatchQueue.main.async {
                //                     //   self.allObjectives.remove(at: indexPath.row)
                //                        tableView.reloadData()
                //                    }
                //                }catch{
                //                    print(error.localizedDescription)
                //                }
                //            }
                //        }
                
                
                
                //                        let _ = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [string: Any]
                //                DispatchQueue.main.async {
                //
                //                   getData()
                //                }
                
            }
        }
    }
    
    func updateData() {
        getData()
    }
}

struct TheData : Codable{
    
    var id : Int?
    var objective: String
    var created_at : String
}
