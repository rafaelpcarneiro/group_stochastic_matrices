# vim: foldmethod=marker : fdl=0
N = 3;
BASE = zeros(N, N, N*(N-1) );
k = 1;
for i = 1:N
	for j = 1:N
		if ( i != j)
			BASE(i,i,k) = -1;
			BASE(i,j,k) = 1;
			k++;
		endif
	endfor
endfor

N2 = N*(N-1);
#BASE = zeros (3,3,N2);
#BASE(:,:,1) = BASE2(:,:,3) ;
#BASE(:,:,2) = BASE2(:,:,4) ;
#BASE(:,:,3) = BASE2(:,:,5) ;
#BASE(:,:,4) = BASE2(:,:,6) ;
###########


## colchete
function ret = colchete (X, Y)
	ret = X*Y - Y*X;
endfunction

QTD    = N2*N2;   # quantidade de coeficientes do polinomio
QTD_EQ = (N**2)*(N**2)*N2; # quantidade de eq. do sist. linear

polinomio = zeros (N,2*N, QTD);  # inicializando o polinomio
alpha     = ones (N2,N2);       # inicializando os coeficientes do polinomio

for i = 1:N2
	for j = 1:N2
		k = j + (i-1)*N2;
		polinomio (:,:,k) = horzcat(BASE(:,:,i), BASE(:,:,j));
	endfor
endfor

# agora vamos tomar o colchete dos coef. do polinomio para X_1, X_2, X_3, ..., X_6
Colchete = zeros (N**2,N**2,QTD,N2);
for k=1:N2
	for i=1:QTD
			# [AB,C] = [A,C]B + A[B,C]
			A = polinomio(1:N,1:N, i);
			B = polinomio(1:N,(N+1):(2*N), i);
			C = BASE(:,:,k);
			Colchete(:,:,i,k) = kron( colchete(A,C), B) + kron( A, colchete(B, C) );
	endfor
endfor

# agora vamos resolver o sistema linear
X = zeros(QTD_EQ, QTD);

for k=1:N2
		for i=1:QTD
			X([1:((N**2)*(N**2))] + (k-1)*((N**2)*(N**2)), i) = (Colchete(:,:,i,k))(:);
		endfor
endfor

y = zeros(QTD_EQ,1);

#X\y;
solucao = rref ([X,y]); #escalona o sistema linear

sistema = fopen('resultado_v4.txt', 'w');
for k = 1:QTD_EQ
	Find_coef=0;
	for l=1:(QTD)
		if (solucao (k,l) != 0)
			Find_coef += 1;
			if (Find_coef == 1)
				x = idivide(l-1,N2) + 1;
				y = l - (idivide(l-1, N2)*N2 );
				alpha(x,y)=0;
			endif
			fprintf (sistema, '%i* alpha(%i, %i)  ', solucao(k,l), idivide(l-1, N2)+1, l - (idivide(l-1, N2)*N2 ));
		endif
		if (Find_coef > 1 && solucao(k,l) != 0)
			alpha(x,y) += -solucao(k,l)*...
			                alpha(idivide(l-1,N2) + 1, l - (idivide(l-1, N2)*N2 ));
		endif
	endfor
	fprintf (sistema, ' = %i \n\n', solucao(k,l+1))
endfor
fclose(sistema);

coproduto = zeros(N**2,N**2);
for i = 1:N2
	for j = 1:N2
		coproduto +=  alpha(i,j) * (kron(BASE(:,:,i) ,BASE(:,:,j)) + kron(BASE(:,:,j) ,BASE(:,:,i)) );
	endfor
endfor

disp (coproduto);
#sistema = fopen('resultado.txt', 'w');
#for k = 1:QTD_EQ
#	for l=1:(QTD)
#		if (solucao (k,l) != 0)
#			fprintf (sistema, '%i* alpha(%i, %i)  ', solucao(k,l), idivide(l-1, 6), l - (idivide(l-1, 6)*6 ));
#		endif
#	endfor
#	fprintf (sistema, ' = %i \n\n', solucao(k,l+1))
#endfor
#fclose(sistema);
##

#### checando os valore
#polinomio = zeros (3,3,7,6);  # inicializando o polinomio
#alpha      = round( 1000*rand (7,6) -5);       # inicializando os coeficientes do polinomio
#
##alpha(1,1)=-(-alpha(2,1)-alpha(2,3)-alpha(2,4)-alpha(3,1)+alpha(3,6)); 
##alpha(1,2)=-(-alpha(2,2)+alpha(2,4)-alpha(3,2)-alpha(3,5)-alpha(3,6));
##alpha(1,3)=-(-alpha(4,1)-alpha(4,2)-alpha(4,3)-alpha(5,3)+alpha(5,5));
##alpha(1,4)=-(+alpha(4,2)-alpha(4,4)-alpha(5,4)-alpha(5,5)-alpha(5,6));
##alpha(1,5)=-(-alpha(6,1)-alpha(6,2)-alpha(6,5)+alpha(7,3)-alpha(7,5));
##alpha(1,6)=-(+alpha(6,1)-alpha(6,6)-alpha(7,3)-alpha(7,4)-alpha(7,6));
#
# alpha(1,:)=zeros(1,6);
#alpha(2,1)=(-alpha(2,3)-alpha(2,4)-alpha(3,1)+alpha(3,6)); 
#alpha(2,2)=(+alpha(2,4)-alpha(3,2)-alpha(3,5)-alpha(3,6));
#alpha(4,1)=(-alpha(4,2)-alpha(4,3)-alpha(5,3)+alpha(5,5));
#alpha(4,4)=(+alpha(4,2)-alpha(5,4)-alpha(5,5)-alpha(5,6));
#alpha(6,2)=(-alpha(6,1)-alpha(6,5)+alpha(7,3)-alpha(7,5));
#alpha(6,6)=(+alpha(6,1)-alpha(7,3)-alpha(7,4)-alpha(7,6));
#
#
#casimir = zeros(3,3);
#for i = 1:7
#	for j = 1:6
#		polinomio (:,:,i, j) = alpha(i,j) * BASE2(:,:,i) * BASE(:,:,j);
#		polinomio (:,:,i, j) = alpha(i,j) * BASE2(:,:,i) * BASE(:,:,j);
#		casimir += polinomio(:,:,i,j);
#	endfor
#endfor
#disp (casimir);
### casimir da zero =(
###}}}
