function tests = test_operator_ncvar1
tests = functiontests(localfunctions);

function test1(testCase)
yalmip('clear')
sdpvar x y z
ncvar a b c
% Test of simple algebra
testCase.assertTrue(a*b-a*b == 0)
testCase.assertTrue(a*x*c*y-a*x*c*y == 0)
testCase.assertTrue(~isequal(a*c-c*a,0))
testCase.assertTrue(b*b-b^2 == 0)
testCase.assertTrue(a*b*b-a*b.^2 == 0)

testCase.assertTrue(b^2-b*b == 0)
testCase.assertTrue(b^2-b.*b == 0)
testCase.assertTrue(b^2-b.^2 == 0)
testCase.assertTrue((a*b)^2-a*b*a*b == 0)
testCase.assertTrue((a*b).^2-a*b*a*b == 0)
testCase.assertTrue((a*b).^2-(a*b).*(a*b) == 0)

testCase.assertTrue((a*b*x).^2-x^2*(a*b).*(a*b) == 0)

% TEST COEFFICIENTS
yalmip('clear')
sdpvar x y z
ncvar a b c
p = a*x + (b+c)*x^2 + x*y*z;
[c,v] = coefficients(p,[x;y;z])

yalmip('clear')
sdpvar x y z
ncvar a b c
[coeff,v] = coefficients(a*b+(a*b*b*c)*x,x);
testCase.assertTrue(coeff(2)-a*b*b*c == 0)

[coeff,v] = coefficients(a*b*x,y);
testCase.assertTrue(coeff-a*b*x == 0)

% TEST REPLACE
testCase.assertTrue(replace(a*b,x,y)-a*b == 0)
testCase.assertTrue(replace(a*b,b,c)-a*c == 0) 
testCase.assertTrue(replace(a*b,a,b)-b^2 == 0) 
testCase.assertTrue(replace(a*b,a,a+b+c)-a*b-b*b-c*b == 0) 
testCase.assertTrue(replace(a*b*c,b,x^2)-x^2*a*c == 0) 
testCase.assertTrue(replace(a*b*c,b,3)-3*a*c == 0) 
testCase.assertTrue(replace(a*b*c,[a b c],[1 2 a])-2*a == 0) 
testCase.assertTrue(replace(a*b*x,x,y)-a*b*y == 0) 
testCase.assertTrue(replace(a*b*x,x,c)-a*b*c == 0) 
testCase.assertTrue(replace(a*b*x^2,x,c)-a*b*c^2 == 0)
testCase.assertTrue(replace(a*b*x^2,y,c)-a*b*x^2 == 0)



