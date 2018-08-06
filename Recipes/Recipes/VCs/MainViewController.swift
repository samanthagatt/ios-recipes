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
    
    func filterRecipes(by searchTerm: String?) {
        let filteredRecipes: [Recipe]
        guard let userInput = searchTerm else { return }
        if userInput == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.instructions.contains(userInput) || $0.name.contains(userInput) }
        }
        self.filteredRecipes = filteredRecipes
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
     }
    
    
    // MARK: - Actions
    
    @IBAction func search(_ sender: Any) {
        resignFirstResponder()
        filterRecipes(by: searchTextField.text)
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes(by: searchTextField.text)
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
