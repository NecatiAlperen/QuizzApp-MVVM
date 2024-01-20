//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Necati Alperen IŞIK on 20.01.2024.
//

import Foundation

class QuizViewModel {
    
    private var responseModel : ResponseModel?
    private var questionModel : [QuestionModel] = []
    
    func fetchData(completion : @escaping ()->Void){
        WebService.shared.getQuestion { responseModel in
            if let rModel = responseModel, let questions = rModel.questions{
                self.responseModel = rModel
                self.questionModel = questions
                completion()
            }
        }
        
    }
    
    func numberOfItemsInSection()->Int{
        return questionModel.count
    }
    
    func questionID(at index : Int)->QuestionModel?{
        guard index >= 0 && index < questionModel.count else {
            return nil
        }
        return questionModel[index]
    }
    
}
