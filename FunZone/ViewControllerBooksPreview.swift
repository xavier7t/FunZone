//
//  ViewControllerBooksPreview.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import UIKit
import PDFKit

class ViewControllerBooksPreview: UIViewController {

    @IBOutlet weak var customPDFView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pdfView = PDFView(frame: customPDFView.bounds)
        customPDFView.addSubview(pdfView)
        pdfView.autoScales = true
        
        let pdfFilePath = Bundle.main.url(forResource: bookArr[indexBook!].name, withExtension: "pdf")
        pdfView.document = PDFDocument(url: pdfFilePath!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
