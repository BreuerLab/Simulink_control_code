    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 3;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (simulink_traverse_control_P)
        ;%
            section.nData     = 30;
            section.data(30)  = dumData; %prealloc

                    ;% simulink_traverse_control_P.freq
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% simulink_traverse_control_P.heave1
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% simulink_traverse_control_P.y_control_signal_ctr0_out_PFI12_Duty
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% simulink_traverse_control_P.theta_control_signal_ctr1_PFI13_Duty
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% simulink_traverse_control_P.ctr1pitch1_InputFilter
                    section.data(5).logicalSrcIdx = 14;
                    section.data(5).dtTransOffset = 4;

                    ;% simulink_traverse_control_P.ctr0heave1_InputFilter
                    section.data(6).logicalSrcIdx = 15;
                    section.data(6).dtTransOffset = 5;

                    ;% simulink_traverse_control_P.ctr1pitch2_InputFilter
                    section.data(7).logicalSrcIdx = 16;
                    section.data(7).dtTransOffset = 6;

                    ;% simulink_traverse_control_P.ctr0heave2_InputFilter
                    section.data(8).logicalSrcIdx = 17;
                    section.data(8).dtTransOffset = 7;

                    ;% simulink_traverse_control_P.AnalogInput_MaxMissedTicks
                    section.data(9).logicalSrcIdx = 18;
                    section.data(9).dtTransOffset = 8;

                    ;% simulink_traverse_control_P.GromitTransduder_MaxMissedTicks
                    section.data(10).logicalSrcIdx = 19;
                    section.data(10).dtTransOffset = 9;

                    ;% simulink_traverse_control_P.ctr1pitch1_MaxMissedTicks
                    section.data(11).logicalSrcIdx = 20;
                    section.data(11).dtTransOffset = 10;

                    ;% simulink_traverse_control_P.ctr0heave1_MaxMissedTicks
                    section.data(12).logicalSrcIdx = 21;
                    section.data(12).dtTransOffset = 11;

                    ;% simulink_traverse_control_P.ctr1pitch2_MaxMissedTicks
                    section.data(13).logicalSrcIdx = 22;
                    section.data(13).dtTransOffset = 12;

                    ;% simulink_traverse_control_P.ctr0heave2_MaxMissedTicks
                    section.data(14).logicalSrcIdx = 23;
                    section.data(14).dtTransOffset = 13;

                    ;% simulink_traverse_control_P.WallaceTransducer_MaxMissedTicks
                    section.data(15).logicalSrcIdx = 24;
                    section.data(15).dtTransOffset = 14;

                    ;% simulink_traverse_control_P.AnalogOutput_MaxMissedTicks
                    section.data(16).logicalSrcIdx = 25;
                    section.data(16).dtTransOffset = 15;

                    ;% simulink_traverse_control_P.AnalogOutput1_MaxMissedTicks
                    section.data(17).logicalSrcIdx = 26;
                    section.data(17).dtTransOffset = 16;

                    ;% simulink_traverse_control_P.y_control_signal_ctr0_out_PFI12_MaxMissedTicks
                    section.data(18).logicalSrcIdx = 27;
                    section.data(18).dtTransOffset = 17;

                    ;% simulink_traverse_control_P.theta_control_signal_ctr1_PFI13_MaxMissedTicks
                    section.data(19).logicalSrcIdx = 28;
                    section.data(19).dtTransOffset = 18;

                    ;% simulink_traverse_control_P.AnalogInput_YieldWhenWaiting
                    section.data(20).logicalSrcIdx = 29;
                    section.data(20).dtTransOffset = 19;

                    ;% simulink_traverse_control_P.GromitTransduder_YieldWhenWaiting
                    section.data(21).logicalSrcIdx = 30;
                    section.data(21).dtTransOffset = 20;

                    ;% simulink_traverse_control_P.ctr1pitch1_YieldWhenWaiting
                    section.data(22).logicalSrcIdx = 31;
                    section.data(22).dtTransOffset = 21;

                    ;% simulink_traverse_control_P.ctr0heave1_YieldWhenWaiting
                    section.data(23).logicalSrcIdx = 32;
                    section.data(23).dtTransOffset = 22;

                    ;% simulink_traverse_control_P.ctr1pitch2_YieldWhenWaiting
                    section.data(24).logicalSrcIdx = 33;
                    section.data(24).dtTransOffset = 23;

                    ;% simulink_traverse_control_P.ctr0heave2_YieldWhenWaiting
                    section.data(25).logicalSrcIdx = 34;
                    section.data(25).dtTransOffset = 24;

                    ;% simulink_traverse_control_P.WallaceTransducer_YieldWhenWaiting
                    section.data(26).logicalSrcIdx = 35;
                    section.data(26).dtTransOffset = 25;

                    ;% simulink_traverse_control_P.AnalogOutput_YieldWhenWaiting
                    section.data(27).logicalSrcIdx = 36;
                    section.data(27).dtTransOffset = 26;

                    ;% simulink_traverse_control_P.AnalogOutput1_YieldWhenWaiting
                    section.data(28).logicalSrcIdx = 37;
                    section.data(28).dtTransOffset = 27;

                    ;% simulink_traverse_control_P.y_control_signal_ctr0_out_PFI12_YieldWhenWaiting
                    section.data(29).logicalSrcIdx = 38;
                    section.data(29).dtTransOffset = 28;

                    ;% simulink_traverse_control_P.theta_control_signal_ctr1_PFI13_YieldWhenWaiting
                    section.data(30).logicalSrcIdx = 39;
                    section.data(30).dtTransOffset = 29;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 21;
            section.data(21)  = dumData; %prealloc

                    ;% simulink_traverse_control_P.AnalogInput_Channels
                    section.data(1).logicalSrcIdx = 40;
                    section.data(1).dtTransOffset = 0;

                    ;% simulink_traverse_control_P.GromitTransduder_Channels
                    section.data(2).logicalSrcIdx = 41;
                    section.data(2).dtTransOffset = 5;

                    ;% simulink_traverse_control_P.ctr1pitch1_Channels
                    section.data(3).logicalSrcIdx = 42;
                    section.data(3).dtTransOffset = 11;

                    ;% simulink_traverse_control_P.ctr0heave1_Channels
                    section.data(4).logicalSrcIdx = 43;
                    section.data(4).dtTransOffset = 12;

                    ;% simulink_traverse_control_P.ctr1pitch2_Channels
                    section.data(5).logicalSrcIdx = 44;
                    section.data(5).dtTransOffset = 13;

                    ;% simulink_traverse_control_P.ctr0heave2_Channels
                    section.data(6).logicalSrcIdx = 45;
                    section.data(6).dtTransOffset = 14;

                    ;% simulink_traverse_control_P.WallaceTransducer_Channels
                    section.data(7).logicalSrcIdx = 46;
                    section.data(7).dtTransOffset = 15;

                    ;% simulink_traverse_control_P.AnalogOutput_Channels
                    section.data(8).logicalSrcIdx = 47;
                    section.data(8).dtTransOffset = 21;

                    ;% simulink_traverse_control_P.AnalogOutput1_Channels
                    section.data(9).logicalSrcIdx = 48;
                    section.data(9).dtTransOffset = 22;

                    ;% simulink_traverse_control_P.y_control_signal_ctr0_out_PFI12_Channels
                    section.data(10).logicalSrcIdx = 49;
                    section.data(10).dtTransOffset = 23;

                    ;% simulink_traverse_control_P.theta_control_signal_ctr1_PFI13_Channels
                    section.data(11).logicalSrcIdx = 50;
                    section.data(11).dtTransOffset = 24;

                    ;% simulink_traverse_control_P.AnalogInput_RangeMode
                    section.data(12).logicalSrcIdx = 51;
                    section.data(12).dtTransOffset = 25;

                    ;% simulink_traverse_control_P.GromitTransduder_RangeMode
                    section.data(13).logicalSrcIdx = 52;
                    section.data(13).dtTransOffset = 26;

                    ;% simulink_traverse_control_P.WallaceTransducer_RangeMode
                    section.data(14).logicalSrcIdx = 53;
                    section.data(14).dtTransOffset = 27;

                    ;% simulink_traverse_control_P.AnalogOutput_RangeMode
                    section.data(15).logicalSrcIdx = 54;
                    section.data(15).dtTransOffset = 28;

                    ;% simulink_traverse_control_P.AnalogOutput1_RangeMode
                    section.data(16).logicalSrcIdx = 55;
                    section.data(16).dtTransOffset = 29;

                    ;% simulink_traverse_control_P.AnalogInput_VoltRange
                    section.data(17).logicalSrcIdx = 56;
                    section.data(17).dtTransOffset = 30;

                    ;% simulink_traverse_control_P.GromitTransduder_VoltRange
                    section.data(18).logicalSrcIdx = 57;
                    section.data(18).dtTransOffset = 31;

                    ;% simulink_traverse_control_P.WallaceTransducer_VoltRange
                    section.data(19).logicalSrcIdx = 58;
                    section.data(19).dtTransOffset = 32;

                    ;% simulink_traverse_control_P.AnalogOutput_VoltRange
                    section.data(20).logicalSrcIdx = 59;
                    section.data(20).dtTransOffset = 33;

                    ;% simulink_traverse_control_P.AnalogOutput1_VoltRange
                    section.data(21).logicalSrcIdx = 60;
                    section.data(21).dtTransOffset = 34;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 29;
            section.data(29)  = dumData; %prealloc

                    ;% simulink_traverse_control_P.MANUALOFFSETP1_Value
                    section.data(1).logicalSrcIdx = 61;
                    section.data(1).dtTransOffset = 0;

                    ;% simulink_traverse_control_P.RateLimiter1_RisingLim
                    section.data(2).logicalSrcIdx = 62;
                    section.data(2).dtTransOffset = 1;

                    ;% simulink_traverse_control_P.RateLimiter1_FallingLim
                    section.data(3).logicalSrcIdx = 63;
                    section.data(3).dtTransOffset = 2;

                    ;% simulink_traverse_control_P.RateLimiter1_IC
                    section.data(4).logicalSrcIdx = 64;
                    section.data(4).dtTransOffset = 3;

                    ;% simulink_traverse_control_P.ConversionVdeg_Gain
                    section.data(5).logicalSrcIdx = 65;
                    section.data(5).dtTransOffset = 4;

                    ;% simulink_traverse_control_P.Saturation_UpperSat
                    section.data(6).logicalSrcIdx = 66;
                    section.data(6).dtTransOffset = 5;

                    ;% simulink_traverse_control_P.Saturation_LowerSat
                    section.data(7).logicalSrcIdx = 67;
                    section.data(7).dtTransOffset = 6;

                    ;% simulink_traverse_control_P.MANUALOFFSETH1_Value
                    section.data(8).logicalSrcIdx = 68;
                    section.data(8).dtTransOffset = 7;

                    ;% simulink_traverse_control_P.RateLimiter3_RisingLim
                    section.data(9).logicalSrcIdx = 69;
                    section.data(9).dtTransOffset = 8;

                    ;% simulink_traverse_control_P.RateLimiter3_FallingLim
                    section.data(10).logicalSrcIdx = 70;
                    section.data(10).dtTransOffset = 9;

                    ;% simulink_traverse_control_P.RateLimiter3_IC
                    section.data(11).logicalSrcIdx = 71;
                    section.data(11).dtTransOffset = 10;

                    ;% simulink_traverse_control_P.Saturation1_UpperSat
                    section.data(12).logicalSrcIdx = 72;
                    section.data(12).dtTransOffset = 11;

                    ;% simulink_traverse_control_P.Saturation1_LowerSat
                    section.data(13).logicalSrcIdx = 73;
                    section.data(13).dtTransOffset = 12;

                    ;% simulink_traverse_control_P.MANUALOFFSETH2_Value
                    section.data(14).logicalSrcIdx = 74;
                    section.data(14).dtTransOffset = 13;

                    ;% simulink_traverse_control_P.RateLimiter2_RisingLim
                    section.data(15).logicalSrcIdx = 75;
                    section.data(15).dtTransOffset = 14;

                    ;% simulink_traverse_control_P.RateLimiter2_FallingLim
                    section.data(16).logicalSrcIdx = 76;
                    section.data(16).dtTransOffset = 15;

                    ;% simulink_traverse_control_P.RateLimiter2_IC
                    section.data(17).logicalSrcIdx = 77;
                    section.data(17).dtTransOffset = 16;

                    ;% simulink_traverse_control_P.y_calibHzm_Gain
                    section.data(18).logicalSrcIdx = 78;
                    section.data(18).dtTransOffset = 17;

                    ;% simulink_traverse_control_P.y_calib_biasHz_Bias
                    section.data(19).logicalSrcIdx = 79;
                    section.data(19).dtTransOffset = 18;

                    ;% simulink_traverse_control_P.Saturation2_UpperSat
                    section.data(20).logicalSrcIdx = 80;
                    section.data(20).dtTransOffset = 19;

                    ;% simulink_traverse_control_P.Saturation2_LowerSat
                    section.data(21).logicalSrcIdx = 81;
                    section.data(21).dtTransOffset = 20;

                    ;% simulink_traverse_control_P.MANUALOFFSETP2_Value
                    section.data(22).logicalSrcIdx = 82;
                    section.data(22).dtTransOffset = 21;

                    ;% simulink_traverse_control_P.RateLimiter4_RisingLim
                    section.data(23).logicalSrcIdx = 83;
                    section.data(23).dtTransOffset = 22;

                    ;% simulink_traverse_control_P.RateLimiter4_FallingLim
                    section.data(24).logicalSrcIdx = 84;
                    section.data(24).dtTransOffset = 23;

                    ;% simulink_traverse_control_P.RateLimiter4_IC
                    section.data(25).logicalSrcIdx = 85;
                    section.data(25).dtTransOffset = 24;

                    ;% simulink_traverse_control_P.theta_calibHzdeg_Gain
                    section.data(26).logicalSrcIdx = 86;
                    section.data(26).dtTransOffset = 25;

                    ;% simulink_traverse_control_P.theta_calib_biasHz_Bias
                    section.data(27).logicalSrcIdx = 87;
                    section.data(27).dtTransOffset = 26;

                    ;% simulink_traverse_control_P.Saturation3_UpperSat
                    section.data(28).logicalSrcIdx = 88;
                    section.data(28).dtTransOffset = 27;

                    ;% simulink_traverse_control_P.Saturation3_LowerSat
                    section.data(29).logicalSrcIdx = 89;
                    section.data(29).dtTransOffset = 28;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 1;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (simulink_traverse_control_B)
        ;%
            section.nData     = 8;
            section.data(8)  = dumData; %prealloc

                    ;% simulink_traverse_control_B.AnalogInput
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% simulink_traverse_control_B.GromitTransduder
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 5;

                    ;% simulink_traverse_control_B.ctr1pitch1
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 11;

                    ;% simulink_traverse_control_B.ctr0heave1
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 12;

                    ;% simulink_traverse_control_B.ctr1pitch2
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 13;

                    ;% simulink_traverse_control_B.ctr0heave2
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 14;

                    ;% simulink_traverse_control_B.WallaceTransducer
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 15;

                    ;% simulink_traverse_control_B.FromWorkspace4
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 21;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 3;
        sectIdxOffset = 1;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (simulink_traverse_control_DW)
        ;%
            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% simulink_traverse_control_DW.PrevY
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% simulink_traverse_control_DW.PrevY_n
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% simulink_traverse_control_DW.PrevY_k
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% simulink_traverse_control_DW.PrevY_a
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 21;
            section.data(21)  = dumData; %prealloc

                    ;% simulink_traverse_control_DW.AnalogInput_PWORK
                    section.data(1).logicalSrcIdx = 4;
                    section.data(1).dtTransOffset = 0;

                    ;% simulink_traverse_control_DW.GromitTransduder_PWORK
                    section.data(2).logicalSrcIdx = 5;
                    section.data(2).dtTransOffset = 1;

                    ;% simulink_traverse_control_DW.ctr1pitch1_PWORK
                    section.data(3).logicalSrcIdx = 6;
                    section.data(3).dtTransOffset = 2;

                    ;% simulink_traverse_control_DW.ctr0heave1_PWORK
                    section.data(4).logicalSrcIdx = 7;
                    section.data(4).dtTransOffset = 3;

                    ;% simulink_traverse_control_DW.ctr1pitch2_PWORK
                    section.data(5).logicalSrcIdx = 8;
                    section.data(5).dtTransOffset = 4;

                    ;% simulink_traverse_control_DW.ctr0heave2_PWORK
                    section.data(6).logicalSrcIdx = 9;
                    section.data(6).dtTransOffset = 5;

                    ;% simulink_traverse_control_DW.WallaceTransducer_PWORK
                    section.data(7).logicalSrcIdx = 10;
                    section.data(7).dtTransOffset = 6;

                    ;% simulink_traverse_control_DW.ToWorkspace7_PWORK.LoggedData
                    section.data(8).logicalSrcIdx = 11;
                    section.data(8).dtTransOffset = 7;

                    ;% simulink_traverse_control_DW.ToWorkspace8_PWORK.LoggedData
                    section.data(9).logicalSrcIdx = 12;
                    section.data(9).dtTransOffset = 8;

                    ;% simulink_traverse_control_DW.FromWorkspace4_PWORK.TimePtr
                    section.data(10).logicalSrcIdx = 13;
                    section.data(10).dtTransOffset = 9;

                    ;% simulink_traverse_control_DW.ToWorkspace_PWORK.LoggedData
                    section.data(11).logicalSrcIdx = 14;
                    section.data(11).dtTransOffset = 10;

                    ;% simulink_traverse_control_DW.ToWorkspace6_PWORK.LoggedData
                    section.data(12).logicalSrcIdx = 15;
                    section.data(12).dtTransOffset = 11;

                    ;% simulink_traverse_control_DW.AnalogOutput_PWORK
                    section.data(13).logicalSrcIdx = 16;
                    section.data(13).dtTransOffset = 12;

                    ;% simulink_traverse_control_DW.AnalogOutput1_PWORK
                    section.data(14).logicalSrcIdx = 17;
                    section.data(14).dtTransOffset = 13;

                    ;% simulink_traverse_control_DW.y_control_signal_ctr0_out_PFI12_PWORK
                    section.data(15).logicalSrcIdx = 18;
                    section.data(15).dtTransOffset = 14;

                    ;% simulink_traverse_control_DW.theta_control_signal_ctr1_PFI13_PWORK
                    section.data(16).logicalSrcIdx = 19;
                    section.data(16).dtTransOffset = 15;

                    ;% simulink_traverse_control_DW.ToWorkspace1_PWORK.LoggedData
                    section.data(17).logicalSrcIdx = 20;
                    section.data(17).dtTransOffset = 16;

                    ;% simulink_traverse_control_DW.ToWorkspace2_PWORK.LoggedData
                    section.data(18).logicalSrcIdx = 21;
                    section.data(18).dtTransOffset = 17;

                    ;% simulink_traverse_control_DW.ToWorkspace3_PWORK.LoggedData
                    section.data(19).logicalSrcIdx = 22;
                    section.data(19).dtTransOffset = 18;

                    ;% simulink_traverse_control_DW.ToWorkspace4_PWORK.LoggedData
                    section.data(20).logicalSrcIdx = 23;
                    section.data(20).dtTransOffset = 19;

                    ;% simulink_traverse_control_DW.ToWorkspace5_PWORK.LoggedData
                    section.data(21).logicalSrcIdx = 24;
                    section.data(21).dtTransOffset = 20;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% simulink_traverse_control_DW.FromWorkspace4_IWORK.PrevIndex
                    section.data(1).logicalSrcIdx = 25;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 1047127014;
    targMap.checksum1 = 2656770288;
    targMap.checksum2 = 2184271167;
    targMap.checksum3 = 3864889569;

