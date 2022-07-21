//
//  ViewControllerBooks.swift
//  FunZone
//
//  Created by Xavier on 6/3/22.
//

import UIKit

var displayIsInColl = true
class ViewControllerBooks: UIViewController {
    
    
    @IBOutlet weak var tcToggle: UIButton!
    @IBAction func tcToggle(_ sender: Any) {
        if displayIsInColl {
            displayIsInColl = false
            collectionViewBook.alpha = 0
            tableViewBook.alpha = 1
            tcToggle.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
            //list.bullet
            //square.grid.2x2

        } else {
            displayIsInColl = true
            collectionViewBook.alpha = 1
            tableViewBook.alpha = 0
            tcToggle.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        }
    }
    @IBOutlet weak var tableViewBook: UITableView!
    @IBOutlet weak var collectionViewBook: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewDidLoad_InstantiateBooks()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func viewDidLoad_InstantiateBooks() {
        //bookArr.append(Book.init(name: "His Fortunate Grace", author: "Gertrude Atherton"))
        bookArr.append(Book.init(name: "The Lone Wolf", author: "Louis J Vance"))
        bookArr.append(Book.init(name: "The Incredible Invasion", author: "George O. Smith"))
        bookArr.append(Book.init(name: "The daily life of G and R", author: "Helen McClees"))
        bookArr.append(Book.init(name: "The Black Eagle", author: "G. P. R. James"))
        bookArr.append(Book.init(name: "The Return of the Native", author: "Thomas Hardy"))
        bookArr.append(Book.init(name: "Kathie's Soldiers", author: "Amanda M. Douglas"))
        bookArr.append(Book.init(name: "The Second Boys' Book of Model Aeroplanes", author: "Francis A. Collins"))
        
    }
}

extension ViewControllerBooks : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexBook = indexPath.row
        performSegue(withIdentifier: "BookToPreview", sender: self) //open pdf preview page
    }
}
extension ViewControllerBooks : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellBook = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBook", for: indexPath) as! CollectionViewCellBooks
        cellBook.imageViewCover.image = UIImage(named: bookArr[indexPath.item].image)
//        cellBook.imageViewCover.contentMode = .scaleAspectFit
        cellBook.clipsToBounds = true
        cellBook.layer.cornerRadius = 14 //define corner of coll cells with radius
        
        cellBook.labelBookName.text = bookArr[indexPath.item].name
        cellBook.labelAuthor.text = bookArr[indexPath.item].author
        return cellBook
    }
}
extension ViewControllerBooks : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //configure the size for item cells (square = ..% of of UIScreen width)
        let screenSize : CGRect = UIScreen.main.bounds
        let squareSide = screenSize.width * 3 / 7
        return CGSize(width: squareSide, height: squareSide)
    }
}

class Book {
    var name : String
    var author : String
    var image : String
    init(name : String, author : String) {
        self.name = name
        self.author = author
        self.image = "\(author)-\(name)"
    }
}

//bookArr defined outside class for preview access
var bookArr = [Book]()

var indexBook : Int?


extension ViewControllerBooks : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellBookTable = tableView.dequeueReusableCell(withIdentifier: "cellBookTable", for: indexPath) as! TableViewCellBooks
        cellBookTable.labelAuthorName.text = bookArr[indexPath.item].author
        cellBookTable.labelBookName.text = bookArr[indexPath.item].name
        cellBookTable.imageViewBookCover.image = UIImage(named: bookArr[indexPath.item].image)
        return cellBookTable
    }
    
    
}

extension ViewControllerBooks : UITableViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        indexBook = indexPath.row
//        performSegue(withIdentifier: "BookToPreview", sender: self) //open pdf preview page
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexBook = indexPath.row
        performSegue(withIdentifier: "BookToPreview", sender: self)
    }
}

