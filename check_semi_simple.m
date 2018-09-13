# not a function file
1;

# bases do espaco 

### Caso Geral. Supondo que estamos trabalhando com matrizes NxN:
N = input("Digite a dimensao das matrizes NxN: ")

#Gerando as bases 
bases = zeros(N, N, N*(N-1) );
k = 1;
for i = 1:N
	for j = 1:N
		if ( i != j)
			bases(i,i,k) = -1;
			bases(i,j,k) = 1;
			k++;
		endif
	endfor
endfor


function ret = colchete(a, b)
	ret = a*b - b*a;
endfunction


X = zeros(N**2, N*(N-1) );

for i = 1:(N*(N-1))
	aux = bases(:,:,i)';
	X(:, i) = aux(:);
endfor
	

function transf_matrix = transformacao(base, X_sist_linear, n)
	transf_matrix = zeros(n*(n-1), n*(n-1), n*(n-1) );
	for i = 1:(n*(n-1))
		for j = 1:(n*(n-1))
			y = ( colchete(base(:,:,i), base(:,:,j ) ) )';
			y = y(:);
			
			transf_matrix(:,j,i) = X_sist_linear \ y;
		endfor
	endfor
endfunction

transformacaoMatrix = transformacao(bases, X, N);


function killing_matrix = killing_form( index_2, n)
	killing_matrix = zeros(n*(n-1), n*(n-1));
	for i = 1:(n*(n-1))
		for j = 1:(n*(n-1))
			killing_matrix( i, j) = trace( index_2(:,:, i) * index_2(:,:, j) );
		endfor
	endfor
endfunction

result = killing_form( transformacaoMatrix, N );

printf("\n\n\n ===== RESULTADO ===== \n\n");
printf("A matriz %dx%d da forma de killing tem posto %d\n\n",N*(N-1), N*(N-1), rank(result) );
if (N*(N-1) > rank(result) )
	printf("logo, a forma de killing eh degenerada\n");
else
	printf("logo, a forma de killing nao eh degenerada\n");
endif

printf("\n\n");
s = input("Deseja ver a matriz da forma de killing?(y/n)", "s");
if (strcmp(s,"y"))
	result
endif



