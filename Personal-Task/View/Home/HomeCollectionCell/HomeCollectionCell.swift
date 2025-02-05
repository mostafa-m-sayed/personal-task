//
//  HomeCollectionCell.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit

final class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var wordText: UILabel!
    @IBOutlet private weak var pronounceText: UILabel!
    @IBOutlet private weak var meaningText: UILabel!
    @IBOutlet private weak var exampleText: UILabel!

    func configure(with vocabulary: Vocabulary) {
        wordText.text = vocabulary.word
        pronounceText.text = vocabulary.pronunciation
        meaningText.text = vocabulary.meaning
        exampleText.text = vocabulary.example
    }
    
}
