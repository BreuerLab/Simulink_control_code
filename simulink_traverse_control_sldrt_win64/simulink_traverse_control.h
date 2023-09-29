/*
 * simulink_traverse_control.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "simulink_traverse_control".
 *
 * Model version              : 1.32
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Thu Sep 28 17:01:52 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_simulink_traverse_control_h_
#define RTW_HEADER_simulink_traverse_control_h_
#ifndef simulink_traverse_control_COMMON_INCLUDES_
#define simulink_traverse_control_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "dt_info.h"
#include "ext_work.h"
#include "sldrtdef.h"
#endif                          /* simulink_traverse_control_COMMON_INCLUDES_ */

#include "simulink_traverse_control_types.h"
#include <math.h>
#include "rtGetInf.h"
#include <stddef.h>
#include "rt_defines.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "zero_crossing_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetBlockIO
#define rtmGetBlockIO(rtm)             ((rtm)->blockIO)
#endif

#ifndef rtmSetBlockIO
#define rtmSetBlockIO(rtm, val)        ((rtm)->blockIO = (val))
#endif

#ifndef rtmGetChecksums
#define rtmGetChecksums(rtm)           ((rtm)->Sizes.checksums)
#endif

#ifndef rtmSetChecksums
#define rtmSetChecksums(rtm, val)      ((rtm)->Sizes.checksums = (val))
#endif

#ifndef rtmGetConstBlockIO
#define rtmGetConstBlockIO(rtm)        ((rtm)->constBlockIO)
#endif

#ifndef rtmSetConstBlockIO
#define rtmSetConstBlockIO(rtm, val)   ((rtm)->constBlockIO = (val))
#endif

#ifndef rtmGetContStateDisabled
#define rtmGetContStateDisabled(rtm)   ((rtm)->contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
#define rtmSetContStateDisabled(rtm, val) ((rtm)->contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
#define rtmGetContStates(rtm)          ((rtm)->contStates)
#endif

#ifndef rtmSetContStates
#define rtmSetContStates(rtm, val)     ((rtm)->contStates = (val))
#endif

#ifndef rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm) ((rtm)->CTOutputIncnstWithState)
#endif

#ifndef rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm, val) ((rtm)->CTOutputIncnstWithState = (val))
#endif

#ifndef rtmGetCtrlRateMdlRefTiming
#define rtmGetCtrlRateMdlRefTiming(rtm) ()
#endif

#ifndef rtmSetCtrlRateMdlRefTiming
#define rtmSetCtrlRateMdlRefTiming(rtm, val) ()
#endif

#ifndef rtmGetCtrlRateMdlRefTimingPtr
#define rtmGetCtrlRateMdlRefTimingPtr(rtm) ()
#endif

#ifndef rtmSetCtrlRateMdlRefTimingPtr
#define rtmSetCtrlRateMdlRefTimingPtr(rtm, val) ()
#endif

#ifndef rtmGetCtrlRateNumTicksToNextHit
#define rtmGetCtrlRateNumTicksToNextHit(rtm) ()
#endif

#ifndef rtmSetCtrlRateNumTicksToNextHit
#define rtmSetCtrlRateNumTicksToNextHit(rtm, val) ()
#endif

#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm)         ()
#endif

#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val)    ()
#endif

#ifndef rtmGetDefaultParam
#define rtmGetDefaultParam(rtm)        ((rtm)->defaultParam)
#endif

#ifndef rtmSetDefaultParam
#define rtmSetDefaultParam(rtm, val)   ((rtm)->defaultParam = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
#define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
#define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetDirectFeedThrough
#define rtmGetDirectFeedThrough(rtm)   ((rtm)->Sizes.sysDirFeedThru)
#endif

#ifndef rtmSetDirectFeedThrough
#define rtmSetDirectFeedThrough(rtm, val) ((rtm)->Sizes.sysDirFeedThru = (val))
#endif

#ifndef rtmGetErrorStatusFlag
#define rtmGetErrorStatusFlag(rtm)     ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatusFlag
#define rtmSetErrorStatusFlag(rtm, val) ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetFinalTime
#define rtmSetFinalTime(rtm, val)      ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetFirstInitCondFlag
#define rtmGetFirstInitCondFlag(rtm)   ()
#endif

#ifndef rtmSetFirstInitCondFlag
#define rtmSetFirstInitCondFlag(rtm, val) ()
#endif

#ifndef rtmGetIntgData
#define rtmGetIntgData(rtm)            ()
#endif

#ifndef rtmSetIntgData
#define rtmSetIntgData(rtm, val)       ()
#endif

#ifndef rtmGetMdlRefGlobalRuntimeEventIndices
#define rtmGetMdlRefGlobalRuntimeEventIndices(rtm) ()
#endif

#ifndef rtmSetMdlRefGlobalRuntimeEventIndices
#define rtmSetMdlRefGlobalRuntimeEventIndices(rtm, val) ()
#endif

#ifndef rtmGetMdlRefGlobalTID
#define rtmGetMdlRefGlobalTID(rtm)     ()
#endif

#ifndef rtmSetMdlRefGlobalTID
#define rtmSetMdlRefGlobalTID(rtm, val) ()
#endif

#ifndef rtmGetMdlRefGlobalTimerIndices
#define rtmGetMdlRefGlobalTimerIndices(rtm) ()
#endif

#ifndef rtmSetMdlRefGlobalTimerIndices
#define rtmSetMdlRefGlobalTimerIndices(rtm, val) ()
#endif

#ifndef rtmGetMdlRefTriggerTID
#define rtmGetMdlRefTriggerTID(rtm)    ()
#endif

#ifndef rtmSetMdlRefTriggerTID
#define rtmSetMdlRefTriggerTID(rtm, val) ()
#endif

#ifndef rtmGetModelMappingInfo
#define rtmGetModelMappingInfo(rtm)    ((rtm)->SpecialInfo.mappingInfo)
#endif

#ifndef rtmSetModelMappingInfo
#define rtmSetModelMappingInfo(rtm, val) ((rtm)->SpecialInfo.mappingInfo = (val))
#endif

#ifndef rtmGetModelName
#define rtmGetModelName(rtm)           ((rtm)->modelName)
#endif

#ifndef rtmSetModelName
#define rtmSetModelName(rtm, val)      ((rtm)->modelName = (val))
#endif

#ifndef rtmGetNonInlinedSFcns
#define rtmGetNonInlinedSFcns(rtm)     ()
#endif

#ifndef rtmSetNonInlinedSFcns
#define rtmSetNonInlinedSFcns(rtm, val) ()
#endif

#ifndef rtmGetNumBlockIO
#define rtmGetNumBlockIO(rtm)          ((rtm)->Sizes.numBlockIO)
#endif

#ifndef rtmSetNumBlockIO
#define rtmSetNumBlockIO(rtm, val)     ((rtm)->Sizes.numBlockIO = (val))
#endif

#ifndef rtmGetNumBlockParams
#define rtmGetNumBlockParams(rtm)      ((rtm)->Sizes.numBlockPrms)
#endif

#ifndef rtmSetNumBlockParams
#define rtmSetNumBlockParams(rtm, val) ((rtm)->Sizes.numBlockPrms = (val))
#endif

#ifndef rtmGetNumBlocks
#define rtmGetNumBlocks(rtm)           ((rtm)->Sizes.numBlocks)
#endif

#ifndef rtmSetNumBlocks
#define rtmSetNumBlocks(rtm, val)      ((rtm)->Sizes.numBlocks = (val))
#endif

#ifndef rtmGetNumContStates
#define rtmGetNumContStates(rtm)       ((rtm)->Sizes.numContStates)
#endif

#ifndef rtmSetNumContStates
#define rtmSetNumContStates(rtm, val)  ((rtm)->Sizes.numContStates = (val))
#endif

#ifndef rtmGetNumDWork
#define rtmGetNumDWork(rtm)            ((rtm)->Sizes.numDwork)
#endif

#ifndef rtmSetNumDWork
#define rtmSetNumDWork(rtm, val)       ((rtm)->Sizes.numDwork = (val))
#endif

#ifndef rtmGetNumInputPorts
#define rtmGetNumInputPorts(rtm)       ((rtm)->Sizes.numIports)
#endif

#ifndef rtmSetNumInputPorts
#define rtmSetNumInputPorts(rtm, val)  ((rtm)->Sizes.numIports = (val))
#endif

#ifndef rtmGetNumNonSampledZCs
#define rtmGetNumNonSampledZCs(rtm)    ((rtm)->Sizes.numNonSampZCs)
#endif

#ifndef rtmSetNumNonSampledZCs
#define rtmSetNumNonSampledZCs(rtm, val) ((rtm)->Sizes.numNonSampZCs = (val))
#endif

#ifndef rtmGetNumOutputPorts
#define rtmGetNumOutputPorts(rtm)      ((rtm)->Sizes.numOports)
#endif

#ifndef rtmSetNumOutputPorts
#define rtmSetNumOutputPorts(rtm, val) ((rtm)->Sizes.numOports = (val))
#endif

#ifndef rtmGetNumPeriodicContStates
#define rtmGetNumPeriodicContStates(rtm) ((rtm)->Sizes.numPeriodicContStates)
#endif

#ifndef rtmSetNumPeriodicContStates
#define rtmSetNumPeriodicContStates(rtm, val) ((rtm)->Sizes.numPeriodicContStates = (val))
#endif

#ifndef rtmGetNumSFcnParams
#define rtmGetNumSFcnParams(rtm)       ((rtm)->Sizes.numSFcnPrms)
#endif

#ifndef rtmSetNumSFcnParams
#define rtmSetNumSFcnParams(rtm, val)  ((rtm)->Sizes.numSFcnPrms = (val))
#endif

#ifndef rtmGetNumSFunctions
#define rtmGetNumSFunctions(rtm)       ((rtm)->Sizes.numSFcns)
#endif

#ifndef rtmSetNumSFunctions
#define rtmSetNumSFunctions(rtm, val)  ((rtm)->Sizes.numSFcns = (val))
#endif

#ifndef rtmGetNumSampleTimes
#define rtmGetNumSampleTimes(rtm)      ((rtm)->Sizes.numSampTimes)
#endif

#ifndef rtmSetNumSampleTimes
#define rtmSetNumSampleTimes(rtm, val) ((rtm)->Sizes.numSampTimes = (val))
#endif

#ifndef rtmGetNumU
#define rtmGetNumU(rtm)                ((rtm)->Sizes.numU)
#endif

#ifndef rtmSetNumU
#define rtmSetNumU(rtm, val)           ((rtm)->Sizes.numU = (val))
#endif

#ifndef rtmGetNumY
#define rtmGetNumY(rtm)                ((rtm)->Sizes.numY)
#endif

#ifndef rtmSetNumY
#define rtmSetNumY(rtm, val)           ((rtm)->Sizes.numY = (val))
#endif

#ifndef rtmGetOdeF
#define rtmGetOdeF(rtm)                ()
#endif

#ifndef rtmSetOdeF
#define rtmSetOdeF(rtm, val)           ()
#endif

#ifndef rtmGetOdeY
#define rtmGetOdeY(rtm)                ()
#endif

#ifndef rtmSetOdeY
#define rtmSetOdeY(rtm, val)           ()
#endif

#ifndef rtmGetOffsetTimeArray
#define rtmGetOffsetTimeArray(rtm)     ((rtm)->Timing.offsetTimesArray)
#endif

#ifndef rtmSetOffsetTimeArray
#define rtmSetOffsetTimeArray(rtm, val) ((rtm)->Timing.offsetTimesArray = (val))
#endif

#ifndef rtmGetOffsetTimePtr
#define rtmGetOffsetTimePtr(rtm)       ((rtm)->Timing.offsetTimes)
#endif

#ifndef rtmSetOffsetTimePtr
#define rtmSetOffsetTimePtr(rtm, val)  ((rtm)->Timing.offsetTimes = (val))
#endif

#ifndef rtmGetOptions
#define rtmGetOptions(rtm)             ((rtm)->Sizes.options)
#endif

#ifndef rtmSetOptions
#define rtmSetOptions(rtm, val)        ((rtm)->Sizes.options = (val))
#endif

#ifndef rtmGetParamIsMalloced
#define rtmGetParamIsMalloced(rtm)     ()
#endif

#ifndef rtmSetParamIsMalloced
#define rtmSetParamIsMalloced(rtm, val) ()
#endif

#ifndef rtmGetPath
#define rtmGetPath(rtm)                ((rtm)->path)
#endif

#ifndef rtmSetPath
#define rtmSetPath(rtm, val)           ((rtm)->path = (val))
#endif

#ifndef rtmGetPerTaskSampleHits
#define rtmGetPerTaskSampleHits(rtm)   ()
#endif

#ifndef rtmSetPerTaskSampleHits
#define rtmSetPerTaskSampleHits(rtm, val) ()
#endif

#ifndef rtmGetPerTaskSampleHitsArray
#define rtmGetPerTaskSampleHitsArray(rtm) ((rtm)->Timing.perTaskSampleHitsArray)
#endif

#ifndef rtmSetPerTaskSampleHitsArray
#define rtmSetPerTaskSampleHitsArray(rtm, val) ((rtm)->Timing.perTaskSampleHitsArray = (val))
#endif

#ifndef rtmGetPerTaskSampleHitsPtr
#define rtmGetPerTaskSampleHitsPtr(rtm) ((rtm)->Timing.perTaskSampleHits)
#endif

#ifndef rtmSetPerTaskSampleHitsPtr
#define rtmSetPerTaskSampleHitsPtr(rtm, val) ((rtm)->Timing.perTaskSampleHits = (val))
#endif

#ifndef rtmGetPeriodicContStateIndices
#define rtmGetPeriodicContStateIndices(rtm) ((rtm)->periodicContStateIndices)
#endif

#ifndef rtmSetPeriodicContStateIndices
#define rtmSetPeriodicContStateIndices(rtm, val) ((rtm)->periodicContStateIndices = (val))
#endif

#ifndef rtmGetPeriodicContStateRanges
#define rtmGetPeriodicContStateRanges(rtm) ((rtm)->periodicContStateRanges)
#endif

#ifndef rtmSetPeriodicContStateRanges
#define rtmSetPeriodicContStateRanges(rtm, val) ((rtm)->periodicContStateRanges = (val))
#endif

#ifndef rtmGetPrevZCSigState
#define rtmGetPrevZCSigState(rtm)      ((rtm)->prevZCSigState)
#endif

#ifndef rtmSetPrevZCSigState
#define rtmSetPrevZCSigState(rtm, val) ((rtm)->prevZCSigState = (val))
#endif

#ifndef rtmGetRTWExtModeInfo
#define rtmGetRTWExtModeInfo(rtm)      ((rtm)->extModeInfo)
#endif

#ifndef rtmSetRTWExtModeInfo
#define rtmSetRTWExtModeInfo(rtm, val) ((rtm)->extModeInfo = (val))
#endif

#ifndef rtmGetRTWGeneratedSFcn
#define rtmGetRTWGeneratedSFcn(rtm)    ((rtm)->Sizes.rtwGenSfcn)
#endif

#ifndef rtmSetRTWGeneratedSFcn
#define rtmSetRTWGeneratedSFcn(rtm, val) ((rtm)->Sizes.rtwGenSfcn = (val))
#endif

#ifndef rtmGetRTWLogInfo
#define rtmGetRTWLogInfo(rtm)          ()
#endif

#ifndef rtmSetRTWLogInfo
#define rtmSetRTWLogInfo(rtm, val)     ()
#endif

#ifndef rtmGetRTWRTModelMethodsInfo
#define rtmGetRTWRTModelMethodsInfo(rtm) ()
#endif

#ifndef rtmSetRTWRTModelMethodsInfo
#define rtmSetRTWRTModelMethodsInfo(rtm, val) ()
#endif

#ifndef rtmGetRTWSfcnInfo
#define rtmGetRTWSfcnInfo(rtm)         ((rtm)->sfcnInfo)
#endif

#ifndef rtmSetRTWSfcnInfo
#define rtmSetRTWSfcnInfo(rtm, val)    ((rtm)->sfcnInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfo
#define rtmGetRTWSolverInfo(rtm)       ((rtm)->solverInfo)
#endif

#ifndef rtmSetRTWSolverInfo
#define rtmSetRTWSolverInfo(rtm, val)  ((rtm)->solverInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfoPtr
#define rtmGetRTWSolverInfoPtr(rtm)    ((rtm)->solverInfoPtr)
#endif

#ifndef rtmSetRTWSolverInfoPtr
#define rtmSetRTWSolverInfoPtr(rtm, val) ((rtm)->solverInfoPtr = (val))
#endif

#ifndef rtmGetReservedForXPC
#define rtmGetReservedForXPC(rtm)      ((rtm)->SpecialInfo.xpcData)
#endif

#ifndef rtmSetReservedForXPC
#define rtmSetReservedForXPC(rtm, val) ((rtm)->SpecialInfo.xpcData = (val))
#endif

#ifndef rtmGetRootDWork
#define rtmGetRootDWork(rtm)           ((rtm)->dwork)
#endif

#ifndef rtmSetRootDWork
#define rtmSetRootDWork(rtm, val)      ((rtm)->dwork = (val))
#endif

#ifndef rtmGetSFunctions
#define rtmGetSFunctions(rtm)          ((rtm)->childSfunctions)
#endif

#ifndef rtmSetSFunctions
#define rtmSetSFunctions(rtm, val)     ((rtm)->childSfunctions = (val))
#endif

#ifndef rtmGetSampleHitArray
#define rtmGetSampleHitArray(rtm)      ((rtm)->Timing.sampleHitArray)
#endif

#ifndef rtmSetSampleHitArray
#define rtmSetSampleHitArray(rtm, val) ((rtm)->Timing.sampleHitArray = (val))
#endif

#ifndef rtmGetSampleHitPtr
#define rtmGetSampleHitPtr(rtm)        ((rtm)->Timing.sampleHits)
#endif

#ifndef rtmSetSampleHitPtr
#define rtmSetSampleHitPtr(rtm, val)   ((rtm)->Timing.sampleHits = (val))
#endif

#ifndef rtmGetSampleTimeArray
#define rtmGetSampleTimeArray(rtm)     ((rtm)->Timing.sampleTimesArray)
#endif

#ifndef rtmSetSampleTimeArray
#define rtmSetSampleTimeArray(rtm, val) ((rtm)->Timing.sampleTimesArray = (val))
#endif

#ifndef rtmGetSampleTimePtr
#define rtmGetSampleTimePtr(rtm)       ((rtm)->Timing.sampleTimes)
#endif

#ifndef rtmSetSampleTimePtr
#define rtmSetSampleTimePtr(rtm, val)  ((rtm)->Timing.sampleTimes = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDArray
#define rtmGetSampleTimeTaskIDArray(rtm) ((rtm)->Timing.sampleTimeTaskIDArray)
#endif

#ifndef rtmSetSampleTimeTaskIDArray
#define rtmSetSampleTimeTaskIDArray(rtm, val) ((rtm)->Timing.sampleTimeTaskIDArray = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDPtr
#define rtmGetSampleTimeTaskIDPtr(rtm) ((rtm)->Timing.sampleTimeTaskIDPtr)
#endif

#ifndef rtmSetSampleTimeTaskIDPtr
#define rtmSetSampleTimeTaskIDPtr(rtm, val) ((rtm)->Timing.sampleTimeTaskIDPtr = (val))
#endif

#ifndef rtmGetSelf
#define rtmGetSelf(rtm)                ()
#endif

#ifndef rtmSetSelf
#define rtmSetSelf(rtm, val)           ()
#endif

#ifndef rtmGetSimMode
#define rtmGetSimMode(rtm)             ((rtm)->simMode)
#endif

#ifndef rtmSetSimMode
#define rtmSetSimMode(rtm, val)        ((rtm)->simMode = (val))
#endif

#ifndef rtmGetSimTimeStep
#define rtmGetSimTimeStep(rtm)         ((rtm)->Timing.simTimeStep)
#endif

#ifndef rtmSetSimTimeStep
#define rtmSetSimTimeStep(rtm, val)    ((rtm)->Timing.simTimeStep = (val))
#endif

#ifndef rtmGetStartTime
#define rtmGetStartTime(rtm)           ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetStartTime
#define rtmSetStartTime(rtm, val)      ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmGetStepSize
#define rtmGetStepSize(rtm)            ((rtm)->Timing.stepSize)
#endif

#ifndef rtmSetStepSize
#define rtmSetStepSize(rtm, val)       ((rtm)->Timing.stepSize = (val))
#endif

#ifndef rtmGetStopRequestedFlag
#define rtmGetStopRequestedFlag(rtm)   ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequestedFlag
#define rtmSetStopRequestedFlag(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetTaskCounters
#define rtmGetTaskCounters(rtm)        ()
#endif

#ifndef rtmSetTaskCounters
#define rtmSetTaskCounters(rtm, val)   ()
#endif

#ifndef rtmGetTaskTimeArray
#define rtmGetTaskTimeArray(rtm)       ((rtm)->Timing.tArray)
#endif

#ifndef rtmSetTaskTimeArray
#define rtmSetTaskTimeArray(rtm, val)  ((rtm)->Timing.tArray = (val))
#endif

#ifndef rtmGetTimePtr
#define rtmGetTimePtr(rtm)             ((rtm)->Timing.t)
#endif

#ifndef rtmSetTimePtr
#define rtmSetTimePtr(rtm, val)        ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTimingData
#define rtmGetTimingData(rtm)          ((rtm)->Timing.timingData)
#endif

#ifndef rtmSetTimingData
#define rtmSetTimingData(rtm, val)     ((rtm)->Timing.timingData = (val))
#endif

#ifndef rtmGetU
#define rtmGetU(rtm)                   ((rtm)->inputs)
#endif

#ifndef rtmSetU
#define rtmSetU(rtm, val)              ((rtm)->inputs = (val))
#endif

#ifndef rtmGetVarNextHitTimesListPtr
#define rtmGetVarNextHitTimesListPtr(rtm) ((rtm)->Timing.varNextHitTimesList)
#endif

#ifndef rtmSetVarNextHitTimesListPtr
#define rtmSetVarNextHitTimesListPtr(rtm, val) ((rtm)->Timing.varNextHitTimesList = (val))
#endif

#ifndef rtmGetY
#define rtmGetY(rtm)                   ((rtm)->outputs)
#endif

#ifndef rtmSetY
#define rtmSetY(rtm, val)              ((rtm)->outputs = (val))
#endif

#ifndef rtmGetZCCacheNeedsReset
#define rtmGetZCCacheNeedsReset(rtm)   ((rtm)->zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
#define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetZCSignalValues
#define rtmGetZCSignalValues(rtm)      ((rtm)->zcSignalValues)
#endif

#ifndef rtmSetZCSignalValues
#define rtmSetZCSignalValues(rtm, val) ((rtm)->zcSignalValues = (val))
#endif

#ifndef rtmGet_TimeOfLastOutput
#define rtmGet_TimeOfLastOutput(rtm)   ((rtm)->Timing.timeOfLastOutput)
#endif

#ifndef rtmSet_TimeOfLastOutput
#define rtmSet_TimeOfLastOutput(rtm, val) ((rtm)->Timing.timeOfLastOutput = (val))
#endif

#ifndef rtmGetdX
#define rtmGetdX(rtm)                  ((rtm)->derivs)
#endif

#ifndef rtmSetdX
#define rtmSetdX(rtm, val)             ((rtm)->derivs = (val))
#endif

#ifndef rtmGettimingBridge
#define rtmGettimingBridge(rtm)        ()
#endif

#ifndef rtmSettimingBridge
#define rtmSettimingBridge(rtm, val)   ()
#endif

#ifndef rtmGetChecksumVal
#define rtmGetChecksumVal(rtm, idx)    ((rtm)->Sizes.checksums[idx])
#endif

#ifndef rtmSetChecksumVal
#define rtmSetChecksumVal(rtm, idx, val) ((rtm)->Sizes.checksums[idx] = (val))
#endif

#ifndef rtmGetDWork
#define rtmGetDWork(rtm, idx)          ((rtm)->dwork[idx])
#endif

#ifndef rtmSetDWork
#define rtmSetDWork(rtm, idx, val)     ((rtm)->dwork[idx] = (val))
#endif

#ifndef rtmGetOffsetTime
#define rtmGetOffsetTime(rtm, idx)     ((rtm)->Timing.offsetTimes[idx])
#endif

#ifndef rtmSetOffsetTime
#define rtmSetOffsetTime(rtm, idx, val) ((rtm)->Timing.offsetTimes[idx] = (val))
#endif

#ifndef rtmGetSFunction
#define rtmGetSFunction(rtm, idx)      ((rtm)->childSfunctions[idx])
#endif

#ifndef rtmSetSFunction
#define rtmSetSFunction(rtm, idx, val) ((rtm)->childSfunctions[idx] = (val))
#endif

#ifndef rtmGetSampleTime
#define rtmGetSampleTime(rtm, idx)     ((rtm)->Timing.sampleTimes[idx])
#endif

#ifndef rtmSetSampleTime
#define rtmSetSampleTime(rtm, idx, val) ((rtm)->Timing.sampleTimes[idx] = (val))
#endif

#ifndef rtmGetSampleTimeTaskID
#define rtmGetSampleTimeTaskID(rtm, idx) ((rtm)->Timing.sampleTimeTaskIDPtr[idx])
#endif

#ifndef rtmSetSampleTimeTaskID
#define rtmSetSampleTimeTaskID(rtm, idx, val) ((rtm)->Timing.sampleTimeTaskIDPtr[idx] = (val))
#endif

#ifndef rtmGetVarNextHitTimeList
#define rtmGetVarNextHitTimeList(rtm, idx) ((rtm)->Timing.varNextHitTimesList[idx])
#endif

#ifndef rtmSetVarNextHitTimeList
#define rtmSetVarNextHitTimeList(rtm, idx, val) ((rtm)->Timing.varNextHitTimesList[idx] = (val))
#endif

#ifndef rtmIsContinuousTask
#define rtmIsContinuousTask(rtm, tid)  0
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmIsSampleHit
#define rtmIsSampleHit(rtm, sti, tid)  ((rtm)->Timing.sampleHits[(rtm)->Timing.sampleTimeTaskIDPtr[sti]])
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmSetT
#define rtmSetT(rtm, val)                                        /* Do Nothing */
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetTFinal
#define rtmSetTFinal(rtm, val)         ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                ((rtm)->Timing.t)
#endif

#ifndef rtmSetTPtr
#define rtmSetTPtr(rtm, val)           ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTStart
#define rtmGetTStart(rtm)              ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetTStart
#define rtmSetTStart(rtm, val)         ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmGetTaskTime
#define rtmGetTaskTime(rtm, sti)       (rtmGetTPtr((rtm))[(rtm)->Timing.sampleTimeTaskIDPtr[sti]])
#endif

#ifndef rtmSetTaskTime
#define rtmSetTaskTime(rtm, sti, val)  (rtmGetTPtr((rtm))[sti] = (val))
#endif

#ifndef rtmGetTimeOfLastOutput
#define rtmGetTimeOfLastOutput(rtm)    ((rtm)->Timing.timeOfLastOutput)
#endif

#ifdef rtmGetRTWSolverInfo
#undef rtmGetRTWSolverInfo
#endif

#define rtmGetRTWSolverInfo(rtm)       &((rtm)->solverInfo)

/* Definition for use in the target main file */
#define simulink_traverse_control_rtModel RT_MODEL_simulink_traverse_control_T

/* Block signals (default storage) */
typedef struct {
  real_T AnalogInput[5];               /* '<Root>/Analog Input' */
  real_T FT16810dev21[6];              /* '<Root>/FT16810, dev2.1' */
  real_T FT16811dev3[6];               /* '<Root>/FT16811, dev3' */
  real_T ctr1pitch1;                   /* '<Root>/ctr1 pitch1' */
  real_T ctr0heave1;                   /* '<Root>/ctr0 heave1' */
  real_T ctr1pitch2;                   /* '<Root>/ctr1 pitch2' */
  real_T ctr0heave2;                   /* '<Root>/ctr0 heave2' */
  real_T FromWorkspace4;               /* '<Root>/From Workspace4' */
} B_simulink_traverse_control_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T PrevY;                        /* '<Root>/Rate Limiter1' */
  real_T PrevY_n;                      /* '<Root>/Rate Limiter3' */
  real_T PrevY_k;                      /* '<Root>/Rate Limiter2' */
  real_T PrevY_a;                      /* '<Root>/Rate Limiter4' */
  void *AnalogInput_PWORK;             /* '<Root>/Analog Input' */
  void *FT16810dev21_PWORK;            /* '<Root>/FT16810, dev2.1' */
  void *FT16811dev3_PWORK;             /* '<Root>/FT16811, dev3' */
  void *ctr1pitch1_PWORK;              /* '<Root>/ctr1 pitch1' */
  void *ctr0heave1_PWORK;              /* '<Root>/ctr0 heave1' */
  void *ctr1pitch2_PWORK;              /* '<Root>/ctr1 pitch2' */
  void *ctr0heave2_PWORK;              /* '<Root>/ctr0 heave2' */
  struct {
    void *LoggedData;
  } ToWorkspace7_PWORK;                /* '<Root>/To Workspace7' */

  struct {
    void *LoggedData;
  } ToWorkspace8_PWORK;                /* '<Root>/To Workspace8' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspace_PWORK;               /* '<Root>/From Workspace' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspace1_PWORK;              /* '<Root>/From Workspace1' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspace4_PWORK;              /* '<Root>/From Workspace4' */

  struct {
    void *LoggedData;
  } ToWorkspace_PWORK;                 /* '<Root>/To Workspace' */

  struct {
    void *LoggedData;
  } ToWorkspace5_PWORK;                /* '<Root>/To Workspace5' */

  struct {
    void *LoggedData;
  } ToWorkspace6_PWORK;                /* '<Root>/To Workspace6' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspace2_PWORK;              /* '<Root>/From Workspace2' */

  struct {
    void *TimePtr;
    void *DataPtr;
    void *RSimInfoPtr;
  } FromWorkspace3_PWORK;              /* '<Root>/From Workspace3' */

  void *AnalogOutput_PWORK;            /* '<Root>/Analog Output' */
  void *AnalogOutput1_PWORK;           /* '<Root>/Analog Output1' */
  void *DigitalOutput_PWORK;           /* '<Root>/Digital Output' */
  void *y_control_signal_ctr0_out_PFI12_PWORK;
                                  /* '<Root>/y_control_signal_ctr0_out_PFI12' */
  void *theta_control_signal_ctr1_PFI13_PWORK;
                                  /* '<Root>/theta_control_signal_ctr1_PFI13' */
  struct {
    void *LoggedData;
  } ToWorkspace1_PWORK;                /* '<Root>/To Workspace1' */

  struct {
    void *LoggedData;
  } ToWorkspace2_PWORK;                /* '<Root>/To Workspace2' */

  struct {
    void *LoggedData;
  } ToWorkspace3_PWORK;                /* '<Root>/To Workspace3' */

  struct {
    void *LoggedData;
  } ToWorkspace4_PWORK;                /* '<Root>/To Workspace4' */

  struct {
    int_T PrevIndex;
  } FromWorkspace_IWORK;               /* '<Root>/From Workspace' */

  struct {
    int_T PrevIndex;
  } FromWorkspace1_IWORK;              /* '<Root>/From Workspace1' */

  struct {
    int_T PrevIndex;
  } FromWorkspace4_IWORK;              /* '<Root>/From Workspace4' */

  struct {
    int_T PrevIndex;
  } FromWorkspace2_IWORK;              /* '<Root>/From Workspace2' */

  struct {
    int_T PrevIndex;
  } FromWorkspace3_IWORK;              /* '<Root>/From Workspace3' */
} DW_simulink_traverse_control_T;

/* Backward compatible GRT Identifiers */
#define rtB                            simulink_traverse_control_B
#define BlockIO                        B_simulink_traverse_control_T
#define rtP                            simulink_traverse_control_P
#define Parameters                     P_simulink_traverse_control_T
#define rtDWork                        simulink_traverse_control_DW
#define D_Work                         DW_simulink_traverse_control_T

/* Parameters (default storage) */
struct P_simulink_traverse_control_T_ {
  real_T freq;                         /* Variable: freq
                                        * Referenced by: '<Root>/Conversion [V//m]'
                                        */
  real_T heave1;                       /* Variable: heave1
                                        * Referenced by: '<Root>/Conversion [V//m]'
                                        */
  real_T y_control_signal_ctr0_out_PFI12_Duty;
                         /* Mask Parameter: y_control_signal_ctr0_out_PFI12_Duty
                          * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
                          */
  real_T theta_control_signal_ctr1_PFI13_Duty;
                         /* Mask Parameter: theta_control_signal_ctr1_PFI13_Duty
                          * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
                          */
  real_T ctr1pitch1_InputFilter;       /* Mask Parameter: ctr1pitch1_InputFilter
                                        * Referenced by: '<Root>/ctr1 pitch1'
                                        */
  real_T ctr0heave1_InputFilter;       /* Mask Parameter: ctr0heave1_InputFilter
                                        * Referenced by: '<Root>/ctr0 heave1'
                                        */
  real_T ctr1pitch2_InputFilter;       /* Mask Parameter: ctr1pitch2_InputFilter
                                        * Referenced by: '<Root>/ctr1 pitch2'
                                        */
  real_T ctr0heave2_InputFilter;       /* Mask Parameter: ctr0heave2_InputFilter
                                        * Referenced by: '<Root>/ctr0 heave2'
                                        */
  real_T AnalogInput_MaxMissedTicks;
                                   /* Mask Parameter: AnalogInput_MaxMissedTicks
                                    * Referenced by: '<Root>/Analog Input'
                                    */
  real_T FT16810dev21_MaxMissedTicks;
                                  /* Mask Parameter: FT16810dev21_MaxMissedTicks
                                   * Referenced by: '<Root>/FT16810, dev2.1'
                                   */
  real_T FT16811dev3_MaxMissedTicks;
                                   /* Mask Parameter: FT16811dev3_MaxMissedTicks
                                    * Referenced by: '<Root>/FT16811, dev3'
                                    */
  real_T ctr1pitch1_MaxMissedTicks; /* Mask Parameter: ctr1pitch1_MaxMissedTicks
                                     * Referenced by: '<Root>/ctr1 pitch1'
                                     */
  real_T ctr0heave1_MaxMissedTicks; /* Mask Parameter: ctr0heave1_MaxMissedTicks
                                     * Referenced by: '<Root>/ctr0 heave1'
                                     */
  real_T ctr1pitch2_MaxMissedTicks; /* Mask Parameter: ctr1pitch2_MaxMissedTicks
                                     * Referenced by: '<Root>/ctr1 pitch2'
                                     */
  real_T ctr0heave2_MaxMissedTicks; /* Mask Parameter: ctr0heave2_MaxMissedTicks
                                     * Referenced by: '<Root>/ctr0 heave2'
                                     */
  real_T AnalogOutput_MaxMissedTicks;
                                  /* Mask Parameter: AnalogOutput_MaxMissedTicks
                                   * Referenced by: '<Root>/Analog Output'
                                   */
  real_T AnalogOutput1_MaxMissedTicks;
                                 /* Mask Parameter: AnalogOutput1_MaxMissedTicks
                                  * Referenced by: '<Root>/Analog Output1'
                                  */
  real_T DigitalOutput_MaxMissedTicks;
                                 /* Mask Parameter: DigitalOutput_MaxMissedTicks
                                  * Referenced by: '<Root>/Digital Output'
                                  */
  real_T y_control_signal_ctr0_out_PFI12_MaxMissedTicks;
               /* Mask Parameter: y_control_signal_ctr0_out_PFI12_MaxMissedTicks
                * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
                */
  real_T theta_control_signal_ctr1_PFI13_MaxMissedTicks;
               /* Mask Parameter: theta_control_signal_ctr1_PFI13_MaxMissedTicks
                * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
                */
  real_T AnalogInput_YieldWhenWaiting;
                                 /* Mask Parameter: AnalogInput_YieldWhenWaiting
                                  * Referenced by: '<Root>/Analog Input'
                                  */
  real_T FT16810dev21_YieldWhenWaiting;
                                /* Mask Parameter: FT16810dev21_YieldWhenWaiting
                                 * Referenced by: '<Root>/FT16810, dev2.1'
                                 */
  real_T FT16811dev3_YieldWhenWaiting;
                                 /* Mask Parameter: FT16811dev3_YieldWhenWaiting
                                  * Referenced by: '<Root>/FT16811, dev3'
                                  */
  real_T ctr1pitch1_YieldWhenWaiting;
                                  /* Mask Parameter: ctr1pitch1_YieldWhenWaiting
                                   * Referenced by: '<Root>/ctr1 pitch1'
                                   */
  real_T ctr0heave1_YieldWhenWaiting;
                                  /* Mask Parameter: ctr0heave1_YieldWhenWaiting
                                   * Referenced by: '<Root>/ctr0 heave1'
                                   */
  real_T ctr1pitch2_YieldWhenWaiting;
                                  /* Mask Parameter: ctr1pitch2_YieldWhenWaiting
                                   * Referenced by: '<Root>/ctr1 pitch2'
                                   */
  real_T ctr0heave2_YieldWhenWaiting;
                                  /* Mask Parameter: ctr0heave2_YieldWhenWaiting
                                   * Referenced by: '<Root>/ctr0 heave2'
                                   */
  real_T AnalogOutput_YieldWhenWaiting;
                                /* Mask Parameter: AnalogOutput_YieldWhenWaiting
                                 * Referenced by: '<Root>/Analog Output'
                                 */
  real_T AnalogOutput1_YieldWhenWaiting;
                               /* Mask Parameter: AnalogOutput1_YieldWhenWaiting
                                * Referenced by: '<Root>/Analog Output1'
                                */
  real_T DigitalOutput_YieldWhenWaiting;
                               /* Mask Parameter: DigitalOutput_YieldWhenWaiting
                                * Referenced by: '<Root>/Digital Output'
                                */
  real_T y_control_signal_ctr0_out_PFI12_YieldWhenWaiting;
             /* Mask Parameter: y_control_signal_ctr0_out_PFI12_YieldWhenWaiting
              * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
              */
  real_T theta_control_signal_ctr1_PFI13_YieldWhenWaiting;
             /* Mask Parameter: theta_control_signal_ctr1_PFI13_YieldWhenWaiting
              * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
              */
  int32_T DigitalOutput_BitMode;       /* Mask Parameter: DigitalOutput_BitMode
                                        * Referenced by: '<Root>/Digital Output'
                                        */
  int32_T AnalogInput_Channels[5];     /* Mask Parameter: AnalogInput_Channels
                                        * Referenced by: '<Root>/Analog Input'
                                        */
  int32_T FT16810dev21_Channels[6];    /* Mask Parameter: FT16810dev21_Channels
                                        * Referenced by: '<Root>/FT16810, dev2.1'
                                        */
  int32_T FT16811dev3_Channels[6];     /* Mask Parameter: FT16811dev3_Channels
                                        * Referenced by: '<Root>/FT16811, dev3'
                                        */
  int32_T ctr1pitch1_Channels;         /* Mask Parameter: ctr1pitch1_Channels
                                        * Referenced by: '<Root>/ctr1 pitch1'
                                        */
  int32_T ctr0heave1_Channels;         /* Mask Parameter: ctr0heave1_Channels
                                        * Referenced by: '<Root>/ctr0 heave1'
                                        */
  int32_T ctr1pitch2_Channels;         /* Mask Parameter: ctr1pitch2_Channels
                                        * Referenced by: '<Root>/ctr1 pitch2'
                                        */
  int32_T ctr0heave2_Channels;         /* Mask Parameter: ctr0heave2_Channels
                                        * Referenced by: '<Root>/ctr0 heave2'
                                        */
  int32_T AnalogOutput_Channels;       /* Mask Parameter: AnalogOutput_Channels
                                        * Referenced by: '<Root>/Analog Output'
                                        */
  int32_T AnalogOutput1_Channels;      /* Mask Parameter: AnalogOutput1_Channels
                                        * Referenced by: '<Root>/Analog Output1'
                                        */
  int32_T DigitalOutput_Channels;      /* Mask Parameter: DigitalOutput_Channels
                                        * Referenced by: '<Root>/Digital Output'
                                        */
  int32_T y_control_signal_ctr0_out_PFI12_Channels;
                     /* Mask Parameter: y_control_signal_ctr0_out_PFI12_Channels
                      * Referenced by: '<Root>/y_control_signal_ctr0_out_PFI12'
                      */
  int32_T theta_control_signal_ctr1_PFI13_Channels;
                     /* Mask Parameter: theta_control_signal_ctr1_PFI13_Channels
                      * Referenced by: '<Root>/theta_control_signal_ctr1_PFI13'
                      */
  int32_T AnalogInput_RangeMode;       /* Mask Parameter: AnalogInput_RangeMode
                                        * Referenced by: '<Root>/Analog Input'
                                        */
  int32_T FT16810dev21_RangeMode;      /* Mask Parameter: FT16810dev21_RangeMode
                                        * Referenced by: '<Root>/FT16810, dev2.1'
                                        */
  int32_T FT16811dev3_RangeMode;       /* Mask Parameter: FT16811dev3_RangeMode
                                        * Referenced by: '<Root>/FT16811, dev3'
                                        */
  int32_T AnalogOutput_RangeMode;      /* Mask Parameter: AnalogOutput_RangeMode
                                        * Referenced by: '<Root>/Analog Output'
                                        */
  int32_T AnalogOutput1_RangeMode;    /* Mask Parameter: AnalogOutput1_RangeMode
                                       * Referenced by: '<Root>/Analog Output1'
                                       */
  int32_T AnalogInput_VoltRange;       /* Mask Parameter: AnalogInput_VoltRange
                                        * Referenced by: '<Root>/Analog Input'
                                        */
  int32_T FT16810dev21_VoltRange;      /* Mask Parameter: FT16810dev21_VoltRange
                                        * Referenced by: '<Root>/FT16810, dev2.1'
                                        */
  int32_T FT16811dev3_VoltRange;       /* Mask Parameter: FT16811dev3_VoltRange
                                        * Referenced by: '<Root>/FT16811, dev3'
                                        */
  int32_T AnalogOutput_VoltRange;      /* Mask Parameter: AnalogOutput_VoltRange
                                        * Referenced by: '<Root>/Analog Output'
                                        */
  int32_T AnalogOutput1_VoltRange;    /* Mask Parameter: AnalogOutput1_VoltRange
                                       * Referenced by: '<Root>/Analog Output1'
                                       */
  real_T MANUALOFFSETP1_Value;         /* Expression: 0
                                        * Referenced by: '<Root>/MANUAL OFFSET P1'
                                        */
  real_T RateLimiter1_RisingLim;       /* Expression: 15
                                        * Referenced by: '<Root>/Rate Limiter1'
                                        */
  real_T RateLimiter1_FallingLim;      /* Expression: -15
                                        * Referenced by: '<Root>/Rate Limiter1'
                                        */
  real_T RateLimiter1_IC;              /* Expression: 0
                                        * Referenced by: '<Root>/Rate Limiter1'
                                        */
  real_T ConversionVdeg_Gain;          /* Expression: 5*0.022222
                                        * Referenced by: '<Root>/Conversion [V//deg]'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 10
                                        * Referenced by: '<Root>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: -10
                                        * Referenced by: '<Root>/Saturation'
                                        */
  real_T MANUALOFFSETH1_Value;         /* Expression: 0
                                        * Referenced by: '<Root>/MANUAL OFFSET H1'
                                        */
  real_T RateLimiter3_RisingLim;       /* Expression: 0.05
                                        * Referenced by: '<Root>/Rate Limiter3'
                                        */
  real_T RateLimiter3_FallingLim;      /* Expression: -0.05
                                        * Referenced by: '<Root>/Rate Limiter3'
                                        */
  real_T RateLimiter3_IC;              /* Expression: 0
                                        * Referenced by: '<Root>/Rate Limiter3'
                                        */
  real_T Saturation1_UpperSat;         /* Expression: 10
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  real_T Saturation1_LowerSat;         /* Expression: -10
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  real_T MANUALOFFSETH2_Value;         /* Expression: 0
                                        * Referenced by: '<Root>/MANUAL OFFSET H2'
                                        */
  real_T RateLimiter2_RisingLim;       /* Expression: 0.05
                                        * Referenced by: '<Root>/Rate Limiter2'
                                        */
  real_T RateLimiter2_FallingLim;      /* Expression: -0.05
                                        * Referenced by: '<Root>/Rate Limiter2'
                                        */
  real_T RateLimiter2_IC;              /* Expression: 0
                                        * Referenced by: '<Root>/Rate Limiter2'
                                        */
  real_T y_calibHzm_Gain;              /* Expression: 10000
                                        * Referenced by: '<Root>/y_calib [Hz//m]'
                                        */
  real_T y_calib_biasHz_Bias;          /* Expression: 5000
                                        * Referenced by: '<Root>/y_calib_bias [Hz]'
                                        */
  real_T Saturation2_UpperSat;         /* Expression: 10000
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  real_T Saturation2_LowerSat;         /* Expression: 5000
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  real_T MANUALOFFSETP2_Value;         /* Expression: 0
                                        * Referenced by: '<Root>/MANUAL OFFSET P2'
                                        */
  real_T RateLimiter4_RisingLim;       /* Expression: 15
                                        * Referenced by: '<Root>/Rate Limiter4'
                                        */
  real_T RateLimiter4_FallingLim;      /* Expression: -15
                                        * Referenced by: '<Root>/Rate Limiter4'
                                        */
  real_T RateLimiter4_IC;              /* Expression: 0
                                        * Referenced by: '<Root>/Rate Limiter4'
                                        */
  real_T theta_calibHzdeg_Gain;        /* Expression: 13.8889
                                        * Referenced by: '<Root>/theta_calib [Hz//deg]'
                                        */
  real_T theta_calib_biasHz_Bias;      /* Expression: 5000
                                        * Referenced by: '<Root>/theta_calib_bias [Hz]'
                                        */
  real_T Saturation3_UpperSat;         /* Expression: 9200
                                        * Referenced by: '<Root>/Saturation3'
                                        */
  real_T Saturation3_LowerSat;         /* Expression: 5000
                                        * Referenced by: '<Root>/Saturation3'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_simulink_traverse_control_T {
  const char_T *path;
  const char_T *modelName;
  struct SimStruct_tag * *childSfunctions;
  const char_T *errorStatus;
  SS_SimMode simMode;
  RTWExtModeInfo *extModeInfo;
  RTWSolverInfo solverInfo;
  RTWSolverInfo *solverInfoPtr;
  void *sfcnInfo;
  void *blockIO;
  const void *constBlockIO;
  void *defaultParam;
  ZCSigState *prevZCSigState;
  real_T *contStates;
  int_T *periodicContStateIndices;
  real_T *periodicContStateRanges;
  real_T *derivs;
  void *zcSignalValues;
  void *inputs;
  void *outputs;
  boolean_T *contStateDisabled;
  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;
  void *dwork;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
    uint32_T options;
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numU;
    int_T numY;
    int_T numSampTimes;
    int_T numBlocks;
    int_T numBlockIO;
    int_T numBlockPrms;
    int_T numDwork;
    int_T numSFcnPrms;
    int_T numSFcns;
    int_T numIports;
    int_T numOports;
    int_T numNonSampZCs;
    int_T sysDirFeedThru;
    int_T rtwGenSfcn;
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
    void *xpcData;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T stepSize;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    time_T tStart;
    time_T tFinal;
    time_T timeOfLastOutput;
    void *timingData;
    real_T *varNextHitTimesList;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *sampleTimes;
    time_T *offsetTimes;
    int_T *sampleTimeTaskIDPtr;
    int_T *sampleHits;
    int_T *perTaskSampleHits;
    time_T *t;
    time_T sampleTimesArray[1];
    time_T offsetTimesArray[1];
    int_T sampleTimeTaskIDArray[1];
    int_T sampleHitArray[1];
    int_T perTaskSampleHitsArray[1];
    time_T tArray[1];
  } Timing;
};

/* Block parameters (default storage) */
extern P_simulink_traverse_control_T simulink_traverse_control_P;

/* Block signals (default storage) */
extern B_simulink_traverse_control_T simulink_traverse_control_B;

/* Block states (default storage) */
extern DW_simulink_traverse_control_T simulink_traverse_control_DW;

/* Model entry point functions */
extern void simulink_traverse_control_initialize(void);
extern void simulink_traverse_control_output(void);
extern void simulink_traverse_control_update(void);
extern void simulink_traverse_control_terminate(void);

/*====================*
 * External functions *
 *====================*/
extern simulink_traverse_control_rtModel *simulink_traverse_control(void);
extern void MdlInitializeSizes(void);
extern void MdlInitializeSampleTimes(void);
extern void MdlInitialize(void);
extern void MdlStart(void);
extern void MdlOutputs(int_T tid);
extern void MdlUpdate(int_T tid);
extern void MdlTerminate(void);

/* Real-time Model object */
extern RT_MODEL_simulink_traverse_control_T *const simulink_traverse_control_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'simulink_traverse_control'
 */
#endif                             /* RTW_HEADER_simulink_traverse_control_h_ */
