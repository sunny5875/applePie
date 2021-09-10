//
//  Game.swift
//  ApplePie
//
//  Created by 현수빈 on 2021/03/24.
//

import Foundation

struct Game{
    var word:String //맞춰야 하는 단어
    var incorrectMovesRemaining:Int //맞출 수 있는 남은 기회 수
    
    var guessedLetters: [Character] //맞춘 문자들
    
    //맞춘걸로 레이블 생성(__a__p)
    var formattedWord: String {
        var guessedWord = ""
        for letter in word{
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
            }
        }
        return guessedWord
        
    }
    
    //사용자가 누른 버튼의 letter가 들어있는지 확인하고 없으면 기회를 하나 까기
    mutating func playerGuessed(letter : Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
    
    
}
