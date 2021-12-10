function sensorModel(gain, prnu, dsnu, read, dark, scene)

analog_offset = 3.585e-3;
exposure_time = 0.007;

% create scene 
ieInit;
wave = 400:10:700;
patchSize = 64;

% model one scene at a time
if scene == "uniform"
    scene = sceneCreate('uniformd65',patchSize,wave);
else
    scene = sceneCreate('macbeth',patchSize,wave); 
end

oi = oiCreate;
oi = oiSet(oi,'optics fnumber',1.7);
oi = oiSet(oi,'optics offaxis method','cos4th');
oi = oiSet(oi,'optics focal length',24e-3);
oi = oiCompute(oi,scene);
oiWindow(oi);

sensor = sensorCreate('imx363');
sensor = sensorSet(sensor,'rows',3024);
sensor = sensorSet(sensor,'cols',4032);
sensor = sensorSet(sensor,'pixel read noise volts',read); 
sensor = sensorSet(sensor,'dsnu level',dsnu);  
sensor = sensorSet(sensor,'prnu level',prnu);
sensor = sensorSet(sensor,'analog gain',gain);
sensor = sensorSet(sensor,'analog offset',analog_offset);
sensor = sensorSet(sensor,'pixel dark voltage',dark);
sensor = sensorSet(sensor,'exposure time',exposure_time);

sensor = sensorCompute(sensor,oi);
sensorWindow(sensor);

ip = ipCreate;
ip = ipSet(ip,'name','Unbalanced');
ip = ipSet(ip,'scale display',1);
ip = ipCompute(ip,sensor);
ieAddObject(ip); 
ipWindow
