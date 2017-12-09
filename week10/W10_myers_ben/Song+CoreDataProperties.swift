//
//  Song+CoreDataProperties.swift
//  W10_myers_ben
//
//  Created by MYERS BENJAMIN D on 10/31/17.
//  Copyright © 2017 MYERS BENJAMIN D. All rights reserved.
//
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var title: String?
    @NSManaged public var song_length: Double
    @NSManaged public var songRel: Album?

}
