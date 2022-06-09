//
//  ViewControllerNotes.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import UIKit

class ViewControllerNotes: UIViewController {

    @IBOutlet weak var tableViewNotes: UITableView!
    @IBAction func buttonComposeDidTouchUpInside(_ sender: Any) {
        indexNote = nil //to create new notes, set index from tableViewCell to nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //refresh information in the tableview while navigating back
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewNotes.reloadData()
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

extension ViewControllerNotes : UITableViewDataSource {
    
    //configure the number of rows, which is the count of notes in db
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBHelpNotes.dbHelperNotes.readNote().count
    }
    
    //configure the label text for note titles
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteArr = DBHelpNotes.dbHelperNotes.readNote()
        let cellNote = tableView.dequeueReusableCell(withIdentifier: "cellNotes", for: indexPath) as! TableViewCellNotes
        cellNote.labelNoteTitle.text = noteArr[indexPath.row].title
        return cellNote
    }
}

extension ViewControllerNotes : UITableViewDelegate {
    //configure the action while cells are selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NotesToEdit", sender: self) //open the note-composing page
        indexNote = indexPath.row
    }
}
var indexNote : Int?
