clc; clear;

n=8; % number of different n-values

n=zeros(1,n);  %declaration of arrays
error_LHR=zeros(1,n);
error_Trapezoid=zeros(1,n);
error_Simpson=zeros(1,n);

%limits of intigration
a=-1;
b=11;
I_exact=0.53063669784362589;
fcn = @(x) exp(-x/10)*sin(x); %anonymous function syntax

for j=1:n
    n(j)=10^j; %number of intervals of dx
    delta_x = (b-a)/n(j);

    I_LHR=0; %accumulated area

    %left hand rule
    for i=0:n(j)-1
    x=a+i*delta_x;
    I_LHR=I_LHR+delta_x*fcn(x);
    end
    error_LHR(j)=abs(I_exact-I_LHR);
    
     I_Trapezoid=0; %accumulated area
    %Simpson 1/3 rule
    for i=1:n(j)-1
    x=a+i*delta_x;
    I_Trapezoid=I_Trapezoid+delta_x*fcn(x);
    end
    I_Trapezoid=I_Trapezoid+fcn(a)*delta_x/2+fcn(b)*delta_x/2;
    error_Trapezoid(j)=abs(I_exact-I_Trapezoid);
    
    I_Simpson=0; %accumulated area
    %Simpson 1/3 rule
    for i=1:n(j)-1
    x=a+i*delta_x;
     if mod(i,2)==1% if true i wil be odd
      I_Simpson=I_Simpson+(4/3)*delta_x*fcn(x);
     else
      I_Simpson=I_Simpson+(2/3)*delta_x*fcn(x);  
     end
    end
    I_Simpson=I_Simpson+fcn(a)*delta_x/3+fcn(b)*delta_x/3;
    error_Simpson(j)=abs(I_exact-I_Simpson);
end

loglog(n,error_LHR,'-s',n,error_Trapezoid,'-d',n,error_Simpson,'-p')
legend({'Left Hand Rule','Trapezoid Rule', 'Simpson 1/3 Rule'},'Location',"eastoutside")
title('Error vs. n')
xlabel('Number of intervals of dx (n)')
ylabel('Error')
grid on;
