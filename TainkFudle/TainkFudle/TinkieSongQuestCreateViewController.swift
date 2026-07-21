import UIKit

final class TinkieSongQuestCreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var onQuestReady: (() -> Void)?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let artButton = UIButton(type: .custom)
    private let artImageView = UIImageView()
    private let titleField = UITextField()
    private let themeView = UITextView()
    private let countLabel = UILabel()
    private let timeButton = UIButton(type: .system)
    private let groupStack = UIStackView()
    private let seatValueLabel = UILabel()
    private let gemValueLabel = UILabel()
    private let createButton = TinkieQuestCreateActionButton()
    private var selectedDate = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
    private var selectedGenre = "Pop"
    private var selectedMode = "Casual"
    private var selectedLimit = 1
    private var selectedGemNeed = 50
    private var selectedArtPath: String?
    private var genreButtons: [TinkieQuestChoiceButton] = []
    private var modeButtons: [TinkieQuestChoiceButton] = []
    private var groupStates: [TinkieSongQuestFormGroup] = [
        TinkieSongQuestFormGroup(name: "Group A", seatLimit: 10, gemNeed: 50, genre: "Pop", mode: "Casual")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
        registerKeyboardObservers()
        refreshTimeText()
        refreshChoices()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let backdrop = TinkieQuestCreateBackdropView()
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backdrop)

        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let headingLabel = UILabel()
        headingLabel.text = "Create Event"
        headingLabel.textColor = .black
        headingLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headingLabel)

        let coreCard = UIView()
        coreCard.backgroundColor = .white
        coreCard.layer.cornerRadius = 24
        coreCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coreCard)

        buildCoreCard(in: coreCard)

        groupStack.axis = .vertical
        groupStack.spacing = 18
        groupStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(groupStack)
        rebuildGroupPanels()

        let addGroupButton = UIButton(type: .system)
        addGroupButton.setTitle("  Add Registration Group", for: .normal)
        addGroupButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addGroupButton.tintColor = UIColor(red: 0.09, green: 0.86, blue: 0.78, alpha: 1)
        addGroupButton.setTitleColor(.black, for: .normal)
        addGroupButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        addGroupButton.layer.cornerRadius = 18
        addGroupButton.layer.borderWidth = 1.5
        addGroupButton.layer.borderColor = UIColor.black.cgColor
        addGroupButton.addTarget(self, action: #selector(addGroupTapped), for: .touchUpInside)
        addGroupButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addGroupButton)

        createButton.setTitle("Create Event", for: .normal)
        createButton.addTarget(self, action: #selector(commitQuest), for: .touchUpInside)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(createButton)

        NSLayoutConstraint.activate([
            backdrop.topAnchor.constraint(equalTo: view.topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 22),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            headingLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            headingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            coreCard.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 34),
            coreCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            coreCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            groupStack.topAnchor.constraint(equalTo: coreCard.bottomAnchor, constant: 24),
            groupStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            groupStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),

            addGroupButton.topAnchor.constraint(equalTo: groupStack.bottomAnchor, constant: 28),
            addGroupButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            addGroupButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            addGroupButton.heightAnchor.constraint(equalToConstant: 48),

            createButton.topAnchor.constraint(equalTo: addGroupButton.bottomAnchor, constant: 40),
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -42)
        ])
    }

    private func buildCoreCard(in card: UIView) {
        artButton.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1)
        artButton.layer.cornerRadius = 14
        artButton.addTarget(self, action: #selector(openArtPicker), for: .touchUpInside)
        artButton.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(artButton)

        artImageView.contentMode = .scaleAspectFill
        artImageView.layer.cornerRadius = 14
        artImageView.layer.masksToBounds = true
        artImageView.translatesAutoresizingMaskIntoConstraints = false
        artButton.addSubview(artImageView)

        let plusLabel = UILabel()
        plusLabel.text = "+"
        plusLabel.textColor = UIColor.black.withAlphaComponent(0.12)
        plusLabel.font = UIFont.systemFont(ofSize: 36, weight: .regular)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        artButton.addSubview(plusLabel)

        let uploadLabel = UILabel()
        uploadLabel.text = "Upload Cover"
        uploadLabel.textColor = UIColor.black.withAlphaComponent(0.32)
        uploadLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        artButton.addSubview(uploadLabel)

        titleField.placeholder = "For example: Friday Pop Hits Challenge"
        titleField.textColor = .black
        titleField.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleField.adjustsFontSizeToFitWidth = true
        titleField.minimumFontSize = 15
        titleField.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(titleField)

        let line = UIView()
        line.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        line.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(line)

        themeView.backgroundColor = .clear
        themeView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        themeView.textColor = .black
        themeView.delegate = self
        themeView.textContainerInset = .zero
        themeView.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(themeView)

        let themePlace = UILabel()
        themePlace.text = "Describe the theme, gameplay, and who the event is for."
        themePlace.textColor = UIColor.black.withAlphaComponent(0.30)
        themePlace.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        themePlace.numberOfLines = 2
        themePlace.tag = 201
        themePlace.translatesAutoresizingMaskIntoConstraints = false
        themeView.addSubview(themePlace)

        timeButton.setImage(UIImage(systemName: "clock"), for: .normal)
        timeButton.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal)
        timeButton.tintColor = .black
        timeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        timeButton.layer.cornerRadius = 20
        timeButton.layer.borderWidth = 1
        timeButton.layer.borderColor = UIColor.black.withAlphaComponent(0.10).cgColor
        timeButton.addTarget(self, action: #selector(openDatePicker), for: .touchUpInside)
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(timeButton)

        countLabel.text = "0/200"
        countLabel.textColor = UIColor.black.withAlphaComponent(0.32)
        countLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        countLabel.textAlignment = .right
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(countLabel)

        NSLayoutConstraint.activate([
            artButton.topAnchor.constraint(equalTo: card.topAnchor, constant: 30),
            artButton.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            artButton.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.31),
            artButton.heightAnchor.constraint(equalTo: artButton.widthAnchor),

            artImageView.topAnchor.constraint(equalTo: artButton.topAnchor),
            artImageView.leadingAnchor.constraint(equalTo: artButton.leadingAnchor),
            artImageView.trailingAnchor.constraint(equalTo: artButton.trailingAnchor),
            artImageView.bottomAnchor.constraint(equalTo: artButton.bottomAnchor),

            plusLabel.centerXAnchor.constraint(equalTo: artButton.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: artButton.centerYAnchor, constant: -14),
            uploadLabel.topAnchor.constraint(equalTo: plusLabel.bottomAnchor, constant: 8),
            uploadLabel.centerXAnchor.constraint(equalTo: artButton.centerXAnchor),

            titleField.topAnchor.constraint(equalTo: artButton.bottomAnchor, constant: 34),
            titleField.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            titleField.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            titleField.heightAnchor.constraint(equalToConstant: 36),

            line.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 12),
            line.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),

            themeView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 22),
            themeView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            themeView.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),
            themeView.heightAnchor.constraint(equalToConstant: 126),

            themePlace.topAnchor.constraint(equalTo: themeView.topAnchor),
            themePlace.leadingAnchor.constraint(equalTo: themeView.leadingAnchor, constant: 4),
            themePlace.trailingAnchor.constraint(equalTo: themeView.trailingAnchor, constant: -4),

            timeButton.topAnchor.constraint(equalTo: themeView.bottomAnchor, constant: 16),
            timeButton.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            timeButton.widthAnchor.constraint(lessThanOrEqualTo: card.widthAnchor, multiplier: 0.56),
            timeButton.heightAnchor.constraint(equalToConstant: 40),

            countLabel.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),
            countLabel.centerYAnchor.constraint(equalTo: timeButton.centerYAnchor),
            countLabel.leadingAnchor.constraint(greaterThanOrEqualTo: timeButton.trailingAnchor, constant: 12),
            countLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -28)
        ])
    }

    private func rebuildGroupPanels() {
        groupStack.arrangedSubviews.forEach { view in
            groupStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for index in groupStates.indices {
            let state = groupStates[index]
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
            remove.addTarget(self, action: #selector(removeGroup(_:)), for: .touchUpInside)
            remove.translatesAutoresizingMaskIntoConstraints = false
            heading.addSubview(remove)

            let panel = TinkieQuestGroupPanel(state: state)
            panel.onStateChange = { [weak self] updated in
                self?.updateGroup(updated, at: index)
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
            groupStack.addArrangedSubview(block)
        }
    }

    private func updateGroup(_ group: TinkieSongQuestFormGroup, at index: Int) {
        guard groupStates.indices.contains(index) else { return }
        groupStates[index] = group
    }

    private func buildGroupCard(in card: UIView) {
        let seatRow = TinkieQuestInfoRow(symbolName: "person.2.fill", title: "Participant Limit")
        seatRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(seatRow)

        let minus = UIButton(type: .system)
        minus.setTitle("-", for: .normal)
        minus.setTitleColor(.black, for: .normal)
        minus.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        minus.addTarget(self, action: #selector(decreaseSeat), for: .touchUpInside)
        minus.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(minus)

        seatValueLabel.textColor = UIColor.black.withAlphaComponent(0.42)
        seatValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        seatValueLabel.textAlignment = .center
        seatValueLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(seatValueLabel)

        let plus = UIButton(type: .system)
        plus.setTitle("+", for: .normal)
        plus.setTitleColor(.black, for: .normal)
        plus.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        plus.addTarget(self, action: #selector(increaseSeat), for: .touchUpInside)
        plus.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(plus)

        let firstLine = TinkieQuestDivider()
        firstLine.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(firstLine)

        let gemRow = TinkieQuestInfoRow(assetName: "tinkie_profile_balance_gem", title: "Gems Required")
        gemRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(gemRow)

        gemValueLabel.text = "\(selectedGemNeed)"
        gemValueLabel.textColor = UIColor.black.withAlphaComponent(0.42)
        gemValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        gemValueLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(gemValueLabel)

        let secondLine = TinkieQuestDivider()
        secondLine.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(secondLine)

        let genreRow = TinkieQuestInfoRow(symbolName: "music.note", title: "Music Genre")
        genreRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(genreRow)

        let genreGrid = buildChoiceGrid(titles: ["Pop", "Rock", "Hip-Hop", "Electronic", "Oldies", "Mixed"], action: #selector(genreTapped(_:)), store: &genreButtons)
        genreGrid.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(genreGrid)

        let thirdLine = TinkieQuestDivider()
        thirdLine.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(thirdLine)

        let modeRow = TinkieQuestInfoRow(symbolName: "bolt.fill", title: "Difficulty")
        modeRow.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(modeRow)

        let modeGrid = buildChoiceGrid(titles: ["Casual", "Medium", "Hard", "Mixed"], action: #selector(modeTapped(_:)), store: &modeButtons)
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

            seatValueLabel.trailingAnchor.constraint(equalTo: plus.leadingAnchor, constant: -6),
            seatValueLabel.centerYAnchor.constraint(equalTo: plus.centerYAnchor),
            seatValueLabel.widthAnchor.constraint(equalToConstant: 30),

            minus.trailingAnchor.constraint(equalTo: seatValueLabel.leadingAnchor, constant: -6),
            minus.centerYAnchor.constraint(equalTo: plus.centerYAnchor),
            minus.widthAnchor.constraint(equalToConstant: 36),
            minus.heightAnchor.constraint(equalToConstant: 36),

            firstLine.topAnchor.constraint(equalTo: seatRow.bottomAnchor, constant: 24),
            firstLine.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            firstLine.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            firstLine.heightAnchor.constraint(equalToConstant: 1),

            gemRow.topAnchor.constraint(equalTo: firstLine.bottomAnchor, constant: 24),
            gemRow.leadingAnchor.constraint(equalTo: seatRow.leadingAnchor),
            gemRow.trailingAnchor.constraint(lessThanOrEqualTo: gemValueLabel.leadingAnchor, constant: -12),

            gemValueLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            gemValueLabel.centerYAnchor.constraint(equalTo: gemRow.centerYAnchor),

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
        refreshSeatText()
    }

    private func buildChoiceGrid(titles: [String], action: Selector, store: inout [TinkieQuestChoiceButton]) -> UIStackView {
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

    @objc private func openArtPicker() {
        let sheet = UIAlertController(title: "Event Cover", message: "Add a cover for your Tinkie song challenge.", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            sheet.addAction(UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.presentArtPicker(source: .camera)
            })
        }
        sheet.addAction(UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            self?.presentArtPicker(source: .photoLibrary)
        })
        sheet.addAction(UIAlertAction(title: "Use Default Cover", style: .default) { [weak self] _ in
            self?.selectedArtPath = nil
            self?.artImageView.image = UIImage(named: "tinkie_event_cover_friday_pop_hits")
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.popoverPresentationController?.sourceView = artButton
        sheet.popoverPresentationController?.sourceRect = artButton.bounds
        present(sheet, animated: true)
    }

    private func presentArtPicker(source: UIImagePickerController.SourceType) {
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
            self.artImageView.image = image
            self.selectedArtPath = self.saveArt(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func saveArt(_ image: UIImage) -> String? {
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

    @objc private func openDatePicker() {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.minimumDate = Date()
        picker.date = selectedDate
        picker.preferredDatePickerStyle = .wheels

        let holder = UIViewController()
        holder.view = picker
        holder.preferredContentSize = CGSize(width: 320, height: 220)

        let alert = UIAlertController(title: "Event Time", message: nil, preferredStyle: .alert)
        alert.setValue(holder, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            self?.selectedDate = picker.date
            self?.refreshTimeText()
        })
        present(alert, animated: true)
    }

    @objc private func decreaseSeat() {
        selectedLimit = max(1, selectedLimit - 1)
        refreshSeatText()
    }

    @objc private func increaseSeat() {
        selectedLimit = min(24, selectedLimit + 1)
        refreshSeatText()
    }

    @objc private func genreTapped(_ sender: TinkieQuestChoiceButton) {
        selectedGenre = sender.titleText
        refreshChoices()
    }

    @objc private func modeTapped(_ sender: TinkieQuestChoiceButton) {
        selectedMode = sender.titleText
        refreshChoices()
    }

    @objc private func addGroupTapped() {
        guard groupStates.count < 2 else {
            showAlert("Group A and Group B are ready.")
            return
        }
        groupStates.append(TinkieSongQuestFormGroup(name: "Group B", seatLimit: 12, gemNeed: 50, genre: "Pop", mode: "Casual"))
        rebuildGroupPanels()
    }

    @objc private func removeGroup(_ sender: UIButton) {
        guard groupStates.count > 1, groupStates.indices.contains(sender.tag) else { return }
        groupStates.remove(at: sender.tag)
        for index in groupStates.indices {
            groupStates[index].name = index == 0 ? "Group A" : "Group B"
        }
        rebuildGroupPanels()
    }

    @objc private func commitQuest() {
        let titleText = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let themeText = themeView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !titleText.isEmpty else {
            showAlert("Please enter an event title.")
            return
        }
        guard themeText.count >= 12 else {
            showAlert("Please add a clearer song challenge description.")
            return
        }
        let firstGroup = groupStates.first ?? TinkieSongQuestFormGroup(name: "Group A", seatLimit: 10, gemNeed: 50, genre: "Pop", mode: "Casual")
        let savedGroups = groupStates.map {
            TinkieSongQuestGroupRecord(name: $0.name, genre: $0.genre, mode: $0.mode, seatLimit: $0.seatLimit, gemNeed: $0.gemNeed)
        }
        let draft = TinkieSongQuestDraftRecord(
            title: titleText,
            theme: themeText,
            dayText: makeDayText(from: selectedDate),
            hourText: makeHourText(from: selectedDate),
            genre: firstGroup.genre,
            mode: firstGroup.mode,
            seatLimit: firstGroup.seatLimit,
            gemNeed: firstGroup.gemNeed,
            groups: savedGroups,
            artPath: selectedArtPath
        )
        TinkieSongQuestDraftStore.save(draft)
        showCreatedNotice()
    }

    private func showCreatedNotice() {
        let alert = UIAlertController(
            title: "Event Created",
            message: "Your Tinkie song guessing event is now saved locally and ready on Discover.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.onQuestReady?()
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func showAlert(_ text: String) {
        let alert = UIAlertController(title: "Tinkie", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func refreshSeatText() {
        seatValueLabel.text = "\(selectedLimit)"
    }

    private func refreshTimeText() {
        timeButton.setTitle("  \(makeDayText(from: selectedDate)) · \(makeHourText(from: selectedDate))  ", for: .normal)
    }

    private func refreshChoices() {
        genreButtons.forEach { $0.isPicked = $0.titleText == selectedGenre }
        modeButtons.forEach { $0.isPicked = $0.titleText == selectedMode }
    }

    private func makeDayText(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }

    private func makeHourText(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 200 {
            textView.text = String(textView.text.prefix(200))
        }
        countLabel.text = "\(textView.text.count)/200"
        textView.viewWithTag(201)?.isHidden = !textView.text.isEmpty
    }

    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingNow))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY)
        scrollView.contentInset.bottom = overlap + 24
        scrollView.scrollIndicatorInsets.bottom = overlap + 24
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }

    @objc private func endEditingNow() {
        view.endEditing(true)
    }

    @objc private func close() {
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

private final class TinkieQuestGroupPanel: UIView {
    var onStateChange: ((TinkieSongQuestFormGroup) -> Void)?
    private var state: TinkieSongQuestFormGroup
    private let seatValueLabel = UILabel()
    private let gemValueLabel = UILabel()
    private var genreButtons: [TinkieQuestChoiceButton] = []
    private var modeButtons: [TinkieQuestChoiceButton] = []

    init(state: TinkieSongQuestFormGroup) {
        self.state = state
        super.init(frame: .zero)
        buildLayout()
        refreshPanel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildLayout() {
        backgroundColor = .white
        layer.cornerRadius = 18

        let seatRow = TinkieQuestInfoRow(symbolName: "person.2.fill", title: "Participant Limit")
        seatRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seatRow)

        let seatMinus = makeStepper(title: "-")
        seatMinus.addTarget(self, action: #selector(lowerSeat), for: .touchUpInside)
        addSubview(seatMinus)

        seatValueLabel.textColor = UIColor.black.withAlphaComponent(0.72)
        seatValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        seatValueLabel.textAlignment = .center
        seatValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(seatValueLabel)

        let seatPlus = makeStepper(title: "+")
        seatPlus.addTarget(self, action: #selector(raiseSeat), for: .touchUpInside)
        addSubview(seatPlus)

        let firstLine = TinkieQuestDivider()
        firstLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(firstLine)

        let gemRow = TinkieQuestInfoRow(assetName: "tinkie_profile_balance_gem", title: "Coins Required")
        gemRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gemRow)

        let gemMinus = makeStepper(title: "-")
        gemMinus.addTarget(self, action: #selector(lowerGem), for: .touchUpInside)
        addSubview(gemMinus)

        gemValueLabel.textColor = UIColor.black.withAlphaComponent(0.72)
        gemValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        gemValueLabel.textAlignment = .center
        gemValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gemValueLabel)

        let gemPlus = makeStepper(title: "+")
        gemPlus.addTarget(self, action: #selector(raiseGem), for: .touchUpInside)
        addSubview(gemPlus)

        let secondLine = TinkieQuestDivider()
        secondLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secondLine)

        let genreRow = TinkieQuestInfoRow(symbolName: "music.note", title: "Music Genre")
        genreRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(genreRow)

        let genreGrid = buildChoiceGrid(titles: ["Pop", "Rock", "Hip-Hop", "Electronic", "Oldies", "Mixed"], selector: #selector(pickGenre(_:)), store: &genreButtons)
        genreGrid.translatesAutoresizingMaskIntoConstraints = false
        addSubview(genreGrid)

        let thirdLine = TinkieQuestDivider()
        thirdLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thirdLine)

        let modeRow = TinkieQuestInfoRow(symbolName: "bolt.fill", title: "Difficulty")
        modeRow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(modeRow)

        let modeGrid = buildChoiceGrid(titles: ["Casual", "Medium", "Hard", "Mixed"], selector: #selector(pickMode(_:)), store: &modeButtons)
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

            seatValueLabel.trailingAnchor.constraint(equalTo: seatPlus.leadingAnchor, constant: -6),
            seatValueLabel.centerYAnchor.constraint(equalTo: seatPlus.centerYAnchor),
            seatValueLabel.widthAnchor.constraint(equalToConstant: 34),

            seatMinus.trailingAnchor.constraint(equalTo: seatValueLabel.leadingAnchor, constant: -6),
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

            gemValueLabel.trailingAnchor.constraint(equalTo: gemPlus.leadingAnchor, constant: -6),
            gemValueLabel.centerYAnchor.constraint(equalTo: gemPlus.centerYAnchor),
            gemValueLabel.widthAnchor.constraint(equalToConstant: 46),

            gemMinus.trailingAnchor.constraint(equalTo: gemValueLabel.leadingAnchor, constant: -6),
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

    private func makeStepper(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: title == "+" ? 26 : 24, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func buildChoiceGrid(titles: [String], selector: Selector, store: inout [TinkieQuestChoiceButton]) -> UIStackView {
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

    @objc private func lowerSeat() {
        state.seatLimit = max(1, state.seatLimit - 1)
        publishState()
    }

    @objc private func raiseSeat() {
        state.seatLimit = min(24, state.seatLimit + 1)
        publishState()
    }

    @objc private func lowerGem() {
        state.gemNeed = max(0, state.gemNeed - 10)
        publishState()
    }

    @objc private func raiseGem() {
        state.gemNeed = min(500, state.gemNeed + 10)
        publishState()
    }

    @objc private func pickGenre(_ sender: TinkieQuestChoiceButton) {
        state.genre = sender.titleText
        publishState()
    }

    @objc private func pickMode(_ sender: TinkieQuestChoiceButton) {
        state.mode = sender.titleText
        publishState()
    }

    private func publishState() {
        refreshPanel()
        onStateChange?(state)
    }

    private func refreshPanel() {
        seatValueLabel.text = "\(state.seatLimit)"
        gemValueLabel.text = "\(state.gemNeed)"
        genreButtons.forEach { $0.isPicked = $0.titleText == state.genre }
        modeButtons.forEach { $0.isPicked = $0.titleText == state.mode }
    }
}

final class TinkieQuestInfoRow: UIView {
    init(symbolName: String, title: String) {
        super.init(frame: .zero)
        buildLayout(icon: UIImage(systemName: symbolName), title: title)
    }

    init(assetName: String, title: String) {
        super.init(frame: .zero)
        buildLayout(icon: UIImage(named: assetName), title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildLayout(icon: UIImage?, title: String) {
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
        didSet { refreshStyle() }
    }

    init(title: String) {
        self.titleText = title
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        layer.cornerRadius = 15
        refreshStyle()
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func refreshStyle() {
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

final class TinkieQuestCreateActionButton: UIButton {
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

final class TinkieQuestCreateBackdropView: UIView {
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
