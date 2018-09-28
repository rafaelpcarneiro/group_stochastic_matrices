# vim: foldmethod=marker
1;

######### Armazenando a base.

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
###########

## colchete
function ret = colchete (X, Y)
	ret = X*Y - Y*X;
endfunction

## Tentativa 1
## {{{
## C = sum_i (a_i * X_i)
#
### colchete X_1 com X_1, X_2, ..., X_6
#colchete_X1_base = zeros(3,3,6);
#for i = 1:6
#	colchete_X1_base (:,:,i) = colchete (BASE(:,:,1), BASE(:,:,i));
#endfor
#
### colchete X_2 com X_1, X_2, ..., X_6
#colchete_X2_base = zeros(3,3,6);
#for i = 1:6
#	colchete_X2_base (:,:,i) = colchete (BASE(:,:,2), BASE(:,:,i));
#endfor
#
### colchete X_3 com X_1, X_2, ..., X_6
#colchete_X3_base = zeros(3,3,6);
#for i = 1:6
#	colchete_X3_base (:,:,i) = colchete (BASE(:,:,3), BASE(:,:,i));
#endfor
#
### colchete X_4 com X_1, X_2, ..., X_6
#colchete_X4_base = zeros(3,3,6);
#for i = 1:6
#	colchete_X4_base (:,:,i) = colchete (BASE(:,:,4), BASE(:,:,i));
#endfor
#
### colchete X_5 com X_1, X_2, ..., X_6
#colchete_X5_base = zeros(3,3,6);
#for i = 1:6
#	colchete_X5_base (:,:,i) = colchete (BASE(:,:,5), BASE(:,:,i));
#endfor
#
### colchete X_6 com X_1, X_2, ..., X_6
#colchete_X6_base = zeros(3,3,6);
#for i = 1:6
#	colchete_X6_base (:,:,i) = colchete (BASE(:,:,6), BASE(:,:,i));
#endfor
#
#
#### tentando calcular o sistema linear
#X = zeros(54,6);
#
#aux1 = horzcat (	(colchete_X1_base(:,:,1))(:), ...
#					(colchete_X1_base(:,:,2))(:), ... 
#					(colchete_X1_base(:,:,3))(:), ...
#					(colchete_X1_base(:,:,4))(:), ...
#					(colchete_X1_base(:,:,5))(:), ...
#					(colchete_X1_base(:,:,6))(:) );
#
#aux2 = horzcat (	(colchete_X2_base(:,:,1))(:), ...
#					(colchete_X2_base(:,:,2))(:), ... 
#					(colchete_X2_base(:,:,3))(:), ...
#					(colchete_X2_base(:,:,4))(:), ...
#					(colchete_X2_base(:,:,5))(:), ...
#					(colchete_X2_base(:,:,6))(:) );
#
#aux3 = horzcat (	(colchete_X3_base(:,:,1))(:), ...
#					(colchete_X3_base(:,:,2))(:), ... 
#					(colchete_X3_base(:,:,3))(:), ...
#					(colchete_X3_base(:,:,4))(:), ...
#					(colchete_X3_base(:,:,5))(:), ...
#					(colchete_X3_base(:,:,6))(:) );
#
#aux4 = horzcat (	(colchete_X4_base(:,:,1))(:), ...
#					(colchete_X4_base(:,:,2))(:), ... 
#					(colchete_X4_base(:,:,3))(:), ...
#					(colchete_X4_base(:,:,4))(:), ...
#					(colchete_X4_base(:,:,5))(:), ...
#					(colchete_X4_base(:,:,6))(:) );
#
#aux5 = horzcat (	(colchete_X5_base(:,:,1))(:), ...
#					(colchete_X5_base(:,:,2))(:), ... 
#					(colchete_X5_base(:,:,3))(:), ...
#					(colchete_X5_base(:,:,4))(:), ...
#					(colchete_X5_base(:,:,5))(:), ...
#					(colchete_X5_base(:,:,6))(:) );
#
#aux6 = horzcat (	(colchete_X6_base(:,:,1))(:), ...
#					(colchete_X6_base(:,:,2))(:), ... 
#					(colchete_X6_base(:,:,3))(:), ...
#					(colchete_X6_base(:,:,4))(:), ...
#					(colchete_X6_base(:,:,5))(:), ...
#					(colchete_X6_base(:,:,6))(:) );
#
#
#X = [aux1; aux2; aux3; aux4; aux5; aux6];
#
## resolvendo o sistema linear
#y = zeros(54,1);
### resultado:
#X\y
### }}}


# Tentativa 2
#
####{{{
###### polinomio de grau 2
###### polinomio do tipo C = sum_{ij} (alpha(i,j) * X_i *X_j) (**)
######
###### onde:
###### i = 0, 1, 2, ..., 6
###### j = 1, 2, ..., 6
###### alpha(i,j) um numero real
###### X_i, X_j, elementos da base, representada por BASE
###### X_0 = I.
######
###### vamos definir o tipo de dado polinomio2 como nosso polinomio (**) acima.
###### Para isto, vamos estabelecer a convencao:
######
###### polinomio2 (i,j) = X_i * X_j para i = 0,1,2,...,6 e j = 1,2,...,6,
# 
#QTD    = 7*6 # quantidade de coeficientes do polinomio2
#QTD_EQ = 9*6 # quantidade de eq. do sist. linear
#
#polinomio2 = zeros (3,3,7,6);  # inicializando o polinomio2
##alpha      = ones (7,6);       # inicializando os coeficientes do polinomio2
#
#
#BASE2 = zeros (3,3,7); # cópia da base com a identidade no inicio, i.e., BASE2(:,:,1) = I.
#BASE2 (:,:,1) = eye(3);
#BASE2 (:,:,2:7) = BASE(:,:,:);
#
#
#for i = 1:7
#	for j = 1:6
#		#polinomio2 (:,:,i, j) = alpha(i,j) * BASE2(:,:,i) * BASE(:,:,j);
#		polinomio2 (:,:,i, j) = BASE2(:,:,i) * BASE(:,:,j);
#	endfor
#endfor
#
## agora vamos tomar o colchete dos coef. do polinomio2 para X_1, X_2, X_3, ..., X_6
#Colchete = zeros (3,3,7,6,6);
#for k=1:6
#	for i=1:7
#		for j=1:6
#			Colchete (:,:,i,j,k) = colchete (BASE(:,:,k), polinomio2(:,:,i,j));
#		endfor
#	endfor
#endfor
#
## agora vamos resolver o sistema linear
#X = zeros(QTD_EQ, QTD);
#
#for k=1:6
#	for i=1:7
#		for j=1:6
#			X([1:9] + (k-1)*9, j + (i-1)*6) = (Colchete(:,:,i,j,k))(:);
#		endfor
#	endfor
#endfor
#
#y = zeros(QTD_EQ,1);
#
##X\y;
#solucao = rref ([X,y]); #escalona o sistema linear
#
##sistema = fopen('resultado.txt', 'w');
##for k = 1:QTD_EQ
##	for l=1:(QTD)
##		if (solucao (k,l) != 0)
##			fprintf (sistema, '%i* alpha(%i, %i)  ', solucao(k,l), idivide(l-1, 6), l - (idivide(l-1, 6)*6 ));
##		endif
##	endfor
##	fprintf (sistema, ' = %i \n\n', solucao(k,l+1))
##endfor
##fclose(sistema);
###
#
#### checando os valore
#polinomio2 = zeros (3,3,7,6);  # inicializando o polinomio2
#alpha      = round( 1000*rand (7,6) -5);       # inicializando os coeficientes do polinomio2
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
#BASE2 = zeros (3,3,7); # cópia da base com a identidade no inicio, i.e., BASE2(:,:,1) = I.
#BASE2 (:,:,1) = eye(3);
#BASE2 (:,:,2:7) = BASE(:,:,:);
#
#casimir = zeros(3,3);
#for i = 1:7
#	for j = 1:6
#		polinomio2 (:,:,i, j) = alpha(i,j) * BASE2(:,:,i) * BASE(:,:,j);
#		polinomio2 (:,:,i, j) = alpha(i,j) * BASE2(:,:,i) * BASE(:,:,j);
#		casimir += polinomio2(:,:,i,j);
#	endfor
#endfor
#disp (casimir);
#### casimir da zero =(
####}}}
#

# Tentativa 3
##
####{{{
###### polinomio de grau 3
###### polinomio do tipo C = sum_{ijk} (alpha(i,j,k) * X_i *X_j *X_k) (**)
######
###### onde:
###### i = 0, 1, 2, ..., 6
###### j = 0, 1, 2, ..., 6
###### k = 1, 2, ..., 6
###### alpha(i,j,k) um numero real
###### X_i, X_j, X_k elementos da base, representada por BASE
###### X_0 = I.
######
###### vamos definir o tipo de dado polinomio2 como nosso polinomio (**) acima.
###### Para isto, vamos estabelecer a convencao:
######
###### polinomio2 (i,j) = X_i * X_j * X_k para i = 0,1,2,...,6 e j = 1,2,...,6,
# 
#QTD    = 7*7*6 # quantidade de coeficientes do polinomio2
#QTD_EQ = 9*6 # quantidade de eq. do sist. linear
#
#polinomio3 = zeros (3,3,7,7,6);  # inicializando o polinomio3
##alpha      = ones (7,7,6);       # inicializando os coeficientes do polinomio3
#
#
#BASE2 = zeros (3,3,7); # cópia da base com a identidade no inicio, i.e., BASE2(:,:,1) = I.
#BASE2 (:,:,1) = eye(3);
#BASE2 (:,:,2:7) = BASE(:,:,:);
#
#
#for i = 1:7
#	for j = 1:7
#		for k = 1:6
#			#polinomio2 (:,:,i, j) = alpha(i,j) * BASE2(:,:,i) * BASE(:,:,j);
#			polinomio3 (:,:,i, j, k) = BASE2(:,:,i) * BASE2(:,:,j) * BASE(:,:,k);
#		endfor
#	endfor
#endfor
#
## agora vamos tomar o colchete dos coef. do polinomio3 para X_1, X_2, X_3, ..., X_6
#Colchete = zeros (3,3,7,7,6,6);
#for l=1:6
#	for i=1:7
#		for j=1:7
#			for k=1:6
#				Colchete (:,:,i,j,k,l) = colchete (BASE(:,:,l), polinomio3(:,:,i,j,k));
#			endfor
#		endfor
#	endfor
#endfor
#
## agora vamos resolver o sistema linear
#X = zeros(QTD_EQ, QTD);
#
#for l=1:6
#	for i=1:7
#		for j=1:7
#			for k=1:6
#				X([1:9] + (l-1)*9, k + (j-1)*6 + (i-1)*7*6) = (Colchete(:,:,i,j,k,l))(:);
#			endfor
#		endfor
#	endfor
#endfor
#
#y = zeros(QTD_EQ,1);
#
##X\y;
#solucao = rref ([X,y]); #escalona o sistema linear
#
#alpha = round( 10*rand(7,7,6) -5 );
#
#sistema = fopen('resultado3.txt', 'w');
#for k = 1:QTD_EQ
#	Find_coef=0;
#	for l=1:(QTD)
#		if (solucao (k,l) != 0)
#			Find_coef += 1;
#			if (Find_coef == 1)
#				x = idivide(l-1,6*7) + 1;
#				y = idivide(l-1, 6) - idivide(l-1,6*7)*7 + 1;
#				z = l - (idivide(l-1, 6)*6 );
#				alpha(x,y,z)=0;
#			endif
#			fprintf (sistema, '%i* alpha(%i, %i, %i)  ', solucao(k,l),...
#   			 					 						 idivide(l-1,6*7),...
#   				 			 							 idivide(l-1, 6) - idivide(l-1,6*7)*7,...
#   						  								 l - (idivide(l-1, 6)*6 ));
#		endif
#		if (Find_coef > 1 && solucao(k,l) != 0)
#			alpha(x,y,z) += -solucao(k,l)*...
#			                alpha(idivide(l-1,6*7) + 1, idivide(l-1, 6) - idivide(l-1,6*7)*7 + 1, l - (idivide(l-1, 6)*6 ));
#		endif
#	endfor
#	fprintf (sistema, ' = %i \n\n', solucao(k,l+1))
#endfor
#fclose(sistema);
###
#
#### checando os valore
#
#casimir = zeros(3,3);
#for i = 1:7
#	for j = 1:7
#		for k = 1:6
#			#polinomio2 (:,:,i, j) = alpha(i,j) * BASE2(:,:,i) * BASE(:,:,j);
#			polinomio3 (:,:,i, j, k) = alpha(i,j,k) * BASE2(:,:,i) * BASE2(:,:,j) * BASE(:,:,k);
#			casimir += polinomio3(:,:,i,j,k);
#		endfor
#	endfor
#endfor
#disp (casimir);
##### casimir da zero =(
#####}}}
#
