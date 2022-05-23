INSERT INTO public.user (id, first_name, last_name, gender) VALUES(1,'Shailendra','Yadav','Male');
INSERT INTO public.user (id, first_name, last_name, gender) VALUES(2,'Jak','Jeremy','Male');
INSERT INTO public.user (id, first_name, last_name, gender) VALUES(3,'Rahul','Yadav','Male');
INSERT INTO public.user (id, first_name, last_name, gender) VALUES(4,'Alison','Lenard','Male');
INSERT INTO public.user (id, first_name, last_name, gender) VALUES(5,'Amy','Bensted','Female');

INSERT INTO public.user_tracking VALUES(1,1,28.7041,77.1025);
INSERT INTO public.user_tracking VALUES(2,2,22.5726,88.3639);
INSERT INTO public.user_tracking VALUES(3,3,12.92961458,77.64038086);
INSERT INTO public.user_tracking VALUES(4,4,12.99385296,77.6184082);
INSERT INTO public.user_tracking VALUES(5,5,51.5073219,-0.1276474);
update public.user_tracking set geo_location = ST_MakePoint(lng,lat)


