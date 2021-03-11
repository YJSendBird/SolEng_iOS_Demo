//
//  SBManager+GroupCall.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2021/02/22.
//  Copyright © 2021 YongjunChoi. All rights reserved.
//

import Foundation
import SendBirdCalls

extension SBManager : RoomDelegate {
    
    func createRoom(param: RoomParams) {
        SendBirdCall.createRoom(with: param) { (room: Room?, error: SBCError?) in
            
        }
    }
    
    func getCachedRoom(roomId: String)-> Room? {
        return SendBirdCall.getCachedRoom(by: roomId)
    }
    
    func fetchRoom(roomId: String) {
        SendBirdCall.fetchRoom(by: roomId) { (room: Room?, error: SBCError?) in
            if(error == nil) {
                print("error::" + error!.description)
                return
            }
        }
    }
    
    func enter(roomId: String) {
        let room = getCachedRoom(roomId: roomId)
        let param = Room.EnterParams()
        param.isAudioEnabled = true
        param.isVideoEnabled = true
        room?.enter(with: param, completionHandler: { (error: SBCError?) in
            
        })
        room?.addDelegate(self, identifier: roomId)
    }
    
    func exit(roomId: String) {
        let room = getCachedRoom(roomId: roomId)
        room?.exit()
        room?.removeDelegate(identifier: roomId)
    }
    
    // MARK - RoomDelegate
    func didRemoteParticipantEnter(_ participant: RemoteParticipant) {
        
    }

    func didRemoteParticipantExit(_ participant: RemoteParticipant) {
        
    }
    
    func didRemoteStreamStart(_ participant: RemoteParticipant) {
        
    }
    
    @nonobjc func didRemoteVideoSettingsChange(_ call: DirectCall) {
        
    }
    
    func didRemoteRecordingStatusChange(_ call: DirectCall) {
        
    }
    
    func didReceiveError(_ error: Error, participant: Participant?) {
        
    }
}
