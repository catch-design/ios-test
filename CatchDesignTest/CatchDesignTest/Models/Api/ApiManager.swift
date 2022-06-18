//
//  ApiManager.swift
//  CatchDesignTest
//
//  Created by Shafee Rehman on 18/06/22.
//

import Foundation

protocol ApiManagerDelegate{
    func didFetchData(fetchedData: [Model])
}

class ApiManager{
    
    static var instance = ApiManager()
    var delegate: ApiManagerDelegate?
    
    func fetch()
    {
        var modelArray : [Model] = []
        
        let url = URL(string: Constants.url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { [self]
            data, response, error in
            
            guard let safeData = data, error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode([ApiResponse].self, from: safeData)
                
                for data in decodedData {
                          
                let model = Model(id: data.id, title: data.title, subtitle: data.subtitle, content: data.content)
                    
                    modelArray.append(model)
                }
                
                self.delegate?.didFetchData(fetchedData: modelArray)
                
            }
            catch{
                print(error)
            }
        }
        
        task.resume()
        
       
    }
}
