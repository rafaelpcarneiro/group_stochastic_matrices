1;

A = [1;0;0];
O = [0;1;0];
B = [0;0;1];

aPlus  = kron( A, O');
aMinus = kron( O, A');  
aHat   = kron( A, A');


bPlus  = kron( B, O');
bMinus = kron( O, B');  
bHat   = kron( B, B');


cPlus  = kron( A, B');
cMinus = kron( B, A');  
vHat   = kron( O, O');

X = zeros(3,3,9);
X(:,:,1) = aPlus;  #1
X(:,:,2) = aMinus; #2
X(:,:,3) = aHat;   #3
X(:,:,4) = bPlus;  #4
X(:,:,5) = bMinus; #5
X(:,:,6) = bHat;   #6
X(:,:,7) = cPlus;  #7
X(:,:,8) = cMinus; #8
X(:,:,9) = vHat;   #9

##for i = 1:9
##	for j = 1:9
##		printf("%d x %d\n", i,j);
##		kron( X(:,:,i), X(:,:,j) )
##		printf( "\n");
##	endfor
##endfor

First = kron( aHat, aHat) + kron( aHat, vHat) + kron( vHat, aHat) + kron( vHat, vHat);
Second = kron( aHat, cPlus) + kron( aHat, bMinus) - kron( aHat, bHat)  ...
         + kron( vHat, cPlus) + kron( vHat, bMinus ) - kron( vHat, bHat ) + kron( cPlus, aHat )  + kron( bMinus, aHat ) ...
         - kron( bHat, aHat) ...
         + kron( cPlus, vHat ) + kron( bMinus, vHat ) - kron( bHat, vHat)  ...
         + kron( cPlus, bHat ) + kron( bMinus, bHat ) + kron( bHat, cPlus ) + kron( bHat, bMinus );

-6 * First +3 * Second
