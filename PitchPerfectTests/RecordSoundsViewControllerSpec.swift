//
//  PitchPerfectTests.swift
//  PitchPerfectTests
//
//  Created by Fernanda Araújo on 11/06/18.
//

import Quick
import Nimble
import AVFoundation

@testable import PitchPerfect

class RecordSoundsViewControllerSpec: QuickSpec {
    override func spec() {
        describe("init") {
            let viewMock = RecordSoundsViewControllerMock()
            
            it("disable stop recording button") {
                viewMock.viewDidLoad()
                
                expect(viewMock.didEnableStopRecordingButton).to(beFalse())
            }
            
            context("recording audio") {
                beforeEach {
                    viewMock.recordAudio(true)
                }
                
                it("sets recording label to recording in progress") {
                    expect(viewMock.didSetRecordingLabel).to(equal("Recording in progress"))
                }
                
                it("enables stop recording button") {
                    expect(viewMock.didEnableStopRecordingButton).to(beTrue())
                }
                
                it("disables record button") {
                    expect(viewMock.didEnableRecordButton).to(beFalse())
                }
                
                it("calls prepare to record function") {
                    expect(viewMock.didCallAudioRecorderPrepareToRecord).to(beTrue())
                }
                
                it("calls record function") {
                    expect(viewMock.didCallAudioRecorderRecord).to(beTrue())
                }
            }
            
            context("stop recording") {
                beforeEach {
                    viewMock.stopRecording(true)
                }
                
                it("enables record button") {
                    expect(viewMock.didEnableRecordButton).to(beTrue())
                }
                
                it("disables stop record button") {
                    expect(viewMock.didEnableStopRecordingButton).to(beFalse())
                }
                
                it("sets recording label to tap to record") {
                    expect(viewMock.didSetRecordingLabel).to(equal("Tap to record..."))
                }
                
                it("") {
                   expect(viewMock.didCallAudioRecorderStop).to(beTrue())
                }
            }
        }
    }
}

class RecordSoundsViewControllerMock: RecordSoundsViewController {
    var didEnableStopRecordingButton = true
    var didSetRecordingLabel = ""
    var didEnableRecordButton = false
    var didCallAudioRecorderPrepareToRecord = false
    var didCallAudioRecorderRecord = false
    var didCallAudioRecorderStop = false
    
    override func viewDidLoad() {
        didEnableStopRecordingButton = false
    }
    
    override func recordAudio(_ sender: Any) {
        didSetRecordingLabel = "Recording in progress"
        didEnableStopRecordingButton = true
        didEnableRecordButton = false
        didCallAudioRecorderPrepareToRecord = true
        didCallAudioRecorderRecord = true
    }
    
    override func stopRecording(_ sender: Any) {
        didEnableRecordButton = true
        didEnableStopRecordingButton = false
        didSetRecordingLabel = "Tap to record..."
        didCallAudioRecorderStop = true
    }
}
