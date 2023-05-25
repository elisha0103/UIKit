//
//  NetworkMock.swift
//  ArticleProjectTests
//
//  Created by 진태영 on 2023/05/25.
//

import Foundation
import UIKit

struct NetworkMock {
    static let articleList: Data = """
        [
            {
                "status": "ok",
                "totalResults": 11776,
                "articles": [
                    {
                        "source": {
                            "id": "engadget",
                            "name": "Engadget"
                        },
                        "author": "Lawrence Bonk",
                        "title": "Venmo now lets you send crypto to other users for some reason",
                        "description": "Paypal-owned money transfer service Venmo dipped its toes into cryptocurrencies in 2021 after opening up an in-app trading platform.\r\n That was just for individuals to buy or sell crypto. Now, the company is going further into the once-heralded digital curren…",
                        "url": "https://www.engadget.com/venmo-now-lets-you-send-crypto-to-other-users-for-some-reason-192015694.html",
                        "urlToImage": "https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg",
                        "publishedAt": "2023-04-28T19:20:15Z",
                        "content": "Paypal-owned money transfer service Venmo dipped its toes into cryptocurrencies in 2021 after opening up an in-app trading platform.\r\n That was just for individuals to buy or sell crypto. Now, the co… [+1625 chars]"
                    },
                    {
                        "source": {
                            "id": null,
                            "name": "Gizmodo.com"
                        },
                        "author": "Kyle Barr",
                        "title": "Bitcoin Pyramid Scheme Fraudster Ordered to Pay $3.4 Billion",
                        "description": "The Commodities Futures Trading Commission patted itself on the back for winning one of the largest civil cases against a crypto crook, even if most—or any—of those affected will see any of their money returned. On Thursday, a Texas judge issued a default jud…",
                        "url": "https://gizmodo.com/bitcoin-mlm-joe-steyn-mirror-trading-international-1850385963",
                        "urlToImage": "https://i.kinja-img.com/gawker-media/image/upload/c_fill,f_auto,fl_progressive,g_center,h_675,pg_1,q_80,w_1200/16e5700ae24064ff50deef40ec83875d.jpg",
                        "publishedAt": "2023-04-28T14:35:25Z",
                        "content": "The Commodities Futures Trading Commission patted itself on the back for winning one of the largest civil cases against a crypto crook, even if mostor anyof those affected will see any of their money… [+3594 chars]"
                    },
                    {
                        "source": {
                            "id": "engadget",
                            "name": "Engadget"
                        },
                        "author": "Mariella Moon",
                        "title": "White House proposes 30 percent tax on electricity used for crypto mining",
                        "description": "The Biden administration wants to impose a 30 percent tax on the electricity used by cryptocurrency mining operations, and it has included the proposal in its budget for the fiscal year of 2024. In a blog post on the White House website, the administration ha…",
                        "url": "https://www.engadget.com/white-house-proposes-30-percent-tax-on-electricity-used-for-crypto-mining-090342986.html",
                        "urlToImage": "https://s.yimg.com/uu/api/res/1.2/_0lUWxV0epaYKnRPQ1.Jxw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-05/5d8f2740-e97d-11ed-b4b3-dfb213c6d348.cf.jpg",
                        "publishedAt": "2023-05-03T09:03:42Z",
                        "content": "The Biden administration wants to impose a 30 percent tax on the electricity used by cryptocurrency mining operations, and it has included the proposal in its budget for the fiscal year of 2024. In a… [+3408 chars]"
                    },
                    {
                        "source": {
                            "id": "wired",
                            "name": "Wired"
                        },
                        "author": "Jessica Maddox",
                        "title": "The Hidden Dangers of the Decentralized Web",
                        "description": "From social networks to crypto, independently run servers are being touted as a solution to the internet’s problems. But they’re far from a magic bullet.",
                        "url": "https://www.wired.com/story/the-hidden-dangers-of-the-decentralized-web/",
                        "urlToImage": "https://media.wired.com/photos/6466a28c9ec11a2433532a66/191:100/w_1280,c_limit/Cons_Social.jpg",
                        "publishedAt": "2023-05-19T12:00:00Z",
                        "content": "When Elon Musk took over Twitter last year, many users migrated to the free and open-source platform Mastodon. Mastodon, like other decentralized social media, isnt owned by one of the major players … [+4331 chars]"
                    },
                    {
                        "source": {
                            "id": null,
                            "name": "Gizmodo.com"
                        },
                        "author": "Nikki Main",
                        "title": "Hacker Pleads Guilty to Hijacking Barack, Elon, and Kim K's Twitter Accounts",
                        "description": "A man accused of hacking Twitter accounts in a Bitcoin scheme pleaded guilty on Tuesday for his role in cyber stalking and computer hacking that exploited numerous high-profile social media accounts. Joseph James O’Connor, 23, was extradited to the U.S. from …",
                        "url": "https://gizmodo.com/hacker-twitter-joseph-james-o-connor-bitcoin-crypto-1850423510",
                        "urlToImage": "https://i.kinja-img.com/gawker-media/image/upload/c_fill,f_auto,fl_progressive,g_center,h_675,pg_1,q_80,w_1200/a51f52cfe2f928955dd8893a8efe3bbb.jpg",
                        "publishedAt": "2023-05-10T15:51:00Z",
                        "content": "A man accused of hacking Twitter accounts in a Bitcoin scheme pleaded guilty on Tuesday for his role in cyber stalking and computer hacking that exploited numerous high-profile social media accounts.… [+3186 chars]"
                    },
                    {
                        "source": {
                            "id": "google-news",
                            "name": "Google News"
                        },
                        "author": null,
                        "title": "Hamas armed wing announces suspension of bitcoin fundraising - Reuters",
                        "description": "Hamas armed wing announces suspension of bitcoin fundraising  Reuters",
                        "url": "https://consent.google.com/ml?continue=https://news.google.com/rss/articles/CBMib2h0dHBzOi8vd3d3LnJldXRlcnMuY29tL3dvcmxkL21pZGRsZS1lYXN0L2hhbWFzLWFybWVkLXdpbmctYW5ub3VuY2VzLXN1c3BlbnNpb24tYml0Y29pbi1mdW5kcmFpc2luZy0yMDIzLTA0LTI4L9IBAA?oc%3D5&gl=FR&hl=en-US&cm=2&pc=n&src=1",
                        "urlToImage": null,
                        "publishedAt": "2023-04-28T12:36:00Z",
                        "content": "We use cookies and data to<ul><li>Deliver and maintain Google services</li><li>Track outages and protect against spam, fraud, and abuse</li><li>Measure audience engagement and site statistics to unde… [+1131 chars]"
                    },
                    {
                        "source": {
                            "id": "google-news",
                            "name": "Google News"
                        },
                        "author": null,
                        "title": "Cryptoverse: Busy bitcoin births new breed of crypto - Reuters",
                        "description": "Cryptoverse: Busy bitcoin births new breed of crypto  Reuters",
                        "url": "https://consent.google.com/ml?continue=https://news.google.com/rss/articles/CBMiX2h0dHBzOi8vd3d3LnJldXRlcnMuY29tL3RlY2hub2xvZ3kvY3J5cHRvdmVyc2UtYnVzeS1iaXRjb2luLWJpcnRocy1uZXctYnJlZWQtY3J5cHRvLTIwMjMtMDUtMjMv0gEA?oc%3D5&gl=FR&hl=en-US&cm=2&pc=n&src=1",
                        "urlToImage": null,
                        "publishedAt": "2023-05-23T05:12:00Z",
                        "content": "We use cookies and data to<ul><li>Deliver and maintain Google services</li><li>Track outages and protect against spam, fraud, and abuse</li><li>Measure audience engagement and site statistics to unde… [+1131 chars]"
                    },
                    {
                        "source": {
                            "id": "google-news",
                            "name": "Google News"
                        },
                        "author": null,
                        "title": "Bitcoin could hit $100000 by end-2024, Standard Chartered says - Reuters",
                        "description": "Bitcoin could hit $100000 by end-2024, Standard Chartered says  Reuters",
                        "url": "https://consent.google.com/ml?continue=https://news.google.com/rss/articles/CBMia2h0dHBzOi8vd3d3LnJldXRlcnMuY29tL21hcmtldHMvdXMvYml0Y29pbi1jb3VsZC1oaXQtMTAwMDAwLWJ5LWVuZC0yMDI0LXN0YW5kYXJkLWNoYXJ0ZXJlZC1zYXlzLTIwMjMtMDQtMjQv0gEA?oc%3D5&gl=FR&hl=en-US&cm=2&pc=n&src=1",
                        "urlToImage": null,
                        "publishedAt": "2023-04-24T13:25:00Z",
                        "content": "We use cookies and data to<ul><li>Deliver and maintain Google services</li><li>Track outages and protect against spam, fraud, and abuse</li><li>Measure audience engagement and site statistics to unde… [+1131 chars]"
                    },
                    {
                        "source": {
                            "id": "google-news",
                            "name": "Google News"
                        },
                        "author": null,
                        "title": "US court orders South African firm's CEO to pay $3.4 bln for bitcoin ... - Reuters",
                        "description": "US court orders South African firm's CEO to pay $3.4 bln for bitcoin ...  Reuters",
                        "url": "https://consent.google.com/ml?continue=https://news.google.com/rss/articles/CBMiamh0dHBzOi8vd3d3LnJldXRlcnMuY29tL2xlZ2FsL3VzLWNvdXJ0LW9yZGVycy1zb3V0aC1hZnJpY2FuLWZpcm1zLWNlby1wYXktMzQtYmxuLWJpdGNvaW4tZnJhdWQtMjAyMy0wNC0yNy_SAQA?oc%3D5&gl=FR&hl=en-US&cm=2&pc=n&src=1",
                        "urlToImage": null,
                        "publishedAt": "2023-04-27T21:43:00Z",
                        "content": "We use cookies and data to<ul><li>Deliver and maintain Google services</li><li>Track outages and protect against spam, fraud, and abuse</li><li>Measure audience engagement and site statistics to unde… [+1131 chars]"
                    },

                        ]
            }
        ]
""".data(using: .utf8)!
    
    static let image: Data = UIImage(systemName: "square")!.pngData()!
}
