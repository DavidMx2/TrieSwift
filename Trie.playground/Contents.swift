//: Playground - noun: a place where people can play

import UIKit

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isFinal: Bool = false
    
    private func createChildFor(character: Character) -> TrieNode {
        let node = TrieNode()
        children[character] = node
        return node
    }
    
    func getOrCreateChildFor(_ : Character) -> TrieNode {
        if let child = children[character] {
            return child
        } else {
            return createChildFor(character: character)
        }
    }
}

class Trie {
    var root = TrieNode()
    
    func insert(word: String) {
        insert(characters: Array(word.characters))
    }
    
    func insert(characters: [Character]) {
        var node = root
        for character in characters {
            node = node.getOrCreateChildFor(character)
        }
        node.isFinal = true
    }
    
    func query(word: String) -> Bool {
        return query(characters: Array(word.characters))
    }
    
    func query(characters: [Character]) -> Bool {
        var node: TrieNode? = root
        for character in characters {
            node = node?.children[character]
            if node == nil {
                return nil
            }
        }
        return node!.isFinal
    }
    
    func remove(word: String) {
        remove(characters: Array(word.characters))
    }
    
    func remove(characters: [Character]) {
        var node: TrieNode? = root
        for character in characters {
            node = node?.children[character]
            if node == nil {
                return
            }
        }
        node!.isFinal = false
    }
    
    func getNodeSequence(characters: [Character]) -> [(Character, TrieNode)] {
        var node: TrieNode? = root
        var nodes: [(Character, TrieNode)] = []
        
        let tup = (Character("@"), node!)
        
        nodes.append(tup)
        
        for character in characters {
            node = node?.children[character]
            if node == nil {
                return nodes
            }
            let tup = (character, node!)
            nodes.append(tup)
        }
        return nodes
    }
    
    func remove2(characters: [Character]) {
        var nodes: [(Character, TrieNode)] = getNodeSequence(characters: characters)
        guard nodes.count == characters.count + 1 else {return}
        nodes[nodes.count - 1].1.isFinal = false
        for i in (1..<nodes.count).reversed() {
            if nodes[i].1.isFinal {
                break
            }
            if nodes[i].1.children.count > = 1 {
                break
            }
            nodes[i-1].1.children.removeValue(forKey: nodes[i].0)
            // we delete the reference from the parent node
            // and because that was the only reference to that Trieode in our program
            // the TrieNode will be erased from memoery
        }
        
        
    }
}
