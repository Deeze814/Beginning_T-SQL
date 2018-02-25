SELECT CHOOSE(4, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i') AS ValueAtPosition4;

/*
	ValueAtPosition4
	d
*/

SELECT CHOOSE(1, 5, 'a', 'Longer String', 50.3) AS ValueAtPosition4;