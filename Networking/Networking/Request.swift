//
//  Request.swift
//  Networking
//
//  Created by 진태영 on 2023/05/01.
//

import Foundation

let DidReceiveFirendsNotification: Notification.Name = Notification.Name("DidRecieveFriends")

func requestFriends() {
    guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    // dataTask는 런타임에 해당 부분을 해석할 때 바로 실행되는 구문이 아니다.
    // dataTask는 URLSession에 대한 정의를 한 것이라고 볼 수 있다.
    // URLSession에 요청을 보내고 응답이 오면 다음과 같은 내용을 수행한다~ 라고 정의한 것
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveFirendsNotification, object: nil, userInfo: ["friends":apiResponse.results])
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    // 실제 dataTask를 실행하는 구문은 바로 resume()에서 수행한다.
    dataTask.resume()

}
