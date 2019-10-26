format compact
format long
clc; clear;%#ok<*NO4LP>

 mass = 16/2.205;
 gravity = 9.81;
 drag = .5;
 rho = 1.29;
 radius = .12;
 area = pi*radius^2;
 initialHeight = 440;

 n = 50000;
 dt = 0.005;
 
 position = zeros(1,n);
 actualverticleposition=zeros(1,n);
 velocity = zeros(1,n);
 actualvelocity = zeros(1,n);
 accleration =zeros (1,n);
 time = zeros(1,n);
 position(1)=initialHeight;
 

 for i=2:n
     time(i)=(i-1)*dt;
     velocity(i) = velocity(i-1)+accleration(i-1)*dt;
     accleration(i) = -gravity +((drag*rho*area)/(2*mass))*(velocity(i)^2);
     position(i) = position(i-1)+velocity(i-1)*dt;
 end
 
 %Exercise 2:Accuracy of Computational Model: Velocity vs. Time

 for i=2:n
  actualvelocity(i-1) = (sqrt((2*mass*gravity)/(drag*area)))*tanh(sqrt((drag*area*gravity)/(2*mass))*time(i-1));
 end
 
 %Exercise 3:Accuracy of Computational Model: Position vs. Time
for i = 2:n
    actualverticleposition(i-1) = 440-(((2*mass)/(drag*area))*reallog(cosh(sqrt((drag*area*gravity)/(2*mass))*time(i-1))));
end
 
 %Exercise 4:Position and Velocity of Dropped Bowling Ball
 figure
    subplot(2,1,1)
        plot(time,position)
        title('Position vs. Time')
        xlabel('Time (s)')
        ylabel('Position (m)')
        ylim([0 440]);
    subplot (2,1,2)
        plot(time, velocity)
        title('Velocity vs. Time')
        xlabel('Time (s)')
        ylabel('Velocity (m/s)') 
        xlim([0 30]);
 %Exercise 5:Position and Velocity of a Dropped Mystery Sphere
 mass2=1000;
 radius2=.5;
 area2 = pi*radius2^2;
 
 position2 = zeros(1,n);
 velocity2 = zeros(1,n);
 accleration2 =zeros (1,n);
 position2(1)=initialHeight;
 
  for i=2:n
     time(i)=(i-1)*dt;
     velocity2(i) = velocity2(i-1)+accleration2(i-1)*dt;
     accleration2(i) = -gravity +((drag*rho*area2)/(2*mass2))*(velocity2(i)^2);
     position2(i) = position2(i-1)+velocity2(i-1)*dt;
  end
 figure
    subplot(2,1,1)
        plot(time,position2)
        title('Position vs. Time')
        xlabel('Time (s)')
        ylabel('Position (m)')
        ylim([0 440]);
    subplot (2,1,2)
        plot(time, velocity2)
        title('Velocity vs. Time')
        xlabel('Time (s)')
        ylabel('Velocity (m/s)') 
        xlim([0 100]);
