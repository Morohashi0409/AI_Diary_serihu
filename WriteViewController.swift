//
//  WriteViewController.swift
//  Calendar
//
//  Created by lab on 2021/09/14.
//

import Foundation
import UIKit
import PencilKit
//このファイル内でRealmを使うのでここを追加
import RealmSwift
import Photos

class WriteViewController: UIViewController,
                           PKCanvasViewDelegate,
                           PKToolPickerObserver,
                           UIImagePickerControllerDelegate,
                           UINavigationControllerDelegate{
    var hiniti = "日付"
    var write = ""
    var kanjo = ""
    var taisyo = ""
    var kekka = ""
    var text = ""
    var image = ""
    var count = 0
    var serihu_list: [String] = []
    var serihu = ""
    var List: [String] = []
    
 
    
    
    @IBOutlet weak var barView: UINavigationBar!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!

    @IBOutlet weak var titleView: PKCanvasView!
    var toolPicker:PKToolPicker!
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet weak var kanjoLabel: UILabel!
    @IBOutlet weak var kanjotext: UILabel!
    @IBOutlet weak var taisyotext: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nezumiImage: UIImageView!
    @IBOutlet var WriteView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var guruguru: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var kanseiButton: UIButton!
    @IBOutlet weak var toolButton: UIButton!
    
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
    let colors = Colors()
    //var bunseki_count : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        commentLabel.numberOfLines = 0
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
        dateLabel.text = self.hiniti
        imageButton.frame.size = CGSize(width: block_x, height: block_y)
        imageButton.frame.origin = CGPoint(x: 25 + block_x + 5, y: 25 + block_y )
        imageButton.backgroundColor = colors.midori
        imageButton.layer.cornerRadius = 20
        
        ImageView.isHidden = true
        ImageView.frame.size = CGSize(width: block_x, height: block_y * 2 )
        ImageView.frame.origin = CGPoint(x: 25 + block_x + 5, y: 25 + block_y )
        
        var heart = UIImage(named: "no_image")
        heartImage.image = heart
        heartImage.frame.size = CGSize(width: block_x, height: block_y * 2)
        heartImage.frame.origin = CGPoint(x: (X + 25) - block_x , y: 25 + block_y )
        var image = UIImage(named: "no_image")
        ImageView.image = image
        
        titleLabel.frame.size = CGSize(width: block_x, height: block_y)
        titleLabel.frame.origin = CGPoint(x: ((X + 60) / 2) - (block_x / 2), y: 25 + block_y * 3 + 5)
        
        titleView.frame.size = CGSize(width: X, height: block_y)
        titleView.frame.origin = CGPoint(x: 25, y: 25 + block_y * 4 + 5)
        
        kanjoLabel.frame.size = CGSize(width: block_x, height: block_y)
        kanjoLabel.frame.origin = CGPoint(x: ((X + 60) / 2) - (block_x / 2), y: 25 + block_y * 5 + 10)
        
        kanjotext.frame.size = CGSize(width: block_x, height: block_y)
        kanjotext.frame.origin = CGPoint(x: 30, y: 25 + block_y * 5 + 10)
        kanjotext.text = self.kanjo
        
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
        
       
        
        canvasView.frame.size = CGSize(width: X, height: block_y * 4)
        canvasView.frame.origin = CGPoint(x: 25, y: 25 + block_y * 6 + 10)
        backImage.frame.size = CGSize(width: canvasView.frame.size.width, height: canvasView.frame.size.height)
        backImage.frame.origin = CGPoint(x: 0, y:0)
        
        guruguru.frame.size = CGSize(width: block_x, height: block_y)
        guruguru.frame.origin = CGPoint(x: (X + 60) / 2 - (block_x / 2) , y: (Y + 75) / 2)
        guruguru.isHidden = true
        commentLabel.text = "今日はどんな1日だったポジ？"
        
        commentLabel.frame.size = CGSize(width: block_x * 2, height: block_y * 2)
        
        commentLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y * 10 + 20)
        commentLabel.adjustsFontSizeToFitWidth = true
        commentLabel.backgroundColor = colors.midori
        commentLabel.layer.cornerRadius = 20
        commentLabel.clipsToBounds = true
        
        let harry = UIImage(named: "porry")
        nezumiImage.image = harry
        nezumiImage.frame.size = CGSize(width: block_x, height: block_y * 2)
        nezumiImage.frame.origin = CGPoint(x: (X + 35) - block_x, y: 25 + block_y * 10 + 20)
        
        
        self.guruguru.stopAnimating()
        commentLabel.text = "今日はどんな一日だったのかな？"
        
        // pencil init
        canvasView.delegate = self
        canvasView.alwaysBounceVertical = false
        //canvasView.isOpaque = false
        canvasView.drawing = PKDrawing()
        titleView.delegate = self
        titleView.alwaysBounceVertical = false
        //canvasView.isOpaque = false
        
        titleView.drawing = PKDrawing()
        
        // tool init
        if #available(iOS 14.0, *){
            
            toolPicker = PKToolPicker()
            
        }else{
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
            
        }
        let back_image_data = UIImage(named: "keisen")
        self.backImage.image = back_image_data
        self.canvasView.backgroundColor = .clear
        self.canvasView.addSubview(self.backImage)
        self.canvasView.sendSubviewToBack(self.backImage)
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
                        let context = savedDiary.context
                        let titlecontext = savedDiary.titlecontext
                        let image_data = savedDiary.image
                        let heart_data = savedDiary.heart
                        if savedDiary.serihu != nil{
                            self.serihu = savedDiary.serihu!
                        }
                        let kanjo = savedDiary.kanjo
                        let taisyo = savedDiary.taisyo
                        if savedDiary.image != nil{
                            image = UIImage(data: image_data!)
                            DispatchQueue.main.async{
                            self.imageButton.isHidden = true
                            self.ImageView.isHidden = false
                            }
                        }
                        if savedDiary.heart != nil{
                            heart = UIImage(data: heart_data!)
                        }
                        if savedDiary.count != nil{
                            self.count = savedDiary.count
                        }
                        DispatchQueue.main.async{
                        // data 表示
                            //self.canvasView.isOpaque = false
                            if context != nil{
                            let dayDrawing = try? PKDrawing(data: context!)
                                self.canvasView.drawing = dayDrawing!
                            }
                            if titlecontext != nil{
                            let titleDrawing = try? PKDrawing(data: titlecontext!)
                            self.titleView.drawing = titleDrawing!
                            }
                            
                            
                            self.ImageView.image = image!
                            self.heartImage.image = heart!
                            
                            self.taisyotext.text = taisyo
                            self.kanjotext.text = kanjo
                            self.commentLabel.text = self.serihu

                            
                    }
                        }
        // Do any additional setup after loading the view.
            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var tool = false
    @objc func penstartAction(sender: Any) {
        canvasView.drawingGestureRecognizer.isEnabled = true
        canvasView.allowsFingerDrawing = true
        titleView.drawingGestureRecognizer.isEnabled = true
        titleView.allowsFingerDrawing = true
        
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        
        toolPicker.setVisible(true, forFirstResponder: titleView)
        toolPicker.addObserver(titleView)
        toolPicker.addObserver(self)
        canvasView.becomeFirstResponder()
        titleView.becomeFirstResponder()
        tool = true
        }
    @objc func penstopAction(sender: Any) {
        canvasView.drawingGestureRecognizer.isEnabled = false
        canvasView.allowsFingerDrawing = false

        toolPicker.setVisible(false, forFirstResponder: canvasView)
        toolPicker.removeObserver(canvasView)
        toolPicker.removeObserver(self)
        titleView.drawingGestureRecognizer.isEnabled = false
        titleView.allowsFingerDrawing = false

        toolPicker.setVisible(false, forFirstResponder: titleView)
        toolPicker.removeObserver(titleView)
        toolPicker.removeObserver(self)
        tool = false
    }
    @IBAction func PenStartBt(_ sender: UIButton) {
    
        if tool == false{
            penstartAction(sender: (Any).self)
        }
        else{
            penstopAction(sender: (Any).self)
        }
    }
    
    
    
    
    @IBAction func SavePenData(_ sender: UIButton) {
        DispatchQueue.main.async { [self] in
            self.view.bringSubviewToFront(guruguru)
            guruguru.isHidden = false
        guruguru.startAnimating()
        }
        self.backButton.isEnabled = false
        self.imageButton.isEnabled = false
        self.kanseiButton.isEnabled = false
        self.toolButton.isEnabled = false

        let PenData:Data!
        let titlePenData:Data!
        PenData = canvasView.drawing.dataRepresentation()
        titlePenData = titleView.drawing.dataRepresentation()
        
        
        // Penのイメージ読取範囲設定
        let Cwidth = canvasView.frame.size.width
        let Cheight = canvasView.frame.size.height
        let Cimage = canvasView.drawing.image(from: CGRect(x:0,y:0,width:Cwidth,height:Cheight), scale: 1.0)
        // png をdata化　その後documentにsave
        let CpngData = Cimage.pngData()
        // for jpg
        //let imageData = image.jpegData(compressionQuality: 0.8)! as NSData
        print(" 分析開始")
        

        let base64String = CpngData!.base64EncodedString(options: .lineLength64Characters)
       let listUrl = "http://inpca0.deta.dev/items/"
        let realm = try! Realm()


        let userData = realm.objects(User.self).last
        let adanaData = userData?.adana
        let nameData = userData?.name
        let oldData = userData?.old
        let sexData = userData?.sex
        let requestItems = RequestItem(
            id : "1",
            name: nameData!,
            old: oldData!,
            sex: sexData!,
            date : hiniti,
            data: base64String,
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
               self.serihu_list = serihu.components(separatedBy: "\n")
               self.count = self.count + 1
                do {
               DispatchQueue.main.async {
                   self.heartImage.image = resultImage
                   self.kekka = String(responseItems![0].kekka)
                   self.commentLabel.text = self.serihu
                }
            }}
            else{
                self.backButton.isEnabled = true
                self.imageButton.isEnabled = true
                self.kanseiButton.isEnabled = true
                DispatchQueue.main.async {
                    self.commentLabel.text = "エラーポジ。未記入のものがないか\n。wifiに繋がっているか確認してみてポジ"
                 }
            }
        }.resume()
        DispatchQueue.main.asyncAfter(deadline: .now() + (10)) { [self] in
        let diary = Diary()
        diary.date = self.hiniti
        diary.context = PenData
        diary.titlecontext = titlePenData
        diary.context = PenData
        let image = ImageView.image
        let image_data = image!.jpegData(compressionQuality: 1)
        let heart = heartImage.image
        let heart_data = heart!.jpegData(compressionQuality: 1)
            diary.count = self.count
        diary.image = image_data
        diary.heart = heart_data
        diary.serihu = self.serihu
        diary.kanjo = kanjo
        diary.taisyo = taisyo
        diary.write = write
            diary.kekka = self.kekka
        
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toserihu" {
               let third = segue.destination as! serihuViewController
               third.hiniti = self.hiniti
               third.serihu_List = self.serihu_list
               third.heartImage = self.heartImage.image
           }
       }
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func ImageButton(_ sender: Any) {
        changeImage()
        imageButton.isHidden = true
        ImageView.isHidden = false
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
                  print(fileURL)
                  print("look")
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
    
               self.ImageView.image = image
               self.dismiss(animated: true, completion: nil)

        
       }
           
}
   
}
