//
//  Record.swift
//  IOSHW3
//
//  Created by Ian Chen on 2019/5/23.
//  Copyright © 2019 Ian Chen. All rights reserved.
//

import Foundation

class Record: Codable{
    init(time:String,score:String) {
        self.Time = time;
        self.Score=score;
    }
    
    var Time:String;
    var Score:String;
}
