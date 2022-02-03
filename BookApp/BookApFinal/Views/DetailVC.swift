import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookThubnailImage: UIImageView!
    @IBOutlet weak var bookAuther: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    var product: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookTitle.text = product?.volumeInfo.title
        bookAuther.text = product?.volumeInfo.authors[0]
        bookDescription.text = product?.volumeInfo.description
        bookThubnailImage.loadFrom(URLAddress: product?.volumeInfo.imageLinks.thumbnail ?? "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
