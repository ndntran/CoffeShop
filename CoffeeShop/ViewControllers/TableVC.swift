//
//  TableController.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    fileprivate let CustomIdentifiedKey = "TableCell"
    var tableList = [Table]()
    var tableSelected: Table?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initServices()
    }
    
    func initServices(){
        let tableServices = Services()
        if let tableURL = tableServices.buildURL(){
            getTable(url: tableURL,
                     success: {table in
                        dump(table)
                        DispatchQueue.main.async {
//                           print(table[0].name)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            
                            self.tableList = table
                            self.tableView.reloadData()
                        }
            }
                ,onError: {})
            print(tableURL)
        }
    }
    
    func getTable(url: URL, success: @escaping ([Table])-> Void, onError: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            let decoder = JSONDecoder()
            
            if let data = data {
                let strData = String(data: data, encoding: .utf8)
//                print(strData)
                if let respone = try? decoder.decode([Table].self, from: data){
                    success(respone)
                    return
                }
            }
            
        }
        // network indicator ON
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task.resume()
    }
    
//    func initData(){
//        let ban1 = Table(1,"Ban 1",TableStatus.free)
//        let ban2 = Table(2,"Ban 2",TableStatus.free)
//
//        tableList.append(ban1)
//        tableList.append(ban2)
//        print(tableList)
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Table menu"
        }
        
        return ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomIdentifiedKey, for: indexPath) as! TableViewCell
        
        if indexPath.section == 0 {
            cell.lblTableName?.text = tableList[indexPath.row].name
            
            if tableList[indexPath.row].status == TableStatus.free {// bàn có người hiển thị màu
                //cell.backgroundColor = UIColor.cyan
                cell.lblTableName.textColor = UIColor.black
            }else{//bàn còn lại hiển thị màu mặc định
//                cell.backgroundColor = UIColor.white
                cell.lblTableName.textColor = UIColor.blue
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableSelected = tableList[indexPath.row]
        performSegue(withIdentifier: "showTableDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableDetailVC{
            vc.tableDetail = tableSelected
            vc.navigationItem.title = tableSelected?.name
        }
    }
    
    @IBAction func unWindToTable(_ sender: UIStoryboardSegue) {

    }
}




