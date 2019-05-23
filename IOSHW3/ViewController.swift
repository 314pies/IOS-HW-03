//
//  ViewController.swift
//  IOSHW3
//
//  Created by Ian Chen on 2019/5/23.
//  Copyright © 2019 Ian Chen. All rights reserved.
//
import SafariServices
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var clickCount : Int=0;
    var StartCountDown: Bool=false;
    var ClickDisabled:Bool = false;
    @IBAction func OnClockButtonClicked(_ sender: Any) {
        if(ClickDisabled == false){
            clickCount+=1;
            CountText.text = String(clickCount);
            
            UIView.animate(withDuration: 5, delay: 0.3, options: [.curveLinear], animations: {
                
                self.CountText.backgroundColor =
                    UIColor(
                    red:CGFloat(drand48()),
                    green:CGFloat(drand48()),
                    blue: CGFloat(drand48()),
                    alpha: 1.0);
            })
        }
       
       
        if(StartCountDown==false){
            StartCountDown = true;
          
            if(isTimerInitial==false){
                isTimerInitial=true;
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            }

        }
    }
    var isTimerInitial:Bool=false;
    @IBOutlet weak var CountText: UILabel!
    @IBAction func Restart(_ sender: Any) {
        TimeLeft = 10;
        StartCountDown = false;
        clickCount=0;
         TimeLeftLabel.text = String(TimeLeft);
        CountText.text = String(clickCount);
        ClickDisabled = false;
        
        let controller = UIAlertController(title: "遊戲已重設", message: "遊戲以重設完畢", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBOutlet weak var TimeLeftLabel: UILabel!
    
    
    var TimeLeft :Int=10;
    @objc func countDown()
    {
        if(StartCountDown){
            if(TimeLeft>0){
                TimeLeft-=1;
                TimeLeftLabel.text = String(TimeLeft);
                if(TimeLeft == 0){
                    ClickDisabled=true;
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var scoreBoard: ScoreBoardView = segue.destination as! ScoreBoardView;
        
        func getCurrentTimeString() -> String{
            
            let date = Date()
            let calender = Calendar.current
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            
            let year = components.year
            let month = components.month
            let day = components.day
            let hour = components.hour
            let minute = components.minute
            let second = components.second
            
            let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
            
            return today_string
            
        }
        
        
        scoreBoard.SaveNewRecord(rec: Record(time:getCurrentTimeString(),score:String(clickCount)));
        
    }
    
    @IBAction func OnURLClick(_ sender: Any) {
        if let url = URL(string: "https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E6%95%99%E5%AE%A4/%E7%95%B6%E4%BD%A0%E5%8A%AA%E5%8A%9B%E6%83%B3%E5%AD%B8%E7%BF%92-swift-%E6%99%82-%E5%85%A8%E4%B8%96%E7%95%8C%E9%83%BD%E6%9C%83%E4%BE%86%E5%B9%AB%E4%BD%A0-b11dca643686") {
            let controller = SFSafariViewController(url: url)
            
            present(controller, animated: true, completion: nil)
        }
    }
}

