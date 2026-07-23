import UIKit

final class TinkieSongQuestForgeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var onQuestReady: (() -> Void)?
    private let questScrollStage = UIScrollView()
    private let questContentStage = UIView()
    private let questCoverButton = UIButton(type: .custom)
    private let questCoverImageView = UIImageView()
    private let questTitleField = UITextField()
    private let questThemeLyricPad = UITextView()
    private let questLyricCountLabel = UILabel()
    private let questTimeButton = UIButton(type: .system)
    private let questGroupStack = UIStackView()
    private let questSeatValueLabel = UILabel()
    private let questGemValueLabel = UILabel()
    private let questSealButton = TinkieQuestForgeActionButton()
    private var questDateChoice = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
    private var questGenreChoice = "Pop"
    private var questModeChoice = "Casual"
    private var questSeatLimit = 1
    private var questGemNeed = 50
    private var questCoverPath: String?
    private var questGenreBeatButtons: [TinkieQuestChoiceButton] = []
    private var questModeBeatButtons: [TinkieQuestChoiceButton] = []
    private var questGroupStates: [TinkieSongQuestFormGroup] = [
        TinkieSongQuestFormGroup(name: "Group A", seatLimit: 10, gemNeed: 50, genre: "Pop", mode: "Casual")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putSongQuestForgeStageTogether()
        listenForQuestKeyboardRise()
        paintQuestTimeText()
        paintQuestChoiceButtons()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func putSongQuestForgeStageTogether() {
        view.backgroundColor = .white

        let backdrop = TinkieQuestForgeBackdropView()
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backdrop)

        questScrollStage.alwaysBounceVertical = true
        questScrollStage.showsVerticalScrollIndicator = false
        questScrollStage.keyboardDismissMode = .interactive
        questScrollStage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questScrollStage)

        questContentStage.translatesAutoresizingMaskIntoConstraints = false
        questScrollStage.addSubview(questContentStage)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(leaveSongQuestForge), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        questContentStage.addSubview(backButton)

        let headingLabel = UILabel()
        headingLabel.text = "Create Event"
        headingLabel.textColor = .black
        headingLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        questContentStage.addSubview(headingLabel)

        let coreCard = UIView()
        coreCard.backgroundColor = .white
        coreCard.layer.cornerRadius = 24
        coreCard.translatesAutoresizingMaskIntoConstraints = false
        questContentStage.addSubview(coreCard)

        fillQuestCoverVerseCard(in: coreCard)

        questGroupStack.axis = .vertical
        questGroupStack.spacing = 18
        questGroupStack.translatesAutoresizingMaskIntoConstraints = false
        questContentStage.addSubview(questGroupStack)
        rebuildQuestChordStack()

        let addGroupButton = UIButton(type: .system)
        addGroupButton.setTitle("  Add Registration Group", for: .normal)
        addGroupButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addGroupButton.tintColor = UIColor(red: 0.09, green: 0.86, blue: 0.78, alpha: 1)
        addGroupButton.setTitleColor(.black, for: .normal)
        addGroupButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        addGroupButton.layer.cornerRadius = 18
        addGroupButton.layer.borderWidth = 1.5
        addGroupButton.layer.borderColor = UIColor.black.cgColor
        addGroupButton.addTarget(self, action: #selector(addQuestChordDraftTapped), for: .touchUpInside)
        addGroupButton.translatesAutoresizingMaskIntoConstraints = false
        questContentStage.addSubview(addGroupButton)

        questSealButton.setTitle("Create Event", for: .normal)
        questSealButton.addTarget(self, action: #selector(sealSongQuestForge), for: .touchUpInside)
        questSealButton.translatesAutoresizingMaskIntoConstraints = false
        questContentStage.addSubview(questSealButton)

        NSLayoutConstraint.activate([
            backdrop.topAnchor.constraint(equalTo: view.topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            questScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            questScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            questContentStage.topAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.topAnchor),
            questContentStage.leadingAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.leadingAnchor),
            questContentStage.trailingAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.trailingAnchor),
            questContentStage.bottomAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.bottomAnchor),
            questContentStage.widthAnchor.constraint(equalTo: questScrollStage.frameLayoutGuide.widthAnchor),

            backButton.topAnchor.constraint(equalTo: questContentStage.safeAreaLayoutGuide.topAnchor, constant: 22),
            backButton.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            headingLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            headingLabel.centerXAnchor.constraint(equalTo: questContentStage.centerXAnchor),

            coreCard.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 34),
            coreCard.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 24),
            coreCard.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor, constant: -24),

            questGroupStack.topAnchor.constraint(equalTo: coreCard.bottomAnchor, constant: 24),
            questGroupStack.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 18),
            questGroupStack.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor, constant: -18),

            addGroupButton.topAnchor.constraint(equalTo: questGroupStack.bottomAnchor, constant: 28),
            addGroupButton.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 24),
            addGroupButton.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor, constant: -24),
            addGroupButton.heightAnchor.constraint(equalToConstant: 48),

            questSealButton.topAnchor.constraint(equalTo: addGroupButton.bottomAnchor, constant: 40),
            questSealButton.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 30),
            questSealButton.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor, constant: -30),
            questSealButton.heightAnchor.constraint(equalToConstant: 50),
            questSealButton.bottomAnchor.constraint(equalTo: questContentStage.bottomAnchor, constant: -42)
        ])
    }

    private func fillQuestCoverVerseCard(in card: UIView) {
        questCoverButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1)
        questCoverButton.layer.cornerRadius = 14
        questCoverButton.addTarget(self, action: #selector(openQuestCoverSourceSheet), for: .touchUpInside)
        questCoverButton.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(questCoverButton)

        questCoverImageView.contentMode = .scaleAspectFill
        questCoverImageView.layer.cornerRadius = 14
        questCoverImageView.layer.masksToBounds = true
        questCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        questCoverButton.addSubview(questCoverImageView)

        let plusLabel = UILabel()
        plusLabel.text = "+"
        plusLabel.textColor = UIColor.black.withAlphaComponent(0.12)
        plusLabel.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        questCoverButton.addSubview(plusLabel)

        let uploadLabel = UILabel()
        uploadLabel.text = "Upload Cover"
        uploadLabel.textColor = UIColor.black.withAlphaComponent(0.32)
        uploadLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        questCoverButton.addSubview(uploadLabel)

        questTitleField.placeholder = "For example: Friday Pop Hits Challenge"
        questTitleField.textColor = .black
        questTitleField.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        questTitleField.adjustsFontSizeToFitWidth = true
        questTitleField.minimumFontSize = 15
        questTitleField.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(questTitleField)

        let line = UIView()
        line.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        line.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(line)

        questThemeLyricPad.backgroundColor = .clear
        questThemeLyricPad.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        questThemeLyricPad.textColor = .black
        questThemeLyricPad.delegate = self
        questThemeLyricPad.textContainerInset = .zero
        questThemeLyricPad.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(questThemeLyricPad)

        let themePlace = UILabel()
        themePlace.text = "Describe the theme, gameplay, and who the event is for."
        themePlace.textColor = UIColor.black.withAlphaComponent(0.30)
        themePlace.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        themePlace.numberOfLines = 2
        themePlace.tag = 201
        themePlace.translatesAutoresizingMaskIntoConstraints = false
        questThemeLyricPad.addSubview(themePlace)

        questTimeButton.setImage(UIImage(systemName: "clock"), for: .normal)
        questTimeButton.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal)
        questTimeButton.tintColor = .black
        questTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        questTimeButton.layer.cornerRadius = 20
        questTimeButton.layer.borderWidth = 1
        questTimeButton.layer.borderColor = UIColor.black.withAlphaComponent(0.10).cgColor
        questTimeButton.addTarget(self, action: #selector(openQuestTimeWheel), for: .touchUpInside)
        questTimeButton.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(questTimeButton)

        questLyricCountLabel.text = "0/200"
        questLyricCountLabel.textColor = UIColor.black.withAlphaComponent(0.32)
        questLyricCountLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        questLyricCountLabel.textAlignment = .right
        questLyricCountLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(questLyricCountLabel)

        NSLayoutConstraint.activate([
            questCoverButton.topAnchor.constraint(equalTo: card.topAnchor, constant: 30),
            questCoverButton.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            questCoverButton.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.31),
            questCoverButton.heightAnchor.constraint(equalTo: questCoverButton.widthAnchor),

            questCoverImageView.topAnchor.constraint(equalTo: questCoverButton.topAnchor),
            questCoverImageView.leadingAnchor.constraint(equalTo: questCoverButton.leadingAnchor),
            questCoverImageView.trailingAnchor.constraint(equalTo: questCoverButton.trailingAnchor),
            questCoverImageView.bottomAnchor.constraint(equalTo: questCoverButton.bottomAnchor),

            plusLabel.centerXAnchor.constraint(equalTo: questCoverButton.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: questCoverButton.centerYAnchor, constant: -14),
            uploadLabel.topAnchor.constraint(equalTo: plusLabel.bottomAnchor, constant: 8),
            uploadLabel.centerXAnchor.constraint(equalTo: questCoverButton.centerXAnchor),

            questTitleField.topAnchor.constraint(equalTo: questCoverButton.bottomAnchor, constant: 34),
            questTitleField.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            questTitleField.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            questTitleField.heightAnchor.constraint(equalToConstant: 36),

            line.topAnchor.constraint(equalTo: questTitleField.bottomAnchor, constant: 12),
            line.leadingAnchor.constraint(equalTo: questTitleField.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),

            questThemeLyricPad.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 22),
            questThemeLyricPad.leadingAnchor.constraint(equalTo: questTitleField.leadingAnchor),
            questThemeLyricPad.trailingAnchor.constraint(equalTo: questTitleField.trailingAnchor),
            questThemeLyricPad.heightAnchor.constraint(equalToConstant: 126),

            themePlace.topAnchor.constraint(equalTo: questThemeLyricPad.topAnchor),
            themePlace.leadingAnchor.constraint(equalTo: questThemeLyricPad.leadingAnchor, constant: 4),
            themePlace.trailingAnchor.constraint(equalTo: questThemeLyricPad.trailingAnchor, constant: -4),

            questTimeButton.topAnchor.constraint(equalTo: questThemeLyricPad.bottomAnchor, constant: 16),
            questTimeButton.leadingAnchor.constraint(equalTo: questTitleField.leadingAnchor),
            questTimeButton.widthAnchor.constraint(lessThanOrEqualTo: card.widthAnchor, multiplier: 0.56),
            questTimeButton.heightAnchor.constraint(equalToConstant: 40),

            questLyricCountLabel.trailingAnchor.constraint(equalTo: questTitleField.trailingAnchor),
            questLyricCountLabel.centerYAnchor.constraint(equalTo: questTimeButton.centerYAnchor),
            questLyricCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: questTimeButton.trailingAnchor, constant: 12),
            questLyricCountLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -28)
        ])
    }

    private func rebuildQuestChordStack() {
        questGroupStack.arrangedSubviews.forEach { view in
            questGroupStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for index in questGroupStates.indices {
            let state = questGroupStates[index]
            let block = UIStackView()
            block.axis = .vertical
            block.spacing = 10

            let heading = UIView()
            heading.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.text = state.name
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            heading.addSubview(label)

            let remove = UIButton(type: .system)
            remove.setTitle("-", for: .normal)
            remove.setTitleColor(.white, for: .normal)
            remove.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .black)
            remove.backgroundColor = UIColor(red: 1, green: 0.24, blue: 0.08, alpha: 1)
            remove.layer.cornerRadius = 12
            remove.tag = index
            remove.addTarget(self, action: #selector(removeQuestChordDraft(_:)), for: .touchUpInside)
            remove.translatesAutoresizingMaskIntoConstraints = false
            heading.addSubview(remove)

            let panel = TinkieSongQuestChordPanel(state: state)
            panel.onStateChange = { [weak self] updated in
                self?.retuneQuestChord(updated, at: index)
            }
            panel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                heading.heightAnchor.constraint(equalToConstant: 30),
                label.leadingAnchor.constraint(equalTo: heading.leadingAnchor),
                label.centerYAnchor.constraint(equalTo: heading.centerYAnchor),
                remove.trailingAnchor.constraint(equalTo: heading.trailingAnchor),
                remove.centerYAnchor.constraint(equalTo: heading.centerYAnchor),
                remove.widthAnchor.constraint(equalToConstant: 24),
                remove.heightAnchor.constraint(equalToConstant: 24)
            ])

            block.addArrangedSubview(heading)
            block.addArrangedSubview(panel)
            questGroupStack.addArrangedSubview(block)
        }
    }

    private func retuneQuestChord(_ group: TinkieSongQuestFormGroup, at index: Int) {
        guard questGroupStates.indices.contains(index) else { return }
        questGroupStates[index] = group
    }

    private func fillQuestChordDraftCard(in card: UIView) {
        let seatRow = TinkieSongQuestChordInfoRow(symbolName: "person.2.fill", title: "Participant Limit")
        seatRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(seatRow)

        let minus = UIButton(type: .system)
        minus.setTitle("-", for: .normal)
        minus.setTitleColor(.black, for: .normal)
        minus.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        minus.addTarget(self, action: #selector(lowerQuestSeatLimit), for: .touchUpInside)
        minus.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(minus)

        questSeatValueLabel.textColor = UIColor.black.withAlphaComponent(0.42)
        questSeatValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        questSeatValueLabel.textAlignment = .center
        questSeatValueLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(questSeatValueLabel)

        let plus = UIButton(type: .system)
        plus.setTitle("+", for: .normal)
        plus.setTitleColor(.black, for: .normal)
        plus.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        plus.addTarget(self, action: #selector(raiseQuestSeatLimit), for: .touchUpInside)
        plus.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(plus)

        let firstLine = TinkieQuestDivider()
        firstLine.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(firstLine)

        let gemRow = TinkieSongQuestChordInfoRow(assetName: "tinkie_profile_balance_gem", title: "Gems Required")
        gemRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(gemRow)

        questGemValueLabel.text = "\(questGemNeed)"
        questGemValueLabel.textColor = UIColor.black.withAlphaComponent(0.42)
        questGemValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        questGemValueLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(questGemValueLabel)

        let secondLine = TinkieQuestDivider()
        secondLine.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(secondLine)

        let genreRow = TinkieSongQuestChordInfoRow(symbolName: "music.note", title: "Music Genre")
        genreRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(genreRow)

        let genreGrid = makeQuestChoiceRows(titles: ["Pop", "Rock", "Hip-Hop", "Electronic", "Oldies", "Mixed"], action: #selector(questGenreBeatTapped(_:)), store: &questGenreBeatButtons)
        genreGrid.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(genreGrid)

        let thirdLine = TinkieQuestDivider()
        thirdLine.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(thirdLine)

        let modeRow = TinkieSongQuestChordInfoRow(symbolName: "bolt.fill", title: "Difficulty")
        modeRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(modeRow)

        let modeGrid = makeQuestChoiceRows(titles: ["Casual", "Medium", "Hard", "Mixed"], action: #selector(questModeBeatTapped(_:)), store: &questModeBeatButtons)
        modeGrid.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(modeGrid)

        NSLayoutConstraint.activate([
            seatRow.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            seatRow.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            seatRow.trailingAnchor.constraint(lessThanOrEqualTo: minus.leadingAnchor, constant: -12),

            plus.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -24),
            plus.centerYAnchor.constraint(equalTo: seatRow.centerYAnchor),
            plus.widthAnchor.constraint(equalToConstant: 36),
            plus.heightAnchor.constraint(equalToConstant: 36),

            questSeatValueLabel.trailingAnchor.constraint(equalTo: plus.leadingAnchor, constant: -6),
            questSeatValueLabel.centerYAnchor.constraint(equalTo: plus.centerYAnchor),
            questSeatValueLabel.widthAnchor.constraint(equalToConstant: 30),

            minus.trailingAnchor.constraint(equalTo: questSeatValueLabel.leadingAnchor, constant: -6),
            minus.centerYAnchor.constraint(equalTo: plus.centerYAnchor),
            minus.widthAnchor.constraint(equalToConstant: 36),
            minus.heightAnchor.constraint(equalToConstant: 36),

            firstLine.topAnchor.constraint(equalTo: seatRow.bottomAnchor, constant: 24),
            firstLine.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            firstLine.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            firstLine.heightAnchor.constraint(equalToConstant: 1),

            gemRow.topAnchor.constraint(equalTo: firstLine.bottomAnchor, constant: 24),
            gemRow.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            gemRow.trailingAnchor.constraint(lessThanOrEqualTo: questGemValueLabel.leadingAnchor, constant: -12),

            questGemValueLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            questGemValueLabel.centerYAnchor.constraint(equalTo: gemRow.centerYAnchor),

            secondLine.topAnchor.constraint(equalTo: gemRow.bottomAnchor, constant: 24),
            secondLine.leadingAnchor.constraint(equalTo: firstLine.leadingAnchor),
            secondLine.trailingAnchor.constraint(equalTo: firstLine.trailingAnchor),
            secondLine.heightAnchor.constraint(equalToConstant: 1),

            genreRow.topAnchor.constraint(equalTo: secondLine.bottomAnchor, constant: 24),
            genreRow.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            genreRow.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),

            genreGrid.topAnchor.constraint(equalTo: genreRow.bottomAnchor, constant: 16),
            genreGrid.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            genreGrid.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),

            thirdLine.topAnchor.constraint(equalTo: genreGrid.bottomAnchor, constant: 24),
            thirdLine.leadingAnchor.constraint(equalTo: firstLine.leadingAnchor),
            thirdLine.trailingAnchor.constraint(equalTo: firstLine.trailingAnchor),
            thirdLine.heightAnchor.constraint(equalToConstant: 1),

            modeRow.topAnchor.constraint(equalTo: thirdLine.bottomAnchor, constant: 24),
            modeRow.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            modeRow.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),

            modeGrid.topAnchor.constraint(equalTo: modeRow.bottomAnchor, constant: 16),
            modeGrid.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            modeGrid.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            modeGrid.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -24)
        ])
        paintQuestSeatText()
    }

    private func makeQuestChoiceRows(titles: [String], action: Selector, store: inout [TinkieQuestChoiceButton]) -> UIStackView {
        let root = UIStackView()
        root.axis = .vertical
        root.spacing = 10
        var row = UIStackView()
        row.axis = .horizontal
        row.spacing = 10
        row.distribution = .fillEqually
        root.addArrangedSubview(row)

        for title in titles {
            if row.arrangedSubviews.count == 4 {
                row = UIStackView()
                row.axis = .horizontal
                row.spacing = 10
                row.distribution = .fillEqually
                root.addArrangedSubview(row)
            }
            let button = TinkieQuestChoiceButton(title: title)
            button.addTarget(self, action: action, for: .touchUpInside)
            row.addArrangedSubview(button)
            store.append(button)
        }
        while row.arrangedSubviews.count < 4 {
            let spacer = UIView()
            row.addArrangedSubview(spacer)
        }
        return root
    }

    @objc private func openQuestCoverSourceSheet() {
        let sheet = UIAlertController(title: "Event Cover", message: "Add a cover for your Tinkie song challenge.", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            sheet.addAction(UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.presentQuestCoverPicker(source: .camera)
            })
        }
        sheet.addAction(UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            self?.presentQuestCoverPicker(source: .photoLibrary)
        })
        sheet.addAction(UIAlertAction(title: "Use Default Cover", style: .default) { [weak self] _ in
            self?.questCoverPath = nil
            self?.questCoverImageView.image = UIImage(named: "tinkie_event_cover_friday_pop_hits")
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.popoverPresentationController?.sourceView = questCoverButton
        sheet.popoverPresentationController?.sourceRect = questCoverButton.bounds
        present(sheet, animated: true)
    }

    private func presentQuestCoverPicker(source: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let image else { return }
            self.questCoverImageView.image = image
            self.questCoverPath = self.stashQuestCoverArt(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func stashQuestCoverArt(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.82) else { return nil }
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tinkie_songquest_art", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let file = folder.appendingPathComponent("tinkie_songquest_cover_\(UUID().uuidString).jpg")
            try data.write(to: file, options: .atomic)
            return file.path
        } catch {
            return nil
        }
    }

    @objc private func openQuestTimeWheel() {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.minimumDate = Date()
        picker.date = questDateChoice
        picker.preferredDatePickerStyle = .wheels

        let holder = UIViewController()
        holder.view = picker
        holder.preferredContentSize = CGSize(width: 320, height: 220)

        let alert = UIAlertController(title: "Event Time", message: nil, preferredStyle: .alert)
        alert.setValue(holder, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            self?.questDateChoice = picker.date
            self?.paintQuestTimeText()
        })
        present(alert, animated: true)
    }

    @objc private func lowerQuestSeatLimit() {
        questSeatLimit = max(1, questSeatLimit - 1)
        paintQuestSeatText()
    }

    @objc private func raiseQuestSeatLimit() {
        questSeatLimit = min(24, questSeatLimit + 1)
        paintQuestSeatText()
    }

    @objc private func questGenreBeatTapped(_ sender: TinkieQuestChoiceButton) {
        questGenreChoice = sender.titleText
        paintQuestChoiceButtons()
    }

    @objc private func questModeBeatTapped(_ sender: TinkieQuestChoiceButton) {
        questModeChoice = sender.titleText
        paintQuestChoiceButtons()
    }

    @objc private func addQuestChordDraftTapped() {
        guard questGroupStates.count < 2 else {
            showPulseForgeHint("Group A and Group B are ready.")
            return
        }
        questGroupStates.append(TinkieSongQuestFormGroup(name: "Group B", seatLimit: 12, gemNeed: 50, genre: "Pop", mode: "Casual"))
        rebuildQuestChordStack()
    }

    @objc private func removeQuestChordDraft(_ sender: UIButton) {
        guard questGroupStates.count > 1, questGroupStates.indices.contains(sender.tag) else { return }
        questGroupStates.remove(at: sender.tag)
        for index in questGroupStates.indices {
            questGroupStates[index].name = index == 0 ? "Group A" : "Group B"
        }
        rebuildQuestChordStack()
    }

    @objc private func sealSongQuestForge() {
        let titleText = questTitleField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let themeText = questThemeLyricPad.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !titleText.isEmpty else {
            showPulseForgeHint("Please enter an event title.")
            return
        }
        guard themeText.count >= 12 else {
            showPulseForgeHint("Please add a clearer song challenge description.")
            return
        }
        let firstGroup = questGroupStates.first ?? TinkieSongQuestFormGroup(name: "Group A", seatLimit: 10, gemNeed: 50, genre: "Pop", mode: "Casual")
        let savedGroups = questGroupStates.map {
            TinkieSongQuestChordDraft(name: $0.name, genre: $0.genre, mode: $0.mode, seatLimit: $0.seatLimit, gemNeed: $0.gemNeed)
        }
        let draft = TinkieSongQuestForgeDraft(
            title: titleText,
            theme: themeText,
            dayText: makeQuestDayCue(from: questDateChoice),
            hourText: makeQuestHourCue(from: questDateChoice),
            genre: firstGroup.genre,
            mode: firstGroup.mode,
            seatLimit: firstGroup.seatLimit,
            gemNeed: firstGroup.gemNeed,
            groups: savedGroups,
            artPath: questCoverPath
        )
        TinkieQuestForgeScorebook.save(draft)
        showQuestSealedNotice()
    }

    private func showQuestSealedNotice() {
        tinkieShowTuneNotice(
            title: "Event Created",
            detail: "Your Tinkie song guessing event is now saved locally and ready on Discover.",
            onPrimary: { [weak self] in
            self?.onQuestReady?()
            self?.dismiss(animated: true)
        })
    }

    private func showPulseForgeHint(_ text: String) {
        tinkieShowTuneNotice(title: "Tinkie", detail: text)
    }

    private func paintQuestSeatText() {
        questSeatValueLabel.text = "\(questSeatLimit)"
    }

    private func paintQuestTimeText() {
        questTimeButton.setTitle("  \(makeQuestDayCue(from: questDateChoice)) · \(makeQuestHourCue(from: questDateChoice))  ", for: .normal)
    }

    private func paintQuestChoiceButtons() {
        questGenreBeatButtons.forEach { $0.isPicked = $0.titleText == questGenreChoice }
        questModeBeatButtons.forEach { $0.isPicked = $0.titleText == questModeChoice }
    }

    private func makeQuestDayCue(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }

    private func makeQuestHourCue(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 200 {
            textView.text = String(textView.text.prefix(200))
        }
        questLyricCountLabel.text = "\(textView.text.count)/200"
        textView.viewWithTag(201)?.isHidden = !textView.text.isEmpty
    }

    private func listenForQuestKeyboardRise() {
        NotificationCenter.default.addObserver(self, selector: #selector(questKeyboardRose), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(questKeyboardSettled), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hushQuestTyping))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func questKeyboardRose(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY)
        questScrollStage.contentInset.bottom = overlap + 24
        questScrollStage.scrollIndicatorInsets.bottom = overlap + 24
    }

    @objc private func questKeyboardSettled() {
        questScrollStage.contentInset.bottom = 0
        questScrollStage.scrollIndicatorInsets.bottom = 0
    }

    @objc private func hushQuestTyping() {
        view.endEditing(true)
    }

    @objc private func leaveSongQuestForge() {
        dismiss(animated: true)
    }
}

private struct TinkieSongQuestFormGroup {
    var name: String
    var seatLimit: Int
    var gemNeed: Int
    var genre: String
    var mode: String
}

private final class TinkieSongQuestChordPanel: UIView {
    var onStateChange: ((TinkieSongQuestFormGroup) -> Void)?
    private var state: TinkieSongQuestFormGroup
    private let questSeatValueLabel = UILabel()
    private let questGemValueLabel = UILabel()
    private var questGenreBeatButtons: [TinkieQuestChoiceButton] = []
    private var questModeBeatButtons: [TinkieQuestChoiceButton] = []

    init(state: TinkieSongQuestFormGroup) {
        self.state = state
        super.init(frame: .zero)
        putQuestChordDraftPanelTogether()
        paintQuestChordDraftPanel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func putQuestChordDraftPanelTogether() {
        backgroundColor = .white
        layer.cornerRadius = 18

        let seatRow = TinkieSongQuestChordInfoRow(symbolName: "person.2.fill", title: "Participant Limit")
        seatRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seatRow)

        let seatMinus = makeChordStepper(title: "-")
        seatMinus.addTarget(self, action: #selector(lowerChordSeatLimit), for: .touchUpInside)
        addSubview(seatMinus)

        questSeatValueLabel.textColor = UIColor.black.withAlphaComponent(0.72)
        questSeatValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        questSeatValueLabel.textAlignment = .center
        questSeatValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questSeatValueLabel)

        let seatPlus = makeChordStepper(title: "+")
        seatPlus.addTarget(self, action: #selector(raiseChordSeatLimit), for: .touchUpInside)
        addSubview(seatPlus)

        let firstLine = TinkieQuestDivider()
        firstLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstLine)

        let gemRow = TinkieSongQuestChordInfoRow(assetName: "tinkie_profile_balance_gem", title: "Coins Required")
        gemRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gemRow)

        let gemMinus = makeChordStepper(title: "-")
        gemMinus.addTarget(self, action: #selector(lowerChordGemNeed), for: .touchUpInside)
        addSubview(gemMinus)

        questGemValueLabel.textColor = UIColor.black.withAlphaComponent(0.72)
        questGemValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        questGemValueLabel.textAlignment = .center
        questGemValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questGemValueLabel)

        let gemPlus = makeChordStepper(title: "+")
        gemPlus.addTarget(self, action: #selector(raiseChordGemNeed), for: .touchUpInside)
        addSubview(gemPlus)

        let secondLine = TinkieQuestDivider()
        secondLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secondLine)

        let genreRow = TinkieSongQuestChordInfoRow(symbolName: "music.note", title: "Music Genre")
        genreRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(genreRow)

        let genreGrid = makeQuestChoiceRows(titles: ["Pop", "Rock", "Hip-Hop", "Electronic", "Oldies", "Mixed"], selector: #selector(pickChordGenre(_:)), store: &questGenreBeatButtons)
        genreGrid.translatesAutoresizingMaskIntoConstraints = false
        addSubview(genreGrid)

        let thirdLine = TinkieQuestDivider()
        thirdLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thirdLine)

        let modeRow = TinkieSongQuestChordInfoRow(symbolName: "bolt.fill", title: "Difficulty")
        modeRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(modeRow)

        let modeGrid = makeQuestChoiceRows(titles: ["Casual", "Medium", "Hard", "Mixed"], selector: #selector(pickChordMode(_:)), store: &questModeBeatButtons)
        modeGrid.translatesAutoresizingMaskIntoConstraints = false
        addSubview(modeGrid)

        NSLayoutConstraint.activate([
            seatRow.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            seatRow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            seatRow.trailingAnchor.constraint(lessThanOrEqualTo: seatMinus.leadingAnchor, constant: -10),

            seatPlus.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            seatPlus.centerYAnchor.constraint(equalTo: seatRow.centerYAnchor),
            seatPlus.widthAnchor.constraint(equalToConstant: 36),
            seatPlus.heightAnchor.constraint(equalToConstant: 36),

            questSeatValueLabel.trailingAnchor.constraint(equalTo: seatPlus.leadingAnchor, constant: -6),
            questSeatValueLabel.centerYAnchor.constraint(equalTo: seatPlus.centerYAnchor),
            questSeatValueLabel.widthAnchor.constraint(equalToConstant: 34),

            seatMinus.trailingAnchor.constraint(equalTo: questSeatValueLabel.leadingAnchor, constant: -6),
            seatMinus.centerYAnchor.constraint(equalTo: seatPlus.centerYAnchor),
            seatMinus.widthAnchor.constraint(equalToConstant: 36),
            seatMinus.heightAnchor.constraint(equalToConstant: 36),

            firstLine.topAnchor.constraint(equalTo: seatRow.bottomAnchor, constant: 24),
            firstLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            firstLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            firstLine.heightAnchor.constraint(equalToConstant: 1),

            gemRow.topAnchor.constraint(equalTo: firstLine.bottomAnchor, constant: 24),
            gemRow.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            gemRow.trailingAnchor.constraint(lessThanOrEqualTo: gemMinus.leadingAnchor, constant: -10),

            gemPlus.trailingAnchor.constraint(equalTo: seatPlus.trailingAnchor),
            gemPlus.centerYAnchor.constraint(equalTo: gemRow.centerYAnchor),
            gemPlus.widthAnchor.constraint(equalToConstant: 36),
            gemPlus.heightAnchor.constraint(equalToConstant: 36),

            questGemValueLabel.trailingAnchor.constraint(equalTo: gemPlus.leadingAnchor, constant: -6),
            questGemValueLabel.centerYAnchor.constraint(equalTo: gemPlus.centerYAnchor),
            questGemValueLabel.widthAnchor.constraint(equalToConstant: 46),

            gemMinus.trailingAnchor.constraint(equalTo: questGemValueLabel.leadingAnchor, constant: -6),
            gemMinus.centerYAnchor.constraint(equalTo: gemPlus.centerYAnchor),
            gemMinus.widthAnchor.constraint(equalToConstant: 36),
            gemMinus.heightAnchor.constraint(equalToConstant: 36),

            secondLine.topAnchor.constraint(equalTo: gemRow.bottomAnchor, constant: 24),
            secondLine.leadingAnchor.constraint(equalTo: firstLine.leadingAnchor),
            secondLine.trailingAnchor.constraint(equalTo: firstLine.trailingAnchor),
            secondLine.heightAnchor.constraint(equalToConstant: 1),

            genreRow.topAnchor.constraint(equalTo: secondLine.bottomAnchor, constant: 24),
            genreRow.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            genreRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),

            genreGrid.topAnchor.constraint(equalTo: genreRow.bottomAnchor, constant: 16),
            genreGrid.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            genreGrid.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),

            thirdLine.topAnchor.constraint(equalTo: genreGrid.bottomAnchor, constant: 24),
            thirdLine.leadingAnchor.constraint(equalTo: firstLine.leadingAnchor),
            thirdLine.trailingAnchor.constraint(equalTo: firstLine.trailingAnchor),
            thirdLine.heightAnchor.constraint(equalToConstant: 1),

            modeRow.topAnchor.constraint(equalTo: thirdLine.bottomAnchor, constant: 24),
            modeRow.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            modeRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),

            modeGrid.topAnchor.constraint(equalTo: modeRow.bottomAnchor, constant: 16),
            modeGrid.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            modeGrid.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            modeGrid.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }

    private func makeChordStepper(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: title == "+" ? 26 : 24, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func makeQuestChoiceRows(titles: [String], selector: Selector, store: inout [TinkieQuestChoiceButton]) -> UIStackView {
        let root = UIStackView()
        root.axis = .vertical
        root.spacing = 10
        var row = UIStackView()
        row.axis = .horizontal
        row.spacing = 10
        row.distribution = .fillEqually
        root.addArrangedSubview(row)

        for title in titles {
            if row.arrangedSubviews.count == 4 {
                row = UIStackView()
                row.axis = .horizontal
                row.spacing = 10
                row.distribution = .fillEqually
                root.addArrangedSubview(row)
            }
            let button = TinkieQuestChoiceButton(title: title)
            button.addTarget(self, action: selector, for: .touchUpInside)
            row.addArrangedSubview(button)
            store.append(button)
        }
        while row.arrangedSubviews.count < 4 {
            row.addArrangedSubview(UIView())
        }
        return root
    }

    @objc private func lowerChordSeatLimit() {
        state.seatLimit = max(1, state.seatLimit - 1)
        publishQuestChordState()
    }

    @objc private func raiseChordSeatLimit() {
        state.seatLimit = min(24, state.seatLimit + 1)
        publishQuestChordState()
    }

    @objc private func lowerChordGemNeed() {
        state.gemNeed = max(0, state.gemNeed - 10)
        publishQuestChordState()
    }

    @objc private func raiseChordGemNeed() {
        state.gemNeed = min(500, state.gemNeed + 10)
        publishQuestChordState()
    }

    @objc private func pickChordGenre(_ sender: TinkieQuestChoiceButton) {
        state.genre = sender.titleText
        publishQuestChordState()
    }

    @objc private func pickChordMode(_ sender: TinkieQuestChoiceButton) {
        state.mode = sender.titleText
        publishQuestChordState()
    }

    private func publishQuestChordState() {
        paintQuestChordDraftPanel()
        onStateChange?(state)
    }

    private func paintQuestChordDraftPanel() {
        questSeatValueLabel.text = "\(state.seatLimit)"
        questGemValueLabel.text = "\(state.gemNeed)"
        questGenreBeatButtons.forEach { $0.isPicked = $0.titleText == state.genre }
        questModeBeatButtons.forEach { $0.isPicked = $0.titleText == state.mode }
    }
}

final class TinkieSongQuestChordInfoRow: UIView {
    init(symbolName: String, title: String) {
        super.init(frame: .zero)
        putQuestChordInfoTogether(icon: UIImage(systemName: symbolName), title: title)
    }

    init(assetName: String, title: String) {
        super.init(frame: .zero)
        putQuestChordInfoTogether(icon: UIImage(named: assetName), title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func putQuestChordInfoTogether(icon: UIImage?, title: String) {
        let mark = UIImageView(image: icon)
        mark.tintColor = .black
        mark.contentMode = .scaleAspectFit
        mark.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mark)

        let label = UILabel()
        label.text = title
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 24),
            mark.leadingAnchor.constraint(equalTo: leadingAnchor),
            mark.centerYAnchor.constraint(equalTo: centerYAnchor),
            mark.widthAnchor.constraint(equalToConstant: 24),
            mark.heightAnchor.constraint(equalToConstant: 24),

            label.leadingAnchor.constraint(equalTo: mark.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

final class TinkieQuestChoiceButton: UIButton {
    let titleText: String
    var isPicked: Bool = false {
        didSet { refreshQuestChoiceStyle() }
    }

    init(title: String) {
        self.titleText = title
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        layer.cornerRadius = 15
        refreshQuestChoiceStyle()
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func refreshQuestChoiceStyle() {
        backgroundColor = isPicked ? UIColor(red: 0.12, green: 0.86, blue: 0.78, alpha: 1) : UIColor.black.withAlphaComponent(0.05)
        setTitleColor(isPicked ? .black : UIColor.black.withAlphaComponent(0.30), for: .normal)
    }
}

final class TinkieQuestDivider: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.07)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieQuestForgeActionButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .black)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 25
        layer.masksToBounds = true
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.88, green: 0.14, blue: 0.62, alpha: 0.56).cgColor,
            UIColor(red: 0.12, green: 0.87, blue: 0.78, alpha: 0.56).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieQuestForgeBackdropView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.93, green: 0.03, blue: 0.57, alpha: 1).cgColor,
            UIColor(red: 0.08, green: 0.70, blue: 0.70, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        gradient.locations = [0, 0.52, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
