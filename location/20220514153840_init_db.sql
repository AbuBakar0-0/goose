-- +goose Up
-- +goose StatementBegin
create table countries (
	id SERIAL Primary key,
	name text unique not null
);

create table location_types(
	id SERIAL Primary key,
	name text not null,
	country_id int ,
	
	FOREIGN KEY(country_id) 
   	REFERENCES countries(id)
);

create table translations(
	id TEXT PRIMARY KEY, 
	key varchar(255),
 	lang varchar(10),
 	value varchar(255),
 	slug varchar(255),
	created_at timestamp,
	updated_at timestamp
);

create table locations(
	id SERIAL Primary key,
	name text not null,
	type_id int,
	code text,
	parent_id int,
	country_id int,
	polygon text,
	lat text,
	long text,
	translation_key text,
	
	FOREIGN KEY(country_id) 
   	REFERENCES countries(id),
	
	FOREIGN KEY(type_id) 
   	REFERENCES location_types(id)
);
 


-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table locations;
drop table location_types;
drop table countries;
drop table translations;
-- +goose StatementEnd
