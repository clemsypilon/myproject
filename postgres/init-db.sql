CREATE SEQUENCE IF NOT EXISTS public.chaussure_idchaussure_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 19
CACHE 1;
	 
ALTER TABLE public.chaussure_idchaussure_seq
OWNER TO postgres;
CREATE TABLE IF NOT EXISTS public.chaussure
(
  idchaussure integer NOT NULL DEFAULT nextval('chaussure_idchaussure_seq'::regclass),
  genre character varying(15),
  marque character varying(20),
  modele character varying(25),
  couleur character varying(15),
  CONSTRAINT chaussure_pkey PRIMARY KEY (idchaussure)
)
WITH (
      OIDS=FALSE
);
ALTER TABLE public.chaussure
OWNER TO postgres;

