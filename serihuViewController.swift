//
//  serihuViewController.swift
//  AI_Diary
//
//  Created by moro on 2021/12/02.
//

import UIKit
import RealmSwift

class serihuViewController: UIViewController {
    @IBOutlet weak var hari_image: UIImageView!
    @IBOutlet weak var heart_image: UIImageView!
    @IBOutlet weak var barView: UINavigationBar!
    @IBOutlet weak var kanryoButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tugiButton: UIButton!
    @IBOutlet weak var messegetext: UITextView!
    var hiniti = ""
    var suuti:Float = 0
    var tapCount: Int = 0
    var count = ""
    var name = "ๅ็กใ"
    var id = "1"
    var serihu_List: [String] = []
    var heartImage:UIImage? = nil
    let colors = Colors()
    
    
    struct RequestItem: Codable {
        var date : String
        var count : String
        var stress : String
        var name : String
    }

    struct ResponseItem: Codable {
        var messege: String
    }
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
        tugiButton.tintColor = colors.white
        tugiButton.backgroundColor = colors.tya
        
        mainView.backgroundColor = colors.white
        let X = view.frame.size.width - 50
        let Y = view.frame.size.height - 75
        mainView.frame.size = CGSize(width: X, height: (Y + 25))
        mainView.frame.origin = CGPoint(x: 25, y: 25)
        self.view.sendSubviewToBack(mainView)

        barView.frame.size = CGSize(width: X, height: (Y / 7))
        barView.frame.origin = CGPoint(x: 25, y: 25)
        dateLabel.frame.size = CGSize(width: X / 3, height: (Y / 7))
        dateLabel.frame.origin = CGPoint(x: 25, y: (Y / 7))
        
        heart_image.frame.size = CGSize(width: X / 2, height: (Y / 7) * 2)
        heart_image.frame.origin = CGPoint(x: 25, y: (Y / 7) )
        
        hari_image.frame.size = CGSize(width: X / 2, height: (Y / 7) * 2)
        hari_image.frame.origin = CGPoint(x: 25 + X / 2, y: (Y / 7) )
        
        tugiButton.frame.size = CGSize(width: (X / 4), height: (X / 8))
        tugiButton.frame.origin = CGPoint(x: (view.frame.size.width / 2) - (X / 8), y: (Y / 7) * 6)
        
        tugiButton.layer.cornerRadius = 20
        
        
        
        dateLabel.text = hiniti
        
        
        
        let realm = try! Realm()
        let userData = realm.objects(User.self).last
        let nameData = userData?.name
        
        
        if suuti < 0 {
            let harryImage = UIImage(named: "nerry.JPG")
            hari_image.image = harryImage
            print("neri")
        }
        else{
            let harryImage = UIImage(named: "porry.JPG")
            hari_image.image = harryImage
            print("pori")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue(label: "background").async {
                    let realm = try! Realm()

                    if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.hiniti)'").last {
                        
                        DispatchQueue.main.async{ [self] in
                        // data ่กจ็คบ
                            self.heart_image.image = heartImage
                            // labelใviewใซaddใใ
                            view.addSubview(animationLabel)

                            // labelใซAutoLayoutใใณใผใใง่จญๅฎ๏ผviewใฎ็ใไธญใซๅบๅฎ๏ผ
                            [animationLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                            animationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)]
                                .forEach { $0.isActive = true }

                            // labelใซtextใ่จญๅฎ
                            // ใทในใใ?ใใฉใณใใใตใคใบ36ใซ่จญๅฎ
                            animationLabel.font = UIFont.systemFont(ofSize: 36)
                            animationLabel.numberOfLines = 0
                            animationLabel.text = self.serihu_List[0]
                            animationLabel.adjustsFontSizeToFitWidth = true
                          }
                    }
        }
        
            
}
    //ๅ้จใฎๅๆๅ
    func initEveryone() {
      self.tapCount = 0 // ใซใฆใณใ
        self.updateCharacters(index: 0) // ใฉใใซใใญในใ
    }

    // ๆๅญใฎใขใใใใผใ
    func updateCharacters(index: Int) {
        self.animationLabel.text = self.serihu_List[index]
    }

    // 2
@IBAction func didTapButton(_ sender: Any) {
   // ใฟใใๅๆฐใๅ?็ฎ
   
     self.tapCount += 1
   // ็จๆใใๆๅญใฎๆฐใใฟใใๅๆฐใ่ถใใฆใใๅ?ดๅ
   if (self.serihu_List.count <= self.tapCount) {
     // ็ป้ข้ท็งป
       self.presentingViewController?.presentingViewController?.presentingViewController?
           .presentingViewController?.dismiss(animated: true, completion: nil)
     return
   }

   // ใฟใใๅๆฐใซๅฟใใๆๅญใซๆดๆฐ
     self.updateCharacters(index: self.tapCount)
 }

    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
}
    @IBAction func kanryoButton(_ sender: Any) {
        
        self.presentingViewController?.presentingViewController?.presentingViewController?
            .presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}

