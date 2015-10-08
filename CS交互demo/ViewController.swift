//
//  ViewController.swift
//  CS交互demo
//
//  Created by 赵希帆 on 15/10/8.
//  Copyright © 2015年 赵希帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIAlertViewDelegate {

    @IBOutlet weak var stuid: UITextField!
    @IBOutlet weak var passwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func check(sender: AnyObject) {
        let manager = AFHTTPRequestOperationManager()
        //将发送的数据和接收的数据都打包成json数据包
        let zxf : AFJSONRequestSerializer = AFJSONRequestSerializer()
        let fxz : AFJSONResponseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer = zxf
        manager.responseSerializer = fxz
        // var studentid : String = stuid.text!
        // let userpwd : String = passwd.text!
        let params : Dictionary<String,String> = ["stu_id" : stuid.text! , "stu_name" : passwd.text!]
        //Get方法访问接口
        manager.GET("http://www.szucal.com/api/1204/schedule.php?", parameters: params, success: {
            (operation: AFHTTPRequestOperation!,
            responseObject: AnyObject!) in
            //将返回的14天的课程数据的Json内容转为字典
            let responseDict = responseObject as! NSDictionary!
            //判断，如果无返回数据则说明账号密码有误
            if(responseDict["schedule"] != nil)
            {
                print("yyy")
                //取得课程表数组
                let schedule = responseDict["schedule"] as! NSArray
                print("sss")
                // schedule数组取0表示今天，demo取1表示明天
                let courses = schedule[1] as! NSDictionary
                print(courses)
                print("sss")
                //取出所有课程作为数组
                let kecheng = courses["courses"] as! NSArray
                print(kecheng)
                var kecheng_name : String!
                if(kecheng.count > 0)
                {
                    //将当天第一节课的课程名取出
                    kecheng_name = kecheng[0]["course_name"] as! String
                }
                else{
                    kecheng_name = "没课"
                }
                //定制一个提醒视图
                let alert = UIAlertView()
                alert.title = "明天课程"
                alert.message = kecheng_name
                alert.addButtonWithTitle("ok")
                alert.show()
            }
            else
            {
                let alert = UIAlertView(title: "警告", message: "您的账号密码有误", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
            
            }, failure: {(operation: AFHTTPRequestOperation!,
                error: NSError!) in
                //Handle Error
                print(error)
                print(operation.responseString)
                let alert = UIAlertView(title: "警告", message: "您的账号密码有误", delegate: self, cancelButtonTitle: "OK")
                alert.show()
        })
        
    }

}

