//
//  MovieListCell.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 30/06/22.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    var cornerRadius: CGFloat = 10
    var shadowOffSetWidth: CGFloat = 0
    var shadowOffSetHeight: CGFloat = 0.0
    var shadowColor: UIColor = UIColor.lightGray
    var shadowRadius : CGFloat = 2.0
    var shadowOpacity: CGFloat = 0.2
    
    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = Float(shadowOpacity)
    }
}


class MovieListCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    var movieViewModel: MovieViewModel! {
        didSet {
            if let posterPath = movieViewModel.posterPath {
                let imgFullPath = imageBaseUrl + posterPath
                moviePosterImage.sd_setImage(with: URL(string: imgFullPath), completed: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        moviePosterImage.layer.cornerRadius = 10
        moviePosterImage.layer.masksToBounds = true
    }
    
}
