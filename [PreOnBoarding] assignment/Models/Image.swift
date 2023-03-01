//
//  Image.swift
//  [PreOnBoarding] assignment
//
//  Created by 강민주 on 2023/03/01.
//

import UIKit

struct ImageLoad {
    var imageStr: URL?
    var image: UIImage?
    
    init(imageStr: String) {
        self.imageStr = URL(string: imageStr)
    }
}
