1;

N = 3;
BASE2 = zeros(N, N, N*(N-1) );
k = 1;
for i = 1:N
	for j = 1:N
		if ( i != j)
			BASE2(i,i,k) = -1;
			BASE2(i,j,k) = 1;
			k++;
		endif
	endfor
endfor

BASE = zeros (3,3,3);
BASE(:,:,1) = -BASE2(:,:,1) + BASE2(:,:,2) ;
BASE(:,:,2) = -BASE2(:,:,1) + BASE2(:,:,3) ;
BASE(:,:,3) = -BASE2(:,:,1) + BASE2(:,:,4) ;

ad_BASE = zeros(3,3,3);
ad_BASE(:,:,1) = [0 -1 -2; 0 0 0; 0 -1 0];
ad_BASE(:,:,2) = [1 0 -1; 0 0 2; 1 0 -1];
ad_BASE(:,:,3) = [2 1 0; 0 -2 0; 0 1 0];


## colchete
function ret = colchete (X, Y)
	ret = X*Y - Y*X;
endfunction
I = eye(3);

ad_casimir = ad_BASE(:,:,1)**2+  ad_BASE(:,:,3)**2  - 2*( ad_BASE(:,:,1)*ad_BASE(:,:,2)+ ad_BASE(:,:,2)*ad_BASE(:,:,1)) ...
			 + ad_BASE(:,:,1)*ad_BASE(:,:,3)+ ad_BASE(:,:,3)*ad_BASE(:,:,2);

ad_coproduto = kron(ad_casimir, I) + kron(I, ad_casimir);	

casimir = BASE(:,:,1)**2+  BASE(:,:,3)**2  - 2*( BASE(:,:,1)*BASE(:,:,2)+ BASE(:,:,2)*BASE(:,:,1)) ...
			 + BASE(:,:,1)*BASE(:,:,3)+ BASE(:,:,3)*BASE(:,:,1);

coproduto = kron(casimir, I) + kron(I, casimir)

