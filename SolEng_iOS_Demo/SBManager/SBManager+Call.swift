//
//  SBManager+Call.swift
//  SolEng_iOS_Demo
//
//  Created by Yongjun Choi on 2020/04/28.
//  Copyright © 2020 YongjunChoi. All rights reserved.
//

import Foundation
import SendBirdCalls
import AVKit
import CallKit
import MediaPlayer


extension SBManager : DirectCallDelegate {
    
    func signIn(userId: String, completion: @escaping(Bool)->()) {
        // MARK: SendBirdCall.authenticate()
        let params = AuthenticateParams(userId: userId, accessToken: nil, voipPushToken: UserDefaults.standard.voipPushToken, unique: false)

        SendBirdCall.authenticate(with: params) { user, error in
            guard let user = user, error == nil else {
                DispatchQueue.main.async {
                    let errorDescription = String(error?.localizedDescription ?? "")
                    print(errorDescription)
                    completion(true)
                }
                return
            }

            UserDefaults.standard.autoLogin = true
            UserDefaults.standard.user = (user.userId, user.nickname, user.profileURL)
            completion(true)
        }
    }

    // MARK: - User Interaction with SendBirdCall
    func doVoiceCall(calleeId:String, completion: @escaping(Bool, SendBirdCalls.DirectCall?) -> ()) {
        // MARK: SendBirdCall.dial()
        let callOptions = CallOptions(isAudioEnabled: true)
        let dialParams = DialParams(calleeId: calleeId, isVideoCall: false, callOptions: callOptions, customItems: [:])

        SendBirdCall.dial(with: dialParams) { call, error in
            guard error == nil, let call = call else {
                let errorDescription = String(error?.localizedDescription ?? "")
                print(errorDescription)
                completion(false, nil)
                return
            }
            call.delegate = self
            self.directCall = call
            completion(true, call)
        }
    }

    func doVideoCall(calleeId:String, completion: @escaping(Bool, SendBirdCalls.DirectCall?) -> ()) {
        // MARK: SendBirdCall.dial()
        let callOptions = CallOptions(isAudioEnabled: true, isVideoEnabled: true, useFrontCamera: true)
        let dialParams = DialParams(calleeId: calleeId, isVideoCall: true, callOptions: callOptions, customItems: [:])

        SendBirdCall.dial(with: dialParams) { call, error in
            guard error == nil, let call = call else {
                let errorDescription = String(error?.localizedDescription ?? "")
                print(errorDescription)
                completion(false, nil)
                return
            }
            call.delegate = self
            self.directCall = call
            completion(true, call)
        }
    }
    
    
    // MARK: - CallKit Methods
    func startCXCall(to calleeId: String) {
        
        let handle = CXHandle(type: .generic, value: calleeId)
        
        let startCallAction = CXStartCallAction(call: directCall!.callUUID!, handle: handle)
        startCallAction.isVideo = directCall!.isVideoCall
        
        let transaction = CXTransaction(action: startCallAction)
        
        CXCallControllerManager.requestTransaction(transaction, action: "SendBird - Start Call")
    }
    
    func requestEndTransaction(_ call: DirectCall) {
        let endCallAction = CXEndCallAction(call: call.callUUID!)
        let transaction = CXTransaction(action: endCallAction)
        
        CXCallControllerManager.requestTransaction(transaction, action: "SendBird - End Call")
    }
    
    
    // MARK: Required Methods
    func didConnect(_ call: DirectCall) {
        print("didConnect")
        //self.activeTimer()      // call.duration
        //self.updateRemoteAudio(isEnabled: call.isRemoteAudioEnabled)
    }
    
    func didEnd(_ call: DirectCall) {
        print("didEnd")
        //self.setupEndedCallUI()
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
        //    guard let self = self else { return }
        //    self.dismiss(animated: true, completion: nil)
        //}
        
        guard let enderId = call.endedBy?.userId, let myId = SendBirdCall.currentUser?.userId, enderId != myId else { return }
        guard let call = SendBirdCall.getCall(forCallId: call.callId) else { return }
        self.requestEndTransaction(call)
    }
    
    // MARK: Optional Methods
    func didEstablish(_ call: DirectCall) {
        //self.callTimerLabel.text = "Connecting..."
        print("didEstablish")
    }
    
    func didRemoteAudioSettingsChange(_ call: DirectCall) {
       // self.updateRemoteAudio(isEnabled: call.isRemoteAudioEnabled)
        print("didRemoteAudioSettingsChange")
    }
    
    func didAudioDeviceChange(_ call: DirectCall, session: AVAudioSession, previousRoute: AVAudioSessionRouteDescription, reason: AVAudioSession.RouteChangeReason) {
        print("didAudioDeviceChange")
        
        guard !call.isEnded else { return }
        guard let output = session.currentRoute.outputs.first else { return }
        
        let outputType = output.portType
        let outputName = output.portName
        
        // Customize images
        var imageName = "btnSpeaker"
        switch outputType {
        case .bluetoothA2DP, .bluetoothHFP, .bluetoothLE: imageName = "btnBluetoothSelected"
        case .builtInSpeaker: imageName = "btnSpeakerSelected"
        default: imageName = "btnSpeaker"
        }
        
        //self.speakerButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
        print("[QuickStart] Audio Route has been changed to \(outputName)")
    }
    
}

