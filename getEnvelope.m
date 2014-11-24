function ampEnv = getEnvelope(audioFile, SR)
% Compute loudness envelope

SignalInfo = nbt_Info;
SignalInfo.converted_sample_frequency = SR; 

hp = 0.1;
lp = 10;
ampEnv = nbt_GetAmplitudeEnvelope(audioFile, SignalInfo, hp, lp, 2/hp);

end