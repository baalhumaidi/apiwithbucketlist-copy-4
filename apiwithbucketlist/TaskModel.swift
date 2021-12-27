//
//  TaskModel.swift
//  apiwithbucketlist
//
//  Created by admin on 25/12/2021.
//

import Foundation

class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
       let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    
    
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    

    static func updatetask(objective: String,id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
    //    let url = URL(string:"https://saudibucketlistapi.herokuapp.com/tasks/\(id)/")!
        var request = URLRequest(url: URL(string:"https://saudibucketlistapi.herokuapp.com/tasks/\(id)/")!)
        request.httpMethod = "PUT"
        do{
            let requestObj = TaskRequest.init(objective: objective)
            let BodyData = try JSONEncoder().encode(requestObj)
            request.httpBody = BodyData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print(request.httpBody)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    completionHandler(nil, nil, error)
                } else {
                    completionHandler(data, response, error)
                }
            }
            task.resume()
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    static func deleteTask(id : Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        //let url = URL(string:"https://saudibucketlistapi.herokuapp.com/tasks/\(id)")!
        var request = URLRequest(url: URL(string:"https://saudibucketlistapi.herokuapp.com/tasks/\(id)")!)
        request.httpMethod = "DELETE"

       let BodyData = "id=\(id)"
        request.httpBody = BodyData.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(nil, nil, error)
            } else {
                completionHandler(data, response, error)
            }
        }
        task.resume()
        
   
    }

}

struct TaskRequest: Codable {
    let objective:String
}
