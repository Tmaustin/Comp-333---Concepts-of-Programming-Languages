:- discontiguous male/1, female/1, parent/2.
male(taylor).
male(johnny).
male(john).
male(darrell).
male(tim).
male(cody).
male(montana).
male(alec).
male(seth).
male(tommy).
male(doug).
male(bill).
male(vern).
male(nick).
male(jason).
male(rick).
male(floyd).

female(nancy).
female(fern).
female(georgia).
female(vicky).
female(mary).
female(betty).
female(dotti).
female(karen).
female(michelle).
female(debbie).
female(april).
female(danielle).
female(dakota).

parent(nancy,floyd).
parent(bill,floyd).

parent(fern,mary).
parent(vern,mary).
parent(fern,betty).
parent(vern,betty).
parent(fern,rick).
parent(vern,rick).

parent(nick,darrell).
parent(georgi,darrell).
parent(vicky,dotti).
parent(jason,dotti).
parent(vicky,karen).
parent(jason,karen).

parent(floyd,tim).
parent(mary,tim).
parent(floyd,doug).
parent(mary,doug).
parent(floyd,debbie).
parent(mary,debbie).

parent(darrell,john).
parent(dotti,john).
parent(darrell,april).
parent(dotti,april).

parent(michelle,cody).
parent(tim,cody).
parent(michelle,montana).
parent(tim,montana).

parent(john,taylor).
parent(debbie,taylor).
parent(john,johnny).
parent(debbie,johnny).
parent(john,danielle).
parent(debbie,danielle).

parent(april,seth).
parent(tom,seth).
parent(april,alec).
parent(tom,alec).
parent(april,dakota).
parent(tom,dakota).

ancestor(X,Y)    :-  parent(X,Y).
ancestor(X,Y)    :-  parent(X, Z),  ancestor(Z, Y).
grandparent(X,Z) :-  parent(X, Y),  parent(Y, Z).
grandfather(X,Z) :-  male(X),       grandparent(X, Z).
grandmother(X,Z) :-  female(X),     grandparent(X, Z).
father(X,Y)      :-  male(X),       parent(X, Y).
mother(X,Y)      :-  female(X),     parent(X, Y).
auntoruncle(X,W) :-  sibling(X, Y), parent(Y, W).
sibling(X, Y)    :-  father(Z, X),  father(Z, Y), mother(W, X),  mother(W, Y),not(X = Y).
uncle(X,W)       :-  male(X),       auntoruncle(X, W).
aunt(X,W)        :-  female(X),     auntoruncle(X, W).
cousin(X,Y)      :-  parent(Z, X),  auntoruncle(Z, Y).
brother(X,Y)     :-  male(X),       sibling(X, Y).
sister(X,Y)      :-  female(X),     sibling(X, Y).
descendent(Y,X)  :-  ancestor(X, Y).
