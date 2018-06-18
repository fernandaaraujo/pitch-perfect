//
//  PlaySoundsViewControllerSpec.swift
//  PitchPerfectTests
//
//  Created by Fernanda Araújo on 14/06/18.
//

import Quick
import Nimble

@testable import PitchPerfect

class PlaySoundsViewControllerSpec: QuickSpec {
    override func spec() {
        describe("init") {
            let viewMock = PlaySoundsViewControllerMock()
            
            it("setup audio on beginning") {
                viewMock.viewDidLoad()
                
                expect(viewMock.didCallSetupAudio).to(beTrue())
            }
            
            it("configures ui for state of not playing") {
                viewMock.viewDidAppear(true)
                
                expect(viewMock.didCallConfigureUIWithValue).to(equal("notPlaying"))
            }
            
            context("plays a song with an effect") {
                var viewController: PlaySoundsViewController!
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    viewController = storyboard.instantiateViewController(withIdentifier: "playSounds") as! PlaySoundsViewController
                    viewController.loadView()
                }

                it("uses slow effect") {
                    viewMock.playSoundForButton(viewController.slowButton)
                    print(viewController.slowButton.buttonType.rawValue)

                    expect(viewMock.rateWithValue).to(equal(0.5))
                }

                it("uses fast effect") {
                    viewMock.playSoundForButton(viewController.fastButton)

                    expect(viewMock.rateWithValue).to(equal(1.5))
                }

                it("uses high pitch effect") {
                    viewMock.playSoundForButton(viewController.highPitchButton)
                    
                    expect(viewMock.pitchWithValue).to(equal(1000))
                }

                it("uses low pitch effect") {
                    viewMock.playSoundForButton(viewController.lowPitchButton)
                    
                    expect(viewMock.pitchWithValue).to(equal(-1000))
                }

                it("uses echo effect") {
                    viewMock.playSoundForButton(viewController.echoButton)
                    
                    expect(viewMock.echoWithValue).to(beTrue())
                }

                it("uses reverb effect") {
                    viewMock.playSoundForButton(viewController.reverbButton)
                    
                    expect(viewMock.reverbWithValue).to(beTrue())
                }

                it("configures ui to status of playing a song") {
                    viewMock.playSoundForButton(viewController.echoButton)
                    
                    expect(viewMock.didCallConfigureUIWithValue).to(equal("playing"))
                }
            }

            context("stop playing a song") {
                it("calls stop audio function") {
                    viewMock.stopPlaying(true)

                    expect(viewMock.didCallConfigureUIWithValue).to(equal("notPlaying"))
                }

                it("configures ui to status of not playing a song") {
                    viewMock.stopPlaying(true)
                    
                    expect(viewMock.didCallConfigureUIWithValue).to(equal("notPlaying"))
                }
            }
        }
    }
}

class PlaySoundsViewControllerMock: PlaySoundsViewController {
    var didCallSetupAudio = false
    var didCallStopPlaying = false
    var didCallConfigureUIWithValue = ""
    var rateWithValue = 0.0
    var pitchWithValue = 0.0
    var echoWithValue = false
    var reverbWithValue = false
    
    enum ButtonTypeMock: Int {
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    
    override func viewDidLoad() {
        didCallSetupAudio = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        didCallConfigureUIWithValue = "notPlaying"
    }
    
    override func playSoundForButton(_ sender: UIButton) {
        switch(ButtonTypeMock(rawValue: sender.tag)!) {
        case .slow:
            rateWithValue = 0.5
        case .fast:
            rateWithValue = 1.5
        case .highPitch:
            pitchWithValue = 1000
        case .lowPitch:
            pitchWithValue = -1000
        case .echo:
            echoWithValue = true
        case .reverb:
            reverbWithValue = true
        }
        
        didCallConfigureUIWithValue = "playing"
    }
    
    override func stopPlaying(_ sender: Any) {
        didCallStopPlaying = true
        didCallConfigureUIWithValue = "notPlaying"
    }
}
