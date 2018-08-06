//
//  MainViewController.swift
//  Recipes
//
//  Created by Samantha Gatt on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes from network: \(error)")
            } else {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    // MARK: - Functions
    
    func filterRecipes() {
        DispatchQueue.main.async {
            let filteredRecipes: [Recipe]
            guard let searchTerm = self.searchTextField.text else { return }
            if searchTerm == "" {
                filteredRecipes = self.allRecipes
            } else {
                filteredRecipes = self.allRecipes.filter { $0.instructions.contains(searchTerm) || $0.name.contains(searchTerm) }
            }
            self.filteredRecipes = filteredRecipes
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            let destVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destVC
        }
     }
    
    
    // MARK: - Actions
    
    @IBAction func search(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
}
