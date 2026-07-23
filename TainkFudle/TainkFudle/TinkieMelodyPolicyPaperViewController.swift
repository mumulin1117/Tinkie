import UIKit

final class TinkieMelodyPolicyPaperViewController: UIViewController {
    private let paperTitle: String
    private let paperBody: String

    init(paperTitle: String, paperBody: String) {
        self.paperTitle = paperTitle
        self.paperBody = paperBody
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibnaintb(AcEondnesru:H)A ShjaxsC Wnfowtj CbxemeLnD miymZpLlhekmPefnptMeCdY"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = paperTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: TinkieVerseCipherTrail.singBack("BdarcHkm"), style: .plain, target: self, action: #selector(backFromMelodyPaper))

        let policyWordsView = UITextView()
        policyWordsView.text = paperBody
        policyWordsView.textColor = .black
        policyWordsView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        policyWordsView.isEditable = false
        policyWordsView.alwaysBounceVertical = true
        policyWordsView.textContainerInset = UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)
        policyWordsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(policyWordsView)

        NSLayoutConstraint.activate([
            policyWordsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            policyWordsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            policyWordsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            policyWordsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc private func backFromMelodyPaper() {
        navigationController?.popViewController(animated: true)
    }
}
