//
//  ListViewController.swift
//  Notas
//
//  Created by jose luis sanchez-porro godoy on 16/01/2017.
//  Copyright © 2017 jose luis sanchez-porro godoy. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var notes: [Note]!
    var selectedNote: Note!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedNote = nil
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            let context = container.viewContext
            //let request : NSFetchRequest<Note> = NSFetchRequest(entityName: "Note")
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            do {
                self.notes = try context.fetch(request)
                self.tableView.reloadData()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        selectedNote = nil
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            let context = container.viewContext
            //let request : NSFetchRequest<Note> = NSFetchRequest(entityName: "Note")
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            do {
                self.notes = try context.fetch(request)
                self.tableView.reloadData()
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toNoteDetail") {
            // pass data to next view
            
            if (self.selectedNote != nil){
                //Se manda la nota que se quiere mostrar a los detalles
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.note = self.selectedNote!
            }
        }

    
    
    }
    

}
extension ListViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
         return self.notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let note = notes[indexPath.row]
        let cellID = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NoteTableViewCell
        let df: DateFormatter = DateFormatter()
        df.dateStyle = DateFormatter.Style.long
        df.timeStyle = .medium
        let dateString: String = df.string(from: note.date as! Date)
        cell.dateCell?.text = dateString
        cell.textCell?.text = note.text
        cell.imageCell.image = UIImage(data: note.image! as Data)

        return cell
    }
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            self.selectedNote = self.notes[indexPath.row]
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                let context = container.viewContext
                context.delete(self.selectedNote)
                self.notes .remove(at: indexPath.row)
                self.selectedNote = nil
                self.tableView.reloadData()
            }

        }

    }

}

extension ListViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
       return 100;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.selectedNote = self.notes[indexPath.row]
        self.performSegue(withIdentifier: "toNoteDetail", sender: nil)
    }

}
