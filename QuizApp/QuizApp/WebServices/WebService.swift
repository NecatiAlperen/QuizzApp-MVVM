//
//  WebService.swift
//  QuizApp
//
//  Created by Necati Alperen IŞIK on 19.01.2024.
//

import Foundation


class WebService {
    
    static let shared = WebService()
    private init (){}
    
    
    func getQuestion( completion : @escaping (ResponseModel?)-> Void){
        let url = URL(string:"https://quiz-68112-default-rtdb.firebaseio.com/quiz.json")
        
        URLSession.shared.dataTask(with: url!) {data,response,error in
            
            if error != nil {
                print(error?.localizedDescription)
                completion(nil)
            }else{
                do{
                    let result =  try! JSONDecoder().decode(DataModel.self, from: data!)
                    completion(result.data)

                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
            
            
        }.resume()
    }
}
