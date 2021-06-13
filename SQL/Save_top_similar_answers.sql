CREATE OR REPLACE FUNCTION Insert_top_similars(limite int) RETURNS void  as
$$
declare
consulta_rec record;
rec record;
Begin
	for consulta_rec in (select * from consulta) LOOP
		FOR rec in (select * from TopSimilares(consulta_rec.vector ,limite int) LOOP
			Insert into respuesta(consulta_id, imagen_id, distancia) 
			Values(consulta_rec.id, rec.id, rec.distancia);
		END LOOP;
	END LOOP;
End
$$ 
language 'plpgsql';
								
				

select SaveTopSimilars(5)