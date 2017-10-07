//
//  ViewController.swift
//  Scryblr
//
//  Created by Girish Rathod on 24/06/17.
//  Copyright © 2017 Girish Rathod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rawPoints:[Int] = []
    var recognizer:DBPathRecognizer?
    
    @IBOutlet var renderView: RenderView!
    
    @IBOutlet var textView: UITextView!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        
        //define the number of direction of PathModel
        let recognizer = DBPathRecognizer(sliceCount: 8, deltaMove: 16.0)
        
        //define specific formes to draw on PathModel
        recognizer.addModel(PathModel(directions: [7, 1], datas:"A" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,6,0,1,2,3,4,0,1,2,3,4], datas:"B" as AnyObject))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0], datas:"C" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,6,7,0,1,2,3,4], datas:"D" as AnyObject))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,4,3,2,1,0], datas:"E" as AnyObject))
        recognizer.addModel(PathModel(directions: [4,2], datas:" " as AnyObject))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,0], datas:"G" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,6,7,0,1,2], datas:"H" as AnyObject))
        recognizer.addModel(PathModel(directions: [2], datas:"I" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,3,4], datas:"J" as AnyObject))
        recognizer.addModel(PathModel(directions: [3,4,5,6,7,0,1], datas:"K" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,0], datas:"L" as AnyObject))
        recognizer.addModel(PathModel(directions: [6,1,7,2], datas:"M" as AnyObject))
        recognizer.addModel(PathModel(directions: [6,1,6], datas:"N" as AnyObject))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4], datas:"O" as AnyObject))
        recognizer.addModel(PathModel(directions: [6,7,0,1,2,3,4], datas:"P" as AnyObject))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,7,6,5,4,0], datas:"Q" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,6,7,0,1,2,3,4,1], datas:"R" as AnyObject))
        recognizer.addModel(PathModel(directions: [4,3,2,1,0,1,2,3,4], datas:"S" as AnyObject))
        recognizer.addModel(PathModel(directions: [0,2], datas:"T" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,1,0,7,6], datas:"U" as AnyObject))
        recognizer.addModel(PathModel(directions: [1,7,0], datas:"V" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,7,1,6], datas:"W" as AnyObject))
        recognizer.addModel(PathModel(directions: [1,0,7,6,5,4,3], datas:"X" as AnyObject))
        recognizer.addModel(PathModel(directions: [2,1,0,7,6,2,3,4,5,6,7], datas:"Y" as AnyObject))
        recognizer.addModel(PathModel(directions: [0,3,0], datas:"Z" as AnyObject))
        self.recognizer = recognizer
        
        super.viewDidLoad()
        
    }
    
    //View beautify
    
    
    //takes the coordinates of the first touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        rawPoints = []

        let touch = touches.first
        let location = touch!.location(in: view)
        rawPoints.append(Int(location.x))
        rawPoints.append(Int(location.y))
    }
    
    //takes all coordinates if touch moves and
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let location = touch!.location(in: view)
        if(rawPoints[rawPoints.count-2] != Int(location.x) && rawPoints[rawPoints.count-1] != Int(location.y)) {
            rawPoints.append(Int(location.x))
            rawPoints.append(Int(location.y))
        }
        self.renderView.pointsToDraw = rawPoints
    }
    
    //create the final path and makes action is letter is S
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var path:Path = Path()
        path.addPointFromRaw(rawPoints)
        
        let gesture:PathModel? = self.recognizer!.recognizePath(path)
        
        if gesture != nil {
            let letters = gesture!.datas as? String
            updateText(textView.text! + letters!)

        }
        else
        {
//            letterLabel.text = ""
        }

    }
    
    //XXX: - draw F X E Q
    
    func update(){
        timer.invalidate()
        rawPoints = []
    }
    
    
    func updateText(_ subStr: String){
        textView.text  = subStr
        let range = NSMakeRange(textView.text.lengthOfBytes(using: String.Encoding.utf8), 0);
        textView.scrollRangeToVisible(range);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func carriegeReturn(){
        var subString: String  = textView.text!
        if subString.characters.count > 0{
            subString.append("\n")
            updateText(subString)
        }

    }
    
    @IBAction func backSpace(){
        var subString: String  = textView.text!
        if subString.characters.count > 0{
            subString.remove(at: subString.index(before: subString.endIndex))
            updateText(subString)
        }
    }
    
    
}

