//
//  HomeVC.swift
//  QuizApp
//
//  Created by Necati Alperen IŞIK on 19.01.2024.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toQuiz", sender: nil)
    }
    
   

}
