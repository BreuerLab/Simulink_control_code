/*
 * simulink_traverse_control_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "simulink_traverse_control".
 *
 * Model version              : 1.32
 * Simulink Coder version : 23.2 (R2023b) 01-Aug-2023
 * C source code generated on : Mon Dec 11 15:18:05 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "simulink_traverse_control.h"

/* Block parameters (default storage) */
P_simulink_traverse_control_T simulink_traverse_control_P = {
  /* Variable: freq
   * Referenced by: '<Root>/Conversion [V//m]'
   */
  0.0,

  /* Variable: heave1
   * Referenced by: '<Root>/Conversion [V//m]'
   */
  0.0,

  /* Mask Parameter: y_control_signal_ctr0_out_PFI12_Duty
   * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
   */
  0.5,

  /* Mask Parameter: theta_control_signal_ctr1_PFI13_Duty
   * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
   */
  0.5,

  /* Mask Parameter: ctr1pitch1_InputFilter
   * Referenced by: '<Root>/ctr1 pitch1'
   */
  0.0,

  /* Mask Parameter: ctr0heave1_InputFilter
   * Referenced by: '<Root>/ctr0 heave1'
   */
  0.0,

  /* Mask Parameter: ctr1pitch2_InputFilter
   * Referenced by: '<Root>/ctr1 pitch2'
   */
  0.0,

  /* Mask Parameter: ctr0heave2_InputFilter
   * Referenced by: '<Root>/ctr0 heave2'
   */
  0.0,

  /* Mask Parameter: AnalogInput_MaxMissedTicks
   * Referenced by: '<Root>/Analog Input'
   */
  10.0,

  /* Mask Parameter: FT16810dev21_MaxMissedTicks
   * Referenced by: '<Root>/FT16810, dev2.1'
   */
  10.0,

  /* Mask Parameter: FT16811dev3_MaxMissedTicks
   * Referenced by: '<Root>/FT16811, dev3'
   */
  10.0,

  /* Mask Parameter: ctr1pitch1_MaxMissedTicks
   * Referenced by: '<Root>/ctr1 pitch1'
   */
  10.0,

  /* Mask Parameter: ctr0heave1_MaxMissedTicks
   * Referenced by: '<Root>/ctr0 heave1'
   */
  10.0,

  /* Mask Parameter: ctr1pitch2_MaxMissedTicks
   * Referenced by: '<Root>/ctr1 pitch2'
   */
  10.0,

  /* Mask Parameter: ctr0heave2_MaxMissedTicks
   * Referenced by: '<Root>/ctr0 heave2'
   */
  10.0,

  /* Mask Parameter: AnalogOutput_MaxMissedTicks
   * Referenced by: '<Root>/Analog Output'
   */
  10.0,

  /* Mask Parameter: AnalogOutput1_MaxMissedTicks
   * Referenced by: '<Root>/Analog Output1'
   */
  10.0,

  /* Mask Parameter: DigitalOutput_MaxMissedTicks
   * Referenced by: '<Root>/Digital Output'
   */
  10.0,

  /* Mask Parameter: y_control_signal_ctr0_out_PFI12_MaxMissedTicks
   * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
   */
  10.0,

  /* Mask Parameter: theta_control_signal_ctr1_PFI13_MaxMissedTicks
   * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
   */
  10.0,

  /* Mask Parameter: AnalogInput_YieldWhenWaiting
   * Referenced by: '<Root>/Analog Input'
   */
  0.0,

  /* Mask Parameter: FT16810dev21_YieldWhenWaiting
   * Referenced by: '<Root>/FT16810, dev2.1'
   */
  0.0,

  /* Mask Parameter: FT16811dev3_YieldWhenWaiting
   * Referenced by: '<Root>/FT16811, dev3'
   */
  0.0,

  /* Mask Parameter: ctr1pitch1_YieldWhenWaiting
   * Referenced by: '<Root>/ctr1 pitch1'
   */
  0.0,

  /* Mask Parameter: ctr0heave1_YieldWhenWaiting
   * Referenced by: '<Root>/ctr0 heave1'
   */
  0.0,

  /* Mask Parameter: ctr1pitch2_YieldWhenWaiting
   * Referenced by: '<Root>/ctr1 pitch2'
   */
  0.0,

  /* Mask Parameter: ctr0heave2_YieldWhenWaiting
   * Referenced by: '<Root>/ctr0 heave2'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_YieldWhenWaiting
   * Referenced by: '<Root>/Analog Output'
   */
  0.0,

  /* Mask Parameter: AnalogOutput1_YieldWhenWaiting
   * Referenced by: '<Root>/Analog Output1'
   */
  0.0,

  /* Mask Parameter: DigitalOutput_YieldWhenWaiting
   * Referenced by: '<Root>/Digital Output'
   */
  0.0,

  /* Mask Parameter: y_control_signal_ctr0_out_PFI12_YieldWhenWaiting
   * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
   */
  0.0,

  /* Mask Parameter: theta_control_signal_ctr1_PFI13_YieldWhenWaiting
   * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
   */
  0.0,

  /* Mask Parameter: DigitalOutput_BitMode
   * Referenced by: '<Root>/Digital Output'
   */
  0,

  /* Mask Parameter: AnalogInput_Channels
   * Referenced by: '<Root>/Analog Input'
   */
  { 16, 17, 18, 19, 20 },

  /* Mask Parameter: FT16810dev21_Channels
   * Referenced by: '<Root>/FT16810, dev2.1'
   */
  { 0, 1, 2, 3, 4, 5 },

  /* Mask Parameter: FT16811dev3_Channels
   * Referenced by: '<Root>/FT16811, dev3'
   */
  { 0, 1, 2, 3, 4, 5 },

  /* Mask Parameter: ctr1pitch1_Channels
   * Referenced by: '<Root>/ctr1 pitch1'
   */
  1,

  /* Mask Parameter: ctr0heave1_Channels
   * Referenced by: '<Root>/ctr0 heave1'
   */
  0,

  /* Mask Parameter: ctr1pitch2_Channels
   * Referenced by: '<Root>/ctr1 pitch2'
   */
  1,

  /* Mask Parameter: ctr0heave2_Channels
   * Referenced by: '<Root>/ctr0 heave2'
   */
  0,

  /* Mask Parameter: AnalogOutput_Channels
   * Referenced by: '<Root>/Analog Output'
   */
  2,

  /* Mask Parameter: AnalogOutput1_Channels
   * Referenced by: '<Root>/Analog Output1'
   */
  3,

  /* Mask Parameter: DigitalOutput_Channels
   * Referenced by: '<Root>/Digital Output'
   */
  14,

  /* Mask Parameter: y_control_signal_ctr0_out_PFI12_Channels
   * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
   */
  0,

  /* Mask Parameter: theta_control_signal_ctr1_PFI13_Channels
   * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
   */
  1,

  /* Mask Parameter: AnalogInput_RangeMode
   * Referenced by: '<Root>/Analog Input'
   */
  0,

  /* Mask Parameter: FT16810dev21_RangeMode
   * Referenced by: '<Root>/FT16810, dev2.1'
   */
  0,

  /* Mask Parameter: FT16811dev3_RangeMode
   * Referenced by: '<Root>/FT16811, dev3'
   */
  0,

  /* Mask Parameter: AnalogOutput_RangeMode
   * Referenced by: '<Root>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogOutput1_RangeMode
   * Referenced by: '<Root>/Analog Output1'
   */
  0,

  /* Mask Parameter: AnalogInput_VoltRange
   * Referenced by: '<Root>/Analog Input'
   */
  0,

  /* Mask Parameter: FT16810dev21_VoltRange
   * Referenced by: '<Root>/FT16810, dev2.1'
   */
  0,

  /* Mask Parameter: FT16811dev3_VoltRange
   * Referenced by: '<Root>/FT16811, dev3'
   */
  0,

  /* Mask Parameter: AnalogOutput_VoltRange
   * Referenced by: '<Root>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogOutput1_VoltRange
   * Referenced by: '<Root>/Analog Output1'
   */
  0,

  /* Expression: 0
   * Referenced by: '<Root>/MANUAL OFFSET P1'
   */
  0.0,

  /* Expression: 15
   * Referenced by: '<Root>/Rate Limiter1'
   */
  15.0,

  /* Expression: -15
   * Referenced by: '<Root>/Rate Limiter1'
   */
  -15.0,

  /* Expression: 0
   * Referenced by: '<Root>/Rate Limiter1'
   */
  0.0,

  /* Expression: 5*0.022222
   * Referenced by: '<Root>/Conversion [V//deg]'
   */
  0.11110999999999999,

  /* Expression: 10
   * Referenced by: '<Root>/Saturation'
   */
  10.0,

  /* Expression: -10
   * Referenced by: '<Root>/Saturation'
   */
  -10.0,

  /* Expression: 0
   * Referenced by: '<Root>/MANUAL OFFSET H1'
   */
  0.0,

  /* Expression: 0.05
   * Referenced by: '<Root>/Rate Limiter3'
   */
  0.05,

  /* Expression: -0.05
   * Referenced by: '<Root>/Rate Limiter3'
   */
  -0.05,

  /* Expression: 0
   * Referenced by: '<Root>/Rate Limiter3'
   */
  0.0,

  /* Expression: 10
   * Referenced by: '<Root>/Saturation1'
   */
  10.0,

  /* Expression: -10
   * Referenced by: '<Root>/Saturation1'
   */
  -10.0,

  /* Expression: 0
   * Referenced by: '<Root>/MANUAL OFFSET H2'
   */
  0.0,

  /* Expression: 0.05
   * Referenced by: '<Root>/Rate Limiter2'
   */
  0.05,

  /* Expression: -0.05
   * Referenced by: '<Root>/Rate Limiter2'
   */
  -0.05,

  /* Expression: 0
   * Referenced by: '<Root>/Rate Limiter2'
   */
  0.0,

  /* Expression: 10000
   * Referenced by: '<Root>/y_calib [Hz//m]'
   */
  10000.0,

  /* Expression: 5000
   * Referenced by: '<Root>/y_calib_bias [Hz]'
   */
  5000.0,

  /* Expression: 10000
   * Referenced by: '<Root>/Saturation2'
   */
  10000.0,

  /* Expression: 5000
   * Referenced by: '<Root>/Saturation2'
   */
  5000.0,

  /* Expression: 0
   * Referenced by: '<Root>/MANUAL OFFSET P2'
   */
  0.0,

  /* Expression: 15
   * Referenced by: '<Root>/Rate Limiter4'
   */
  15.0,

  /* Expression: -15
   * Referenced by: '<Root>/Rate Limiter4'
   */
  -15.0,

  /* Expression: 0
   * Referenced by: '<Root>/Rate Limiter4'
   */
  0.0,

  /* Expression: 13.8889
   * Referenced by: '<Root>/theta_calib [Hz//deg]'
   */
  13.8889,

  /* Expression: 5000
   * Referenced by: '<Root>/theta_calib_bias [Hz]'
   */
  5000.0,

  /* Expression: 9200
   * Referenced by: '<Root>/Saturation3'
   */
  9200.0,

  /* Expression: 5000
   * Referenced by: '<Root>/Saturation3'
   */
  5000.0
};
