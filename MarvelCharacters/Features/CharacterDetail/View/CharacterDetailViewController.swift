//
//  CharacterDetailViewController.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    private lazy var viewDetail: CharacterDetailView = {
        let view = CharacterDetailView(character: character)
        view.delegate = self
        return view
    }()

    private lazy var backButton: UIButton = {
        let size: CGFloat = 40
        let button = UIButton(frame: .init(x: 0, y: 0, width: size, height: size))
        button.layer.cornerRadius = size / 2
        button.layer.borderWidth = 0
        button.setImage(Icon.back.image, for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        button.backgroundColor = .systemFill
        return button
    }()

    private let character: Character
    private let presenter: CharacterDetailPresenterProtocol

    init(presenter: CharacterDetailPresenterProtocol, character: Character) {
        self.presenter = presenter
        self.character = character
        super.init(nibName: nil, bundle: nil)
        view.accessibilityIdentifier = "CharacterDetailViewController"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()

        let leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Remove background color
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }

    @objc
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension CharacterDetailViewController: CharacterDetailViewDelegate {
    func setFavorite(character: Character, isFavorite: Bool, imageData: Data?) {
        presenter.setFavorite(character: character, isFavorite: isFavorite, imageData: imageData)
    }
}

extension CharacterDetailViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(viewDetail)
    }

    func makeContraints() {
        let top = geTheSumOftNavBarAndStatusBarHeight()

        viewDetail.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: -top, left: 0, bottom: 0, right: 0))

    }

    private func geTheSumOftNavBarAndStatusBarHeight() -> CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navBarHeight: CGFloat = 44
        return statusBarHeight + navBarHeight
    }
}
