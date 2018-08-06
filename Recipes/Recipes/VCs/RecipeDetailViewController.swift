//
//  DetailViewController.swift
//  Recipes
//
//  Created by Samantha Gatt on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Functions
    
    func updateViews() {
        if self.isViewLoaded == true {
            guard let thisRecipe = recipe else { return }
            recipeLabel.text = thisRecipe.name
            recipeTextField.text = thisRecipe.instructions
        }
        
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextField: UITextView!
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

}
