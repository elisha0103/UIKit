//
//  ViewController.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/10.
//

import UIKit

class ViewController: UIViewController {

    var model = ArticleController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ArticleController의 getArticles 함수로 가져온 데이터를 사용하기 위해서 delegate를 사용함
        // model에서 사용하는 함수를 self를 통해 ViewController과 관장하고 있으므로 데이터도 비동기적으로 가져올 수 있음
        // model의 delegate는 ArticleProtocol을 따르는 객체이다. 따라서 self가 관장하기 위해서 self도 해당 프로토콜을 따라야한다.
        model.delegate = self
        model.getArticles()
        /*
         model의 getArticles 함수는 내부에 delegate.articleRetrieved() 구문이 있다.
         아직 articleRetrieved의 함수를 정의해주지 않았는데, model.delegate를 self가 관장하고 있고 delegate는 ArticleProtocol을 따르므로 해당 프로토콜의 함수 정의도
         self가 해줘야한다. 따라서 extension에 해당 프로토콜 함수를 정의했다.
         */
    }


}

