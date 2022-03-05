//
//  ApiService.swift
//  telemat
//
//  Created by didarmarat on 26.01.2022.
//

import Foundation

struct Constats {
    static let domainName = "https://lk.telemat.su/"
}


public class ApiService {
    static let shared = ApiService()
    
//    func createGroup(_ token: String, _ groupName: String, completion: @escaping ((Group?, Error?) -> ())) {
    func getTMValuesUsing(_ deviceId: String, completion: @escaping ((TMValue?, Error?) -> ())) {
        let parameters = [
//          [
//            "key": "token",
//            "value": token,
//            "type": "text"
//          ],
//          [
//            "key": "name",
//            "value": groupName,
//            "type": "text"
//          ]
        ] as [[String : Any]]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var error: Error? = nil
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
              let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data
              let fileContent = String(data: fileData!, encoding: .utf8)!
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
          }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: "\(Constats.domainName)api/device/getDevice?serialNumber=\(deviceId)")!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "GET"
//        request.httpBody = postData

        let sessionConfig = URLSessionConfiguration.default
        let task = URLSession(configuration: sessionConfig).dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                completion(nil, error)
                return
            }
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            do {
                let decoder = JSONDecoder()
                let tmResponse = try decoder
                    .decode(TMResponse.self, from: data)
                completion(tmResponse.result, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
//            catch let jsonError {
//                debugPrint(jsonError.localizedDescription)
//                completion(nil, error)
//                return
//            }
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    print(json)
////                    let group = Group(dict: json)
////                    completion(group, nil)
//                    // try to read out a string array
//                    //if let error = json["error"] as? String {
//                    //    self.showAlertWithText(error)
//                    //}
//                }
//            } catch let error as NSError {
//                print("Failed to load: \(error.localizedDescription)")
////                completion(nil, error)
//            }
        }
        task.resume()
    }
    
    func saveNotificationToken(_ serialNumber: String, _ token: String, _ description: String, _ widgetId: String) {
        let parameters = [
            [
                "key": "serialNumber",
                "value": serialNumber,
                "type": "text"
            ],
            [
                "key": "token",
                "value": token,
                "type": "text"
            ],
            [
                "key": "description",
                "value": description,
                "type": "text"
            ],
            [
                "key": "widgetId",
                "value": widgetId,
                "type": "text"
            ]
        ] as [[String : Any]]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var error: Error? = nil
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
              let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data
              let fileContent = String(data: fileData!, encoding: .utf8)!
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
          }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: "\(Constats.domainName)api/device/saveNotificationToken")!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let sessionConfig = URLSessionConfiguration.default
        let task = URLSession(configuration: sessionConfig).dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
//                completion(nil, error)
                return
            }
            print(String(data: data, encoding: .utf8) ?? "")
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
//                    let group = Group(dict: json)
//                    completion(group, nil)
                    // try to read out a string array
                    //if let error = json["error"] as? String {
                    //    self.showAlertWithText(error)
                    //}
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
//                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func deleteNotificationToken(_ serialNumber: String, _ token: String, _ description: String, _ widgetId: String) {
        let parameters = [
            [
                "key": "serialNumber",
                "value": serialNumber,
                "type": "text"
            ],
            [
                "key": "token",
                "value": token,
                "type": "text"
            ]
        ] as [[String : Any]]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var error: Error? = nil
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
              let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data
              let fileContent = String(data: fileData!, encoding: .utf8)!
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
          }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: "\(Constats.domainName)api/device/deleteNotificationToken")!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let sessionConfig = URLSessionConfiguration.default
        let task = URLSession(configuration: sessionConfig).dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
//                completion(nil, error)
                return
            }
            print(String(data: data, encoding: .utf8) ?? "")
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
//                    let group = Group(dict: json)
//                    completion(group, nil)
                    // try to read out a string array
                    //if let error = json["error"] as? String {
                    //    self.showAlertWithText(error)
                    //}
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
//                completion(nil, error)
            }
        }
        task.resume()
    }
}
