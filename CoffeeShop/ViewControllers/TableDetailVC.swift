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

    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var tableDetail : Table?
    var order: OrderResponse?
    var orderPost: OrderResponse?
    var orderDetail: OrderDetail?
    var oldListDrink: [OrderDetail] = []
    var newListDrink: [OrderDetail] = []
    
//    var sumMoney: Int = 0
    
    // biến giá trị hiển thị button Order (đặt món) & Bill (thanh toán)
    var enableOrder : Bool = false
    var enableBill : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        
        showData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
    
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
            if order?.listDrink?.count ?? 0 > 0 {
                oldListDrink = order!.listDrink!
                self.enableBill = true
            }
            else{
                self.enableBill = false
            }
            
            //return order?.listDrink.count ?? 0
            return oldListDrink.count
        }
        
        if section == 2 {
            if newListDrink.count > 0 {
                self.enableOrder = true
            }
            else
            {
                self.enableOrder = false
            }
            
            return newListDrink.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomIdentifiedKey, for: indexPath) as! TableDetailViewCell
            cell.lblTableName?.text = tableDetail?.name
            cell.lblTableStatus?.text = tableDetail?.status.description()
            
            cell.btnOrder.isEnabled = enableOrder
            cell.btnBill.isEnabled = enableBill
            
            //Tính tiền
            cell.lblTotal?.text = sumMoney().toCurrencyString() ?? "" + " VNĐ "
            
            cell.btnOrder.addTarget(self, action: #selector(btnOrderTap), for: UIControlEvents.touchUpInside)
            cell.btnBill.addTarget(self, action: #selector(btnBillTap), for: UIControlEvents.touchUpInside)
            
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderIdentifiedKey, for: indexPath) as! OrderDetailViewCell
//            cell.lblDrinkName?.text = order?.listDrink[indexPath.row].drinkName
//            cell.lblDrinkPrice?.text = ((order?.listDrink[indexPath.row].price)?.toCurrencyString() ?? "") + " x "
//            cell.txtDrinkAmount?.text = String(order?.listDrink[indexPath.row].amount ?? 0)
            
            if oldListDrink.count>0{
                cell.lblDrinkName?.text = order?.listDrink![indexPath.row].drinkName
                cell.lblDrinkPrice?.text = ((order?.listDrink![indexPath.row].price)?.toCurrencyString() ?? "") + " x "
                cell.txtDrinkAmount?.text = String(order?.listDrink![indexPath.row].amount ?? 0)
            }
            
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderIdentifiedKey, for: indexPath) as! OrderDetailViewCell
            cell.lblDrinkName?.text = newListDrink[indexPath.row].drinkName
            cell.lblDrinkPrice?.text = (newListDrink[indexPath.row].price.toCurrencyString() ?? "") + " x "
            cell.txtDrinkAmount?.text = String(newListDrink[indexPath.row].amount)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return ""
        }
        
        if section == 1{
            return "Current drinks"
        }
        
        if section == 2{
            return "New drinks"
        }
        
        return ""
    }
    
    //chỉ tính trên current drinks
    func sumMoney()-> Int{
        var total = 0
        if oldListDrink.count>0{
            for item in oldListDrink {
                total += item.price * item.amount
            }
        }
        
//        for item in newListDrink{
//            total += item.price * item.amount
//        }
        return total
    }

    func showData(){
        let service = Services().changePath(path: "/ios/public/api/getListDrinkByTable/\(tableDetail?.idTable ?? 0)")
        if let orderURL = service.buildURL(){
            //dump(orderURL)
            getOrder(url: orderURL,
                     success: {orderResponse in
                        dump(orderResponse)
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            self.order = orderResponse
                            print(self.order?.idOrder)
                            self.tableView.reloadData() // refresh view
                            }
                        }
                ,onError: {})
//            print(orderDetailURL)
        }
    }
    
    func getOrder(url: URL, success: @escaping (OrderResponse)-> Void, onError: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            let decoder = JSONDecoder()
            //print(String(data: data ?? Data(), encoding: .utf8))
            if let data = data {
                //let strData = String(data: data, encoding: .utf8)
                //print(strData)
//                try! decoder.decode(OrderResponse.self, from: data)
                if let respone = try? decoder.decode(OrderResponse.self, from: data){
//                    dump(respone)
                    success(respone)
                    return
                }
//                print("Convert unsuccess!")
            }
        }
        // network indicator ON
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task.resume()
    }
    
    @IBAction func btnOrderTap(_ sender: UIButton) {
        let service = Services().changePath(path: "/ios/public/api/addDrinkToOrder")
        let toDay = Date()
        if let orderURL = service.buildURL(){
            //dump(orderURL)
            orderPost = OrderResponse(idOrder: order?.idOrder, idTable: (tableDetail?.idTable)!, orderDate: toDay.toString(formatString: "yyyy-MM-dd hh:mm:ss"), orderStatus: .finished, listDrink: newListDrink)
            //print(orderPost?.idOrder!)
            //dump(orderPost)
//            let loi = try! JSONEncoder().encode(orderPost)
            
            if let encodedData = try? JSONEncoder().encode(orderPost){
                print(String(data: encodedData, encoding: .utf8)!)
                postOrder(url: orderURL,
                          data: encodedData,
                          success: {orderResponse in
                                    //dump(orderResponse)
                                    DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                                        self.indicator.stopAnimating()
//                                self.performSegue(withIdentifier: "unWindToTable", sender: self)
//                                        if self.actIndicatorView.isAnimating{
//                                            self.actIndicatorView.stopAnimating()
//                                        }
                                        
                                        //sum oldListDrink
                                        //if let oldListDrink = self.order?.listDrink{/..
                                        //self.enableOrder = false
                                        
//                                        if self.order?.idOrder == nil{
//                                            self.order?.idOrder = orderResponse.idOrder
//                                        }
                                        
                                        self.newListDrink = []
                                        self.showData()
                                        
//                                        self.tableView.reloadData()
                                    }
                                    },
                          onError: {
                            print("OnError")
                            
                })
                //print(orderDetailURL)
            }else{
                print("btnOrderTap: Encode fail")
            }
        }
    }
    
    func postOrder(url: URL, data: Data, success: @escaping (OrderResponse)-> Void, onError: @escaping () -> Void) {
//        let dataString = String(data: data, encoding: .utf8)
//        print(dataString)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data

        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            let decoder = JSONDecoder()
            print(String(data: data ?? Data(), encoding: .utf8))
            if let data = data {
                //let strData = String(data: data, encoding: .utf8)
                //print(strData)
                //try! encoder.encode(data)
                let respone = try! decoder.decode(OrderResponse.self, from: data)
                if let respone = try? decoder.decode(OrderResponse.self, from: data){
                    success(respone)
                    return
                }
                
                print("btnOrdersTap: Post unsuccess")
            }
            
            if error != nil {
                dump(error)
            } else {
                if let usableData = data {
                    print(usableData) //JSONSerialization
                }
            }
            
            onError()
        }
        // network indicator ON
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        indicator.startAnimating()
        task.resume()
    }
    
    @IBAction func btnBillTap(_ sender: UIButton) {
        let service = Services().changePath(path: "/ios/public/api/updateOrderAndTableStatus/\(tableDetail?.idTable ?? 0)")
        if let orderURL = service.buildURL(){
            //dump(orderURL)
            if let encodedData = try? JSONEncoder().encode(order){
                //print(String(data: encodedData, encoding: .utf8)!)
                putOrder(url: orderURL,
                         data: encodedData,
                         success: {
                            //dump(orderResponse)
                            DispatchQueue.main.async {
                                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                //                                    self.actIndicatorView.startAnimating()
                                
                                //self.enableBill = false
                                //self.tableView.reloadData()
                                
                                self.performSegue(withIdentifier: "unWindTable", sender: self)
                            }
                },
                         onError: {})
                //print(orderDetailURL)
            }else{
                print("btnBillTap: Encode fail")
            }
        }
    }
    
    func putOrder(url: URL, data: Data, success: @escaping ()-> Void, onError: @escaping () -> Void) {
        //        let dataString = String(data: data, encoding: .utf8)
        //        print(dataString)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            success()
//            let decoder = JSONDecoder()
//            print(String(data: data ?? Data(), encoding: .utf8))
//            if let data = data {
//                //                let strData = String(data: data, encoding: .utf8)
//                //                print(strData)
//                //                try! encoder.encode(data)
//                let respone = try! decoder.decode(OrderResponse.self, from: data)
//                if let respone = try? decoder.decode(OrderResponse.self, from: data){
//                    success(respone)
//                    return
//                }
//                print("btnBillTap: Post unsuccess")
//            }
        }
        task.resume()
    }
    
    @IBAction func btnAddDrink(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showDrink", sender: self)
    }
    
    @IBAction func unWindToTableDetail(_ sender: UIStoryboardSegue) {
        if let drink = sender.source as? DrinkVC{
            if let drSelected = drink.drinkSelected{
                if let oldDrink = newListDrink.first(where: {$0.idDrink == drSelected.idDrink}){
                    oldDrink.amount += 1
                }else{
                    let orderDetail = OrderDetail(idOrderDetail: 0, idOrder: (order?.idOrder) ?? 0, idDrink: drSelected.idDrink, drinkName: drSelected.name, price: drSelected.price, image: drSelected.image, amount: 1, status: .finished)
                    
                    newListDrink.append(orderDetail)
                    print(orderDetail.idOrder!)
                }
                self.tableView.reloadData()
            }
        }
    }
}
