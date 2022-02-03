import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookThubnailImage: UIImageView!
    @IBOutlet weak var bookAuther: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func drawCellBymodel(model: Item) {
        self.bookTitle.text = model.volumeInfo.title
        let http = model.volumeInfo.imageLinks.thumbnail
        
        self.bookThubnailImage.loadFrom(URLAddress: http)
        self.bookAuther.text = model.volumeInfo.authors[0]
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        let https = "https" + URLAddress.dropFirst(4)
        guard let url = URL(string: https) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
    
    
}


