//
//  QuizVCV.swift
//  QuizApp
//
//  Created by Necati Alperen IŞIK on 19.01.2024.
//

import UIKit

class QuizVCV: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var quizViewModel = QuizViewModel()
    var score = 0
    //MARK: -  VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        getData()
    }
    
    
    //MARK: - FETCH DATA
    
    func  getData(){
        quizViewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - check Answers
    
    func checkAnswer(question :QuestionModel,choosenOption :String!){
        if let correctAnswer = question.correct_answer,choosenOption == correctAnswer{
            // true
            score += 1
        }else{
            // false
        }
    }
    
    //MARK: - optionClicked
    
    @IBAction func optionClicked(_ sender : Any){
        
        
        guard let button = sender as? UIButton else{
            return
        }
        guard let cell = button.superview?.superview as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        if indexPath.row < quizViewModel.numberOfItemsInSection(){
            if let question = quizViewModel.questionID(at: indexPath.row){
                let choosenButton = button.titleLabel?.text ?? ""
                checkAnswer(question: question, choosenOption: choosenButton)
                
                let nextQuestion = indexPath.row + 1
                
                if nextQuestion < quizViewModel.numberOfItemsInSection(){
                    let nextQuestionIP = IndexPath(row: nextQuestion, section: indexPath.section)
                    collectionView.scrollToItem(at: nextQuestionIP, at: .centeredHorizontally, animated: true)
                }else{
                    // lat quest
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultVC") as? ResultVC{
                        resultVC.score = score
                        //performSegue(withIdentifier: "toResult", sender: nil)
                        navigationController?.pushViewController(resultVC, animated: true)
                    }
                    
                }
            }
        }
        
        
    }
    
    
    //MARK: -  SHUFFLED OPTIONS
    func mixOptions(question : QuestionModel) -> [String]{
        var options = [question.option_1,question.option_2,question.option_3,question.option_4]
        options.shuffle()
        return options.compactMap{$0}
    }
    //MARK: - SETUP CELL
    func setupCell(cell : QuestionCell,with question: QuestionModel){
        cell.questionCell.text = question.question
        let shuffledOptions = mixOptions(question: question)
        cell.option1.setTitle(shuffledOptions[0], for: .normal)
        cell.option2.setTitle(shuffledOptions[1], for: .normal)
        cell.option3.setTitle(shuffledOptions[2], for: .normal)
        cell.option4.setTitle(shuffledOptions[3], for: .normal)
    }
    
    
    //MARK: - FINISH QUIZ
    @IBAction func finishQuizClicked(_ sender: Any) {
    }
    
    //MARK: -  PASS QUESTION
    @IBAction func passQuestionClicked(_ sender: Any) {
    }
    
}
    //MARK: - EXTENSIONS
extension QuizVCV : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! QuestionCell
        if let item  = quizViewModel.questionID(at: indexPath.row){
            cell.questionCell.text = item.question
            cell.option1.setTitle(item.option_1, for: .normal)
            cell.option2.setTitle(item.option_2, for: .normal)
            cell.option3.setTitle(item.option_3, for: .normal)
            cell.option4.setTitle(item.option_4, for: .normal)
            setupCell(cell: cell, with: item)
        }
        return cell
    }
    
    
}
