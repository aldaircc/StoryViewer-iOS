//
//  StoryCell.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 11/06/21.
//

import UIKit

class StoryCell: UITableViewCell {
    
    //MARK: - UI Controls
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .darkGray
        return label
    }()
    
    //MARK: - Local variables
    var model: StoryModel?
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Methods
    fileprivate func configureTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    
    fileprivate func configureInformationLabel() {
        self.contentView.addSubview(self.informationLabel)
        NSLayoutConstraint.activate([
            self.informationLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.informationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.informationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setupUI(_ story: StoryModel) {
        configureTitleLabel()
        configureInformationLabel()
        self.titleLabel.text = story.story_title
        self.informationLabel.text = String("\(story.story_author) - \(story.createdAt.toDate().timeAgoDisplay())")
    }
}
