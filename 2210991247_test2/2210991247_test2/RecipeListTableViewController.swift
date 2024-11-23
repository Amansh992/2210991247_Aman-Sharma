//
//  RecipeListTableViewController.swift
//  2210991247_test2
//
//  Created by Aman SHarma on 23/11/24.
//

import UIKit

class RecipeListTableViewController: UITableViewController {
    
    var meals: Meal = Meal(
        breakfast: [
            Recipe(
                name: "Avocado Toast",
                ingredients: "Bread, Avocado, Olive Oil, Salt, Pepper",
                instructions: "Toast bread, spread mashed avocado, season with salt and pepper.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 250, Protein: 6g, Carbs: 30g",
                thumbnail: "avocado_toast_thumbnail"
            ),
            Recipe(
                name: "Berry Yogurt Parfait",
                ingredients: "Yogurt, Granola, Mixed Berries, Honey",
                instructions: "Layer yogurt, granola, and berries in a glass, drizzle with honey.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 300, Protein: 8g, Carbs: 40g",
                thumbnail: "parfait_thumbnail"
            )
        ],
        lunch: [
            Recipe(
                name: "Quinoa Salad",
                ingredients: "Quinoa, Chickpeas, Cucumber, Tomatoes, Lemon Dressing",
                instructions: "Mix cooked quinoa with vegetables and dressing.",
                category: "Vegan",
                nutritionInfo: "Calories: 350, Protein: 12g, Carbs: 45g",
                thumbnail: "quinoa_salad_thumbnail"
            ),
            Recipe(
                name: "Fish Tacos",
                ingredients: "Fish Fillets, Tortillas, Cabbage, Lime, Sauce",
                instructions: "Grill fish, assemble tacos with cabbage and lime.",
                category: "Non-Vegetarian",
                nutritionInfo: "Calories: 400, Protein: 25g, Carbs: 30g",
                thumbnail: "fish_tacos_thumbnail"
            )
        ],
        dinner: [
            Recipe(
                name: "Chicken Curry",
                ingredients: "Chicken, Curry Powder, Coconut Milk, Vegetables",
                instructions: "Cook chicken with vegetables and curry spices in coconut milk.",
                category: "Non-Vegetarian",
                nutritionInfo: "Calories: 450, Protein: 35g, Carbs: 20g",
                thumbnail: "chicken_curry_thumbnail"
            ),
            Recipe(
                name: "Mushroom Risotto",
                ingredients: "Rice, Mushrooms, Parmesan, Vegetable Stock",
                instructions: "Cook rice with mushrooms and stock, finish with Parmesan.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 350, Protein: 10g, Carbs: 50g",
                thumbnail: "risotto_thumbnail"
            )
        ],
        snacks: [
            Recipe(
                name: "Peanut Butter Energy Balls",
                ingredients: "Oats, Peanut Butter, Honey, Chia Seeds",
                instructions: "Mix ingredients, roll into balls, refrigerate.",
                category: "Vegetarian",
                nutritionInfo: "Calories: 150, Protein: 5g, Carbs: 15g",
                thumbnail: "energy_balls_thumbnail"
            ),
            Recipe(
                name: "Veggie Chips",
                ingredients: "Kale, Sweet Potatoes, Olive Oil, Salt",
                instructions: "Thinly slice vegetables, bake with olive oil and salt.",
                category: "Vegan",
                nutritionInfo: "Calories: 120, Protein: 3g, Carbs: 20g",
                thumbnail: "veggie_chips_thumbnail"
            )
        ]
    )


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return meals.breakfast.count
            case 1: return meals.lunch.count
            case 2: return meals.snacks.count
            case 3: return meals.dinner.count
            default: return 0
        }
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! RecipeListTableViewCell
        
        var recipe: Recipe
        
        switch indexPath.section {
            case 0: recipe = meals.breakfast[indexPath.row]
            case 1: recipe = meals.lunch[indexPath.row]
            case 2: recipe = meals.snacks[indexPath.row]
            case 3: recipe = meals.dinner[indexPath.row]
            default: recipe = Recipe(name: "", ingredients: "", instructions: "", category: "", nutritionInfo: "",thumbnail: "r1")
        }
        
        cell.update(using : recipe)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Breakfast"
        case 1: return "Lunch"
        case 2: return "Snacks"
        case 3: return "Dinner"
        default: return ""
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "editSegue" else { return }
        let destinationVC = segue.destination as? RecipeAddEditTableViewController
        
        let indexPath = tableView.indexPathForSelectedRow!
        var selectedRecipe: Recipe?
        switch indexPath.section {
        case 0:
            selectedRecipe = meals.breakfast[indexPath.row]
        case 1:
            selectedRecipe = meals.lunch[indexPath.row]
        case 2:
            selectedRecipe = meals.snacks[indexPath.row]
        case 3:
            selectedRecipe = meals.dinner[indexPath.row]
        default:
            break
        }
        destinationVC?.recipe = selectedRecipe
        
    }
    
    
    @IBAction func unwindSegue(segue : UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        if let sourceVC = segue.source as? RecipeAddEditTableViewController {
            if let recipe = sourceVC.recipe, let mealType = sourceVC.type {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        switch indexPath.section {
                        case 0: meals.breakfast[indexPath.row] = recipe
                        case 1: meals.lunch[indexPath.row] = recipe
                        case 2: meals.snacks[indexPath.row] = recipe
                        case 3: meals.dinner[indexPath.row] = recipe
                        default: break
                        }
                        tableView.reloadData()
                    }
                    else {
                        switch mealType {
                        case "breakfast":
                            meals.breakfast.append(recipe)
                            let newIndexPath = IndexPath(row: meals.breakfast.count - 1, section: 0)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "lunch":
                            meals.lunch.append(recipe)
                            let newIndexPath = IndexPath(row: meals.lunch.count - 1, section: 1)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "snacks":
                            meals.snacks.append(recipe)
                            let newIndexPath = IndexPath(row: meals.snacks.count - 1, section: 2)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "dinner":
                            meals.dinner.append(recipe)
                            let newIndexPath = IndexPath(row: meals.dinner.count - 1, section: 3)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        default:
                            break
                        }
                    }
                }
            }
    }

}
