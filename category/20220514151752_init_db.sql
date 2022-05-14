-- +goose Up
-- +goose StatementBegin

create table translations(
	id TEXT PRIMARY KEY, 
	key varchar(255),
 	lang varchar(10),
 	value varchar(255),
 	slug varchar(255),
	created_at timestamp,
	updated_at timestamp
);

create table attribute_containers (
	id SERIAL PRIMARY KEY, 
	name varchar(255) unique not null,
	created_at timestamp,
	updated_at timestamp
);

create table attributes_types(
 	id SERIAL PRIMARY KEY, 
	value varchar(255) unique not null,
	created_at timestamp,
	updated_at timestamp
);

create table attribute_groups(
	id SERIAL PRIMARY KEY, 
	name varchar(255) unique not null,
	attribute_container_id int,
	translation_key text,
	created_at timestamp,
	updated_at timestamp,
	
	FOREIGN KEY(translation_key) 
   	REFERENCES translations(id),
	
	FOREIGN KEY(attribute_container_id) 
   	REFERENCES attribute_containers(id)
);

create table attributes(
 	id SERIAL PRIMARY KEY, 
	name varchar(255) unique not null,
	active bool,
	tags text unique not null,
	scopes varchar(255)[],
	format text, -- {{value}} inches -- format_size({{value}})

	translation_key text,
	attribute_type_id int,
	attribute_group_id int,
	created_at timestamp,
	updated_at timestamp,
	
	FOREIGN KEY(translation_key) 
   	REFERENCES translations(id),
	
	FOREIGN KEY(attribute_type_id) 
   	REFERENCES attributes_types(id),
	
	FOREIGN KEY(attribute_group_id) 
   	REFERENCES attribute_groups(id)
);

create table categories (
	id SERIAL PRIMARY KEY, 
	name varchar(255) unique not null,
	parent_id int,
	level int,
	icon varchar(255),
	description text,
	active bool,
	tags text,
	translation_key text,
	attribute_container_id int,
	created_at timestamp,
	updated_at timestamp,
	
	FOREIGN KEY(translation_key) 
   	REFERENCES translations(id),
	
	FOREIGN KEY(attribute_container_id) 
   	REFERENCES attribute_containers(id)
);

create table attribute_values(
	id SERIAL PRIMARY KEY, 
	value varchar(255) unique not null,
	translation_key text,
 	attribute_id int,
 	created_at timestamp,
	updated_at timestamp,
	
	FOREIGN KEY(translation_key) 
   	REFERENCES translations(id),
	
	FOREIGN KEY(attribute_id) 
   	REFERENCES attributes(id)
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table attribute_values;
drop table categories;
drop table attributes;
drop table attribute_groups;
drop table attributes_types;
drop table attribute_containers;
drop table translations;
-- +goose StatementEnd
