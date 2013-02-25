/*
	qWat - QGIS Water Module
	
	SQL file :: valve table
*/
BEGIN;
/* create */
DROP TABLE IF EXISTS distribution.valve CASCADE;
CREATE TABLE distribution.valve (id serial , CONSTRAINT valve_pkey PRIMARY KEY (id));
COMMENT ON TABLE distribution.valve IS 'Table for valve.';

/* columns */
ALTER TABLE distribution.valve ADD COLUMN identification              integer ;
ALTER TABLE distribution.valve ADD COLUMN id_type           integer ;
ALTER TABLE distribution.valve ADD COLUMN id_function       integer ;
ALTER TABLE distribution.valve ADD COLUMN id_maintenance    integer[] ;
ALTER TABLE distribution.valve ADD COLUMN diameter_nominal  varchar(10) ;
ALTER TABLE distribution.valve ADD COLUMN year              smallint CHECK (year > 1800 AND year < 2100);
ALTER TABLE distribution.valve ADD COLUMN closed            boolean     default false ;
ALTER TABLE distribution.valve ADD COLUMN altitude_real     decimal(10,3)  ;
ALTER TABLE distribution.valve ADD COLUMN remarks           text           ;
ALTER TABLE distribution.valve ADD COLUMN schema_force_view boolean     default NULL::boolean; 
   
/* geometry */
SELECT distribution.geom_tool_point('valve',true,false,true,true);

/* constraints */
ALTER TABLE distribution.valve ADD CONSTRAINT valve_id_type         FOREIGN KEY (id_type)         REFERENCES distribution.valve_type(id)        MATCH FULL   ; CREATE INDEX fki_valve_id_type         ON distribution.valve(id_type)        ;
ALTER TABLE distribution.valve ADD CONSTRAINT valve_id_function     FOREIGN KEY (id_function)     REFERENCES distribution.valve_function(id)    MATCH FULL   ; CREATE INDEX fki_valve_id_function     ON distribution.valve(id_function)    ;
/* cannot create constraint on arrays yet
ALTER TABLE distribution.valve ADD CONSTRAINT valve_id_maintenance FOREIGN KEY (id_maintenance) REFERENCES distribution.valve_maintenance(id) MATCH SIMPLE ; CREATE INDEX fki_valve_id_maintenance ON distribution.valve(id_maintenance) ;
*/

COMMIT;

