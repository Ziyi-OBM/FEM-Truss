%This is an example FE model of a Truss(Triangle) composed of bar elements

Em=[50,50,100];
A=[2, 1, 2*sqrt(2)];
L=[10,10,10*sqrt(2)];

Node=[0 0; 10 0; 10 10];
Element=[1 2;2 3; 3 1];

zeroDBC=[1,2,4];
applyedF=[0 0 0 0 2 1];

numE=3;
DoF=4;  %per element


% ncoor=[0 0 30 40];
% Em=1000;
% A=5;
% Ke  = PlaneBar2Stiffness( ncoor, Em, A );
KE=zeros(DoF,DoF,numE);
for n=1:numE
    Ke(:,:,n)=PlaneBar2Stiffness( [Node(Element(n,1),:),Node(Element(n,2),:)], Em(n), A(n) );
end


eft=zeros(numE,DoF);
for i=1:numE
   eft(i,:)=[2*Element(i,1)-1,2*Element(i,1),2*Element(i,2)-1,2*Element(i,2),]; %2 node per element
end

Kglob=zeros(size(Node(:),1));

for n=1:numE
   for i=1:DoF
       for j=1:DoF
           
           Kglob(eft(n,i),eft(n,j))= Kglob(eft(n,i),eft(n,j)) + Ke(i,j,n);
       end
   end   
end


%Apply DBC
%Apply 0 to ux1 uy1 and uy2
I=eye(6);
for i=1:length(zeroDBC)
Kglob(zeroDBC(i),:)=I(zeroDBC(i),:);
Kglob(:,zeroDBC(i))=I(zeroDBC(i),:);
end

SolvedDisp=(applyedF/Kglob)'



