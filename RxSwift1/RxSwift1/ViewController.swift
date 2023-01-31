//
//  ViewController.swift
//  RxSwift1
//
//  Created by Giap on 20/01/2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController,
        let photoVC = navVC.viewControllers.first as? PhotoCollectionViewController else {
            fatalError("Segue destination not found")
        }
        
        photoVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        guard let sourceImage = self.photoImageView.image else { return }
        
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                DispatchQueue.main.async {
                    self.photoImageView.image = filteredImage
                }
            }).disposed(by: disposeBag)
        
//        FilterService().applyFilter(to: sourceImage) { filteredImage in
//            DispatchQueue.main.async {
//                self.photoImageView.image = filteredImage
//            }
//        }
        
        
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.filterButton.isHidden = false
    }


}

