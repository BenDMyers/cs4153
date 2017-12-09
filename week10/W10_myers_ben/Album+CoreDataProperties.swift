//
//  Album+CoreDataProperties.swift
//  W10_myers_ben
//
//  Created by MYERS BENJAMIN D on 10/31/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var title: String?
    @NSManaged public var artist: String?
    @NSManaged public var year_of_release: Int16
    @NSManaged public var albumRel: NSSet?

}

// MARK: Generated accessors for albumRel
extension Album {

    @objc(addAlbumRelObject:)
    @NSManaged public func addToAlbumRel(_ value: Song)

    @objc(removeAlbumRelObject:)
    @NSManaged public func removeFromAlbumRel(_ value: Song)

    @objc(addAlbumRel:)
    @NSManaged public func addToAlbumRel(_ values: NSSet)

    @objc(removeAlbumRel:)
    @NSManaged public func removeFromAlbumRel(_ values: NSSet)

}
