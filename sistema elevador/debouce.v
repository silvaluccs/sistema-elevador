// modulo com o debouce para remover o ruido do botao

module debouce(ruido, clock, sem_ruido);
 input ruido, clock;
 output sem_ruido;
 
 wire Q0, Q1, not_Q1;
 
 FF_d d0(Q0, clock, ruido);
 FF_d d1(Q1, clock, d0);
 
 not notQ1(not_Q1, Q1);
 
 and and0(sem_ruido, not_Q1, Q0);
endmodule 