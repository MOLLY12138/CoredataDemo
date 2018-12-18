//
//  ViewController.swift
//  CoredataDemo
//
//  Created by Marryjia on 2018/12/18.
//  Copyright © 2018年 mlj. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    //获得应用代理
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //拿到上下文
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func add(_ sender: Any) {
        let person = Person(context: context)
        person.name = tfName.text
        person.phone = tfPhone.text
//        appDelegate.saveContext()
        
        
    }
    @IBAction func del(_ sender: Any) {
        
        let fetch:NSFetchRequest<Person> = Person.fetchRequest()
        fetch.predicate = NSPredicate(format: "name=%@", tfName.text!)
        //返回整张表
        let persons = try? context.fetch(fetch)
        if let p = persons?.first{
            context.delete(p)
            //每次操作完都保存数据库很耗时，只用在界面结束的时候保存,也就是进入后台时
//            appDelegate.saveContext()
        }
    }
    @IBAction func update(_ sender: Any) {
        
        let fetch:NSFetchRequest<Person> = Person.fetchRequest()
        fetch.predicate = NSPredicate(format: "name=%@", tfName.text!)
        //返回整张表
        let persons = try? context.fetch(fetch)
        if let p = persons?.first{
            p.phone = tfPhone.text
//            appDelegate.saveContext()
        }
        
        
    }
    //更新和删除都需要先查询
    @IBAction func query(_ sender: Any) {
        let fetch:NSFetchRequest<Person> = Person.fetchRequest()
        fetch.predicate = NSPredicate(format: "name=%@", tfName.text!)
        //返回整张表
        let persons = try? context.fetch(fetch)
        if let p = persons?.first{
            tfPhone.text = p.phone
        }
        
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

