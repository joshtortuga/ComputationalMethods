format compact
format long
clc; clear;
close all
%https://courses.lumenlearning.com/boundless-physics/chapter/projectile-motion/
%Exercise 1,2, and 3

n = 100000;
time = zeros(1,n);
theta = 32.4;
dt = 0.001;
drag1 = .01;
drag2 = .5;
drag3 =1;
rho = 1.29;
mass = 3;
gravity = 9.8;
radius = .25;
area = pi*radius^2;
initialVelocity = 500;


xPosition = zeros(1,n);
yPosition = zeros(1,n);
magnitudeVelocity = zeros(1,n);
xVelocity = zeros(1,n);
yVelocity = zeros(1,n);
xaccleration = zeros(1,n);
yaccleration = zeros(1,n);

xPosition(1) = 0;
yPosition(1) = 0;
xVelocity(1) = initialVelocity*cos(deg2rad(theta));
yVelocity(1) = initialVelocity*sin(deg2rad(theta));
magnitudeVelocity(1) = initialVelocity;
xaccleration(1) = - ((drag1*area*rho*(magnitudeVelocity(1))*xVelocity(1))/(2*mass));
yaccleration(1) = -gravity - ((drag1*area*rho*(magnitudeVelocity(1))*yVelocity(1))/(2*mass));


xPosition2 = zeros(1,n);
yPosition2 = zeros(1,n);
magnitudeVelocity2 = zeros(1,n);
xVelocity2 = zeros(1,n);
yVelocity2 = zeros(1,n);
xaccleration2 = zeros(1,n);
yaccleration2 = zeros(1,n);

xPosition2(1) = 0;
yPosition2(1) = 0;
xVelocity2(1) = initialVelocity*cos(deg2rad(theta));
yVelocity2(1) = initialVelocity*sin(deg2rad(theta));
magnitudeVelocity2(1) = initialVelocity;
xaccleration2(1) = - ((drag2*area*rho*(magnitudeVelocity(1))*xVelocity(1))/(2*mass));
yaccleration2(1) = -gravity - ((drag2*area*rho*(magnitudeVelocity(1))*yVelocity(1))/(2*mass));


xPosition3 = zeros(1,n);
yPosition3 = zeros(1,n);
magnitudeVelocity3 = zeros(1,n);
xVelocity3 = zeros(1,n);
yVelocity3 = zeros(1,n);
xaccleration3 = zeros(1,n);
yaccleration3 = zeros(1,n);

xPosition3(1) = 0;
yPosition3(1) = 0;
xVelocity3(1) = initialVelocity*cos(deg2rad(theta));
yVelocity3(1) = initialVelocity*sin(deg2rad(theta));
magnitudeVelocity3(1) = initialVelocity;
xaccleration3(1) = - ((drag3*area*rho*(magnitudeVelocity(1))*xVelocity(1))/(2*mass));
yaccleration3(1) = -gravity - ((drag3*area*rho*(magnitudeVelocity(1))*yVelocity(1))/(2*mass));


for i=3:n+1
    time(i-1)=(i-1)*dt;
    
    magnitudeVelocity(i-1) = sqrt((xVelocity(i-2))^2+(yVelocity(i-2))^2);
    yaccleration(i-1) = -gravity - ((drag1*area*rho*(magnitudeVelocity(i-2))*yVelocity(i-2))/(2*mass));
    xaccleration(i-1) = - ((drag1*area*rho*(magnitudeVelocity(i-2))*xVelocity(i-2))/(2*mass));
    
    yVelocity(i-1) = (yVelocity(i-2))+yaccleration(i-2)*dt;
    xVelocity(i-1) = (xVelocity(i-2))+xaccleration(i-2)*dt;
    
    yPosition(i-1) = (yPosition(i-2))+yVelocity(i-1)*dt;
    xPosition(i-1) = (xPosition(i-2))+xVelocity(i-1)*dt;
    
    
    magnitudeVelocity2(i-1) = sqrt((xVelocity2(i-2))^2+(yVelocity2(i-2))^2);
    yaccleration2(i-1) = -gravity - ((drag2*area*rho*(magnitudeVelocity2(i-2))*yVelocity2(i-2))/(2*mass));
    xaccleration2(i-1) = - ((drag2*area*rho*(magnitudeVelocity2(i-2))*xVelocity2(i-2))/(2*mass));
    
    yVelocity2(i-1) = (yVelocity2(i-2))+yaccleration2(i-2)*dt;
    xVelocity2(i-1) = (xVelocity2(i-2))+xaccleration2(i-2)*dt;
    
    yPosition2(i-1) = (yPosition2(i-2))+yVelocity2(i-1)*dt;
    xPosition2(i-1) = (xPosition2(i-2))+xVelocity2(i-1)*dt;
    
    
    magnitudeVelocity3(i-1) = sqrt((xVelocity3(i-2))^2+(yVelocity3(i-2))^2);
    yaccleration3(i-1) = -gravity - ((drag3*area*rho*(magnitudeVelocity3(i-2))*yVelocity3(i-2))/(2*mass));
    xaccleration3(i-1) = - ((drag3*area*rho*(magnitudeVelocity3(i-2))*xVelocity3(i-2))/(2*mass));
    
    yVelocity3(i-1) = (yVelocity3(i-2))+yaccleration3(i-2)*dt;
    xVelocity3(i-1) = (xVelocity3(i-2))+xaccleration3(i-2)*dt;
    
    yPosition3(i-1) = (yPosition3(i-2))+yVelocity3(i-1)*dt;
    xPosition3(i-1) = (xPosition3(i-2))+xVelocity3(i-1)*dt;
    
    
end

figure 
       plot(xPosition,yPosition,xPosition2,yPosition2,xPosition3,yPosition3)
        title('Trajectory')
        xlabel('X Position (m)')
        ylabel('Y Position (m)')
        xlim([0 300])
        ylim([0 200])
        
figure 
       plot(xPosition2,yPosition2)
        title('Trajectory')
        xlabel('X Position (m)')
        ylabel('Y Position (m)')
        xlim([0 200])
        ylim([0 100])

Z = 0.1;
[~,idx] = min(abs(Z-yPosition));
maxXDistance = xPosition(idx);

%exercise 4 and exercise 5

shellMass = 12247;
shellMagnitudeVelocity = 768;
diameter = .203*2;
firingAngle = 20;
c = .0065;
T= 300;
alpha = 2.5;
xshellArea = (pi*diameter^2)/4;
yshellarea = (diameter*1.31+.5*diameter*.52);
RhoAtSeaLevel = 1.2;
shelldrag = .283;

shellInitialXVelocity = shellMagnitudeVelocity*cos(deg2rad(firingAngle));
shellInitialYVelocity  = shellMagnitudeVelocity*sin(deg2rad(firingAngle));

xShellPosition = zeros(1,n);
yShellPosition = zeros(1,n);
magnitudeShellVelocity = zeros(1,n);
xShellVelocity = zeros(1,n);
yShellVelocity = zeros(1,n);
xShellAccleration = zeros(1,n);
yShellAccleration = zeros(1,n);
GunRho= zeros(1,n);

xShellPosition(1) = 0;
yShellPosition(1) = 0;
xShellVelocity(1) = shellInitialXVelocity;
yShellVelocity(1) = shellInitialYVelocity;
magnitudeShellVelocity(1) = sqrt((xShellVelocity(1))^2+(yShellVelocity(1))^2);
GunRho(1) = RhoAtSeaLevel*1^alpha;
yShellAccleration(1) = -gravity - ((shelldrag*yshellarea*GunRho(1)*(magnitudeShellVelocity(1))*yShellVelocity(1))/(2*shellMass));
xShellAccleration(1) = - ((shelldrag*xshellArea*GunRho(1)*(magnitudeShellVelocity(1))*xShellVelocity(1))/(2*shellMass));

for i = 3:n+1
    magnitudeShellVelocity(i-1) = sqrt((xShellVelocity(i-2))^2+(yShellVelocity(i-2))^2);
   
    yShellVelocity(i-1) = (yShellVelocity(i-2))+yShellAccleration(i-2)*dt;
    xShellVelocity(i-1) = (xShellVelocity(i-2))+xShellAccleration(i-2)*dt;
    
    yShellPosition(i-1) = (yShellPosition(i-2))+yShellVelocity(i-1)*dt;
    xShellPosition(i-1) = (xShellPosition(i-2))+xShellVelocity(i-1)*dt;
    
    if yShellPosition(i-1) >= 0
       GunRho(i-1) = RhoAtSeaLevel*(1-(c*yShellPosition(i-1)/300))^alpha; 
       yShellAccleration(i-1) = -gravity - ((shelldrag*yshellarea*GunRho(i-1)*(magnitudeShellVelocity(i-2))*yShellVelocity(i-2))/(2*shellMass));
       xShellAccleration(i-1) = - ((shelldrag*xshellArea*GunRho(i-1)*(magnitudeShellVelocity(i-2))*xShellVelocity(i-2))/(2*shellMass));  
    else
        break
    end
   MAXSHELL = max(xShellPosition); 
   MAXYSHELL = max(yShellPosition); 
end

figure
plot(xShellPosition,yShellPosition)
