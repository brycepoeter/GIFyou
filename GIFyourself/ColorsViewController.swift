//
//  ViewController.swift
//  GIFyourself
//
//  Created by Bryce Poeter on 3/3/22.
//

// timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColors), userInfo: nil, repeats: true)

import UIKit

class ColorsViewController: UIViewController {
    
    var passedText: String?
    var passedFont: UIFont?
    
    var collectionView: UICollectionView!
    var colors: [[UIColor]] = []
    
    let inverters = [
        invertExperiment(red:green:blue:alpha:),
        invertOneMinusInputRGB(red:green:blue:alpha:)
    ]
    
    let numberOfCells = ColorFactory.sharedInstance.generators.count
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Setup the Collection View
        let layout: UICollectionViewLayout = makeLayout()
        self.collectionView = UICollectionView(frame: self.view.bounds,
                                               collectionViewLayout: layout)
        self.collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "colorCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Place the collectionView in the viewController's view
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
      
        // Make some colors
        colors = ColorFactory.sharedInstance.makeAllCellColors(numColorsPerCell: 6)
        
        // Autolayout programmatically
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
  }
    
    func generateColorPairs(number: Int, inverter: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor) -> [(UIColor, UIColor)] {
        var colors: [(UIColor, UIColor)] = []
        for _ in 0..<number {
            let randRed = CGFloat(Float.random(in: 0...255) / 255.0)
            let randGreen = CGFloat(Float.random(in: 0...255) / 255.0)
            let randBlue = CGFloat(Float.random(in: 0...255) / 255.0)
            let alpha = 1.0
            let color = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: alpha)
            let inverted = inverter(randRed, randGreen, randBlue, alpha)
            colors.append((color, inverted))
        }
        return colors
    }
    
    func invertOneMinusInputRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        let newRed = 1 - red
        let newGreen = 1 - green
        let newBlue = 1 - blue
        let newColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
        return newColor
    }
    
    func invertExperiment(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        let newRed = abs(0.5 - red)
        let newGreen = abs(0.5 - green)
        let newBlue = abs(0.5 - blue)
        let newColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
        return newColor
    }
}

extension ColorsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCell {
           
            cell.colors = colors[indexPath.row]
//            cell.colors = generateColorPairs(number: 5, inverter: invertOneMinusInputRGB(red:green:blue:alpha:))
//            cell.textView.backgroundColor = colors[indexPath.row].0
//            cell.textView.textColor = colors[indexPath.row].1
            cell.textView.text = passedText
            cell.textView.font = passedFont
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:))))
            return cell
        } else {
            return ColorCell()
        }
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: collectionView)
        let indexPath = collectionView?.indexPathForItem(at: location)
        let row = indexPath?.row
    }
    

  
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
                                                     heightDimension: NSCollectionLayoutDimension.fractionalHeight(1.0)))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20)
        return section
        }
        return layout
        }

}
