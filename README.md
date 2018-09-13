Given a group of stochastic matrices G with real entries, i.e.,
a subgroup of the general linear group GL_n (group that all 
nxn matrices are invertible) whose all rows sum to 1, 
I am interested to check, for example, if
such group G has a tangent space T_1(G), which is a Lie algebra, that is
semi-simple or at least it has a subalgebra that is semisimple.

The following scripts are going to check such properties.

1) Script: check_semi_simple.m

*Description*: Given the group G, described as above, it's easy to check
that it has a tangent space T_1(G) defined by all matrices nxn 
such that all rows sum to zero. 
Now, in order to check if T_1(G) is a semi-simple Lie algebra, we
calculate its killing form, named as K. Given the killing form,
we only need to observe that the quadratic matrix associated to this form  
is invertible, or, in other words, we inspect if this matrix is full rank.
The script check_semi_simple does exactly this idea, it ask the user
to define the dimension of the stochastic matrices that define the group
G and returns as output a message saying that the tangent space is 
a semi-simple algebra or not and, in case the user desires to check 
the killing form, it returns the matrix of the killing form.
