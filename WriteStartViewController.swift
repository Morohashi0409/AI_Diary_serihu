//
//  WriteStartViewController.swift
//  AI_Diary
//
//  Created by moro on 2022/01/27.
//

import UIKit
import RealmSwift
class WriteStartViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var barView: UINavigationBar!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tugi_Button: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    var hiniti = ""
    var serihu: [String] = []
    var charsA: Array = ["はじめまして","僕の名前はポリー","いつもポジティブなハリネズミポジ","今日から君の日記をサポートするポジ！","今、今日一日を振り返ってみてほしいポジ","いい日だったポジ？","それともあんまりいい日ではなかったポジ？","どちらにしても\n形に残すことが重要ポジ！","どんな出来事も過ぎて思い出になるポジ","これから何個か質問に答えてから\n日記を書くポジ！"]
    var charsB: Array = ["お疲れ様ポジ！","今日も一日よく頑張ったポジ！","日記が続けられていて嬉しいポジ！","じゃあ一個アドバイスをするポジ！", "ハートに書いてある数字についてポジ！", "あれは、あなたの感情を数値化したものポジ!","-100点から+100点で表しているポジ",
        "だから、感情を踏まえて日記を書くことをお勧めするポジ",
        "研究の結果から、1日の終わりには良いことを考えると\nその日が良いものであると評価することが明らかになっているポジ",
        "一応参考にしてくれると嬉しいポジ"]
    var charsC: Array = ["お疲れ様ポジ！","今日はどんな1日だったポジ？","自分の感情を意識して書いてみるポジ"]
  
    var tapCount: Int = 0
    
    let colors = Colors()
    
    private lazy var animationLabel: CLTypingLabel = {
            let label = CLTypingLabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.charInterval = 0.03
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.akatya
        tugi_Button.tintColor = colors.white
        tugi_Button.backgroundColor = colors.tya
        nextButton.tintColor = colors.white
        tugi_Button.tintColor = colors.white
        mainView.backgroundColor = colors.white

        let realm = try! Realm()
        let result = realm.objects(Diary.self).filter("count != 0")
        print(result)
        print(result.count)
        if result.count == 0{
            self.serihu = charsA
        }
        else if result.count == 1{
            self.serihu = charsB
        }
        else{
            self.serihu = charsC
        }
        
        
        let X = view.frame.size.width - 50
        let Y = view.frame.size.height - 75

        barView.frame.size = CGSize(width: X, height: (Y / 7))
        barView.frame.origin = CGPoint(x: 25, y: 25)
        
        
        ImageView.frame.size = CGSize(width: (X / 2), height: (X / 2))
        ImageView.frame.origin = CGPoint(x:(view.frame.size.width / 2) - (X / 4), y: 25 + (Y / 7) + 20)
        let porryImage = UIImage(named: "porry")
        ImageView.image = porryImage
        
        
        tugi_Button.frame.size = CGSize(width: (X / 4), height: (X / 8))
        tugi_Button.frame.origin = CGPoint(x: (view.frame.size.width / 2) - (X / 8), y: (Y / 7) * 6 )
        tugi_Button.layer.cornerRadius = 20
        
        dateLabel.frame.size = CGSize(width: (X / 4), height: (X / 8))
        dateLabel.frame.origin = CGPoint(x: (view.frame.size.width / 2) - (X / 8), y: 25 + (Y / 7) + 5)
        
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.layer.cornerRadius = 20
        
        mainView.frame.size = CGSize(width: X , height: Y + 25)
        mainView.frame.origin = CGPoint(x: 25, y: 25)
        self.view.sendSubviewToBack(mainView)
        
        
        
        
        
        
        
                                
        
        dateLabel.text = hiniti
        
        
        view.addSubview(animationLabel)

        // labelにAutoLayoutをコードで設定（viewの真ん中に固定）
        [animationLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        animationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)]
            .forEach {$0.isActive = true }

        // labelにtextを設定
        // システムフォントをサイズ36に設定
        animationLabel.font = UIFont.systemFont(ofSize: 36)
        //animationLabel.text = "やあ、初めまして、きみが諸橋かい？"
        animationLabel.numberOfLines = 0
        animationLabel.adjustsFontSizeToFitWidth = true
       
        
        // 3
        self.initEveryone()
    }
         // 各部の初期化
         func initEveryone() {
           self.tapCount = 0 // カウント
             self.updateCharacters(index: 0) // ラベルテキスト
         }

         // 文字のアップデート
         func updateCharacters(index: Int) {
             self.animationLabel.text = self.serihu[index]
         }

         // 次の画面を開く
         func presentNextViewController() {
           // 画面遷移のコードをここに書く...
             self.performSegue(withIdentifier:"toTheme", sender: nil)
         }

         // 2
    @IBAction func didTapButton(_ sender: Any) {
        // タップ回数を加算
        
          self.tapCount += 1
        // 用意した文字の数をタップ回数が超えている場合
        if (self.serihu.count <= self.tapCount) {
          // 画面遷移
            
          self.presentNextViewController()
          return
        }

        // タップ回数に応じた文字に更新
          self.updateCharacters(index: self.tapCount)
      }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func toNextButton(_ sender: Any) {
        self.performSegue(withIdentifier:"toTheme", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toTheme" {
               let Second = segue.destination as!  ThemeSelectViewController
            Second.hiniti = self.hiniti
           }
        
    }

    
}


