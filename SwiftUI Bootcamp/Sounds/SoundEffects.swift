//
//  SoundEffects.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 11.04.2022.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager() /// Singleton
    
    var player: AVAudioPlayer?
    
    enum SoundOptions: String {
        case Tada
        case Badum
    }
    
    
    func playSound(sound: SoundOptions) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error. \(error.localizedDescription)")
        }
        
    }
}

struct SoundEffects: View {
        
    var body: some View {
        VStack {
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .Tada)
            }
            
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .Badum)
            }
        }
    }
}

