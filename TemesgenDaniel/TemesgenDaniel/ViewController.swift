//
//  ViewController.swift
//  Assignment 2
//
//  Created by Temesgen Daniel on 01/11/2020.
//  Copyright © 2020 kustar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scorelabel: UILabel!
    
    @IBOutlet weak var scorevalue: UILabel!
    
    @IBOutlet weak var timervalue: UILabel!
    //var expression : Expression = Expression()
    //var expression2 : Expression = Expression()
    
    var score = 0
    var count = 30
    var timer: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         score = 0
         count = 30
        scorevalue.text = String (score)
        timervalue.text = String(count)
        shuffleView(express: &expression)

        shuffleView(express: &expression2)
        
        while (expression == expression2) {
            shuffleView(express: &expression2)
        }
        updateUI(true,&expression)
        updateUI(false,&expression2)                // Do any additional setup after loading the view.
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementCountLabel), userInfo: nil, repeats: true)
        
    }
   // override func viewWillDisappear(_ animated: Bool) {
       // super.viewWillDisappear(animated)
       // timer.invalidate()
    //}
    
    @IBAction func hometapped(_ sender: Any) {
         let secondview = storyboard?.instantiateViewController(withIdentifier: "game") as! ViewController
               
    secondview.modalPresentationStyle = .fullScreen
    present(secondview,animated:true)
        
    }
    
    @objc func incrementCountLabel() {
           count = count - 1
           timervalue.text = String(count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 29) {
            
           // NotificationCenter.default.post(name: Notification.Name("text"), object: self.scorevalue.text)
            self.timer.invalidate()
            self.performSegue(withIdentifier: "pass", sender: self)
            
            //let secondview = self.storyboard?.instantiateViewController(withIdentifier: "gameover") as! GameOverViewController
            //secondview.modalPresentationStyle = .fullScreen
            //self.present(secondview,animated:true)
        }
        var  express: Expression = expression2
        if (expression2.eyes == .Closed){
            express.eyeshape = .Square
        }
        if (expression == expression2 || expression == express) {
            score += 10
            print("same")
            scorevalue.text = String(score)
            shuffleView(express: &expression)
            shuffleView(express: &expression2)
            while (expression == expression2) {
                shuffleView(express: &expression2)                //shuffleView(express: &expression)
            }
             
            updateUI(true,&expression)
            
            updateUI(false,&expression2)
            
        }
    
        
        
    }
    
    override func prepare (for segue:UIStoryboardSegue , sender :Any?){
        
        var vc = segue.destination as! GameOverViewController
        vc.passedscore = String(score)
        
    }

    
    @IBAction func info(_ sender: Any) {
        
        
        let secondview = storyboard?.instantiateViewController(withIdentifier: "tutorial") as! TutorialViewController
        secondview.modalPresentationStyle = .fullScreen
        present(secondview,animated:true)
        
        
    }
    @IBOutlet weak var faceView: faceView!
    @IBOutlet weak var faceview2: faceView2!
    var expression = Expression(eyes:.Open, mouth: .Smirk,skull:.Round ,eyeshape: .Round ,color:.Red ,eyebrow: .tilt)
   {
           didSet{
               updateUI(true,&expression) // this is to update the view each time the model changes
           }
       }
    
    var expression2 = Expression(eyes: .Closed, mouth:.Smile,skull:.Square ,eyeshape: .Round ,color:.yellow ,eyebrow: .tilt)
        
    {
        didSet{
            //shuffleView(express: &expression)
            updateUI(false,&expression2) // this is to update the view each time the model changes
           }
      }
    
    func shuffleView(express: inout Expression){
       var expressIds: [Int] = [1, 2, 3,4]
        expressIds.shuffle()
    
    switch expressIds[1] {
    case 1: //case 1: eyes open,smile mouth
        express.eyes = .Open;
        express.mouth = .Smile;
        express.eyeshape = .Round
        express.skull = .Round
        express.color = .Red
    case 2: //case 2: eyes closed, neutral mouth
        express.eyes = .Closed;
        express.mouth = .Neutral;
        express.eyeshape = .Round
        express.skull = .Square
        express.color = .Blue
        
    case 3:
        express.eyes = .Open;
        express.mouth = .Smirk;
        express.eyeshape = .Square
        express.skull = .Round
        express.color = .yellow
    default: //case 4: eyes open, sad mouth
        express.eyes = .Open;
        express.mouth = .Smile;
        express.eyeshape = .Square
        express.skull = .Square
        express.color = .yellow
    
        }
        
    }
    
    @IBAction func swipeleft(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            
            switch expression.color {
             case .Red: expression.color = .Blue
             case .Blue: expression.color = .yellow
            case .yellow: expression.color = .Red
                
            
             }
        }
    }
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        
        if sender.state == .ended {
            
            switch expression.eyes {
             case .Open: expression.eyes = .Closed
             case .Closed: expression.eyes = .Open
            
             }
        }
    }
    @IBAction func toggedEye(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
             print( "begin")
             //print (expression.eyes)
                  
                   
            switch expression.skull {
            case .Round: expression.skull = .Square
            case .Square: expression.skull = .Round
            
            
               }
        }
               print("end")
        print (expression.eyes)
        
    }
    
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
         if sender.state == .ended {
            
            switch expression.mouth {
            
            case .Neutral : expression.mouth =  .Smile
        case .Smile : expression.mouth =  .Smirk
        case .Smirk: expression.mouth =  .Neutral
        }
        
    }
    }
    @IBAction func tappedEye(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
                 print( "begin")
                 print (expression.eyes)
                      
                      
                switch expression.eyeshape {
                case .Round: expression.eyeshape = .Square
                case .Square: expression.eyeshape = .Round
                
                
                   }
            }
                   print("end")
            print (expression.eyes)
            
        }
        
    
    
    
     func updateUI(_ viewbool: Bool,_ express: inout Expression){
            if (viewbool) {
                
            print(" I am in updateUI () function ")
            switch express.eyes {
                
            case .Closed : faceview2.eyesOpen = false
                               
            case .Open :faceview2.eyesOpen = true        }
            
            
            switch express.skull {
            case .Round: faceview2.skullForm = true
            case .Square: faceview2.skullForm = false
            
            
               }
            
            switch express.eyeshape {
            case .Round: faceview2.eyeShape = true
            case .Square: faceview2.eyeShape = false
            
            
               }
            switch express.mouth {
                
            case .Neutral : faceview2.mouthCurvature = 0
            case .Smile : faceview2.mouthCurvature = 1
            case .Smirk: faceview2.mouthCurvature = -1
            }
            
            switch express.color {
                
            case .Red : faceview2.colorNUM = 0
            case .Blue : faceview2.colorNUM = 1
            case .yellow: faceview2.colorNUM = -1
            }
            
        }
            else {
                switch express.eyes {
                    
                case .Closed : faceView.eyesOpen = false
                                   
                case .Open :faceView.eyesOpen = true        }
                
                
                switch express.skull {
                case .Round: faceView.skullForm = true
                case .Square: faceView.skullForm = false
                
                
                   }
                
                switch express.eyeshape {
                case .Round: faceView.eyeShape = true
                case .Square: faceView.eyeShape = false
                
                
                   }
                switch express.mouth {
                    
                case .Neutral : faceView.mouthCurvature = 0
                case .Smile : faceView.mouthCurvature = 1
                case .Smirk: faceView.mouthCurvature = -1
                }
                
                switch express.color {
                    
                case .Red : faceView.colorNUM = 0
                case .Blue : faceView.colorNUM = 1
                case .yellow: faceView.colorNUM = -1
                }
            }
    }
}

