//
//  TableDetailVC.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 7/29/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import UIKit

class TableDetailVC: UITableViewController {
    fileprivate let CustomIdentifiedKey = "TableDetailCell"
    fileprivate let OrderIdentifiedKey = "OrderDetailCell"
    
    var tableDetail : Table?
    var order: OrderResponse?
    var orderDetail: OrderDetail?
    var newListDrink: [OrderDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initServices()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        if section == 1 {
            return order?.listDrink.count ?? 0
        }
        if section == 2 {
            return newListDrink.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomIdentifiedKey, for: indexPath) as! TableDetailViewCell
            cell.lblTableName?.text = tableDetail?.name
            cell.lblTableStatus?.text = tableDetail?.status.description()
            
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderIdentifiedKey, for: indexPath) as! OrderDetailViewCell
            cell.lblDrinkName?.text = order?.listDrink[indexPath.row].drinkName
            cell.txtDrinkAmount?.text = String(order?.listDrink[indexPath.row].amount ?? 0)
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderIdentifiedKey, for: indexPath) as! OrderDetailViewCell
            cell.lblDrinkName?.text = newListDrink[indexPath.row].drinkName
            cell.txtDrinkAmount?.text = String(newListDrink[indexPath.row].amount)
            return cell
        }
        return UITableViewCell()
    }
    
    func initServices(){
        let orderServices = Services().changePath(path: "/ios/public/api/getListDrinkByTable/\(tableDetail?.idTable ?? 0)")
        if let orderURL = orderServices.buildURL(){
            dump(orderURL)
            getOrder(url: orderURL,
                     success: {orderResponse in
                        dump(orderResponse)
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            
                            self.order = orderResponse
                            self.tableView.reloadData()
                            }
                        }
                ,onError: {})
//            print(orderDetailURL)
        }
    }
    
    func getOrder(url: URL, success: @escaping (OrderResponse)-> Void, onError: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            let decoder = JSONDecoder()
//            print(String(data: data ?? Data(), encoding: .utf8))
            if let data = data {
                //                let strData = String(data: data, encoding: .utf8)
                //                print(strData)
                try! decoder.decode(OrderResponse.self, from: data)
                if let respone = try? decoder.decode(OrderResponse.self, from: data){
                    dump(respone)
                    success(respone)
                    return
                }
                print("Convert unsuccess")
            }
            
        }
        // network indicator ON
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task.resume()
    }
    
    @IBAction func btnAddDrink(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showDrink", sender: self)
    }
    
    @IBAction func unWind(_ sender: UIStoryboardSegue) {
//        sender.destination
        if let drink = sender.source as? DrinkVC{
            if let drSelected = drink.drinkSelected{
//            if newListDrink.contains(where: { (orderDetail) -> Bool in
//                return orderDetail.idDrink == drink.drinkSelected!.idDrink
//            }){}
                if let oldDrink = newListDrink.first(where: {$0.idDrink == drSelected.idDrink}){
                    oldDrink.amount += 1
                }else{
                    var orderDetail = OrderDetail(idOrderDetail: 0, idDrink: drSelected.idDrink, drinkName: drSelected.name, price: drSelected.price, image: drSelected.image, amount: 1, status: .finished)
                    newListDrink.append(orderDetail)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
