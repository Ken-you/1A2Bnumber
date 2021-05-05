//
//  ABnumberViewController.swift
//  ABnumber
//
//  Created by yousun on 2021/5/4.
//

import UIKit
import GameplayKit


var inputNumber = ""

var ABNumber = ["","","","",]

var peepNumber = [Int]()
    
var count = 0


class ABnumberViewController: UIViewController {
   
    
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var showTextView: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var answerButton: UIButton!
    
    @IBOutlet weak var TrophyCupImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNumber()
    }
    
    
    // 判斷玩家輸入的數字，按下 Button 後顯示在 TextView
    @IBAction func checkBtn(_ sender: UIButton) {
        
        var A = 0
        var B = 0
        var i = 0
        
        // 取 Label 值轉成 String 後再比較
        for value in guessLabel.text! {
            
            let char = String(value)
                
            if ABNumber[i] == char {
                    
                A += 1
                    
            }else if ABNumber.contains(char){
                    
                B += 1
            }
            i += 1
        }
        
        if A == 4 {
            
            showTextView.text = "猜 對 囉 ！"
            TrophyCupImageView.isHidden = false
            
        }else{
            count += 1
            showTextView.text += "[\(count)]:    \(A)A\(B)B     " + guessLabel.text! + "\n"
        }
        
        deleteNumber()
    }
    
    
    // 所有數字拉在同一個 IBAction，用 Tag 判斷數字並取值
    @IBAction func numberBtn(_ sender: UIButton) {
        
        inputNumber.append("\(sender.tag)")
        guessLabel.text = inputNumber

        // 防呆 只有輸入 4 個數字才能按送出
        if inputNumber.count != 4 {
            
            sendButton.isEnabled = false
            
        }else if inputNumber.count == 4{
            
            sendButton.isEnabled = true
        }
    
    }
    
    
    // 刪除數字，一次全部刪除
    @IBAction func deleteBtn(_ sender: Any) {
        
        deleteNumber()
    }
    
    
    // 全部歸零，重玩遊戲
    @IBAction func resetBtn(_ sender: Any) {
        
        reset()
    }
    
    
    // 偷看答案，點一下 Button 才會顯示答案，放開及消失
    @IBAction func peepBtn(_ sender: Any) {
        
        answerButton.isSelected = true
        answerButton.setTitle("偷看一下", for: .selected)
        answerButton.setTitle("\(peepNumber)", for: .normal)
    }
    
    
    // 亂數創造一組不重複的數字
    func createNumber() {
        
        let random = GKShuffledDistribution(lowestValue: 0, highestValue: 9)
        
        for i in 0...ABNumber.count - 1 {
            
            ABNumber[i] = "\(random.nextInt())"
        }
        
        // 把ABNumber 的字串array 轉成 數字array
        for (_,number) in ABNumber.enumerated(){
            peepNumber.append(Int(number)!)
        }
    }

    
    // 刪除數字，清空 Label
    func deleteNumber(){
        
        inputNumber.removeAll()
        guessLabel.text = inputNumber
    }
 
    
    // 重新遊戲，用 Alert 提示玩家
    func reset() {
        
        let optionMenu = UIAlertController(title: nil , message: "確 定 重 新 開 始 ?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "確定", style: .default) { [self] (_) in
            
            inputNumber = ""

            ABNumber = ["","","","",]
            
            peepNumber = []

            count = 0
            
            showTextView.text = ""
            
            TrophyCupImageView.isHidden = true
            
            deleteNumber()
            
            createNumber()
        }
        optionMenu.addAction(cancelAction)
        
        optionMenu.addAction(okAction)
        
        present(optionMenu, animated: true, completion: nil)
    }
}
