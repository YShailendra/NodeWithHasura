SET check_function_bodies = false;
CREATE TYPE public.person AS (
	id integer,
	first_name character varying(50),
	last_name character varying(50),
	gender character varying(50),
	lng double precision,
	lat double precision
);
CREATE TABLE public."user" (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text,
    gender text
);
COMMENT ON TABLE public."user" IS 'user data';
CREATE TABLE public.user_tracking (
    id integer NOT NULL,
    user_id integer NOT NULL,
    lat numeric NOT NULL,
    lng numeric NOT NULL,
    geo_location public.geography(Point,4326)
);
COMMENT ON TABLE public.user_tracking IS 'user tracking data';
CREATE VIEW public.user_view AS
 SELECT ur.id,
    ur.first_name,
    ur.last_name,
    ur.gender,
    ut.lat,
    ut.lng,
    ut.geo_location
   FROM (public."user" ur
     JOIN public.user_tracking ut ON ((ut.user_id = ur.id)));
CREATE FUNCTION public.findusers(radius integer, lat double precision, lng double precision) RETURNS SETOF public.user_view
    LANGUAGE sql STABLE
    AS $$
    SELECT 
    *
    from public.user_view 
    where (ST_Distance(geo_location,ST_SetSRID(ST_Point(lng, lat),4326))/1000)<=radius;
$$;
CREATE FUNCTION public.findusers1(radius integer, lat double precision, lng double precision) RETURNS public.person
    LANGUAGE plpgsql
    AS $$
DECLARE
    persons PERSON[];
BEGIN
    SELECT ARRAY_AGG(ROW(s.id, s.first_name, s.last_name,s.gender,s.lat,s.lng)::person) FROM public.user_view s
    INTO persons
    where (ST_Distance(geo_location,ST_SetSRID(ST_Point(lng, lat),4326))/1000)<radius;
    RETURN ROW(
        students
    )::person;
END;
$$;
ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_tracking
    ADD CONSTRAINT user_tracking_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_tracking
    ADD CONSTRAINT user_tracking_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
