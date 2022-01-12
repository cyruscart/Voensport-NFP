//
//  AboutAppViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 26.12.2021.
//

import UIKit
import PassKit

enum AboutAppSectionKind: CaseIterable  {
    case onboarding
    case logo
    case donate
    
    static let logoImagesName = ["logo5", "logo2", "logo3", "logo4", "logo1", "logo6", "logo7", "logo8"]
}

final class AboutAppViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var smallPaymentRequest = PKPaymentRequest()
    private var mediumPaymentRequest =  PKPaymentRequest()
    private var largePaymentRequest =  PKPaymentRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        setPaymentRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: AboutAppCompositionalLayout.createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AboutImageCell.self, forCellWithReuseIdentifier: AboutImageCell.identifier)
        collectionView.register(DonateCell.self, forCellWithReuseIdentifier: DonateCell.identifier)
        collectionView.register(AboutAppHeaderView.self, forSupplementaryViewOfKind: "AboutAppHeaderView", withReuseIdentifier: AboutAppHeaderView.identifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "О приложении"
    }
    
    private func setPaymentRequests() {
        smallPaymentRequest = createPaymentRequest(amount: 99)
        mediumPaymentRequest = createPaymentRequest(amount: 199)
        largePaymentRequest = createPaymentRequest(amount: 499)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension AboutAppViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        AboutAppSectionKind.allCases[section] == .logo ? AboutAppSectionKind.logoImagesName.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch AboutAppSectionKind.allCases[indexPath.section] {
            
        case .onboarding:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutImageCell.identifier, for: indexPath) as! AboutImageCell
            cell.showLogo(images: 50)
            return cell
            
        case .logo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutImageCell.identifier, for: indexPath) as! AboutImageCell
            cell.configureCell(imageName: AboutAppSectionKind.logoImagesName[indexPath.item])
            return cell
            
        case .donate:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DonateCell.identifier, for: indexPath) as! DonateCell
            cell.configureCellAfterPay()
            cell.smallDonateButton.addTarget(self, action: #selector(smallDonatePressed), for: .touchUpInside)
            cell.mediumDonateButton.addTarget(self, action: #selector(mediumDonatePressed), for: .touchUpInside)
            cell.largeDonateButton.addTarget(self, action: #selector(largeDonatePressed), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: "AboutAppHeaderView", withReuseIdentifier: AboutAppHeaderView.identifier, for: indexPath) as! AboutAppHeaderView
        view.headingLabel.text = ["Возможности", "Логотип"][indexPath.section]
        view.messageLabel.text = ["", "Вы могли заметить, какой необычный логотип у этого приложения. Он был сгенерирован нейросетью ruDALL-E по текстовому запросу. Посмотрите, какие еще крутые варианты она нарисовала"][indexPath.section]
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let onboardingVC = OnboardingViewController()
            onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC, animated: true, completion: nil)
        }
    }
    
}

//MARK: - Apple pay

extension AboutAppViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    private func createPaymentRequest(amount: Int) -> PKPaymentRequest {
        let request = PKPaymentRequest()
        
        request.merchantIdentifier = ""
        request.supportedNetworks = [.visa, .masterCard, .mir]
        request.supportedCountries = ["RU"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "RU"
        request.currencyCode = "RUB"
        
        let paymentSummaryItems = PKPaymentSummaryItem(label: "Благодарность разработчику", amount: NSDecimalNumber(value: amount))
        request.paymentSummaryItems = [paymentSummaryItems]
        
        return request
    }
}

//MARK: - Navigation

extension AboutAppViewController {
    
    @objc private func smallDonatePressed() {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: smallPaymentRequest) {
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
    @objc private func mediumDonatePressed() {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: mediumPaymentRequest) {
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
    @objc private func largeDonatePressed() {
        if let controller = PKPaymentAuthorizationViewController(paymentRequest: largePaymentRequest) {
            controller.delegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
}
