//
//  userViewController.swift
//  AI_Diary
//
//  Created by moro on 2021/12/22.
//

import UIKit
import RealmSwift

class MyRoundButtonb : UIButton {
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



class userViewController: UIViewController {

    @IBOutlet weak var adanaFirld: UITextField!
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var adanaLabel: UILabel!
    @IBOutlet weak var oldLabel: UILabel!
    @IBOutlet weak var oldFirld: UITextField!
    @IBOutlet weak var saiText: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var womenButton: UIButton!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var register: UIBarButtonItem!
    @IBOutlet weak var barView: UINavigationBar!
    @IBOutlet weak var mainView: UIView!
    
    
    
    
    
    let colors = Colors()
    var sex = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let X = view.frame.size.width - 50
        let Y = view.frame.size.height - 50
        let block_y = Y / 12
        view.backgroundColor = colors.akatya
        mainView.backgroundColor = colors.white
        mainView.frame.size = CGSize(width: X, height: (Y))
        mainView.frame.origin = CGPoint(x: 25, y: 25)
        self.view.sendSubviewToBack(mainView)
        
        nameLabel.frame.size = CGSize(width: X / 2, height: (block_y))
        nameLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        errorLabel.frame.size = CGSize(width: X, height: (block_y))
        errorLabel.frame.origin = CGPoint(x: (X+25) - (X / 2)  , y: 25 + block_y)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.isHidden = true
        
        IDLabel.frame.size = CGSize(width: X / 2, height: (block_y))
        IDLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y * 2)
        
        adanaLabel.frame.size = CGSize(width: X, height: (block_y))
        adanaLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y * 4)
        adanaLabel.adjustsFontSizeToFitWidth = true
        
        adanaFirld.frame.size = CGSize(width: X / 2, height: (block_y))
        adanaFirld.frame.origin = CGPoint(x: 25, y: 25 + block_y * 5)
        
        oldLabel.frame.size = CGSize(width: X, height: (block_y))
        oldLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y * 7)
        oldLabel.adjustsFontSizeToFitWidth = true
        
        oldFirld.frame.size = CGSize(width: X / 4, height: (block_y))
        oldFirld.frame.origin = CGPoint(x: 25, y: 25 + block_y * 8)
        
        saiText.frame.size = CGSize(width: X, height: (block_y))
        saiText.frame.origin = CGPoint(x: 25 + X / 4, y: 25 + block_y * 8)
        saiText.adjustsFontSizeToFitWidth = true
        
        
        sexLabel.frame.size = CGSize(width: X, height: (block_y))
        sexLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y * 10)
        sexLabel.adjustsFontSizeToFitWidth = true
        
        menButton.frame.size = CGSize(width: X / 3, height: block_y)
        menButton.frame.origin = CGPoint(x: 50, y: 25 + block_y * 11)
        menButton.layer.cornerRadius = 20
        
        womenButton.frame.size = CGSize(width: X / 3, height: block_y)
        womenButton.frame.origin = CGPoint(x: X - (X / 3), y: 25 + block_y * 11)
        womenButton.layer.cornerRadius = 20
        
        
        
        barView.frame.size = CGSize(width: X, height: (Y / 12))
        barView.frame.origin = CGPoint(x: 25, y: 25)
        
        
        menButton.setTitle("男性", for: .normal)
        menButton.setTitle("男性", for: .selected)
        menButton.setTitle("男性", for: [.highlighted, .selected])
        menButton.addTarget(self, action: #selector(menButtonAction(sender:)), for: .touchUpInside)
        
        womenButton.setTitle("女性", for: .normal)
        womenButton.setTitle("女性", for: .selected)
        womenButton.setTitle("女性", for: [.highlighted, .selected])
        womenButton.addTarget(self, action: #selector(womenButtonAction(sender:)), for: .touchUpInside)
        
        
        
        // Do any additional setup after loading the view.
        DispatchQueue(label: "background").async { [self] in
            let realm = try! Realm()
    

            if let userData = realm.objects(User.self).last{
                let idData = userData.name
                let adanaData = userData.adana
                let oldData = userData.old
                let sexData = userData.sex
                DispatchQueue.main.async{
                    self.IDLabel.text = idData
                    self.adanaFirld.text = adanaData
                    self.oldFirld.text = oldData
                    if sexData == "men"{
                        self.menButton.isSelected = true
                    }
                    else{
                        self.womenButton.isSelected = true
                    }
                }
            }
            else{
                let passLen: Int = 6
                let charactersSource:String = "abcdefghijklmnopqrstuvwxyz#$%&_ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
                let randomPasswd = String((0..<passLen).compactMap{ _ in charactersSource.randomElement() })
                DispatchQueue.main.async{
                IDLabel.text = randomPasswd
                }
            }
    }
    }
    @objc func menButtonAction(sender: Any) {
            menButton.isSelected = !menButton.isSelected
        womenButton.isSelected = false
        sex = "men"
        
        
        }
    @objc func womenButtonAction(sender: Any) {
            womenButton.isSelected = !womenButton.isSelected
        menButton.isSelected = false
        sex = "women"
        }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func registerButton(_ sender: Any) {
        let adanatext = adanaFirld.text
        let oldtext = oldFirld.text
        let realm = try! Realm()
        let user = User()
        
        if adanatext!.count == 0{
            errorLabel.text = "あだ名が未記入です"
            self.errorLabel.isHidden = false
             
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
            self.errorLabel.isHidden = true
        }
        }
        else if oldtext!.count == 0{
            errorLabel.text = "年齢が未記入です"
            self.errorLabel.isHidden = false
             
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
               self.errorLabel.isHidden = true
        }
        }
        else if (menButton.isSelected) || (womenButton.isSelected){
                user.adana = adanaFirld.text
                
                user.name = IDLabel.text
                user.old = oldFirld.text
                user.sex = self.sex
                
                //STEP.3 Realmに書き込み
                try! realm.write {
                    realm.add(user, update:.all)}
                errorLabel.text = "完了しました。"
                self.errorLabel.isHidden = false
                 
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
                   self.errorLabel.isHidden = true
                }}
        else{
        errorLabel.text = "性別を選択してください"
        self.errorLabel.isHidden = false
         
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {_ in
           self.errorLabel.isHidden = true
        }
    }
            
        
        }
        
    }

