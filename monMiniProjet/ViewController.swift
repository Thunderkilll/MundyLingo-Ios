//
//  ViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 07/11/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import CoreData
import Alamofire
class ViewController: UIViewController ,GIDSignInUIDelegate {
    //"http://172.20.35.112/"
    static let Ip = "http://172.19.19.85/"
    var url = ViewController.Ip
    
    static var monEmail = ""
    static var nbrOfLives = 3
      static var scoreFF = 0
    
    
    //@IBOutlet weak var signInButton:  GIDSignInButton!
    @IBOutlet weak var signGmailbtn: GIDSignInButton!
    
    @IBAction func signinMail(_ sender: Any) {
        GIDSignIn.sharedInstance()?.delegate = self as? GIDSignInDelegate
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.signIn()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "nav")
        present(vc, animated: true, completion: nil)
        
        
    }
    func signIn(signIn: GIDSignIn!,didSignInForUser user : GIDGoogleUser!, withError error : NSError!)
    {
        if  error != nil{
            print(error)
        }
        else {
            print(GIDSignIn.sharedInstance().currentUser.profile.name)
            print(GIDSignIn.sharedInstance().currentUser.profile.email)
            self.performSegue(withIdentifier: "idSegueContent", sender: self)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        url += "miniProjetWebService/selectAjouUser.php"
        // Do any additional setup after loading the view, typically from a nib.
        // self.updateViewConstraints()
        
        //let signInButton =  GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // signInButton.center = view.center
        //view.addSubview(signInButton)
        //  GIDSignIn.sharedInstance().uiDelegate = self
        
        
    }
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    
    
    @IBAction func btnLoginWithFacebookTapped(_ sender: Any) {
        let fbLoginManager:FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self){(result , error)in
            if (error == nil){
                let fbLoginresult:FBSDKLoginManagerLoginResult = result!
                if fbLoginresult.grantedPermissions != nil {
                    if(fbLoginresult.grantedPermissions.contains("email")){
                        self.GetFBUserData()
                        
                        print("inside facebook button ")
                        fbLoginManager.logOut()
                        let HomePage = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                        let HomePageNav = UINavigationController(rootViewController: HomePage)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = HomePageNav
                        
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func GetFBUserData () {
        
        if ((FBSDKAccessToken.current()) != nil)
        {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name,last_name,picture.type(large),email"])?.start(completionHandler: {(connection,result,error)-> Void in
                if (error == nil){
                    print("   **start affichage des utilisateurs***      ")
                    let faceDic = result as! [String:AnyObject]
                    print("this is a string of any object :",faceDic)
                    let email = faceDic["email"] as! String
                    print(email)
                    ViewController.monEmail = email
                    
                    let id = faceDic["id"] as! String
                    print(id )
                    let name = faceDic["name"] as! String
                    print("here ",  name)
                    let score = 0;
                    print(score)
                    let pict = faceDic["picture"] as! [String:AnyObject]
                    let data = pict["data"] as! [String:AnyObject]
                    let urlImg = data["url"] as! String
                    print("url image comming ...")
                    
                    //   let x = ((faceDic["picture"] as! [String:AnyObject])["data"] as? [String:AnyObject])?["url"] as! String
                    print(((faceDic["picture"] as! [String:AnyObject])["data"] as? [String:AnyObject])?["url"] as! String)
                    
                    
                    
                    
                    
                    let paramatres = ["email" : faceDic["email"] as! String ,"image" : ((faceDic["picture"] as! [String:AnyObject])["data"] as? [String:AnyObject])?["url"] as! String ] as [String : Any ]
                    
                    
                    Alamofire.request(ViewController.Ip + "miniProjetWebService/selectAjouUser.php", method: .post , parameters: paramatres).responseString{ repsonse in
                        print(repsonse)
                    }
                    
                    
                    
                    ///Code d'insertion  de user  dans la dataCoreas! String
                    
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    let persistantContainer = appDelegate?.persistentContainer
                    
                    let managedContext = persistantContainer?.viewContext
                    
                    let UserDesc = NSEntityDescription.entity(forEntityName:"User", in: managedContext!)
                    //Fetch request
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                    request.predicate = NSPredicate(format: "id == %@",id)
                    
                    do {
                        let result = try managedContext?.fetch(request)
                        if result?.count == 0{
                            
                            let user = NSManagedObject(entity: UserDesc!, insertInto: managedContext!)
                            user.setValue(email, forKey: "email")
                            user.setValue(id, forKey: "id")
                            user.setValue(name, forKey: "name")
                            user.setValue(score, forKey: "score")
                            user.setValue(urlImg, forKey: "urlImage")
                            do {
                                try managedContext?.save()
                                print(" user ajouté")
                                
                            } catch {
                                print("erreur")
                            }
                        }else{
                            let alert = UIAlertController(title: "Alert", message:"vous etes deja inscrit", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    catch  {
                        print("erreur2")
                    }
                    
                    
                    
                    
                }
            })
            
            
            
            
            
        }
    }
    
    
    
    
}


func VerifInsertInBase(){
    
}



func loginButtonDidLout(_ loginButton: FBSDKLoginButton)
    
{
    print("user logout")
}



