//
//  SBManager+Desk.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/05/22.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SendBirdDesk

extension SBManager {
      // Connect+Authenticate to SendBird Desk
    func connectDesk(userId:String, accessToken: String, completion:@escaping(Bool) -> ()) {
        SBDSKMain.authenticate(withUserId: userId, accessToken: accessToken, completionHandler:{ (error) in guard error == nil else {
                print("Encountered Error while SBDSKMain.authenticate(): " + error.debugDescription)
                completion(false)
                return
            }
            print("After SendBird Desk Authenticate")
            completion(true)
         })
    }
    
    // Create Desk Ticket
    func createTicket(title:String, userName:String, completion:@escaping(SBDGroupChannel?) -> ()) {
              SBDSKTicket.createTicket(withTitle: title, userName: userName, completionHandler: { (ticket, error) in guard error == nil else {
                      print("Encountered Error while SBDSKMain.createTicket() " + error.debugDescription)
                      return
                  }

                  let messageText = "test user message"
                  guard let params = SBDUserMessageParams(message: messageText) else { return }
                  ticket?.channel?.sendUserMessage(with: params) { (userMessage, error) in
                      guard error == nil else {   // Error.
                          return
                      }
                  }

                  completion(ticket?.channel!)
                  print("Created Ticket Title = " + (ticket?.title)!)
              })
    }
    
    // Create Desk Ticket with priority
    
    // getTicket
    func getTicket(completion:@escaping(Bool) -> ()) {
        // Get Desk Ticket List for Current User
        SBDSKTicket.getClosedList(withOffset: 0, completionHandler: { (ticketList, hasNext, error) in guard error == nil else {
                print("Encountered Error while SBDSKTicket.getClosedList() " + error.debugDescription)
                return
            }
            
            print("Closed Ticket List Length = " + String(ticketList.count))
            for ticket in ticketList {
                print("Ticket Title = " + ticket.title!)
            }
            
        })
    }
    
    // confirmEndofTicket
    
    // confirmCAST
    
    
}
