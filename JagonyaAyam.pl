/* Fakta */
/* dynamic */
:- dynamic(playerPosition/2).
:- dynamic(weaponPosition/3).
:- dynamic(playerHealth/1).
:- dynamic(playerHelmet/2).
:- dynamic(playerRompi/2).
:- dynamic(playerAmmo/1).
:- dynamic(playerInventory/2).
:- dynamic(playerEquip/2).
:- dynamic(luasmap/2).
:- dynamic(medicinePosition/3).
:- dynamic(armorPosition/3).
:- dynamic(ammoPosition/4).
:- dynamic(npcEquipment/3).
:- dynamic(npcPosition/3).
:- dynamic(npcHealth/2).
:- dynamic(danger/1).
:- dynamic(time/1).
:- dynamic(object/1).
:- dynamic(npcAlive/1).
:- dynamic(armor/3).
/* static */
weapon(akm, 50, 0).
weapon(ump, 35, 0).
weapon(pistol, 10, 0).
ammo(5).
ammo(10).
medicine(firstaid, 70).
medicine(bandage, 10).

/* RULES pokok */
start :- write(' _____    _    _   ____     _____ '),nl,
		 write('|  __ \\  | |  | | |  _ \\   / ____|'),nl,
		 write('| |__) | | |  | | | |_) | | |  __'),nl,
		 write('|  ___/  | |  | | |  _ <  | | |_ |'),nl,
		 write('| |      | |__| | | |_) | | |__| |'),nl,
		 write('|_|       \\____/  |____/   \\_____|  Jagonya Ayam'),nl,
		 write('                                     '),nl,
		 write('Selamat datang di Pulau Champs.'), nl,
		 write('Bersenang-senanglah di pulau ini!. Tapi ingat only one can survive and get the title "Jagonya Ayam"'), nl,
		 write('Jika kamu menang, Kamu juga akan mendapatkan persediaan sosis selama 1 tahun penuh. So, let\'s the battle royale begin!'), nl, nl,
		 help,
		 randomize,
		 buatDatabase,
		 repeat,
		 command,nl,
		 winOrlose.

help :- print('  ==================================================================================='),nl,
		print('  |Available commands to help you survive the game and win the title  "Jagonya Ayam"|'),nl,
		print('  |=================================================================================|'),nl,
		print('  |start.            | Start the game.                                              |'),nl,
		print('  |help.             | Show some information about the game.                        |'),nl,
		print('  |quit.             | Quit from the game.                                          |'),nl,
		print('  |look.             | Look around you.                                             |'),nl,
		print('  |map.              | Open map in the game                                         |'),nl,
		print('  |N. E. S. W.       | Move to the North, East, South, or West.                     |'),nl,
		print('  |take(Object).     | Pick up an object.                                           |'),nl,
		print('  |drop(Object).     | Drop an object from your inventory                           |'),nl,
		print('  |use(Object).      | Use an object from your inventory.                           |'),nl,
		print('  |attack.           | Attack the enemy.                                            |'),nl,
		print('  |status.           | Show your status.                                            |'),nl,
		print('  |save(FileName).   | Save your game.                                              |'),nl,
		print('  |load(FileName).   | Load your previously saved game.                             |'),nl,
		print('  |=================================================================================|'),nl,
		print('  |                            Information of the MAP                               |'),nl,
		print('  |=================================================================================|'),nl,
		print('  |         W        | Weapon                                                       |'),nl,
		print('  |         A        | Armor                                                        |'),nl,
		print('  |         M        | Medicine                                                     |'),nl,
		print('  |         O        | Ammo                                                         |'),nl,
		print('  |         P        | Player                                                       |'),nl,
		print('  |         E        | Enemy                                                        |'),nl,
		print('  |         -        | Accessible                                                   |'),nl,
		print('  |         X        | Inaccessible                                                 |'),nl,
		print('  ==================================================================================='),nl.

quit :- halt.

n :- playerPosition(X, Y), Z is Y-1, retract(playerPosition(X,Y)), assertz(playerPosition(X,Z)), cetakKeteranganTempatSetelahGerak(X,Z),  increaseTime, gerakMusuh, increaseDanger,  killbot.
w :- playerPosition(X, Y), Z is X-1, retract(playerPosition(X,Y)), assertz(playerPosition(Z,Y)), cetakKeteranganTempatSetelahGerak(Z,Y), increaseTime, gerakMusuh, increaseDanger, killbot.
e :- playerPosition(X, Y), Z is X+1, retract(playerPosition(X,Y)), assertz(playerPosition(Z,Y)), cetakKeteranganTempatSetelahGerak(Z,Y), increaseTime, gerakMusuh, increaseDanger, killbot.
s :- playerPosition(X, Y), Z is Y+1, retract(playerPosition(X,Y)), assertz(playerPosition(X,Z)), cetakKeteranganTempatSetelahGerak(X,Z), increaseTime, gerakMusuh, increaseDanger, killbot.

cetakKeteranganTempatSetelahGerak(X,Y) :-  A is X+1, B is X-1, C is Y + 1, D is Y - 1,
write('You are in '), namaWilayah(X,Y), write(' To the north is '), namaWilayah(X,D), write(' To the west is '), namaWilayah(B,Y),
write(' To the south is '), namaWilayah(X,C), write(' To the east is '),namaWilayah(A,Y), nl.

status :- playerHealth(Health),playerArmorHelmet(NamaHelmet,HealthHelmet), playerArmorRompi(NamaRompi,HealthRompi), playerEquip(Equipment, _), playerInventory(Inven,Sisa),
			write('Health : '), write(Health), nl,
			write('Helmet : '), write(NamaHelmet), write(' '), write(HealthHelmet), nl,
			write('Rompi : '), write(NamaRompi), write(' '), write(HealthRompi), nl,
			write('Weapon : '), write(Equipment), nl,
			write('Ammo : '), playerAmmo(X), write(X),nl,
			write('Inventory :'),nl, cekInventory.

look :- playerPosition(X,Y),object(L),retract(object(L)),assertz(object([])),
		A is X-1, B is Y-1, cek(A,B),
		C is X, D is Y-1,cek(C,D),
		E is X+1, F is Y-1,cek(E,F),nl,
		G is X-1, H is Y,cek(G,H),
		I is X, J is Y,cek(I,J),
		K is X+1, L1 is Y,cek(K,L1),nl,
		M is X-1, N is Y+1,cek(M,N),
		O is X, P is Y+1,cek(O,P),
		Q is X+1, R is Y+1,cek(Q,R),nl,
		write('You are in '), namaWilayah(X,Y),
		object(L2),
		keterangan(L2).

namaWilayah(X,Y) :- dangerZone(X,Y), write('Deadzone.'), !.
namaWilayah(X,Y) :- luasmap(A,B), X>=2, X=<(A//2), Y>=2, Y=<(B//2), write('Coblong.'), !.
namaWilayah(X,Y) :- luasmap(A,B), C is (A//2)+1, X>=C, X=<(A-1), Y>=2, Y=<(B//2), write('Cicaheum.'), !.
namaWilayah(X,Y) :- luasmap(A,B), C is (B//2)+1, X>=2, X=<(A//2), Y>=C, Y=<(B-1), write('Cibaduyut.'), !.
namaWilayah(X,Y) :- luasmap(A,B), C is (A//2)+1, D is (B//2)+1, X>=C, X=<(A-1), Y>=D, Y=<(B-1), write('Ciumbuleuit.'), !.

attack :- playerPosition(X,Y), npcPosition(IdEnemy,X,Y), playerEquip(NamaEquip,DamageEquip), NamaEquip == none, write('Gunakan senjata dulu gan'), nl ,healthAfterAttack(IdEnemy), !.
attack :- playerPosition(X,Y), npcPosition(IdEnemy,X,Y), playerAmmo(JumlahAmmo), JumlahAmmo == 0, write('Serangan gagal, ammo abis'), nl, healthAfterAttack(IdEnemy),!.
attack :- playerPosition(X,Y), npcPosition(IdEnemy,X,Y), playerEquip(NamaEquip,DamageEquip), npcHealth(IdEnemy,HpNPC), HpNPCNow is HpNPC-DamageEquip, healthAfterAttack(IdEnemy), attackEnemy(IdEnemy, HpNPCNow), playerAmmo(JumlahAmmo), JumlahAmmoSkrg is JumlahAmmo - 1, retract(playerAmmo(JumlahAmmo)), asserta(playerAmmo(JumlahAmmoSkrg)), !.

healthAfterAttack(IdEnemy) :- playerArmorHelmet(NamaHelmet,X), X>0, npcEquipment(IdEnemy,_,Y), Z is X-Y, Z>=0, write('Kena Tembak Gan, Your Helmet '), write(Z), nl, retract(playerArmorHelmet(NamaHelmet,X)), assertz(playerArmorHelmet(NamaHelmet,Z)),!.
healthAfterAttack(IdEnemy) :- playerArmorHelmet(NamaHelmet,X), X>0, npcEquipment(IdEnemy,_,Y), Z is X-Y, Z<0, write('Kena Tembak Gan, Your Helmet '), write(0), nl, A is Y-X, changeHealthArmorVest(A), retract(playerArmorHelmet(NamaHelmet,X)), assertz(playerArmorHelmet(NamaHelmet,0)),!.
healthAfterAttack(IdEnemy) :- playerArmorRompi(NamaRompi,X), X>0, npcEquipment(IdEnemy,_,Y), Z is X-Y, Z>=0, write('Kena Tembak Gan, Your Rompi '), write(Z), nl, retract(playerArmorRompi(NamaRompi,X)), assertz(playerArmorRompi(NamaRompi,Z)),!.
healthAfterAttack(IdEnemy) :- playerArmorRompi(NamaRompi,X), X>0, npcEquipment(IdEnemy,_,Y), Z is X-Y, Z<0, write('Kena Tembak Gan, Your Rompi '), write(0), nl, A is Y-X, changeHealth(A), retract(playerArmorRompi(NamaRompi,X)), assertz(playerArmorRompi(NamaRompi,0)),!.
healthAfterAttack(IdEnemy) :- playerHealth(X), npcEquipment(IdEnemy,_,Y), Z is X-Y, write('Kena Tembak Gan, Your Health '), write(Z), nl, retract(playerHealth(X)), assertz(playerHealth(Z)),!.

changeHealthArmorVest(AttackSisa) :- playerArmorRompi(NamaRompi,X), X>0, AttackTotal is X-AttackSisa, AttackTotal>=0 ,retract(playerArmorRompi(NamaRompi, X)),write('Kena Tembak Gan, Your Rompi '), write(AttackTotal),nl, assertz(playerArmorRompi(NamaRompi, AttackTotal)), retract(armor(vest,NamaRompi,X)), assertz(armor(vest,NamaRompi,AttackTotal)),!.
changeHealthArmorVest(AttackSisa) :- playerArmorRompi(NamaRompi,X), X>0, AttackTotal is X-AttackSisa, AttackTotal<0 ,AttackSisa2 is AttackSisa-X,changeHealth(AttackSisa2),write('Kena Tembak Gan, Your Rompi '), write(0),nl, retract(playerArmorRompi(NamaRompi, X)), assertz(playerArmorRompi(NamaRompi, 0)), retract(armor(vest,NamaRompi,X)), assertz(armor(vest,NamaRompi,0)),!.
changeHealthArmorVest(AttackSisa) :- changeHealth(AttackSisa).

changeHealth(AttackSisa) :- playerHealth(X), Z is X-AttackSisa, retract(playerHealth(X)), asserta(playerHealth(Z)).

attackEnemy(Id, Hp) :- Hp=<0, retract(npcEquipment(Id,NamaSenjata,_)), retract(npcPosition(Id,X,Y)), retract(npcHealth(Id,_)),asserta(weaponPosition(NamaSenjata,X,Y)), write('Musuhmu Mati'), npcAlive(Alive), NewAlive is Alive-1, retract(npcAlive(Alive)), assertz(npcAlive(NewAlive)),nl,!.
attackEnemy(Id, Hp) :- retract(npcHealth(Id,_)), asserta(npcHealth(Id,Hp)), write('Musuh Belum Mati, Sisa darah musuh:'), write(Hp),nl.

map :- playerPosition(X,Y), luasmap(A,A), danger(B), cetakMAP(1,1,A,B,X,Y).

take(Object):-playerPosition(X,Y),A is X, B is Y, medicinePosition(Object,A,B),playerInventory(I,N),N>0, M is N-1,retract(medicinePosition(Object,A,B)),retract(playerInventory(I,N)),assertz(playerInventory([Object|I],M)),write('You took the '),write(Object),nl, increaseTime, !,increaseDanger,killbot.
take(Object):-playerPosition(X,Y),A is X, B is Y, weaponPosition(Object,A,B),playerInventory(I,N),N>0,M is N-1,retract(weaponPosition(Object,X,Y)),retract(playerInventory(I,N)),assertz(playerInventory([Object|I],M)),write('You took the '),write(Object),nl, increaseTime, !,increaseDanger, killbot.
take(Object):-playerPosition(X,Y),A is X, B is Y, armorPosition(Object,A,B),playerInventory(I,N),N>0,M is N-1,retract(armorPosition(Object,X,Y)),retract(playerInventory(I,N)),assertz(playerInventory([Object|I],M)),write('You took the '),write(Object),nl, increaseTime, !,increaseDanger, killbot.
take(Object):-playerPosition(X,Y),A is X, B is Y, ammoPosition(Object,J,A,B),playerAmmo(N),M is N+J,retract(playerAmmo(N)),retract(ammoPosition(Object,J,A,B)),assertz(playerAmmo(M)),write('You took the '),write(Object),nl, increaseTime, !,increaseDanger,killbot.
take(Object):-playerInventory(I,N),N =< 0,write('Inventory sudah penuh'),nl,increaseTime, !,increaseDanger,killbot.
take(Object):-write(Object), write(' tidak ada di sekeliling mu'),nl.

drop(Object):-weapon(Object,F,G),playerPosition(X,Y),playerInventory(L,N),member(Object,L), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),assertz(weaponPosition(Object,X,Y)),write('You drop the '),write(Object),nl,increaseTime, !,increaseDanger,killbot.
drop(Object):-armor(Jenis,Object,F),playerPosition(X,Y),playerInventory(L,N),member(Object,L), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),assertz(armorPosition(Object,X,Y)),write('You drop the '),write(Object),nl,increaseTime,!, increaseDanger,killbot.
drop(Object):-medicine(Object,F),playerPosition(X,Y),playerInventory(L,N), member(Object,L),M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),assertz(medicinePosition(Object,X,Y)),write('You drop the '),write(Object),nl,increaseTime,!, increaseDanger,killbot.
drop(Object):-ammoPosition(Object,Jm,_,_),playerAmmo(J),J>0,playerPosition(X,Y),playerInventory(L,N), M is N, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerAmmo(J)),assertz(playerAmmo(0)),assertz(playerInventory(L2,M)),assertz(ammoPosition(Object,J,X,Y)),write('You drop the '),write(Object),nl,increaseTime,!, increaseDanger,killbot.
drop(Object):-write(Object), write(' tidak ada di inventori mu'),nl.

use(Object):-weapon(Object,Attack,G),playerInventory(L,N),member(Object,L),playerEquip(Equipment,_), Equipment==none, M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerEquip(Equipment,_)),assertz(playerInventory(L2,M)),assertz(playerEquip(Object,Attack)),write('You use the '),write(Object),nl,increaseTime,!, increaseDanger, killbot.
use(Object):-weapon(Object,Attack,G),playerInventory(L,N),member(Object,L),playerEquip(Equipment,_), M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)),change(Equipment,Object),write('You use the '),write(Object),nl,increaseTime,!, increaseDanger, killbot.
use(Object):- armor(Jenis,Object,F),playerInventory(L,N),member(Object,L), Jenis == helmet,playerArmorHelmet(Equipment,Jumlah), Equipment \== none, M is N+1,
							retract(armor(helmet,Equipment,_)), assertz(armor(helmet,Equipment,Jumlah)),
							delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)), write('You use the '),write(Object),nl,
							change(Equipment,Object),changeHealthArmor(Jumlah,F),increaseTime,!, increaseDanger, killbot.
use(Object):-armor(Jenis,Object,F),playerInventory(L,N),member(Object,L),Jenis == helmet,playerArmorHelmet(Equipment,Jumlah),
							Equipment==none, M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerArmorHelmet(Equipment,Jumlah)),
							assertz(playerInventory(L2,M)),assertz(playerArmorHelmet(Object,F)),write('You use the '),
							write(Object),nl,increaseTime,!, increaseDanger, killbot.
use(Object):- armor(Jenis,Object,F),playerInventory(L,N),member(Object,L), Jenis == vest,playerArmorRompi(Equipment,Jumlah), Equipment \== none, M is N+1,
							retract(armor(vest,Equipment,_)), assertz(armor(vest,Equipment,Jumlah)),
							delete(L,Object,L2),retract(playerInventory(L,N)),assertz(playerInventory(L2,M)), write('You use the '),write(Object),nl,
							change(Equipment,Object),retract(armor(Jenis,Equipment,_)),assertz(armor(Jenis,Equipment,Jumlah)),changeHealthArmor(Jumlah,F),increaseTime,!, increaseDanger, killbot.
use(Object):-armor(Jenis,Object,F),playerInventory(L,N),member(Object,L),Jenis == vest,playerArmorRompi(Equipment,Jumlah),
							Equipment==none, M is N+1, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerArmorRompi(Equipment,Jumlah)),
							assertz(playerInventory(L2,M)),assertz(playerArmorRompi(Object,F)),write('You use the '),
							write(Object),nl,increaseTime,!, increaseDanger, killbot.
use(Object):-medicine(Object,F),playerInventory(L,N),member(Object,L),playerHealth(X), M is N+1, Y is X + F, Y<100, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerHealth(X)),assertz(playerInventory(L2,M)), assertz(playerHealth(Y)),write('You use the '),write(Object),nl,write('Now your health is '),write(Y),nl,increaseTime, !,increaseDanger,killbot.
use(Object):-medicine(Object,F),playerInventory(L,N),member(Object,L),playerHealth(X), M is N+1,  Y = 100, delete(L,Object,L2),retract(playerInventory(L,N)),retract(playerHealth(X)),assertz(playerInventory(L2,M)),assertz(playerHealth(Y)),write('You use the '),write(Object),nl,write('Now your health is '),write(Y), nl,increaseTime, !,increaseDanger, killbot.
use(Object):-write(Object),write(' tidak ada di inventori mu'),nl.

change(Equipment,Object):-weapon(Object,Damage,A),playerEquip(Equipment,_),playerInventory(L,N),M is N-1,retract(playerInventory(L,N)),retract(playerEquip(Equipment,_)),assertz(playerInventory([Equipment|L],M)),assertz(playerEquip(Object,Damage)),!.
change(Equipment,Object):-armor(Jenis,Object,Jumlah),Jenis == helmet,playerArmorHelmet(Equipment,_),playerInventory(L,N),M is N-1,retract(playerInventory(L,N)),retract(playerArmorHelmet(Equipment,_)),assertz(playerInventory([Equipment|L],M)),assertz(playerArmorHelmet(Object,Jumlah)),!.
change(Equipment,Object):-armor(Jenis,Object,Jumlah),Jenis == vest,playerArmorRompi(Equipment,_),playerInventory(L,N),M is N-1,retract(playerInventory(L,N)),retract(playerArmorRompi(Equipment,_)),assertz(playerInventory([Equipment|L],M)),assertz(playerArmorRompi(Object,Jumlah)),!.
changeHealthArmor(Awal,Akhir) :- armor(Jenis,Object,Akhir),Jenis == helmet,playerArmorHelmet(_,Awal), retract(playerArmorHelmet(_,Awal)),assertz(playerArmorHelmet(Object,Akhir)),!.
changeHealthArmor(Awal,Akhir) :- armor(Jenis,Object,Akhir),Jenis == vest,playerArmorRompi(_,Awal), retract(playerArmorRompi(_,Awal)),assertz(playerArmorRompi(Object,Akhir)),!.

/* Predikat Tambahan */
cek(X,Y):-dangerZone(X,Y), write('X'), !.
cek(X,Y):-npcPosition(_,X,Y), write('E'), !.
cek(X,Y):-object(L),medicinePosition(Benda,X,Y),!,write('M'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-object(L),weaponPosition(Benda,X,Y),!,write('W'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-object(L),armorPosition(Benda,X,Y),!,write('A'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-object(L),ammoPosition(Benda,N,X,Y),!,write('O'),retract(object(L)),assertz(object([Benda|L])).
cek(X,Y):-write('-').

keterangan([]):-write('').
keterangan([H|T]):-write('You see the '),write(H),write('. '),keterangan(T).

dangerZone(X,Y) :- danger(A), luasmap(Z1, Z2), (X =< A; Y =< A; X >= Z1+1-A; Y >= Z2+1-A).

cekInventory:-playerInventory(L,N),cetakInventory(L).
cetakInventory([]):-write('').
cetakInventory([H|T]):-write(H),nl,cetakInventory(T).

generateNPCHard(Id) :- random(2,10,X), random(2,10,Y), assertz(npcEquipment(Id,akm,50)), assertz(npcPosition(Id,X,Y)), assertz(npcHealth(Id,50)).
generateNPCMedium(Id) :- random(2,10,X), random(2,10,Y), assertz(npcEquipment(Id,ump,35)), assertz(npcPosition(Id,X,Y)), assertz(npcHealth(Id,50)).
generateNPCEasy(Id) :- random(2,10,X), random(2,10,Y), assertz(npcEquipment(Id,pistol,10)), assertz(npcPosition(Id,X,Y)), assertz(npcHealth(Id,50)).

cetakMAP(Baris,_,X,_,_,_) :- Baris>X.
cetakMAP(Baris,Kolom,X,DangerZone,Px,Py) :- (Kolom =< DangerZone ; Kolom >= X-DangerZone+1; Baris =< DangerZone; Baris >= X-DangerZone+1), write(' X '),((Kolom=:=X, nl, K is 1, B is Baris+1, cetakMAP(B,K,X,DangerZone,Px,Py),!) ; (K is Kolom+1,cetakMAP(Baris,K,X,DangerZone,Px,Py))),!.
cetakMAP(Baris,Kolom,X,DangerZone,Px,Py) :- Baris =:= Py, Kolom =:= Px, write(' P '),(K is Kolom+1, cetakMAP(Baris,K,X,DangerZone,Px,Py)),!.
cetakMAP(Baris,Kolom,X,DangerZone,Px,Py) :- write(' - '),((Kolom=:=X, nl, K is 1, B is Baris+1, cetakMAP(B,K,X,DangerZone,Px,Py),!) ; (K is Kolom+1,cetakMAP(Baris,K,X,DangerZone,Px,Py))),!.

buatDatabase :- generateNPCEasy(1),generateNPCEasy(2),
		 generateNPCMedium(3), generateNPCMedium(4),
		 generateNPCHard(5), generateNPCHard(6),
		 random(2,10,X),
		 random(2,10,Y),
		 assertz(playerPosition(X,Y)),
		 generateWeapon(akm),
		 generateWeapon(ump),
		 generateWeapon(pistol),
		 generateMedicine(firstaid),
		 generateMedicine(bandage),
		 generateArmor(helmet,helmlv2,30),
		 generateArmor(helmet,helmlv1,15),
		 generateArmor(vest,vestlv2,50),
		 generateArmor(vest,vestlv1,25),
		 generateAmmo(5),
		 generateAmmo(10),
		 assertz(playerHealth(100)),
		 assertz(playerAmmo(0)),
		 assertz(playerInventory([],10)),
		 assertz(playerEquip(none, 0)),
		 assertz(luasmap(12, 12)),
		 assertz(danger(1)),
		 assertz(time(0)),
		 assertz(object([])),
		 assertz(playerArmorHelmet(none,0)),
		 assertz(playerArmorRompi(none,0)),
		 assertz(npcAlive(6)).

command :- write('>'), read(X), X.

increaseDanger :- time(T), C is T mod 10, C == 0, !, danger(X), Z is X+1, retract(danger(X)), assertz(danger(Z)).

gerakMusuh :- time(T), C is T mod 3, C == 0, !, moveNPC(1), moveNPC(2), moveNPC(3), moveNPC(4), moveNPC(5), moveNPC(6). /* musuh gerak */
gerakMusuh:-true.

moveNPC(Id) :- random(1,5,X), Z is X, (Z == 1 -> (retract(npcPosition(Id,Px,Py)),Pz is Py-1,assertz(npcPosition(Id,Px,Pz)));
			(Z == 2 ->(npcPosition(Id,Px,Py),retract(npcPosition(Id,Px,Py)),Pz is Py-1,assertz(npcPosition(Id,Px,Pz)));
			(Z == 3 ->(npcPosition(Id,Px,Py),retract(npcPosition(Id,Px,Py)),Pz is Py+1,assertz(npcPosition(Id,Px,Pz)));
			(Z == 4 ->(npcPosition(Id,Px,Py),retract(npcPosition(Id,Px,Py)),Pz is Px+1,assertz(npcPosition(Id,Pz,Py))))))).


generateWeapon(Object) :- random(2,10,X), random(2,10,Y), assertz(weaponPosition(Object,X,Y)).
generateMedicine(Object) :- random(2,10,X), random(2,10,Y), assertz(medicinePosition(Object,X,Y)).
generateArmor(Jenis,Object,Health) :- random(2,10,X), random(2,10,Y), assertz(armor(Jenis,Object,Health)), assertz(armorPosition(Object,X,Y)).
generateAmmo(Ammo) :- random(2,10,X), random(2,10,Y), assertz(ammoPosition(ammo,Ammo,X,Y)).

increaseTime :- time(X), Z is X+1, retract(time(X)), assertz(time(Z)).

winOrlose :- playerPosition(X,Y), dangerZone(X,Y),!, write('Kamu kalah! Maaf anda bukan jagonya ayam'), nl, true.
winOrlose :- playerHealth(X), X < 0, !, write('Kamu kalah! Maaf anda bukan jagonya ayam'), nl, true.
winOrlose :- npcAlive(X), X = 0, !, write('Kamu memang JAGONYA AYAM!'), nl, gambarAyam, true.
winOrlose :- false.

cetakArmor([]):-nl.
cetakArmor([H|T]):-write(H),write(' '),cetakArmor(T).

deleteEnemy(Id, Hp) :- Hp =< 0, retract(npcEquipment(Id,NamaSenjata,_)), retract(npcPosition(Id,X,Y)), retract(npcHealth(Id,_)), assertz(weaponPosition(NamaSenjata,X,Y)), npcAlive(Alive), NewAlive is Alive-1, retract(npcAlive(Alive)), assertz(npcAlive(NewAlive)), !.
deleteEnemy(Id, Hp) :- retract(npcHealth(Id,_)), assertz(npcHealth(Id,Hp)).

killbot :- npcPosition(Id, X, Y), dangerZone(X,Y), retract(npcPosition(Id,X,Y)), retract(npcHealth(Id,_)), assertz(weaponPosition(NamaSenjata,X,Y)), npcAlive(Alive), NewAlive is Alive-1, retract(npcAlive(Alive)), assertz(npcAlive(NewAlive)), !.

resetDatabase :- retractall(playerPosition(_,_)), retractall(weaponPosition(_,_,_)), retractall(playerHealth(_)),
				retractall(playerArmor(_,_)), retractall(playerAmmo(_)), retractall(playerInventory(_,_)),
                retractall(playerEquip(_,_)), retractall(luasmap(_,_)), retractall(medicinePosition(_,_,_)),
                retractall(armorPosition(_,_,_)), retractall(ammoPosition(_,_,_,_)), retractall(inventory(_,_,_)),
                retractall(npcEquipment(_,_,_)), retractall(npcPosition(_,_,_)), retractall(npcHealth(_,_)),
                retractall(danger(_)), retractall(time(_)), retractall(object(_)), retractall(npcAlive(_)).

saveFile(FileName) :- open(FileName, write, Stream),
					playerPosition(X,Y),
					write(Stream, playerPosition(X,Y)), write(Stream, '.'), nl(Stream),
					playerHealth(Health),
					write(Stream, playerHealth(Health)), write(Stream, '.'), nl(Stream),
					playerArmor(Armor,B),
					write(Stream, playerArmor(Armor,B)), write(Stream, '.'), nl(Stream),
					playerAmmo(Ammo),
					write(Stream, playerAmmo(Ammo)), write(Stream, '.'), nl(Stream),
					playerInventory(In,K),
					write(Stream, playerInventory(In,K)), write(Stream, '.'), nl(Stream),
					playerEquip(E,V),
					write(Stream, playerEquip(E,V)), write(Stream, '.'), nl(Stream),
					luasmap(M,M),
					write(Stream, luasmap(M,M)), write(Stream, '.'), nl(Stream),
					danger(D),
					write(Stream,danger(D)), write(Stream, '.'), nl(Stream),
					time(T),
					write(Stream, time(T)), write(Stream, '.'), nl(Stream),
					object(O),
					write(Stream, object(O)), write(Stream, '.'), nl(Stream),
					npcAlive(NPC),
					write(Stream, npcAlive(NPC)), write(Stream, '.'), nl(Stream),

					findall(W, weaponPosition(W,_,_), Weapon),
					length(Weapon, Nb),
					write(Stream,Nb), write(Stream, '.'), nl(Stream),
					saveweapon(Stream),

					findall(Med, medicinePosition(Med,_,_), Medicine),
					length(Medicine, Nm),
					write(Stream, Nm), write(Stream, '.'), nl(Stream),
					savemedicine(Stream),

					findall(Arm, armorPosition(Arm,_,_), Armo),
					length(Armo, Na),
					write(Stream, Na), write(Stream, '.'), nl(Stream),
					savearmor(Stream),

					findall(Am, ammoPosition(Am,_,_,_), Amm),
					length(Amm, Nam),
					write(Stream, Nam), write(Stream, '.'), nl(Stream),
					saveammo(Stream),

					findall(Eq, npcEquipment(Eq,_,_), Equip),
					length(Equip, Ne),
					write(Stream, Ne), write(Stream,'.'), nl(Stream),
					savenpcEquipment(Stream),

					findall(Pos, npcPosition(Pos,_,_), Position),
					length(Position, Npos),
					write(Stream, Npos), write(Stream,'.'), nl(Stream),
					savenpcPosition(Stream),

					findall(H, npcHealth(H,_), Heal),
					length(Heal, Nh),
					write(Stream, Nh), write(Stream,'.'), nl(Stream),
					savenpcHealth(Stream),

					close(Stream).

saveweapon(Stream) :- weaponPosition(A,B,C), retract(weaponPosition(A,B,C)),
					write(Stream, weaponPosition(A,B,C)), write(Stream, '.'), nl(Stream),
					saveweapon(Stream), !.
saveweapon(Stream).

savemedicine(Stream) :- medicinePosition(A,B,C), retract(medicinePosition(A,B, C)),
					write(Stream, medicinePosition(A,B, C)), write(Stream, '.'), nl(Stream),
					savemedicine(Stream), !.
savemedicine(Stream).

savearmor(Stream) :- armorPosition(A,B,C), retract(armorPosition(A,B,C)),
					write(Stream, armorPosition(A,B, C)), write(Stream, '.'), nl(Stream),
					savearmor(Stream), !.
savearmor(Stream).

saveammo(Stream) :- ammoPosition(A,B,C,D), retract(ammoPosition(A,B,C,D)),
					write(Stream, ammoPosition(A,B,C,D)), write(Stream, '.'), nl(Stream),
					saveammo(Stream), !.
saveammo(Stream).

savenpcHealth(Stream) :- npcHealth(A, B), retract(npcHealth(A, B)),
					write(Stream, npcHealth(A, B)), write(Stream,'.'), nl(Stream),
					savenpcHealth(Stream),!.
savenpcHealth(Stream).

savenpcPosition(Stream) :- npcPosition(A, B, C), retract(npcPosition(A, B, C)),
					write(Stream, npcPosition(A, B, C)), write(Stream,'.'), nl(Stream),
					savenpcPosition(Stream),!.
savenpcPosition(Stream).

savenpcEquipment(Stream) :- npcEquipment(A, B, C), retract(npcEquipment(A, B, C)),
					write(Stream, npcEquipment(A, B, C)), write(Stream,'.'), nl(Stream),
					savenpcEquipment(Stream),!.
savenpcEquipment(Stream).


loadFile(NamaFile) :- resetDatabase, open(NamaFile, read, Stream),
						read(Stream, PPos),
						asserta(PPos),
						read(Stream, PH),
						asserta(PH),
						read(Stream, PArmor),
						asserta(PArmor),
						read(Stream, PAmmo),
						asserta(PAmmo),
						read(Stream, PInven),
						asserta(PInven),
						read(Stream, PEquip),
						asserta(PEquip),
						read(Stream, LMap),
						asserta(LMap),
						read(Stream, Danger),
						asserta(Danger),
						read(Stream, Time),
						asserta(Time),
						read(Stream,Obj),
						asserta(Obj),
						read(Stream,Alive),
						asserta(Alive),

						read(Stream, Nb),
						loadMany(Stream, Nb),

						read(Stream, Nw),
						loadMany(Stream, Nw),

						read(Stream, Na),
						loadMany(Stream, Na),

						read(Stream, Nc),
						loadMany(Stream, Nc),

						read(Stream, Nd),
						loadMany(Stream, Nd),

						read(Stream, Ne),
						loadMany(Stream, Ne),

						read(Stream, Nf),
						loadMany(Stream, Nf),

						close(Stream).

loadMany(Stream, N) :- N>0, read(Stream,B), asserta(B), N1 is N-1, loadMany(Stream,N1), !.
loadMany(Stream, 0).

gambarAyam :-   write('                                  .-.  .--------)'),nl,
				print('                                _ |  |/`   .- -)'),nl,
				print('                               ( `       /`'),nl,
				print('                               _)   _.  -| ._'),nl,
				print('                             /`  .\'    .-.-.'),nl,
				print('                             `).       |  |  |'),nl,
				print('                            (`,        |_o|_o|__'),nl,
				print('                             /           .-''`  `````)'),nl,
				print('                             {         /` ,__________)'),nl,
				print('                             {   ;     ''-.___________)'),nl,
				print('           _   _             {   }-....----`'),nl,
				print('          / `./ `.           {   }         `'),nl,
				print('       _  {   {  |            {   }'),nl,
				print('      ( `-.J     }_..----.._ __)   `}--..__'),nl,
				print('     .-`                    `        `}    ``--...--.'),nl,
				print('    (_,.--````/`         .-             `}       .__ _)'),nl,nl,
				print('            |          (                 }    .__ _)'),nl,
				print('            {_,         `.               }_  - _.`'),nl,
				print('               {_,         `.            } ``--`'),nl,
				print('                  `._.     ,_)          /'),nl,
				print('                     |    /           .`'),nl,
				print('                      {   |    _   .-`'),nl,
				print('                      {__/;--.||-`'),nl,
				print('                      _||   _||__   __'),nl,
				print('               _ __.-` ```)(` ```  ```._)'),nl,
				print('              (_`,-   ,-`  ```-.   `-._)'),nl,
				print('             (  (    /          `.__.`'),nl,
				print('              `````--`'),nl.
