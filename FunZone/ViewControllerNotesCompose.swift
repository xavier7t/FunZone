//
//  ViewControllerNotesCompose.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import UIKit

class ViewControllerNotesCompose: UIViewController {

    @IBAction func buttonDeleteDidTouchUpInside(_ sender: Any) {
        buttonDeleteDidTouchUpInside_deleteNote()
    }
    @IBAction func buttonSaveDidTouchUpInside(_ sender: Any) {
        buttonSaveDidTouchUpInside_createNote()
    }
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var labelEWMessage: UILabel!
    @IBOutlet weak var textViewNoteBody: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //if indexNote is populated from the tableViewCell, display note title and oby
        if indexNote != nil {
            textFieldTitle.text = DBHelpNotes.dbHelperNotes.readNote()[indexNote!].title
            textViewNoteBody.text = DBHelpNotes.dbHelperNotes.readNote()[indexNote!].body
        } else {
            viewDidLoad_UpdateMsgLabel()
        }
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

extension ViewControllerNotesCompose {
    func viewDidLoad_UpdateMsgLabel() {
        labelEWMessage.textColor = .black
        labelEWMessage.text = "Tap the blank area below to take notes:"
    }
    func buttonSaveDidTouchUpInside_inputValidation(input : String?) -> Bool {
        var inputIsValid = false
        if input != nil && input! != "" && !input!.isEmpty {
            inputIsValid = true
        }
        return inputIsValid
    }
    func buttonSaveDidTouchUpInside_createNote() {
        let title = textFieldTitle.text
        let body = textViewNoteBody.text
        //error handling for invalid input
        if buttonSaveDidTouchUpInside_inputValidation(input: title) && !buttonSaveDidTouchUpInside_inputValidation(input: body) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter your note body below."
        }
        if !buttonSaveDidTouchUpInside_inputValidation(input: title) && buttonSaveDidTouchUpInside_inputValidation(input: body) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter your note title."
        }
        if !buttonSaveDidTouchUpInside_inputValidation(input: title) && !buttonSaveDidTouchUpInside_inputValidation(input: body) {
            labelEWMessage.textColor = .red
            labelEWMessage.text = "Please enter note title and body."
        }
        if buttonSaveDidTouchUpInside_inputValidation(input: title) && buttonSaveDidTouchUpInside_inputValidation(input: body) {
            print("Valid input.")
            labelEWMessage.text = ""
            labelEWMessage.textColor = view.backgroundColor
            
            if DBHelpNotes.dbHelperNotes.noteTitleDoesExist(title: title!) {
                //if title exists, update note in db
                DBHelpNotes.dbHelperNotes.updateNote(title: title!, body: body!)
                labelEWMessage.text = "Note Saved."
                labelEWMessage.textColor = .black
            } else {
                //if title doesnot exist, create note in db
                DBHelpNotes.dbHelperNotes.createNote(title: title!, body: body!)
                labelEWMessage.text = "Note Created."
                labelEWMessage.textColor = .black
            }
        }
    }
    
    func buttonDeleteDidTouchUpInside_deleteNote() {
        //delete note, dev use only
        DBHelpNotes.dbHelperNotes.deleteNote(title: textFieldTitle.text!)
    }
}
