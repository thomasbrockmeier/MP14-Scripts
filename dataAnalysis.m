HG={1,4,2/1,[1 20],[0.1 110],0.5,0,[],10};
try
    nbt_NBTcompute(@nbt_runDFA,'AutoICASignal','E:\Thomas\Data\toNBT\NBT',[],[],[],HG)
catch err
end

HG={4,8,2/4,[1 20],[0.1 110],0.5,0,[],10};
try
nbt_NBTcompute(@nbt_runDFA,'AutoICASignal','E:\Thomas\Data\toNBT\NBT',[],[],[],HG)
catch err
end

HG={8,13,2/8,[1 20],[0.1 110],0.5,0,[],10};
try
nbt_NBTcompute(@nbt_runDFA,'AutoICASignal','E:\Thomas\Data\toNBT\NBT',[],[],[],HG)
catch err
end

HG={13,30,2/13,[1 20],[0.1 110],0.5,0,[],10};
try
nbt_NBTcompute(@nbt_runDFA,'AutoICASignal','E:\Thomas\Data\toNBT\NBT',[],[],[],HG)
catch err
end

HG={30,45,2/30,[1 20],[0.1 110],0.5,0,[],10};
try
nbt_NBTcompute(@nbt_runDFA,'AutoICASignal','E:\Thomas\Data\toNBT\NBT',[],[],[],HG)
catch err
end

HG={55,125,2/55,[1 20],[0.1 110],0.5,0,[],10};
try
nbt_NBTcompute(@nbt_runDFA,'AutoICASignal','E:\Thomas\Data\toNBT\NBT',[],[],[],HG)
catch err
end

try
nbt_NBTcompute(@nbt_runAmplitudewHF,'AutoICASignal','E:\Thomas\Data\toNBT\NBT')
catch err
end