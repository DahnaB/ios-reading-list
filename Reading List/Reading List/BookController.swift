//
//  BookController.swift
//  Reading List
//
//  Created by Dahna on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDirectory?.appendingPathComponent("books.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            
            guard let readingListURL = readingListURL else { return }
            
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving books: \(error)")
        
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            
            let booksPlist = try Data(contentsOf: readingListURL)
            
            let decoder = PropertyListDecoder()
            
            let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
            
            self.books = decodedBooks
            
        } catch {
            print("Error decoding books: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        if let index = books.index(of: book) {
            books.remove(at: index)
        saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
       
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        books[bookIndex].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateBooksOtherProperties(for book: Book, title: String, reasonToRead: String) {
        
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        books[bookIndex].title = title
        books[bookIndex].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
    
    var readBooks: [Book] {
        books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        books.filter { $0.hasBeenRead == false}
    }
}


