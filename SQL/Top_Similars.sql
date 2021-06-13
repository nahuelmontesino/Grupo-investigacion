CREATE OR REPLACE FUNCTION TopSimilars(vector_entrada float[], limite int) 
RETURNS table (
	id int,
	name varchar,
	distancia float) as
$$
Declare
rec record;
Begin 
	FOR REC in 
			(select * from Distancias(vector_entrada)
			order by distancia asc
			limit limite) LOOP
		name := rec.name;
		distancia:= rec.distancia;
		id := rec.id;
		RETURN NEXT;
	END LOOP;
End
$$
language 'plpgsql';

select TopSimilars(array[1,2,3], 5)