import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "BiteFlow") // Ensure BiteFlow.xcdatamodeld exists
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                AppLogger.error("Unresolved error \(error), \(error.userInfo)", category: .database)
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
