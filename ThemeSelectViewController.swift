//
//  ThemeSelectViewController.swift
//  AI_Diary
//
//  Created by moro on 2022/01/27.
//

import UIKit

class MyRoundButton : UIButton {
    let colors = Colors()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(.black, for: .normal)
        setTitleColor(.darkGray, for: [.selected, .highlighted])
        setTitleColor(.black, for: .selected)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        tintColor = .clear
        layer.cornerRadius = frame.height / 2
        layer.borderColor = colors.tya.cgColor
        layer.borderWidth = 2
    }
    
    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    fileprivate func updateBackgroundColor() {
        if !isSelected && !isHighlighted {
            backgroundColor = .clear
        } else if !isSelected && isHighlighted {
            backgroundColor = .lightGray
        } else {
            backgroundColor = colors.akatya
        }
    }
}


class ThemeSelectViewController: UIViewController {
    var hiniti = ""
    var write = ""
    var kanjo = ""
    var taisyo = ""
    
    
    
    @IBOutlet weak var tegaki_button: MyRoundButton!
    @IBOutlet weak var digital_button: MyRoundButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var people_button: UIButton!
    @IBOutlet weak var pozi_button: UIButton!
    @IBOutlet weak var nega_button: UIButton!
    private var checked = false
    @IBOutlet weak var things_button: UIButton!
    
    @IBOutlet weak var barView: UINavigationBar!
    @IBOutlet weak var myself_button: UIButton!
    @IBOutlet weak var kakikataLabel: UILabel!
    @IBOutlet weak var error_Label: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var kanjoLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var naiyoLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    let colors = Colors()
    override func viewDidLoad() {
        super.viewDidLoad()
        let X = view.frame.size.width - 50
        let Y = view.frame.size.height
        let block_x = (X / 3)
        let block_y = (Y / 15)
        view.backgroundColor = colors.akatya
        mainView.frame.size = CGSize(width: X, height: Y - 50)
        mainView.frame.origin = CGPoint(x: 25, y: 25)
        mainView.backgroundColor = colors.white
        self.view.sendSubviewToBack(mainView)
        dateLabel.frame.size = CGSize(width: block_x, height: block_y)
        dateLabel.frame.origin = CGPoint(x: 25, y: 30 + block_y)
        dateLabel.adjustsFontSizeToFitWidth = true
        
        barView.frame.size = CGSize(width: X, height: block_y )
        barView.frame.origin = CGPoint(x: 25, y: 25)
        
        kakikataLabel.frame.size = CGSize(width: block_x, height: block_y)
        kakikataLabel.frame.origin = CGPoint(x: ((X + 50) / 2) - (block_x / 2), y: 30 + block_y )
        kakikataLabel.adjustsFontSizeToFitWidth = true
        error_Label.frame.size = CGSize(width: block_x, height: block_y)
        error_Label.frame.origin = CGPoint(x: 25 + block_x * 2, y: 30 + block_y )
        error_Label.adjustsFontSizeToFitWidth = true
        tegaki_button.frame.size = CGSize(width:block_x, height:block_y)
        tegaki_button.frame.origin = CGPoint(x: 50, y: block_y * 3)
        tegaki_button.layer.cornerRadius = 20
               
        digital_button.frame.size = CGSize(width: block_x, height: block_y)
        digital_button.frame.origin = CGPoint(x: X - block_x, y: block_y * 3)
        digital_button.layer.cornerRadius = 20
        
        kanjoLabel.frame.size = CGSize(width: X, height: 30)
        kanjoLabel.frame.origin = CGPoint(x: ((X + 50) / 2) - (X / 2), y: 25 + block_y * 4)
        kanjoLabel.adjustsFontSizeToFitWidth = true
        
        pozi_button.frame.size = CGSize(width: block_x, height: block_y)
        pozi_button.frame.origin = CGPoint(x: 50, y: block_y * 6)
        pozi_button.layer.cornerRadius = 20
        
        nega_button.frame.size = CGSize(width: block_x, height: block_y)
        nega_button.frame.origin = CGPoint(x: X - block_x, y: block_y * 6)
        nega_button.layer.cornerRadius = 20
        
        naiyoLabel.frame.size = CGSize(width: X, height: 30)
        naiyoLabel.frame.origin = CGPoint(x: ((X + 50) / 2) - (X / 2), y: 25 + block_y * 8)
        naiyoLabel.adjustsFontSizeToFitWidth = true
        
        people_button.frame.size = CGSize(width: block_x, height: block_y)
        people_button.frame.origin = CGPoint(x:((X + 50) / 2) - block_x / 2, y: block_y * 10)
        people_button.layer.cornerRadius = 20
        
        things_button.frame.size = CGSize(width: block_x, height: block_y)
        things_button.frame.origin = CGPoint(x: 50, y: block_y * 12)
        things_button.layer.cornerRadius = 20
        
        myself_button.frame.size = CGSize(width: block_x, height: block_y)
        myself_button.frame.origin = CGPoint(x: X - block_x, y: block_y * 12)
        myself_button.layer.cornerRadius = 20
        
        
        
        
        
        self.error_Label.isHidden = true
        
       tegaki_button.setTitle("手書き", for: .normal)
       tegaki_button.setTitle("手書きで書く！", for: .selected)
       tegaki_button.setTitle("手書きで書く！", for: [.highlighted, .selected])
       tegaki_button.addTarget(self, action: #selector(tegaki_buttonAction(sender:)), for: .touchUpInside)
        
        digital_button.setTitle("文字入力", for: .normal)
        digital_button.setTitle("文字入力で書く！", for: .selected)
        digital_button.setTitle("文字入力で書く！", for: [.highlighted, .selected])
        digital_button.addTarget(self, action: #selector(digital_buttonAction(sender:)), for: .touchUpInside)
        
        pozi_button.setTitle("感謝", for: .normal)
        pozi_button.setTitle("感謝を書く", for: .selected)
        pozi_button.setTitle("感謝を書く", for: [.highlighted, .selected])
        pozi_button.addTarget(self, action: #selector(pozi_buttonAction(sender:)), for: .touchUpInside)
        
        nega_button.setTitle("不快", for: .normal)
        nega_button.setTitle("不快を書く", for: .selected)
        nega_button.setTitle("不快を書く", for: [.highlighted, .selected])
        nega_button.addTarget(self, action: #selector(nega_buttonAction(sender:)), for: .touchUpInside)
        
        people_button.setTitle("人のこと", for: .normal)
        people_button.setTitle("人のこと", for: .selected)
        people_button.setTitle("人のこと", for: [.highlighted, .selected])
        people_button.addTarget(self, action: #selector(people_buttonAction(sender:)), for: .touchUpInside)
        
        things_button.setTitle("モノのこと", for: .normal)
        things_button.setTitle("モノのこと", for: .selected)
        things_button.setTitle("モノのこと", for: [.highlighted, .selected])
        things_button.addTarget(self, action: #selector(things_buttonAction(sender:)), for: .touchUpInside)
        
        myself_button.setTitle("自分のこと", for: .normal)
        myself_button.setTitle("自分のこと", for: .selected)
        myself_button.setTitle("自分のこと", for: [.highlighted, .selected])
        myself_button.addTarget(self, action: #selector(myself_buttonAction(sender:)), for: .touchUpInside)
        
        
        
        dateLabel.text = self.hiniti
        
    }
    @objc func tegaki_buttonAction(sender: Any) {
            tegaki_button.isSelected = !tegaki_button.isSelected
        digital_button.isSelected = false
        write = "手書き"
        
        }
    @objc func digital_buttonAction(sender: Any) {
            digital_button.isSelected = !digital_button.isSelected
        tegaki_button.isSelected = false
        write = "デジタル"
        }
    @objc func pozi_buttonAction(sender: Any) {
            pozi_button.isSelected = !pozi_button.isSelected
        nega_button.isSelected = false
        kanjo = "ポジティブ"
        }
    @objc func nega_buttonAction(sender: Any) {
            nega_button.isSelected = !nega_button.isSelected
        pozi_button.isSelected = false
        kanjo = "ネガティブ"
        }
    @objc func people_buttonAction(sender: Any) {
            people_button.isSelected = !people_button.isSelected
        things_button.isSelected = false
        myself_button.isSelected = false
        taisyo = "人のこと"
        }
    @objc func things_buttonAction(sender: Any) {
            things_button.isSelected = !things_button.isSelected
        people_button.isSelected = false
        myself_button.isSelected = false
        taisyo = "モノのこと"
        }
    @objc func myself_buttonAction(sender: Any) {
            myself_button.isSelected = !myself_button.isSelected
        people_button.isSelected = false
        things_button.isSelected = false
        taisyo = "自分自身のこと"
        }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toMainDiary" {
               let Second = segue.destination as! WriteViewController
               Second.hiniti = self.hiniti
               Second.kanjo = self.kanjo
               Second.write = self.write
               Second.taisyo = self.taisyo
           }
        else if segue.identifier == "toDigitalDiary" {
            let Third = segue.destination as! DigitalWriteViewController
            Third.hiniti = self.hiniti
            Third.kanjo = self.kanjo
            Third.write = self.write
            Third.taisyo = self.taisyo
        }
    }
   
    @IBAction func NextButton(_ sender: Any) {
        if  (digital_button.isSelected || tegaki_button.isSelected ){
            if  (pozi_button.isSelected || nega_button.isSelected ){
                if  (people_button.isSelected || things_button.isSelected || myself_button.isSelected ){
                    if tegaki_button.isSelected{
                    self.performSegue(withIdentifier:"toMainDiary", sender: nil)
                }
                    else if digital_button.isSelected{
                        self.performSegue(withIdentifier:"toDigitalDiary", sender: nil)
                    }
                    
                }
                else{
                    self.error_Label.text = "書く対象を選んでください。"
                    self.error_Label.isHidden = false
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
                       self.error_Label.isHidden = true
                }
                
                }}
            else{
                self.error_Label.text = "感謝日記か不快日記か選んでください。"
                self.error_Label.isHidden = false
                
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
                   self.error_Label.isHidden = true
                
               }
            }
        }
        else{
            self.error_Label.text = "書き方を選んでください。"
            self.error_Label.isHidden = false
             
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
               self.error_Label.isHidden = true
           }
        }
        
    }
    @IBAction func backButton(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
}
}
