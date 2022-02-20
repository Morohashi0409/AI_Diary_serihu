//
//  WeekViewController.swift
//  AI_Diary
//
//  Created by moro on 2021/12/05.
//

import UIKit
import PencilKit

class WeekViewController: UIViewController,
                          PKCanvasViewDelegate, PKToolPickerObserver{

    @IBOutlet weak var weekView: PKCanvasView!
    var toolPicker:PKToolPicker!
    @IBOutlet weak var weekImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var PenData:Data!
                
                // data read
                let docDir = FileManager.SearchPathDirectory.documentDirectory
                let uMask = FileManager.SearchPathDomainMask.userDomainMask
                let upath = NSSearchPathForDirectoriesInDomains(docDir, uMask, true)
                //var loadImg:UIImage!
                
                if let dirPath = upath.first{
                    do {
                        let dataURL = URL(fileURLWithPath: dirPath).appendingPathComponent("SavePenData")
                        PenData = try Data(contentsOf: dataURL)
                    } catch let error{
                        print(error)
                    }
                }
                
                // data 表示
        if PenData != nil{
                do {
                    weekView.drawing = try PKDrawing(data: PenData)
                }catch{
                    let err = error as NSError
                    fatalError("error \(err),\(err.userInfo)")
                    
                }
        }
        
        
        if #available(iOS 14.0, *){
            
            toolPicker = PKToolPicker()
            
        }else{
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
            
        }
        DispatchQueue(label: "background").async {
                        let back_image_data = UIImage(named:"weekly_calendar-mon-ol10241024_1.jpg")
                        
                        DispatchQueue.main.async{
                        // data 表示
                            //self.canvasView.isOpaque = false
                            self.weekView.backgroundColor = .clear
                            self.weekImage.image = back_image_data
                            self.weekView.addSubview(self.weekImage)
                            self.weekView.sendSubviewToBack(self.weekImage)
                    }
                        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Penstart(_ sender: Any) {
        // use pen and finger
       // canvasView.isOpaque = false
       
        weekView.drawingGestureRecognizer.isEnabled = true
        weekView.allowsFingerDrawing = true
        toolPicker.setVisible(true, forFirstResponder: weekView)
        toolPicker.addObserver(weekView)
        toolPicker.addObserver(self)
        weekView.becomeFirstResponder()
        
    }
    
    @IBAction func Penstop(_ sender: Any) {
        weekView.drawingGestureRecognizer.isEnabled = false
        weekView.allowsFingerDrawing = false

        toolPicker.setVisible(false, forFirstResponder: weekView)
        toolPicker.removeObserver(weekView)
        toolPicker.removeObserver(self)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButton(_ sender: Any) {
        //画面遷移して前の画面に戻る
        let PenData:Data!
           PenData = weekView.drawing.dataRepresentation()
           
           // local
           let CpenData = PenData
           let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
           let fileURL = documentsURL.appendingPathComponent("SavePenData")
           do{
               try CpenData!.write(to: fileURL)
           }catch{
               
           }

           weekView.drawing = PKDrawing()
        self.dismiss(animated: true, completion: nil)
    }
    
        

    
}
