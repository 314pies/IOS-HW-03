//
//  ScoreBoardView.swift
//  IOSHW3
//
//  Created by Ian Chen on 2019/5/23.
//  Copyright © 2019 Ian Chen. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class ScoreBoardView : UIViewController{
    
    override func viewDidLoad(){
        ScoresView?.text="";
        for score in Scores.reversed(){
            ScoresView?.text += score;
            ScoresView?.text += "\n";
        }
    }
    
    var Scores = [""]
    
    let savingKey:String = "SavedIntArray";
    public func SaveNewRecord(rec:Record){
        var recStr: String = "分數：";
        recStr += rec.Score;
        recStr += " (";
        recStr += rec.Time;
        recStr += ")";
        print(recStr);
        let defaults = UserDefaults.standard
        Scores = defaults.stringArray(forKey: savingKey) ?? [String]()
        
        Scores.append(recStr);
        defaults.set(Scores, forKey: savingKey)
        
        ScoresView?.text="";
        for score in Scores.reversed(){
            ScoresView?.text += score;
            ScoresView?.text += "\n";
        }
        
        
        
        let content = UNMutableNotificationContent()
        content.title = "本地的分數存檔以刷新嚕"
        content.body = "您已經更新了本地的分數存檔"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    @IBOutlet weak var ScoresView: UITextView!
    
    
}
