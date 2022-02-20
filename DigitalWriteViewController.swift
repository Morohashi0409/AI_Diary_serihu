//
//  DigitalWriteViewController.swift
//  AI_Diary
//
//  Created by moro on 2022/01/29.
//

import UIKit
import RealmSwift

class DigitalWriteViewController: UIViewController,
                                  UIImagePickerControllerDelegate,
                                  UINavigationControllerDelegate{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kanjoLabel: UILabel!
    
    @IBOutlet weak var kanjotext: UILabel!
    @IBOutlet weak var taisyotext: UILabel!
    @IBOutlet weak var kanjoFirld: UITextView!
    @IBOutlet weak var themeFirld: UITextField!
    @IBOutlet weak var kanseiButton: UIButton!
    @IBOutlet weak var nezumiImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var guruguru: UIActivityIndicatorView!
    @IBOutlet weak var heartImage: UIImageView!

    @IBOutlet weak var barView: UINavigationBar!
    @IBOutlet weak var titleLabel: UILabel!
    struct RequestItem: Codable {
        var id: String
        var name : String
        var old : String
        var sex : String
        var date : String
        var data: String
        var count: String
        var write: String
        var kanjo: String
        var taisyo: String
    }

    struct ResponseItem: Codable {
        var kekka: Float
        var heart: String
        var serihu: String
    }
    
    var hiniti = "日付"
    var write = ""
    var kanjo = ""
    var taisyo = ""
    var text = ""
    var kekka = ""
    var image = ""
    var count = 0
    var List: [String] = []
    var serihu_list: [String] = []
    var serihu = ""
    var ActivityIndicator: UIActivityIndicatorView!
    
    
    let colors = Colors()
    override func viewDidLoad() {
        commentLabel.numberOfLines = 0
        super.viewDidLoad()
        let X = view.frame.size.width - 60
        let Y = view.frame.size.height - 75
        let block_x = (X / 3)
        let block_y = (Y / 12)
        view.backgroundColor = colors.akatya
        mainView.frame.size = CGSize(width: X + 10, height: Y + 25)
        mainView.frame.origin = CGPoint(x: 25, y: 25)
        mainView.backgroundColor = colors.white
        self.view.sendSubviewToBack(mainView)
        barView.frame.size = CGSize(width: X, height: (block_y))
        barView.frame.origin = CGPoint(x: 25, y: 25)
        dateLabel.frame.size = CGSize(width: block_x, height: block_y)
        dateLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y)

        imageButton.frame.size = CGSize(width: block_x, height: block_y)
        imageButton.frame.origin = CGPoint(x: 25 + block_x + 5, y: 25 + block_y )
        imageButton.backgroundColor = colors.midori
        imageButton.layer.cornerRadius = 20
        
        imageView.isHidden = true
        imageView.frame.size = CGSize(width: block_x, height: block_y * 2)
        imageView.frame.origin = CGPoint(x: 25 + block_x + 5, y: 25 + block_y )
        
        heartImage.frame.size = CGSize(width: block_x, height: block_y * 2)
        heartImage.frame.origin = CGPoint(x: (X + 25) - block_x , y: 25 + block_y )
        let image = UIImage(named: "no_image")
        imageView.image = image
        
        titleLabel.frame.size = CGSize(width: block_x, height: block_y)
        titleLabel.frame.origin = CGPoint(x: ((X + 60) / 2) - (block_x / 2), y: 25 + block_y * 3 + 5)
        
        
        themeFirld.frame.size = CGSize(width: X, height: block_y )
        themeFirld.frame.origin = CGPoint(x: 25, y: 25 + block_y * 4 + 10)
        
        kanjoLabel.frame.size = CGSize(width: block_x, height: block_y)
        kanjoLabel.frame.origin = CGPoint(x: ((X + 60) / 2) - (block_x / 2), y: 25 + block_y * 5 + 10)
        
        kanjotext.frame.size = CGSize(width: block_x, height: block_y)
        kanjotext.frame.origin = CGPoint(x: 30, y: 25 + block_y * 5 + 10)
        kanjotext.text = kanjo
        kanjotext.adjustsFontSizeToFitWidth = true
        kanjotext.backgroundColor = colors.midori
        kanjotext.layer.cornerRadius = 20
        kanjotext.clipsToBounds = true
        
        taisyotext.frame.size = CGSize(width: block_x, height: block_y)
        taisyotext.frame.origin = CGPoint(x: (X + 25) - block_x, y: 25 + block_y * 5 + 10)
        taisyotext.text = self.taisyo
        taisyotext.adjustsFontSizeToFitWidth = true
        taisyotext.backgroundColor = colors.midori
        taisyotext.layer.cornerRadius = 20
        taisyotext.clipsToBounds = true
        
        
        
        
        kanjoFirld.frame.size = CGSize(width: X, height: block_y * 4)
        kanjoFirld.frame.origin = CGPoint(x: 25, y: 25 + block_y * 6 + 10)
        commentLabel.text = "今日はどんな1日だったポジ？"
        
        commentLabel.frame.size = CGSize(width: block_x * 2, height: block_y * 2)
        
        commentLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y * 10 + 20)
        commentLabel.adjustsFontSizeToFitWidth = true
        commentLabel.backgroundColor = colors.midori
        commentLabel.layer.cornerRadius = 20
        commentLabel.clipsToBounds = true
        
        nezumiImage.frame.size = CGSize(width: block_x, height: block_y * 2)
        nezumiImage.frame.origin = CGPoint(x: (X + 35) - block_x, y: 25 + block_y * 10 + 20)
        
        guruguru.frame.size = CGSize(width: block_x, height: block_y)
        guruguru.frame.origin = CGPoint(x: (X + 60) / 2 - (block_x / 2) , y: (Y + 75) / 2)
        guruguru.isHidden = true
        self.guruguru.stopAnimating()
        self.commentLabel.isHidden = false
        self.countLabel.isHidden = true
        List.append(kanjo)
        List.append(taisyo)
        dateLabel.text = self.hiniti
        switch List{
         case ["pozi", "people"]:
            commentLabel.text = "その「人」のどんなところが好きかな？"
        case ["pozi", "things"]:
            commentLabel.text = "その「もの」のどんなところが好きかな？"
        case ["pozi", "myself"]:
            commentLabel.text = "自分のしたことからを書いてみよう"
        case ["nega", "people"]:
            commentLabel.text = "その「人」と何があったのかな？・"
        case ["nega", "things"]:
            commentLabel.text = "その「モノ」に何をされたのかな？"
        case ["nega", "myself"]:
            commentLabel.text = "自分がしたことから書いてみよう"
        default:
            print("それ以外")
        }
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.hiniti)'").last {
                let titletext = savedDiary.titletext
                let kanjotext = savedDiary.kanjotext
                let image_data = savedDiary.image
                let heart_data = savedDiary.heart
                if savedDiary.serihu != nil{
                    self.serihu = savedDiary.serihu!
                }
                let kanjo = savedDiary.kanjo
                let taisyo = savedDiary.taisyo
                self.count = savedDiary.count
                
                DispatchQueue.main.async{
                // data 表示
                    //self.canvasView.isOpaque = false
                    if image_data != nil{
                        let image = UIImage(data: image_data!)
                        self.imageView.image = image!
                        DispatchQueue.main.async{
                        self.imageButton.isHidden = true
                        self.imageView.isHidden = false
                        }
                    }
                    if heart_data != nil{
                        let heart = UIImage(data: heart_data!)
                        self.heartImage.image = heart!
                    }
                    //self.commentLabel.text = messege
                    self.taisyotext.text = taisyo
                    self.kanjotext.text = kanjo
                    self.themeFirld.text = titletext
                    self.kanjoFirld.text = kanjotext
                    self.commentLabel.text = self.serihu
            }
        
        }
        
    }
    }
  
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageButton(_ sender: Any) {
        changeImage()
        imageButton.isHidden = true
        imageView.isHidden = false
    }
    
    @IBAction func kansei_button(_ sender: Any) {
        DispatchQueue.main.async { [self] in
            self.view.bringSubviewToFront(guruguru)
            guruguru.isHidden = false
        guruguru.startAnimating()
        }
        let theme_text = themeFirld.text
        let kanjo_text = kanjoFirld.text
        
        
        if theme_text!.count != 0  && kanjo_text!.count != 0{
            print("分析開始")
            self.backButton.isEnabled = false
            self.imageButton.isEnabled = false
            self.kanseiButton.isEnabled = false
           
            
            //print(base64String)

           let listUrl = "http://inpca0.deta.dev/digital/"
            let realm = try! Realm()


            let userData = realm.objects(User.self).last
            let adanaData = userData?.adana
            let nameData = userData?.name
            let oldData = userData?.old
            let sexData = userData?.sex
            let requestItems = RequestItem(
                id :"1",
                name: nameData!,
                old: oldData!,
                sex: sexData!,
                date : self.hiniti,
                data: kanjo_text!,
                count: String(self.count),
                write: self.write,
                kanjo: self.kanjo,
                taisyo: self.taisyo)
            
           
           guard let requestBody = try? JSONEncoder().encode(requestItems) else { return }

           var request = URLRequest(url: URL(string: listUrl)!)
           request.httpMethod = "POST"
           request.httpBody = requestBody
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
                if let data = data{
                   let responseItems = try? JSONDecoder().decode([ResponseItem].self, from: data)
                    let resultData = Data(base64Encoded: responseItems![0].heart)
                    let resultImage = UIImage(data: resultData!)
                    self.serihu = responseItems![0].serihu
                   self.serihu_list = self.serihu.components(separatedBy: "\n")
                    self.count = self.count + 1
                    do {
                    DispatchQueue.main.async() {
                       self.heartImage.image = resultImage
                        self.kekka = String(responseItems![0].kekka)
                        self.commentLabel.text = self.serihu
            
                    }
               }}
                else{
                    DispatchQueue.main.async {
                        self.backButton.isEnabled = true
                        self.imageButton.isEnabled = true
                        self.kanseiButton.isEnabled = true
                        self.guruguru.isHidden = true
                        self.guruguru.stopAnimating()
                    self.commentLabel.text = "エラーポジ。未記入のものがないか\n。wifiに繋がっているか確認してみてポジ"
                    }
                }
            }.resume()
            DispatchQueue.main.asyncAfter(deadline: .now() + (10)) { [self] in
                let diary = Diary()
                diary.date = hiniti
                diary.titletext = themeFirld.text
                diary.kanjotext = kanjoFirld.text
    
                let image = imageView.image
                let image_data = image!.jpegData(compressionQuality: 1)
                let heart = heartImage.image
                let heart_data = heart!.jpegData(compressionQuality: 1)
                diary.count = self.count
                diary.image = image_data
                diary.heart = heart_data
                diary.serihu = self.serihu
                diary.kekka = self.kekka
                diary.kanjo = kanjo
                diary.taisyo = taisyo
                diary.write = write
                //diary.value = 1
                //STEP.3 Realmに書き込み
                try! realm.write {
                    realm.add(diary, update:.all)}
                print("保存完了")
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + (12)) {
                self.guruguru.stopAnimating()
                    self.backButton.isEnabled = true
                    self.imageButton.isEnabled = true
                    self.kanseiButton.isEnabled = true
                    self.performSegue(withIdentifier:"toserihu", sender: nil)
                }
        
                
                
           
        }
        else{
            self.guruguru.isHidden = true
            self.guruguru.stopAnimating()
            self.commentLabel.text = "未記入のものがあるポジ。"
        
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toserihu" {
            let third = segue.destination as! serihuViewController
            third.hiniti = self.hiniti
            third.serihu_List = self.serihu_list
            third.heartImage = self.heartImage.image
            
        }
        }
    // 画像パス関連（テスト）
          // DocumentディレクトリのfileURL取得
          func getDocumentsURL() -> NSURL {
              let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
              return documentsURL
          }

          // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
          func fileInDocumentsDirectory(filename: String) -> String {
              let fileURL = getDocumentsURL().appendingPathComponent(filename)
              return fileURL!.path
          }
    func changeImage() {
            let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary

            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self

                self.present(cameraPicker, animated: true, completion: nil)
            }
    }
    //アルバム画面で写真を選択した時
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               defer {
                          picker.dismiss(animated: true, completion: nil)
                       }
    
               self.imageView.image = image
               self.dismiss(animated: true, completion: nil)

        
       }
           
}
}
