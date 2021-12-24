//
//  DetailResultViewController.swift
//  Voensport-NFP
//
//  Created by Кирилл on 23.12.2021.
//

import UIKit

class DetailResultViewController: UIViewController  {
    
    var sportResult: SportResult?
    var nfpResult: NfpResult?
    var numberOfSectionForLayout = 3
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: ResultsCompositionalLayout.createLayout(numberOfSection: numberOfSectionForLayout))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ResultNfpExerciseCell.self, forCellWithReuseIdentifier: ResultNfpExerciseCell.identifier)
        collectionView.register(ResultTotalScoreCell.self, forCellWithReuseIdentifier: ResultTotalScoreCell.identifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = nfpResult == nil
        ? sportResult?.getDate() ?? ""
        : nfpResult?.getDate() ?? ""
    }
    
}
   
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension DetailResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       numberOfSectionForLayout + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == numberOfSectionForLayout {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultTotalScoreCell.identifier, for: indexPath) as! ResultTotalScoreCell
            
            if let nfpResult = nfpResult {
                cell.configureCell(nfpResult: nfpResult)
            } else if let sportResult = sportResult {
                cell.configureCell(sportResult: sportResult)
            }

            cell.editButtonCallBack = { [unowned self] in
                self.editResults()
            }
            
            cell.saveButtonCallBack = { [unowned self] in
                dismiss(animated: true)
            }
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultNfpExerciseCell.identifier, for: indexPath) as! ResultNfpExerciseCell
           
            if let nfpResult = nfpResult {
                cell.configureCell(nfpExercise: nfpResult.nfpExercises[indexPath.section])
            } else if let sportResult = sportResult {
                cell.configureCell(sportResult: sportResult, index: indexPath.section)
            }
            
            return cell
        }
        
    }
}

//MARK: - Navigation

extension DetailResultViewController {
    
    private func editResults() {
        if let _ = nfpResult {
            showNfpViewController()
        }
        
        if let _ = sportResult {
            showTriathlonViewController()
        }
    }
    
    private func showNfpViewController() {
        guard let nfpResult = nfpResult else { return }
        let nfpVC = NfpViewController()
        
        let settings = Settings()
        settings.sex = nfpResult.sex
        settings.maleAgeCategory = nfpResult.maleAgeCategory
        settings.femaleAgeCategory = nfpResult.femaleAgeCategory
        settings.numberOfExercise = nfpResult.numberOfExercise
        settings.category = nfpResult.category
       
        nfpVC.nfpController = NfpController(settings: settings)
        nfpVC.nfpController.exercises = nfpResult.getExerciseForEditing()
        nfpVC.nfpController.isEditing = true
         
        present(nfpVC, animated: true, completion: nil)
    }
    
    private func showTriathlonViewController() {
        guard let sportResult = sportResult else { return }
        
        let triathlonVC = TriathlonViewController()
        triathlonVC.sportController = TriathlonController(sportResult: sportResult)
        
        present(triathlonVC, animated: true, completion: nil)
    }
    
    
}

