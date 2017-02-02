//
//  Sound.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 2/2/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import AudioToolbox

struct Sound {
    private var files: [String: SystemSoundID] = ["Correct": 0, "Incorrect": 1]
    
    init() {
        for (file, var id) in files {
            let filePath = Bundle.main.path(forResource: file, ofType: "wav")
            let url = URL(fileURLWithPath: filePath!) as CFURL
            
            AudioServicesCreateSystemSoundID(url, &id)
            files[file] = id
        }
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(files["Correct"]!)
    }
    
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(files["Incorrect"]!)
    }
}
