function [ dfaExpL, dfaExpI, dfaExpR ] = LOAD(input)

[ ~, audioFile, SR, pitchesRawCell, onsets, key, tuningFreq ] = evalc('dataLoad(input)');
keyFreq = key2pitch(key, tuningFreq);
intervals = intervalCollectKey(pitchesRawCell, tuningFreq, keyFreq);

ampEnv = getEnvelope(audioFile, SR);
[ ~, dfaExpL ]    = evalc('compDFA(ampEnv, SR)');

[ intervalsS, ~ ] = getSpectrum(intervals, 2);
[ ~, dfaExpI ]    = evalc('compDFA(intervalsS, 10)');

[ rhythmS, ~ ]    = getSpectrum(onsets, 1);
[ ~, dfaExpR ]    = evalc('compDFA(rhythmS, 10)');