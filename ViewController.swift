import UIKit
import FSCalendar
import CalculateCalendarLogic
import PencilKit
import RealmSwift
import PencilKit

class ViewController: UIViewController,
                      FSCalendarDelegate,
                      FSCalendarDataSource,
                      FSCalendarDelegateAppearance,
                      PKToolPickerObserver{
    var date = ""
    var id = "1"
    var write = ""
    var write_end  = false
    @IBOutlet weak var titleView: PKCanvasView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    var datesWithEvents: Set<String> = []
    var toolPicker:PKToolPicker!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heartView: UIImageView!
    
    @IBOutlet weak var kanjoLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var taisyoLabel: UILabel!
    @IBOutlet weak var stressView: UIImageView!
    
    @IBOutlet weak var colendarView: FSCalendar!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lookView: UIImageView!
    @IBOutlet weak var writeView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var porryView: UIImageView!
    
    @IBOutlet weak var diaryLabel: UILabel!
    
    @IBOutlet weak var diaryCanvas: PKCanvasView!
    let colors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        view.backgroundColor = colors.akatya
        colendarView.backgroundColor = colors.white
        titleView.backgroundColor = colors.midori
        titleLabel.backgroundColor = colors.midori
        kanjoLabel.backgroundColor = colors.midori
        taisyoLabel.backgroundColor = colors.midori
        colendarView.layer.cornerRadius = 20
        kanjoLabel.layer.borderColor = (colors.tya).cgColor
        taisyoLabel.layer.borderColor = (colors.tya).cgColor
        mainView.backgroundColor = colors.white
        
        diaryCanvas.backgroundColor = colors.white
        diaryCanvas.layer.borderColor = (colors.tya).cgColor
        diaryCanvas.layer.borderWidth = 2.0
        
        diaryLabel.backgroundColor = colors.white
        diaryLabel.layer.borderWidth = 2.0
        diaryLabel.layer.borderColor = (colors.tya).cgColor
        
        titleLabel.layer.cornerRadius = 20
        titleView.layer.cornerRadius = 20

        kanjoLabel.layer.cornerRadius = 10
        diaryLabel.layer.cornerRadius = 10
        diaryCanvas.layer.cornerRadius = 10
        taisyoLabel.layer.cornerRadius = 10
        titleView.clipsToBounds = true
        titleLabel.clipsToBounds = true
        kanjoLabel.clipsToBounds = true
        taisyoLabel.clipsToBounds = true
        let X = view.frame.size.width - 65
        let Y = view.frame.size.height - 75
        let block = (X / 4)
        let block_y = (Y / 6)
        
        mainView.frame.size = CGSize(width: X + 15, height: Y + 25)
        mainView.frame.origin = CGPoint(x: 25, y: 25)
        self.view.sendSubviewToBack(mainView)
        userImage.frame.size = CGSize(width:block, height: block_y / 2)
        userImage.frame.origin = CGPoint(x : 25, y: 25)
        stressView.frame.size = CGSize(width: block, height: block_y / 2)
        stressView.frame.origin = CGPoint(x : 25 + block + 5, y: 25)
        lookView.frame.size = CGSize(width: block, height: block_y / 2)
        lookView.frame.origin = CGPoint(x : 25 + block * 2 + 10 , y: 25)
        writeView.frame.size = CGSize(width: block, height: block_y / 2)
        writeView.frame.origin = CGPoint(x : 25 + block * 3 + 15, y: 25)
        
        
        colendarView.frame.size = CGSize(width: X, height: block_y * 2)
        colendarView.frame.origin = CGPoint(x:25 , y: 25 + block_y / 2 + 5)
        
        dateLabel.frame.size = CGSize(width: X, height: block_y / 4)
        dateLabel.frame.origin = CGPoint(x: 25, y: 25 + block_y * 2.5 + 10)
        titleView.frame.size = CGSize(width: X, height: block_y / 2)
        titleView.frame.origin = CGPoint(x: 25, y:25 + block_y * 2.5 + 10)
        titleLabel.frame.size = CGSize(width: X, height: block_y / 2)
        titleLabel.frame.origin = CGPoint(x: 25, y:25 + block_y * 2.5 + 10)
        
        diaryCanvas.frame.size = CGSize(width: X, height: block_y * 2)
        diaryCanvas.frame.origin = CGPoint(x: 25, y:25 + block_y * 3 + 15)
        diaryLabel.frame.size = CGSize(width: X, height: block_y * 2)
        diaryLabel.frame.origin = CGPoint(x: 25, y:25 + block_y * 3 + 15)
        diaryLabel.numberOfLines = 0

        
        
        commentLabel.frame.size = CGSize(width: block, height: block_y / 3)
        commentLabel.frame.origin = CGPoint(x: 25, y: view.frame.size.height - (25 + block_y))
        porryView.frame.size = CGSize(width: block, height: block_y)
        porryView.frame.origin = CGPoint(x : 25, y: view.frame.size.height - (25 + block_y))
        
        imageView.frame.size = CGSize(width: block, height: block_y)
        imageView.frame.origin = CGPoint(x : 25 + block, y: view.frame.size.height - (25 + block_y))
        
        kanjoLabel.frame.size = CGSize(width: block - 6, height: (block_y / 3 ))
        kanjoLabel.frame.origin = CGPoint(x: 25 + (block * 2) + 3, y: view.frame.size.height - (25 + block_y))
        
        taisyoLabel.frame.size = CGSize(width: block - 6, height: (block_y / 3 ))
        taisyoLabel.frame.origin = CGPoint(x: 25 + (block * 2) + 3, y: view.frame.size.height - (25 + block_y) + (block_y / 3))
        
        
        
        heartView.frame.size = CGSize(width: block, height: block_y)
        heartView.frame.origin = CGPoint(x : 25 + block * 3, y: view.frame.size.height - (25 + block_y))
                                       
                                    
                                         
        
        

        
        //self.writeButton.layer.cornerRadius = 5
        
        let sampleImage = UIImage(named: "no_image")
        imageView.image = sampleImage
        let heartImage = UIImage(named: "no_image")
        heartView.image = heartImage
        let porryImage = UIImage(named: "porry")
        porryView.image = porryImage
        
        taisyoLabel.adjustsFontSizeToFitWidth = true
        taisyoLabel.layer.cornerRadius = 20
        kanjoLabel.adjustsFontSizeToFitWidth = true
        kanjoLabel.layer.cornerRadius = 20
        commentLabel.adjustsFontSizeToFitWidth = true
        
        id = "1"

    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        //初めての起動の時の強制転移
        let ud = UserDefaults.standard
        let firstLunchKey = "firstLunch"
        if ud.bool(forKey: firstLunchKey) {
            ud.set(false, forKey: firstLunchKey)
            ud.synchronize()
            self.performSegue(withIdentifier:"toUser", sender: nil)
        }


       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        self.calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
                self.calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
                self.calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
                self.calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
                self.calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
                self.calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
                self.calendar.calendarWeekdayView.weekdayLabels[6].text = "土"

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }

    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }

        return nil
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.string(from: date)
        dateLabel.text = self.date
        
        DispatchQueue(label: "background").async {
              let realm = try! Realm()
            if let savedDiary = realm.objects(Diary.self).filter("date == '\(self.date)'").last {
                self.write_end = true
                let titlecontext = savedDiary.titlecontext
                let diarycontext = savedDiary.context
                let image_data = savedDiary.image
                let heart_data = savedDiary.heart
                var image = UIImage(named: "no_image")
                var heart = UIImage(named: "no_image")
                let kanjo = savedDiary.kanjo
                let taisyo = savedDiary.taisyo
                let write = savedDiary.write
                let titletext = savedDiary.titletext
                let diarytext = savedDiary.kanjotext
                if savedDiary.image != nil{
                    image = UIImage(data: image_data!)
                }
                if savedDiary.heart != nil{
                    heart = UIImage(data: heart_data!)
                }
                if write == "手書き"{
                    DispatchQueue.main.async{
                    // data 表示
                        let titleDrawing = try? PKDrawing(data: titlecontext!)
                        let diaryDrawing = try? PKDrawing(data: diarycontext!)
                        self.titleView.drawing = titleDrawing!
                        self.diaryCanvas.drawing = diaryDrawing!
                        
                        self.diaryCanvas.isHidden = false
                        self.titleView.isHidden = false
                        
                        self.titleLabel.isHidden = true
                        self.diaryLabel.isHidden = true
                        
                        self.imageView.image = image!
                        self.heartView.image = heart!
                        self.kanjoLabel.text = kanjo
                        self.taisyoLabel.text = taisyo
                        self.write = write!
                        
                        
                }
                }
                else if write == "デジタル"{
                    DispatchQueue.main.async{
                    self.imageView.image = image!
                    self.heartView.image = heart!
                    self.kanjoLabel.text = kanjo
                        self.titleLabel.isHidden = false
                        self.diaryLabel.isHidden = false
                        
                        self.titleView.isHidden = true
                        self.diaryCanvas.isHidden = true
                    self.taisyoLabel.text = taisyo
                        self.titleLabel.text = titletext
                        self.write = write!
                        self.diaryLabel.text = diarytext
                }
                }
                
                //let image_data = savedDiary.image!
                //let heart_data = savedDiary.heart!
                
            }else{
                self.write_end = false
                let image = UIImage(named: "no_image")
                let heart = UIImage(named: "no_image")
                let kanjo = "感情"
                let taisyo = "書いたこと"
                let titletext = " "
                let diarytext = " "
                self.write = ""
                DispatchQueue.main.async{
                    self.titleView.drawing = PKDrawing()
                self.imageView.image = image!
                self.heartView.image = heart!
                self.kanjoLabel.text = kanjo
                    self.titleLabel.isHidden = false
                    self.diaryLabel.isHidden = false
                    self.diaryCanvas.isHidden = true
                    self.titleView.isHidden = true
                self.taisyoLabel.text = taisyo
                    self.titleLabel.text = titletext
                    self.diaryLabel.text = diarytext
                    self.commentLabel.text = "この日にするポジ？"
        }
            }}}
    @IBAction func onLook(_ sender: Any) {
        if date == ""{
            commentLabel.text = "日にちを選択するポジ！"
        }
        else if write == "デジタル" {
            self.performSegue(withIdentifier: "toLookDigitalDiary", sender: nil)
            
        }
        else if write == "手書き" {
            self.performSegue(withIdentifier: "toLookWriteDiary", sender: nil)
            
        }
        else{
            commentLabel.text = "まだ書いていないポジ"
        }
    }
    @IBAction func onClick(_ sender: Any) {
        if write_end == true{
            commentLabel.text = "その日はもう書いたポジ"
        }
        else if date == "" {
            commentLabel.text = "日にちを選択するポジ！"
        }
        else {
            
            self.performSegue(withIdentifier: "toStartDiary", sender: nil)
            
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toStartDiary" {
               let Second = segue.destination as! WriteStartViewController
            Second.hiniti = self.date
               
           }
        if segue.identifier == "toLookDigitalDiary" {
            let Second = segue.destination as! DigitalWriteViewController
         Second.hiniti = self.date
            
        }
        if segue.identifier == "toLookWriteDiary" {
            let Second = segue.destination as! WriteViewController
         Second.hiniti = self.date
            
        }
       }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        var hungoverDays = [String]()
        var hungoversuuti = [String]()
        if id == "1"{
        
    let realm = try! Realm()
        let result = realm.objects(Diary.self).filter("count != 0")
        
    for event in result{
        hungoverDays.append(event.date)
        hungoversuuti.append(event.kekka!)
    }
    }
    // cellのデザインを変更

    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    let dataString = formatter.string(from: date)
    
    if hungoverDays.contains(dataString){
        let number = hungoverDays.firstIndex(of: dataString)
        let suuti = hungoversuuti[number!]
        let Floatsuuti = Float(suuti)
        if Floatsuuti! >= 0{
            let color = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: CGFloat(Floatsuuti!))
            return color
        }else{
            let fabs_suuti = abs(Floatsuuti!)
            let color = UIColor(red: 0.0, green: 0.0, blue: 1, alpha: CGFloat(fabs_suuti))
            return color
        }
        
    }else{
    return nil
    }
    }


    @IBAction func userbutton(_ sender: Any) {
        self.performSegue(withIdentifier: "toUser", sender: nil)
    }
    
    
    
}
