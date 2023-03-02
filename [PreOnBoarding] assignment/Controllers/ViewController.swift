//
//  ViewController.swift
//  [PreOnBoarding] assignment
//
//  Created by 강민주 on 2023/03/01.
//

import UIKit

class ViewController: UIViewController {
    
    var imageArray: [ImageLoad] = [
        ImageLoad(imageStr: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTwkK3moZMOx_3yXkv4dp_AhmkXXRYn6i4dJD6ER20RJ90o4JlXI6H7_Yk_cNeiUcMcp8&usqp=CAU"),
        ImageLoad(imageStr: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVeyfAqF-jReebv_mp4vZsKPBcBAtNNzhRi3LSFnrcIL7XYtBypXZkzygmAxAbosZ55VE&usqp=CAU"),
        ImageLoad(imageStr: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPnwob6mUwyJFjY44lWQ3VQ_gINAO1cRAtyzQYOhRdPiiyMAdpJPI-w9TqDh2EL4LIeJ4&usqp=CAU"),
        ImageLoad(imageStr: "https://blog.kakaocdn.net/dn/cxA39V/btrJj5YXZEj/qNBdEFeFikOdAcnR6pWeW1/img.png"),
        ImageLoad(imageStr: "https://blog.kakaocdn.net/dn/Jas0y/btrLhPewpE0/dZibLv5wfDQAYBaEBqCqq0/img.jpg"),
    ]

    @IBOutlet weak var loadAllButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    
    @IBAction func loadAllImageButton(_ sender: Any) {
        
    }
    func imageDownload(url: URL, indexPath: IndexPath, completion: @escaping(_ image: UIImage) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("Download image fail : \(url)")
                    return
                }
            
            self.imageArray[indexPath.row].image = image
            guard let image = self.imageArray[indexPath.row].image else {return}
            completion(image)
            
        }.resume()
    }


}

extension ViewController : UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.selectionStyle = .none
        
        cell.mainImageView.image = UIImage(named: "noimage")
        
        cell.loadImageAction = { [unowned self] in
            
            let timeOutDuration = 2.0
            var timer: Timer?
            self.imageDownload(url: imageArray[indexPath.row].imageStr!, indexPath: indexPath) { image in
                
                DispatchQueue.main.async {
                    cell.mainImageView.image = image
                    timer = Timer.scheduledTimer(withTimeInterval: timeOutDuration, repeats: false) { timer in
                        cell.mainImageView.image = UIImage(named: "noimage")
                    }
                }
            }

        }
        
        return cell
    }
}







