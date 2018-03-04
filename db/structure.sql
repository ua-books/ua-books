SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: gender; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gender AS ENUM (
    'female',
    'male'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: books; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE books (
    id bigint NOT NULL,
    title character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    published_on date DEFAULT ('now'::text)::date NOT NULL,
    number_of_pages integer NOT NULL,
    cover_uid character varying,
    publisher_page_url character varying,
    description_md text,
    state character varying DEFAULT 'draft'::character varying NOT NULL,
    publisher_id integer NOT NULL
);


--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE books_id_seq OWNED BY books.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE people (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    gender gender NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


--
-- Name: person_aliases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE person_aliases (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    person_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: person_aliases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE person_aliases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE person_aliases_id_seq OWNED BY person_aliases.id;


--
-- Name: publishers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE publishers (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE publishers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE publishers_id_seq OWNED BY publishers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: work_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE work_types (
    id bigint NOT NULL,
    name_feminine character varying NOT NULL,
    name_masculine character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: work_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE work_types_id_seq OWNED BY work_types.id;


--
-- Name: works; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE works (
    id bigint NOT NULL,
    book_id bigint NOT NULL,
    person_alias_id bigint NOT NULL,
    work_type_id bigint NOT NULL,
    title boolean DEFAULT false NOT NULL,
    notes character varying
);


--
-- Name: works_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE works_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: works_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE works_id_seq OWNED BY works.id;


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: person_aliases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_aliases ALTER COLUMN id SET DEFAULT nextval('person_aliases_id_seq'::regclass);


--
-- Name: publishers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY publishers ALTER COLUMN id SET DEFAULT nextval('publishers_id_seq'::regclass);


--
-- Name: work_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_types ALTER COLUMN id SET DEFAULT nextval('work_types_id_seq'::regclass);


--
-- Name: works id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY works ALTER COLUMN id SET DEFAULT nextval('works_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: person_aliases person_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_aliases
    ADD CONSTRAINT person_aliases_pkey PRIMARY KEY (id);


--
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: work_types work_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_types
    ADD CONSTRAINT work_types_pkey PRIMARY KEY (id);


--
-- Name: works works_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT works_pkey PRIMARY KEY (id);


--
-- Name: index_books_on_publisher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_books_on_publisher_id ON books USING btree (publisher_id);


--
-- Name: index_books_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_books_on_state ON books USING btree (state);


--
-- Name: index_person_aliases_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_aliases_on_person_id ON person_aliases USING btree (person_id);


--
-- Name: index_works_on_book_id_and_person_alias_id_and_work_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_works_on_book_id_and_person_alias_id_and_work_type_id ON works USING btree (book_id, person_alias_id, work_type_id);


--
-- Name: index_works_on_person_alias_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_works_on_person_alias_id ON works USING btree (person_alias_id);


--
-- Name: index_works_on_work_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_works_on_work_type_id ON works USING btree (work_type_id);


--
-- Name: works fk_rails_2a8b3c3c4c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT fk_rails_2a8b3c3c4c FOREIGN KEY (book_id) REFERENCES books(id);


--
-- Name: works fk_rails_86dd05cfb5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT fk_rails_86dd05cfb5 FOREIGN KEY (person_alias_id) REFERENCES person_aliases(id);


--
-- Name: works fk_rails_9ade36165d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT fk_rails_9ade36165d FOREIGN KEY (work_type_id) REFERENCES work_types(id);


--
-- Name: person_aliases fk_rails_a4cf4f8aaa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_aliases
    ADD CONSTRAINT fk_rails_a4cf4f8aaa FOREIGN KEY (person_id) REFERENCES people(id);


--
-- Name: books fk_rails_d7ae2b039e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY books
    ADD CONSTRAINT fk_rails_d7ae2b039e FOREIGN KEY (publisher_id) REFERENCES publishers(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20171005125359'),
('20171006125238'),
('20171029122110'),
('20171105155810'),
('20171105170914'),
('20171119083656'),
('20171222185134'),
('20180103203154'),
('20180105201202'),
('20180106133300'),
('20180123191209'),
('20180225184939');


