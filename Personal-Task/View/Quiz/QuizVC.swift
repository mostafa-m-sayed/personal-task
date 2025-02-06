//
//  QuizVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 04/02/2025.
//
import UIKit

final class QuizVC: UIViewController {
    @IBOutlet weak var nextButton: SubmitButton!
    @IBOutlet private weak var collectionView: UICollectionView!

    private var quizVM: QuizVM?
    private var currentIndex = 0
    private var correctAnswers = 0
    private var dataSource: UICollectionViewDiffableDataSource<Int, Quiz>!
    private var lastQuestion: Bool {
        return currentIndex == (quizVM?.quiz?.count ?? 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizVM = QuizVM()
        setupCollectionView()
        setupDataSource()
        applyInitialSnapshot(quizItems: quizVM?.quiz ?? [])
        navigationItem.backButtonTitle = ""
        nextButton.isEnabled = false

    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "QuizCollectionCell", bundle: nil), forCellWithReuseIdentifier: "QuizCollectionCell")
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Quiz>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCollectionCell", for: indexPath) as! QuizCollectionCell
            cell.delegate = self
            cell.configure(with: item)
            return cell
        }
    }

    private func applyInitialSnapshot(quizItems: [Quiz]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Quiz>()
        snapshot.appendSections([0])

        snapshot.appendItems(quizItems)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @IBAction private func nextButtonTapped(_ sender: Any) {
        nextButton.isEnabled = false
        currentIndex += 1
        if lastQuestion {
            let popup = ScorePopupView(score: "\(correctAnswers)/\(quizVM?.quiz?.count ?? 0)")
            popup.delegate = self
            HapticManager.shared.performImpactFeedback(style: .heavy)
            popup.show(in: self.view)
            return
        }
        collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }

}
extension QuizVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
extension QuizVC: QuizCollectionCellDelegate {
    func didSelectAnswer(isCorrect: Bool) {
        nextButton.isEnabled = true
        if isCorrect {
            correctAnswers += 1
        }
    }
}
extension QuizVC: ScorePopupViewDelegate {
    func didDismiss() {
        navigationController?.popViewController(animated: true)
    }
}
