<Cabbage>
    form caption("Kaos") size(400, 300), guiMode("queue") pluginId("def1")
    rslider bounds(296, 162, 100, 100), channel("softness"), range(0, 1, 0.01, 1, 0.01), text("Softness"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
    rslider bounds(12, 24, 100, 100), channel("balance"), range(0, 1, 0.5, 1, 0.01), text("Balance"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
    rslider bounds(12, 162, 100, 100), channel("crunch"), range(0, 1, 0.5, 1, 0.01), text("Crunch"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black") 
    rslider bounds (296, 24, 100, 100), channel("suffocation"), range(0, 1, 0, 1, 0.01), text("Suffocation"), trackerColour("lime"), outlineColour(0, 0, 0, 50), textColour("black")
</Cabbage>
<CsoundSynthesizer>
    <CsOptions>
        -n -d
    </CsOptions>
    <CsInstruments>
        ; Initialize the global variables. 
        ksmps = 32
        nchnls = 2
        0dbfs = 1


        instr 1
        
        aL inch 1
        aR inch 2

        kSoftness cabbageGetValue "softness"
        if (kSoftness == 0) then ; Stop it from making the powershape distortion act weird
            kSoftness = 0.005
        endif
        kSoftness = 2 * (kSoftness - 0.5) ; Transpose from 0-1 to -1-1
        
        kCrunch cabbageGetValue "crunch"
        kCrunch = kCrunch * 2 ; Transpose range from 0-1 to 0-2
        if (kCrunch == 0) then ; Make it so that no crunch doesn't mean no noise
            kCrunch = 0.001
        endif
        
        kSuffocate cabbageGetValue "suffocation"
        
        kAmp cabbageGetValue "balance"
        kAmp = sqrt(kAmp * 100) * 0.1 ; Apply square root curve to kAmp to give lower amplitudes a more pronounced effect
        kInAmp = (1 - kAmp) ; Invert the amplitude of the noise to get the amplitude of the input audio

        kAmpL rms aL
        kAmpR rms aR
        
        aNoise noise 1, kSoftness
        aNoise powershape aNoise, kCrunch; , iAmpMax ; Exponentiates noise signal to add distortion and scales accordingly
        aNoise pdhalf aNoise, kSuffocate ; Applies a phase distortion
        
        aL gain aL, kInAmp * kAmpL
        aR gain aR, kInAmp * kAmpR
        aNoiseL gain aNoise, kAmp * kAmpL
        aNoiseR gain aNoise, kAmp * kAmpR
        
        aL = aL + aNoiseL
        aR = aR + aNoiseR
        outs aL, aR
        endin

    </CsInstruments>
    <CsScore>
        ; causes Csound to run for about 7000 years...
        f0 z
        ;starts instrument 1 and runs it for a week
        i1 0 [60*60*24*7] 
    </CsScore>
</CsoundSynthesizer>
