#!/usr/bin/swift


import Foundation

struct Category: Encodable {
    var productive = [String]()
    var nonProductive = [String]()
    var neutral = [String]()
}

class ProductivityBuilder {
    private let defaultManager = FileManager.default
    
    init() {
        guard let category = generateCategory,
            let categoryData = try? JSONEncoder().encode(category),
            let categoryString = String(bytes: categoryData, encoding: .utf8) else { print("✘ Failure"); return }
        
        try? categoryString.write(toFile: "bin/category.json", atomically: true, encoding: .utf8)
        print("✔ Success")
    }
    
    private var generateCategory: Category? {
        return defaultManager
            .enumerator(atPath: defaultManager.currentDirectoryPath)?
            .flatMap { any -> NSString? in
                any as? NSString
            }.reduce(Category(), { (accumulator, path) -> Category in
                var newCategory = accumulator
                switch path {
                case let x where x.contains("productive/"):
                    newCategory.productive.append(path.lastPathComponent)
                case let x where x.contains("neutral/"):
                    newCategory.neutral.append(path.lastPathComponent)
                case let x where x.contains("nonProductive/"):
                    newCategory.nonProductive.append(path.lastPathComponent)
                default: break
                }
                return newCategory
            })
    }
}

let _ = ProductivityBuilder()
