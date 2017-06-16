function out = cnvFn(in)
   
    out = [1 0; 0 -1]*in + [-2600; 2600];
    
    out = out./1000;

end