function [val] = getRaByKy_Y(rule,rg,a_min_range, a_max_range, b_min_range, b_max_range, binnodes)
[weights, x] = getRule(rule);

sum = 0;

for i = 1:rule
   
    [a_dt_mult, a_value] = transformVariable(a_min_range, a_max_range, x(i));
    for j = 1:rule
        [b_dt_mult, b_value] = transformVariable(b_min_range, b_max_range, x(j));
        delRgByDelA = getRgDelByDelA(rg,a_value,b_value);
        delRgByDelB = getRgDelByDelB(rg,a_value,b_value);
        
        kx = delRgByDelA(1); ky = delRgByDelA(2);
        lx = delRgByDelB(1); ly = delRgByDelB(2);
        
        numer = ((2*ky)*(((kx*ly) - (ky*lx))^2)) + (lx*((kx*kx)+(ky*ky))*((kx*ly) - (ky*lx)));
        denom = (((kx*ly) - (ky*lx))^2)*(abs((kx*ly)-(ky*lx)));
        
        delKByDelY = getDelKByDelX_1(binnodes,b_value);
        
        sum = sum + ((weights(i)*weights(j)*a_dt_mult*b_dt_mult*numer*delKByDelY)/denom);
    end
end

val = sum;
