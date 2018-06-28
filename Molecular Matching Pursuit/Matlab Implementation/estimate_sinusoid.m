function est_dct = estimate_sinusoid(dctCoeff, S, k, L)
    dk = dctCoeff(k);
    if k>1
        dkm1 = dctCoeff(k-1);
    else
        dkm1 = 0;
    end
    if k<L/2
        dkp1 = dctCoeff(k+1);
    else
        dkp1 = 0;
    end
    
    alpha = dkm1/dkp1;
    if alpha ~= 1
        epsilon = (3 + alpha - sqrt(alpha^2+14*alpha+1))/(2*(1-alpha));
    else 
        epsilon = 0.5;
    end
    
    f = epsilon + k;
    
    tanPsi = (dkm1/dk)*(epsilon - 1)/(epsilon + 1);
    phi = atan(tanPsi) - (pi/2)*k - pi*(L-1)*f/(2*L) + pi/4;
    
    Asq = (epsilon - 1)^2*(epsilon^2*dk^2 + (epsilon-2)^2*dkp1^2)*2*pi^2....
        /(L^2*sin(pi*epsilon)^2);
    A = sqrt(Asq);
    
    seg = (A*sin((f*pi/L)*[1:L] + phi).*sin(2*pi*[1:L]/(2*L)))';
    y = [-seg(3*L/4:-1:L/2+1)-seg(3*L/4+1:L); ...
                    seg(1:L/4)-seg(L/2:-1:L/4+1)];
    est_dct = dct(y, 'Type', 4);
end