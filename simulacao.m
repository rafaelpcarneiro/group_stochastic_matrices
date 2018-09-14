# Just an octave script file to perform a simulation
# with the objective to find a semi simple lie algebra
1;

pkg load all; # call linear-algebra package

######### Ordinary Base

N = 3;
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
###########


###### auxiliary functions
function ret = colchete(a, b)
	ret = a*b - b*a;
endfunction



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

function killing_matrix = killing_form( index_2, n)
	killing_matrix = zeros(n, n);
	for i = 1:n
		for j = 1:n
			killing_matrix( i, j) = trace( index_2(:,:, i) * index_2(:,:, j) );
		endfor
	endfor
endfunction


#################
Points = cartprod (1:6, 1:6)
Total =6**2;

#Points = zeros(30,2);
#
#k =1;
#for i = 1:36
#	if points(i, 1) != points(i, 2)
#		Points(k,:) = points(i, :);
#		k++;
#	endif
#endfor

LIbases = zeros(Total, 6);
for i = 1:Total
	LIbases(i, Points(i,1) ) = 1;
	LIbases(i, Points(i,2) ) = -1;
	#LIbases(i, Points(i,3) ) = -1;
	#LIbases(i, Points(i,4) ) = -1;
endfor

LI = zeros(6,6);
LI(1,:) = [0,1,-1,1,-1,0];
LI(2,:) = [-1,1,0,1,0,-1];

newBases = zeros(N, N, N*(N-1) );
newBases(:,:,1) = bases(:,:,2) + bases(:,:,4) - ( bases(:,:,5) + bases(:,:,3) );
newBases(:,:,2) = bases(:,:,2) + bases(:,:,4) - ( bases(:,:,1) + bases(:,:,6) );

interacao = 1;
for i = unique(1:Total)
	for j = setdiff(1:Total, i)
		for k = setdiff(1:Total, union(i, j) )
			for l = setdiff(1:Total, union( union(i,j), k ) )
				newBases(:,:,3) = bases(:,:, Points(i,1) ) - bases(:,:, Points(i,2) ) ;

				newBases(:,:,4) = bases(:,:, Points(j,1) ) - bases(:,:, Points(j,2) ) ; 

				newBases(:,:,5) = bases(:,:, Points(k,1) ) - bases(:,:, Points(k,2) ) ; 

				newBases(:,:,6) = bases(:,:, Points(l,1) ) - bases(:,:, Points(l,2) ) ; 

				interacao++;

				LI(3,:) = LIbases(i,:);						
				LI(4,:) = LIbases(j,:);						
				LI(5,:) = LIbases(k,:);						
				LI(6,:) = LIbases(l,:);						
				#rank(LI)

				if ( rank(LI) == 6 )
					#disp(interacao);

					X = zeros(N**2, N*(N-1) );
					
					for i = 1:(N*(N-1))
						aux = newBases(:,:,i)';
						X(:, i) = aux(:);
					endfor
					transformacaoMatrix = transformacao(newBases, X, N);
	
					transformacaoMatrix2 = zeros(3,3,3);
					transformacaoMatrix2(:,:,1) = transformacaoMatrix(4:6,4:6,4);
					transformacaoMatrix2(:,:,2) = transformacaoMatrix(4:6,4:6,5);
					transformacaoMatrix2(:,:,3) = transformacaoMatrix(4:6,4:6,6);
					#transformacaoMatrix2(:,:,4) = transformacaoMatrix(3:6,3:6,6);
					
					a1 =  round( transformacaoMatrix(1:3,4:6,4) .* 100000) ./100000;
					a2 =  round( transformacaoMatrix(1:3,4:6,5) .* 100000) ./100000;
					a3 =  round( transformacaoMatrix(1:3,4:6,6) .* 100000) ./100000;
					#a4 =  round( transformacaoMatrix(1:2,3:6,6) .* 100000) ./100000;
					
					if ( all( all(a1 == 0 ) ) && all( all(a2 == 0 ) ) &&
					     all( all(a3 == 0 ) ) )
						result = killing_form( transformacaoMatrix2, 3 );
						rank(result)
						if (rank (result ) == 3 )
							filename1 = strcat(  num2str(interacao), '.txt');
	
							myfile = fopen(filename1,'a');
							fdisp (myfile, '************************************************************');
							fdisp (myfile, 'i j k l');
							fdisp (myfile, [i j k l] );
							fdisp (myfile, LI );
							fdisp (myfile, transformacaoMatrix );
							fdisp (myfile, '  ' );
				
							fdisp (myfile, result );
							fclose(myfile);	
						endif

					endif
				endif
			endfor
		endfor
	endfor
endfor
