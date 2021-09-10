//
//  ViewController.swift
//  ApplePie
//
//  Created by 현수빈 on 2021/03/23.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]! //콜렉션으로 한꺼번에 묶기
    
    //맞출 단어들의 리스트
    var listOfWords=["buccameer","swift","glorious","incandescent","bug","program"]
    
    //맞출 수 있는 기회 수
    let incorrectMoveAllowed = 7
    
    //맞춘 수, 이 값이 바뀌면 새로운라운드가 시작되는 거니까 newROUND 호출
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    //진 수, 위와 동일
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    
    //맞춰야 하는 하나의 언어에 대한 게임 객체
    var currentGame:Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound() //일단 새 판을 깐다
    }

    
    func newRound(){
        //게임을 다해서 없으면 letter를 누르는  버튼을 다 끈다
        if !listOfWords.isEmpty{
            //맨 처음 꺼를 가져와서 게임객체를 만들고 버튼을 다 활성화 시킨다
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,incorrectMovesRemaining: incorrectMoveAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
            
        }else {
            enableLetterButtons(false)
        }
        
    }
    
    
    //라벨을 세팅하는 함수
    func updateUI(){
        var letters=[String]()
        // _가 연달아 생길 시 선처럼 보이는 것을 막기 위해 추가적인 코드 작성
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ") //이걸로 사이를 벌려서 선처럼 보이는 것을 막는다
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins : \(totalWins), Losses : \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        //누르면 일단 다시 못누르게 하기
        sender.isEnabled=false
        let letterString = sender.title(for: .normal) //sender의 타이틀을 가져오기
        let letter = Character(letterString!.lowercased())//소문자로 바뚠 후 letterString으로 변경
        currentGame.playerGuessed(letter: letter) //누른 letter로 단어에 있는지 확인
        updateGameState()
        
    }
    
    //이겼는지 졌는지 확인하는 함수
    func updateGameState(){
        if currentGame.incorrectMovesRemaining==0{
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord{
            totalWins+=1
        }
        else{
            updateUI()
            
        }
    }
    
    //더이상 게임을 할 단어가 없을 때 끄거나 다 킬 때 사용
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled=enable
        }
    }
    
}

