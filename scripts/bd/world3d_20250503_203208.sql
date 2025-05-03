--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    action_parameters jsonb,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_permissions OWNER TO admin;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_id_seq OWNER TO admin;

--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


ALTER TABLE public.admin_permissions_role_lnk OWNER TO admin;

--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.admin_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_permissions_role_lnk_id_seq OWNER TO admin;

--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.admin_permissions_role_lnk_id_seq OWNED BY public.admin_permissions_role_lnk.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_roles OWNER TO admin;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_roles_id_seq OWNER TO admin;

--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    document_id character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.admin_users OWNER TO admin;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO admin;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_users_roles_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_ord double precision,
    user_ord double precision
);


ALTER TABLE public.admin_users_roles_lnk OWNER TO admin;

--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.admin_users_roles_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_roles_lnk_id_seq OWNER TO admin;

--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.admin_users_roles_lnk_id_seq OWNED BY public.admin_users_roles_lnk.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    document_id character varying(255),
    brand_name character varying(255),
    slug character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.brands OWNER TO admin;

--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brands_id_seq OWNER TO admin;

--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- Name: brands_products_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.brands_products_lnk (
    id integer NOT NULL,
    brand_id integer,
    product_id integer,
    product_ord double precision,
    brand_ord double precision
);


ALTER TABLE public.brands_products_lnk OWNER TO admin;

--
-- Name: brands_products_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.brands_products_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brands_products_lnk_id_seq OWNER TO admin;

--
-- Name: brands_products_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.brands_products_lnk_id_seq OWNED BY public.brands_products_lnk.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    document_id character varying(255),
    category_name character varying(255),
    slug character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.categories OWNER TO admin;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO admin;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.favorites (
    id integer NOT NULL,
    document_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.favorites OWNER TO admin;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_id_seq OWNER TO admin;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: favorites_products_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.favorites_products_lnk (
    id integer NOT NULL,
    favorite_id integer,
    product_id integer,
    product_ord double precision,
    favorite_ord double precision
);


ALTER TABLE public.favorites_products_lnk OWNER TO admin;

--
-- Name: favorites_products_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.favorites_products_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_products_lnk_id_seq OWNER TO admin;

--
-- Name: favorites_products_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.favorites_products_lnk_id_seq OWNED BY public.favorites_products_lnk.id;


--
-- Name: favorites_users_permissions_user_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.favorites_users_permissions_user_lnk (
    id integer NOT NULL,
    favorite_id integer,
    user_id integer
);


ALTER TABLE public.favorites_users_permissions_user_lnk OWNER TO admin;

--
-- Name: favorites_users_permissions_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.favorites_users_permissions_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_users_permissions_user_lnk_id_seq OWNER TO admin;

--
-- Name: favorites_users_permissions_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.favorites_users_permissions_user_lnk_id_seq OWNED BY public.favorites_users_permissions_user_lnk.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.files (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    alternative_text character varying(255),
    caption character varying(255),
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url character varying(255),
    preview_url character varying(255),
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.files OWNER TO admin;

--
-- Name: files_folder_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.files_folder_lnk (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_ord double precision
);


ALTER TABLE public.files_folder_lnk OWNER TO admin;

--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.files_folder_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_folder_lnk_id_seq OWNER TO admin;

--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.files_folder_lnk_id_seq OWNED BY public.files_folder_lnk.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_id_seq OWNER TO admin;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_mph; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.files_related_mph (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


ALTER TABLE public.files_related_mph OWNER TO admin;

--
-- Name: files_related_mph_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.files_related_mph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.files_related_mph_id_seq OWNER TO admin;

--
-- Name: files_related_mph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.files_related_mph_id_seq OWNED BY public.files_related_mph.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.i18n_locale OWNER TO admin;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.i18n_locale_id_seq OWNER TO admin;

--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: image_generals; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.image_generals (
    id integer NOT NULL,
    document_id character varying(255),
    image_general_name character varying(255),
    slug character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    text_general jsonb,
    links jsonb
);


ALTER TABLE public.image_generals OWNER TO admin;

--
-- Name: image_generals_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.image_generals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_generals_id_seq OWNER TO admin;

--
-- Name: image_generals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.image_generals_id_seq OWNED BY public.image_generals.id;


--
-- Name: product_ratings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.product_ratings (
    id integer NOT NULL,
    document_id character varying(255),
    rating integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.product_ratings OWNER TO admin;

--
-- Name: product_ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.product_ratings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_ratings_id_seq OWNER TO admin;

--
-- Name: product_ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.product_ratings_id_seq OWNED BY public.product_ratings.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products (
    id integer NOT NULL,
    document_id character varying(255),
    product_name character varying(255),
    slug character varying(255),
    description text,
    active boolean,
    price numeric(10,2),
    is_featured boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    weight numeric(10,2),
    dimensions character varying(255),
    date_manufactured date,
    remainin_warranty character varying(255),
    state character varying(255),
    city_name character varying(255),
    province_name character varying(255),
    country_name character varying(255),
    direction_name character varying(255),
    latitud double precision,
    longitud double precision,
    average_rating numeric(10,2),
    total_ratings integer,
    views integer,
    create_by character varying(255),
    owner_id character varying(255)
);


ALTER TABLE public.products OWNER TO admin;

--
-- Name: products_categories_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products_categories_lnk (
    id integer NOT NULL,
    product_id integer,
    category_id integer,
    category_ord double precision,
    product_ord double precision
);


ALTER TABLE public.products_categories_lnk OWNER TO admin;

--
-- Name: products_categories_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_categories_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_categories_lnk_id_seq OWNER TO admin;

--
-- Name: products_categories_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_categories_lnk_id_seq OWNED BY public.products_categories_lnk.id;


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO admin;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: products_product_ratings_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products_product_ratings_lnk (
    id integer NOT NULL,
    product_id integer,
    product_rating_id integer,
    product_rating_ord double precision,
    product_ord double precision
);


ALTER TABLE public.products_product_ratings_lnk OWNER TO admin;

--
-- Name: products_product_ratings_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_product_ratings_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_ratings_lnk_id_seq OWNER TO admin;

--
-- Name: products_product_ratings_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_product_ratings_lnk_id_seq OWNED BY public.products_product_ratings_lnk.id;


--
-- Name: products_shipping_types_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products_shipping_types_lnk (
    id integer NOT NULL,
    product_id integer,
    shipping_type_id integer,
    shipping_type_ord double precision,
    product_ord double precision
);


ALTER TABLE public.products_shipping_types_lnk OWNER TO admin;

--
-- Name: products_shipping_types_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_shipping_types_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_shipping_types_lnk_id_seq OWNER TO admin;

--
-- Name: products_shipping_types_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_shipping_types_lnk_id_seq OWNED BY public.products_shipping_types_lnk.id;


--
-- Name: products_users_permissions_users_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.products_users_permissions_users_lnk (
    id integer NOT NULL,
    product_id integer,
    user_id integer,
    user_ord double precision,
    product_ord double precision
);


ALTER TABLE public.products_users_permissions_users_lnk OWNER TO admin;

--
-- Name: products_users_permissions_users_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.products_users_permissions_users_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_users_permissions_users_lnk_id_seq OWNER TO admin;

--
-- Name: products_users_permissions_users_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.products_users_permissions_users_lnk_id_seq OWNED BY public.products_users_permissions_users_lnk.id;


--
-- Name: reactions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.reactions (
    id integer NOT NULL,
    document_id character varying(255),
    nombre character varying(255),
    tipo character varying(255),
    descripcion character varying(255),
    "timestamp" timestamp(6) without time zone,
    type character varying(255),
    active boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.reactions OWNER TO admin;

--
-- Name: reactions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.reactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reactions_id_seq OWNER TO admin;

--
-- Name: reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.reactions_id_seq OWNED BY public.reactions.id;


--
-- Name: reactions_product_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.reactions_product_lnk (
    id integer NOT NULL,
    reaction_id integer,
    product_id integer,
    reaction_ord double precision
);


ALTER TABLE public.reactions_product_lnk OWNER TO admin;

--
-- Name: reactions_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.reactions_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reactions_product_lnk_id_seq OWNER TO admin;

--
-- Name: reactions_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.reactions_product_lnk_id_seq OWNED BY public.reactions_product_lnk.id;


--
-- Name: reactions_users_permissions_user_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.reactions_users_permissions_user_lnk (
    id integer NOT NULL,
    reaction_id integer,
    user_id integer,
    reaction_ord double precision
);


ALTER TABLE public.reactions_users_permissions_user_lnk OWNER TO admin;

--
-- Name: reactions_users_permissions_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.reactions_users_permissions_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reactions_users_permissions_user_lnk_id_seq OWNER TO admin;

--
-- Name: reactions_users_permissions_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.reactions_users_permissions_user_lnk_id_seq OWNED BY public.reactions_users_permissions_user_lnk.id;


--
-- Name: shipping_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shipping_types (
    id integer NOT NULL,
    document_id character varying(255),
    shipping_type character varying(255),
    slug character varying(255),
    name_shipping_type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.shipping_types OWNER TO admin;

--
-- Name: shipping_types_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shipping_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_types_id_seq OWNER TO admin;

--
-- Name: shipping_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shipping_types_id_seq OWNED BY public.shipping_types.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_api_token_permissions OWNER TO admin;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_id_seq OWNER TO admin;

--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_api_token_permissions_token_lnk (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_ord double precision
);


ALTER TABLE public.strapi_api_token_permissions_token_lnk OWNER TO admin;

--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_token_permissions_token_lnk_id_seq OWNER TO admin;

--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq OWNED BY public.strapi_api_token_permissions_token_lnk.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_api_tokens OWNER TO admin;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_api_tokens_id_seq OWNER TO admin;

--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


ALTER TABLE public.strapi_core_store_settings OWNER TO admin;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_core_store_settings_id_seq OWNER TO admin;

--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


ALTER TABLE public.strapi_database_schema OWNER TO admin;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_database_schema_id_seq OWNER TO admin;

--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_history_versions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_history_versions (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255),
    locale character varying(255),
    status character varying(255),
    data jsonb,
    schema jsonb,
    created_at timestamp(6) without time zone,
    created_by_id integer
);


ALTER TABLE public.strapi_history_versions OWNER TO admin;

--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_history_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_history_versions_id_seq OWNER TO admin;

--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_history_versions_id_seq OWNED BY public.strapi_history_versions.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations OWNER TO admin;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_migrations_id_seq OWNER TO admin;

--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_migrations_internal; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_migrations_internal (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


ALTER TABLE public.strapi_migrations_internal OWNER TO admin;

--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_migrations_internal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_migrations_internal_id_seq OWNER TO admin;

--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_migrations_internal_id_seq OWNED BY public.strapi_migrations_internal.id;


--
-- Name: strapi_release_actions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_release_actions (
    id integer NOT NULL,
    document_id character varying(255),
    type character varying(255),
    content_type character varying(255),
    entry_document_id character varying(255),
    locale character varying(255),
    is_entry_valid boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


ALTER TABLE public.strapi_release_actions OWNER TO admin;

--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_release_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_release_actions_id_seq OWNER TO admin;

--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_release_actions_id_seq OWNED BY public.strapi_release_actions.id;


--
-- Name: strapi_release_actions_release_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_release_actions_release_lnk (
    id integer NOT NULL,
    release_action_id integer,
    release_id integer,
    release_action_ord double precision
);


ALTER TABLE public.strapi_release_actions_release_lnk OWNER TO admin;

--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_release_actions_release_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_release_actions_release_lnk_id_seq OWNER TO admin;

--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_release_actions_release_lnk_id_seq OWNED BY public.strapi_release_actions_release_lnk.id;


--
-- Name: strapi_releases; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_releases (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    released_at timestamp(6) without time zone,
    scheduled_at timestamp(6) without time zone,
    timezone character varying(255),
    status character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_releases OWNER TO admin;

--
-- Name: strapi_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_releases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_releases_id_seq OWNER TO admin;

--
-- Name: strapi_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_releases_id_seq OWNED BY public.strapi_releases.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_transfer_token_permissions OWNER TO admin;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_id_seq OWNER TO admin;

--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_transfer_token_permissions_token_lnk (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_ord double precision
);


ALTER TABLE public.strapi_transfer_token_permissions_token_lnk OWNER TO admin;

--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNER TO admin;

--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNED BY public.strapi_transfer_token_permissions_token_lnk.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_transfer_tokens OWNER TO admin;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_transfer_tokens_id_seq OWNER TO admin;

--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


ALTER TABLE public.strapi_webhooks OWNER TO admin;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_webhooks_id_seq OWNER TO admin;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: strapi_workflows; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_workflows (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    content_types jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_workflows OWNER TO admin;

--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_id_seq OWNER TO admin;

--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_workflows_id_seq OWNED BY public.strapi_workflows.id;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_workflows_stage_required_to_publish_lnk (
    id integer NOT NULL,
    workflow_id integer,
    workflow_stage_id integer
);


ALTER TABLE public.strapi_workflows_stage_required_to_publish_lnk OWNER TO admin;

--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNER TO admin;

--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNED BY public.strapi_workflows_stage_required_to_publish_lnk.id;


--
-- Name: strapi_workflows_stages; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_workflows_stages (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    color character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.strapi_workflows_stages OWNER TO admin;

--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_workflows_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stages_id_seq OWNER TO admin;

--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_workflows_stages_id_seq OWNED BY public.strapi_workflows_stages.id;


--
-- Name: strapi_workflows_stages_permissions_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_workflows_stages_permissions_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    permission_id integer,
    permission_ord double precision
);


ALTER TABLE public.strapi_workflows_stages_permissions_lnk OWNER TO admin;

--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stages_permissions_lnk_id_seq OWNER TO admin;

--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq OWNED BY public.strapi_workflows_stages_permissions_lnk.id;


--
-- Name: strapi_workflows_stages_workflow_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.strapi_workflows_stages_workflow_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    workflow_id integer,
    workflow_stage_ord double precision
);


ALTER TABLE public.strapi_workflows_stages_workflow_lnk OWNER TO admin;

--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_workflows_stages_workflow_lnk_id_seq OWNER TO admin;

--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq OWNED BY public.strapi_workflows_stages_workflow_lnk.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_permissions OWNER TO admin;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_id_seq OWNER TO admin;

--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.up_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


ALTER TABLE public.up_permissions_role_lnk OWNER TO admin;

--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.up_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_permissions_role_lnk_id_seq OWNER TO admin;

--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.up_permissions_role_lnk_id_seq OWNED BY public.up_permissions_role_lnk.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.up_roles OWNER TO admin;

--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_roles_id_seq OWNER TO admin;

--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    document_id character varying(255),
    username character varying(255),
    email character varying(255),
    provider character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    confirmation_token character varying(255),
    confirmed boolean,
    blocked boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.up_users OWNER TO admin;

--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_id_seq OWNER TO admin;

--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: up_users_product_ratings_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.up_users_product_ratings_lnk (
    id integer NOT NULL,
    user_id integer,
    product_rating_id integer,
    product_rating_ord double precision,
    user_ord double precision
);


ALTER TABLE public.up_users_product_ratings_lnk OWNER TO admin;

--
-- Name: up_users_product_ratings_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.up_users_product_ratings_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_product_ratings_lnk_id_seq OWNER TO admin;

--
-- Name: up_users_product_ratings_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.up_users_product_ratings_lnk_id_seq OWNED BY public.up_users_product_ratings_lnk.id;


--
-- Name: up_users_role_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.up_users_role_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    user_ord double precision
);


ALTER TABLE public.up_users_role_lnk OWNER TO admin;

--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.up_users_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_users_role_lnk_id_seq OWNER TO admin;

--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.up_users_role_lnk_id_seq OWNED BY public.up_users_role_lnk.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


ALTER TABLE public.upload_folders OWNER TO admin;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_id_seq OWNER TO admin;

--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_lnk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.upload_folders_parent_lnk (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_ord double precision
);


ALTER TABLE public.upload_folders_parent_lnk OWNER TO admin;

--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.upload_folders_parent_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_folders_parent_lnk_id_seq OWNER TO admin;

--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.upload_folders_parent_lnk_id_seq OWNED BY public.upload_folders_parent_lnk.id;


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_lnk_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users_roles_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_lnk_id_seq'::regclass);


--
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- Name: brands_products_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands_products_lnk ALTER COLUMN id SET DEFAULT nextval('public.brands_products_lnk_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: favorites_products_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_products_lnk ALTER COLUMN id SET DEFAULT nextval('public.favorites_products_lnk_id_seq'::regclass);


--
-- Name: favorites_users_permissions_user_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_users_permissions_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.favorites_users_permissions_user_lnk_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_folder_lnk ALTER COLUMN id SET DEFAULT nextval('public.files_folder_lnk_id_seq'::regclass);


--
-- Name: files_related_mph id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_related_mph ALTER COLUMN id SET DEFAULT nextval('public.files_related_mph_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: image_generals id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.image_generals ALTER COLUMN id SET DEFAULT nextval('public.image_generals_id_seq'::regclass);


--
-- Name: product_ratings id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_ratings ALTER COLUMN id SET DEFAULT nextval('public.product_ratings_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: products_categories_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_categories_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_categories_lnk_id_seq'::regclass);


--
-- Name: products_product_ratings_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_product_ratings_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_product_ratings_lnk_id_seq'::regclass);


--
-- Name: products_shipping_types_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_shipping_types_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_shipping_types_lnk_id_seq'::regclass);


--
-- Name: products_users_permissions_users_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_users_permissions_users_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_users_permissions_users_lnk_id_seq'::regclass);


--
-- Name: reactions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions ALTER COLUMN id SET DEFAULT nextval('public.reactions_id_seq'::regclass);


--
-- Name: reactions_product_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.reactions_product_lnk_id_seq'::regclass);


--
-- Name: reactions_users_permissions_user_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_users_permissions_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.reactions_users_permissions_user_lnk_id_seq'::regclass);


--
-- Name: shipping_types id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shipping_types ALTER COLUMN id SET DEFAULT nextval('public.shipping_types_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_history_versions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_history_versions ALTER COLUMN id SET DEFAULT nextval('public.strapi_history_versions_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_migrations_internal id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_migrations_internal ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_internal_id_seq'::regclass);


--
-- Name: strapi_release_actions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_id_seq'::regclass);


--
-- Name: strapi_release_actions_release_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_release_lnk_id_seq'::regclass);


--
-- Name: strapi_releases id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_releases ALTER COLUMN id SET DEFAULT nextval('public.strapi_releases_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: strapi_workflows id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_id_seq'::regclass);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_permissions_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_permissions_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_workflow_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_workflow_lnk_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_lnk_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: up_users_product_ratings_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_product_ratings_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_users_product_ratings_lnk_id_seq'::regclass);


--
-- Name: up_users_role_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_users_role_lnk_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_lnk id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders_parent_lnk ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_lnk_id_seq'::regclass);


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_permissions (id, document_id, action, action_parameters, subject, properties, conditions, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	ym83k09jc48gx5u08ad2wl5t	plugin::upload.read	{}	\N	{}	[]	2025-04-14 19:18:04.349	2025-04-14 19:18:04.349	2025-04-14 19:18:04.349	\N	\N	\N
2	l1fm109rrzm0udyfusah88i8	plugin::upload.configure-view	{}	\N	{}	[]	2025-04-14 19:18:04.352	2025-04-14 19:18:04.352	2025-04-14 19:18:04.352	\N	\N	\N
3	tf036dtowiitbkfahfy847th	plugin::upload.assets.create	{}	\N	{}	[]	2025-04-14 19:18:04.353	2025-04-14 19:18:04.353	2025-04-14 19:18:04.353	\N	\N	\N
4	zgifcdwgr3te62vl7of4usxt	plugin::upload.assets.update	{}	\N	{}	[]	2025-04-14 19:18:04.355	2025-04-14 19:18:04.355	2025-04-14 19:18:04.355	\N	\N	\N
5	j76jsyi4wg3b9pgn8ul0rrs9	plugin::upload.assets.download	{}	\N	{}	[]	2025-04-14 19:18:04.357	2025-04-14 19:18:04.357	2025-04-14 19:18:04.357	\N	\N	\N
6	csz8qpjtcbgf6gz1dl7jtsms	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-04-14 19:18:04.359	2025-04-14 19:18:04.359	2025-04-14 19:18:04.359	\N	\N	\N
7	x75i2ms8e0nrb0ydg8jtw1f0	plugin::upload.read	{}	\N	{}	["admin::is-creator"]	2025-04-14 19:18:04.361	2025-04-14 19:18:04.361	2025-04-14 19:18:04.361	\N	\N	\N
8	olbtwubhoi5u10b8mh9kf5bg	plugin::upload.configure-view	{}	\N	{}	[]	2025-04-14 19:18:04.362	2025-04-14 19:18:04.362	2025-04-14 19:18:04.362	\N	\N	\N
9	tap995gzvvgp753zs5u7mnh3	plugin::upload.assets.create	{}	\N	{}	[]	2025-04-14 19:18:04.364	2025-04-14 19:18:04.364	2025-04-14 19:18:04.364	\N	\N	\N
10	xounby0danmken676jqz874z	plugin::upload.assets.update	{}	\N	{}	["admin::is-creator"]	2025-04-14 19:18:04.365	2025-04-14 19:18:04.365	2025-04-14 19:18:04.366	\N	\N	\N
11	tose0rzaeusbonpofdffpmf2	plugin::upload.assets.download	{}	\N	{}	[]	2025-04-14 19:18:04.367	2025-04-14 19:18:04.367	2025-04-14 19:18:04.367	\N	\N	\N
12	tvesz37a6gaoo2wnias1l7jk	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-04-14 19:18:04.369	2025-04-14 19:18:04.369	2025-04-14 19:18:04.369	\N	\N	\N
16	bcxxen7i5avweo57blkjopqn	plugin::content-manager.explorer.delete	{}	plugin::users-permissions.user	{}	[]	2025-04-14 19:18:04.382	2025-04-14 19:18:04.382	2025-04-14 19:18:04.382	\N	\N	\N
17	cngq79qttsizzwoe9toiyp2n	plugin::content-manager.explorer.publish	{}	plugin::users-permissions.user	{}	[]	2025-04-14 19:18:04.383	2025-04-14 19:18:04.383	2025-04-14 19:18:04.383	\N	\N	\N
18	g9w73gxdjx2y74kave03qvcr	plugin::content-manager.single-types.configure-view	{}	\N	{}	[]	2025-04-14 19:18:04.385	2025-04-14 19:18:04.385	2025-04-14 19:18:04.385	\N	\N	\N
19	yxnrs1g2p41zmgbckwjhlcow	plugin::content-manager.collection-types.configure-view	{}	\N	{}	[]	2025-04-14 19:18:04.387	2025-04-14 19:18:04.387	2025-04-14 19:18:04.387	\N	\N	\N
20	afq03foybukfccmgv68ycmvw	plugin::content-manager.components.configure-layout	{}	\N	{}	[]	2025-04-14 19:18:04.388	2025-04-14 19:18:04.388	2025-04-14 19:18:04.388	\N	\N	\N
21	oy64s495cp4j18yizdpahu8g	plugin::content-type-builder.read	{}	\N	{}	[]	2025-04-14 19:18:04.39	2025-04-14 19:18:04.39	2025-04-14 19:18:04.39	\N	\N	\N
22	c323k7gvuw2kvihx7qzus4aq	plugin::email.settings.read	{}	\N	{}	[]	2025-04-14 19:18:04.391	2025-04-14 19:18:04.391	2025-04-14 19:18:04.391	\N	\N	\N
23	mfh7j1voyx4fdam6hdtzxx0r	plugin::upload.read	{}	\N	{}	[]	2025-04-14 19:18:04.393	2025-04-14 19:18:04.393	2025-04-14 19:18:04.393	\N	\N	\N
24	n6g97g8dyilnrrks9fhpvkan	plugin::upload.assets.create	{}	\N	{}	[]	2025-04-14 19:18:04.394	2025-04-14 19:18:04.394	2025-04-14 19:18:04.394	\N	\N	\N
25	f5q3h8ljpbk0ny8d14j01tlg	plugin::upload.assets.update	{}	\N	{}	[]	2025-04-14 19:18:04.396	2025-04-14 19:18:04.396	2025-04-14 19:18:04.396	\N	\N	\N
26	ju7o54vpjy3x8e6iur4wu4na	plugin::upload.assets.download	{}	\N	{}	[]	2025-04-14 19:18:04.398	2025-04-14 19:18:04.398	2025-04-14 19:18:04.398	\N	\N	\N
27	n31sx9hhdbs4xg4yvfhdgx5s	plugin::upload.assets.copy-link	{}	\N	{}	[]	2025-04-14 19:18:04.399	2025-04-14 19:18:04.399	2025-04-14 19:18:04.399	\N	\N	\N
28	zo0kpji1xzwxm44wlyxtjf65	plugin::upload.configure-view	{}	\N	{}	[]	2025-04-14 19:18:04.401	2025-04-14 19:18:04.401	2025-04-14 19:18:04.401	\N	\N	\N
29	nd65gxth4kwwylaljiom8azz	plugin::upload.settings.read	{}	\N	{}	[]	2025-04-14 19:18:04.402	2025-04-14 19:18:04.402	2025-04-14 19:18:04.402	\N	\N	\N
30	hb9ef0zpfsjukr2spghabjcu	plugin::i18n.locale.create	{}	\N	{}	[]	2025-04-14 19:18:04.404	2025-04-14 19:18:04.404	2025-04-14 19:18:04.404	\N	\N	\N
31	wsn4vichxm90u0tbrz6lnrri	plugin::i18n.locale.read	{}	\N	{}	[]	2025-04-14 19:18:04.405	2025-04-14 19:18:04.405	2025-04-14 19:18:04.406	\N	\N	\N
32	obb0rr88edy14vnntu87r4iy	plugin::i18n.locale.update	{}	\N	{}	[]	2025-04-14 19:18:04.407	2025-04-14 19:18:04.407	2025-04-14 19:18:04.407	\N	\N	\N
33	ymsgfeqdzewiwtxfoc9q0nnz	plugin::i18n.locale.delete	{}	\N	{}	[]	2025-04-14 19:18:04.408	2025-04-14 19:18:04.408	2025-04-14 19:18:04.408	\N	\N	\N
34	m38xihdwffl0l5zwb3p69r56	plugin::users-permissions.roles.create	{}	\N	{}	[]	2025-04-14 19:18:04.41	2025-04-14 19:18:04.41	2025-04-14 19:18:04.41	\N	\N	\N
35	grwj2a4bu6r05wkdhdoknxg7	plugin::users-permissions.roles.read	{}	\N	{}	[]	2025-04-14 19:18:04.412	2025-04-14 19:18:04.412	2025-04-14 19:18:04.412	\N	\N	\N
36	gl9fknltdy1ve9hrmkia6wb2	plugin::users-permissions.roles.update	{}	\N	{}	[]	2025-04-14 19:18:04.413	2025-04-14 19:18:04.413	2025-04-14 19:18:04.413	\N	\N	\N
37	vilnsklwwfkux596awaxccfs	plugin::users-permissions.roles.delete	{}	\N	{}	[]	2025-04-14 19:18:04.415	2025-04-14 19:18:04.415	2025-04-14 19:18:04.415	\N	\N	\N
38	lvrh9cphz06ijebyjxmgv952	plugin::users-permissions.providers.read	{}	\N	{}	[]	2025-04-14 19:18:04.416	2025-04-14 19:18:04.416	2025-04-14 19:18:04.416	\N	\N	\N
39	vzdwloq7nkv7gnxrbogbi166	plugin::users-permissions.providers.update	{}	\N	{}	[]	2025-04-14 19:18:04.418	2025-04-14 19:18:04.418	2025-04-14 19:18:04.418	\N	\N	\N
40	fp7ux129wftrct2f1ilf0126	plugin::users-permissions.email-templates.read	{}	\N	{}	[]	2025-04-14 19:18:04.419	2025-04-14 19:18:04.419	2025-04-14 19:18:04.419	\N	\N	\N
41	x9oqv9z2k6qq59ymvwfzbehq	plugin::users-permissions.email-templates.update	{}	\N	{}	[]	2025-04-14 19:18:04.421	2025-04-14 19:18:04.421	2025-04-14 19:18:04.421	\N	\N	\N
42	r5s0evrznl7n9rpx8q3x2wxr	plugin::users-permissions.advanced-settings.read	{}	\N	{}	[]	2025-04-14 19:18:04.422	2025-04-14 19:18:04.422	2025-04-14 19:18:04.422	\N	\N	\N
43	oyshe6wg8ixydqssrc7lo2zi	plugin::users-permissions.advanced-settings.update	{}	\N	{}	[]	2025-04-14 19:18:04.424	2025-04-14 19:18:04.424	2025-04-14 19:18:04.424	\N	\N	\N
44	hug31srdj87ooxyt96e7ii94	admin::marketplace.read	{}	\N	{}	[]	2025-04-14 19:18:04.425	2025-04-14 19:18:04.425	2025-04-14 19:18:04.425	\N	\N	\N
45	gvfzrsxpcgm1vq53iashjm4t	admin::webhooks.create	{}	\N	{}	[]	2025-04-14 19:18:04.426	2025-04-14 19:18:04.426	2025-04-14 19:18:04.426	\N	\N	\N
46	r58vt404cthv3kfkdkrzxltg	admin::webhooks.read	{}	\N	{}	[]	2025-04-14 19:18:04.428	2025-04-14 19:18:04.428	2025-04-14 19:18:04.428	\N	\N	\N
47	imsyt20imxnxg7ez89qbyv0c	admin::webhooks.update	{}	\N	{}	[]	2025-04-14 19:18:04.429	2025-04-14 19:18:04.429	2025-04-14 19:18:04.429	\N	\N	\N
48	emqeibinhknhw5oq174y1lj9	admin::webhooks.delete	{}	\N	{}	[]	2025-04-14 19:18:04.43	2025-04-14 19:18:04.43	2025-04-14 19:18:04.43	\N	\N	\N
49	o5i2zzvl1kaygiaqolup05vj	admin::users.create	{}	\N	{}	[]	2025-04-14 19:18:04.432	2025-04-14 19:18:04.432	2025-04-14 19:18:04.432	\N	\N	\N
50	v5hquvdbkqv4o153aojnsi15	admin::users.read	{}	\N	{}	[]	2025-04-14 19:18:04.433	2025-04-14 19:18:04.433	2025-04-14 19:18:04.433	\N	\N	\N
51	xyg3yfr4nc4bsmpa9frrpik2	admin::users.update	{}	\N	{}	[]	2025-04-14 19:18:04.434	2025-04-14 19:18:04.434	2025-04-14 19:18:04.434	\N	\N	\N
52	x8kogx1nr5eh9t4vw9r522pe	admin::users.delete	{}	\N	{}	[]	2025-04-14 19:18:04.436	2025-04-14 19:18:04.436	2025-04-14 19:18:04.436	\N	\N	\N
53	b5v1mb5tn0tt57cb4lwrmieg	admin::roles.create	{}	\N	{}	[]	2025-04-14 19:18:04.437	2025-04-14 19:18:04.437	2025-04-14 19:18:04.437	\N	\N	\N
54	sb65dkdmafkjncdutjjxclc0	admin::roles.read	{}	\N	{}	[]	2025-04-14 19:18:04.438	2025-04-14 19:18:04.438	2025-04-14 19:18:04.438	\N	\N	\N
55	zkbor67h4jncjkzkr5lykols	admin::roles.update	{}	\N	{}	[]	2025-04-14 19:18:04.44	2025-04-14 19:18:04.44	2025-04-14 19:18:04.44	\N	\N	\N
56	ezehgccqhiu33tsh17azic13	admin::roles.delete	{}	\N	{}	[]	2025-04-14 19:18:04.441	2025-04-14 19:18:04.441	2025-04-14 19:18:04.441	\N	\N	\N
57	say4fq7idrb60x57991s8lsd	admin::api-tokens.access	{}	\N	{}	[]	2025-04-14 19:18:04.442	2025-04-14 19:18:04.442	2025-04-14 19:18:04.442	\N	\N	\N
58	y6xoq3py3koc60ll0k55i7g3	admin::api-tokens.create	{}	\N	{}	[]	2025-04-14 19:18:04.444	2025-04-14 19:18:04.444	2025-04-14 19:18:04.444	\N	\N	\N
59	m80mvlhz3bnagu8dy55x01z9	admin::api-tokens.read	{}	\N	{}	[]	2025-04-14 19:18:04.445	2025-04-14 19:18:04.445	2025-04-14 19:18:04.445	\N	\N	\N
60	m6tru323pf7lcklucoru0hpq	admin::api-tokens.update	{}	\N	{}	[]	2025-04-14 19:18:04.447	2025-04-14 19:18:04.447	2025-04-14 19:18:04.447	\N	\N	\N
61	hjr5lot9yl6tyb8kh71ix7po	admin::api-tokens.regenerate	{}	\N	{}	[]	2025-04-14 19:18:04.448	2025-04-14 19:18:04.448	2025-04-14 19:18:04.448	\N	\N	\N
62	utdbgn1ym7kg5xc7rai56jlz	admin::api-tokens.delete	{}	\N	{}	[]	2025-04-14 19:18:04.449	2025-04-14 19:18:04.449	2025-04-14 19:18:04.449	\N	\N	\N
63	xat7b2uatqzftvjt1mbcwkmo	admin::project-settings.update	{}	\N	{}	[]	2025-04-14 19:18:04.45	2025-04-14 19:18:04.45	2025-04-14 19:18:04.45	\N	\N	\N
64	nwv2lf11tsjyf1bv51otm7no	admin::project-settings.read	{}	\N	{}	[]	2025-04-14 19:18:04.452	2025-04-14 19:18:04.452	2025-04-14 19:18:04.452	\N	\N	\N
65	b7kd9uptlddoz1beybf53sqs	admin::transfer.tokens.access	{}	\N	{}	[]	2025-04-14 19:18:04.453	2025-04-14 19:18:04.453	2025-04-14 19:18:04.453	\N	\N	\N
66	yw0nomizwfk23z9r8zfrp31g	admin::transfer.tokens.create	{}	\N	{}	[]	2025-04-14 19:18:04.455	2025-04-14 19:18:04.455	2025-04-14 19:18:04.455	\N	\N	\N
67	khyf8b9062bed3v9godmiglc	admin::transfer.tokens.read	{}	\N	{}	[]	2025-04-14 19:18:04.456	2025-04-14 19:18:04.456	2025-04-14 19:18:04.456	\N	\N	\N
68	rjpyoy2km2xbw2eylx9zomob	admin::transfer.tokens.update	{}	\N	{}	[]	2025-04-14 19:18:04.458	2025-04-14 19:18:04.458	2025-04-14 19:18:04.458	\N	\N	\N
69	wklryw7fbrnp0btn8rxmlcd6	admin::transfer.tokens.regenerate	{}	\N	{}	[]	2025-04-14 19:18:04.459	2025-04-14 19:18:04.459	2025-04-14 19:18:04.459	\N	\N	\N
70	zkjdpqkpfocue8wp9y2ah8kc	admin::transfer.tokens.delete	{}	\N	{}	[]	2025-04-14 19:18:04.461	2025-04-14 19:18:04.461	2025-04-14 19:18:04.461	\N	\N	\N
74	yuskmbyc0zchp64x8o55p14m	plugin::content-manager.explorer.delete	{}	api::product.product	{}	[]	2025-04-14 20:47:06.137	2025-04-14 20:47:06.137	2025-04-14 20:47:06.137	\N	\N	\N
75	qrr1sne0m10mut8n5brmep7n	plugin::content-manager.explorer.publish	{}	api::product.product	{}	[]	2025-04-14 20:47:06.139	2025-04-14 20:47:06.139	2025-04-14 20:47:06.14	\N	\N	\N
79	dc5bixk02xkr6a9695ue49u1	plugin::content-manager.explorer.delete	{}	api::category.category	{}	[]	2025-04-14 20:49:07.288	2025-04-14 20:49:07.288	2025-04-14 20:49:07.289	\N	\N	\N
80	e2ows8wu3pdivd1rugbz8anu	plugin::content-manager.explorer.publish	{}	api::category.category	{}	[]	2025-04-14 20:49:07.291	2025-04-14 20:49:07.291	2025-04-14 20:49:07.291	\N	\N	\N
90	oqbdaugbgncl2ek44ucnlsus	plugin::content-manager.explorer.delete	{}	api::brand.brand	{}	[]	2025-04-14 20:54:53.45	2025-04-14 20:54:53.45	2025-04-14 20:54:53.451	\N	\N	\N
91	sua5lm4ayix8akw7nr7bzmqu	plugin::content-manager.explorer.publish	{}	api::brand.brand	{}	[]	2025-04-14 20:54:53.453	2025-04-14 20:54:53.453	2025-04-14 20:54:53.453	\N	\N	\N
92	fvofjz7uo9dvzhhk9mpu6ac6	plugin::content-manager.explorer.create	{}	api::category.category	{"fields": ["categoryName", "slug", "mainimage", "products"]}	[]	2025-04-14 21:02:39.099	2025-04-14 21:02:39.099	2025-04-14 21:02:39.1	\N	\N	\N
94	grpp7730m63qu6brhcelhhcx	plugin::content-manager.explorer.read	{}	api::category.category	{"fields": ["categoryName", "slug", "mainimage", "products"]}	[]	2025-04-14 21:02:39.106	2025-04-14 21:02:39.106	2025-04-14 21:02:39.106	\N	\N	\N
96	fc4rws3slgs2vtfactdw3et8	plugin::content-manager.explorer.update	{}	api::category.category	{"fields": ["categoryName", "slug", "mainimage", "products"]}	[]	2025-04-14 21:02:39.11	2025-04-14 21:02:39.11	2025-04-14 21:02:39.11	\N	\N	\N
225	dd3umrlwbnu0zq45le6cheim	plugin::content-manager.explorer.create	{}	api::image-general.image-general	{"fields": ["imageGeneralName", "slug", "nameGeneralImage", "textGeneral", "links"]}	[]	2025-04-19 19:05:05.438	2025-04-19 19:05:05.438	2025-04-19 19:05:05.438	\N	\N	\N
226	yyme4leyjtu10vwe8rcuk8fz	plugin::content-manager.explorer.read	{}	api::image-general.image-general	{"fields": ["imageGeneralName", "slug", "nameGeneralImage", "textGeneral", "links"]}	[]	2025-04-19 19:05:05.443	2025-04-19 19:05:05.443	2025-04-19 19:05:05.443	\N	\N	\N
227	i2xal2yh74fhs4w9repiq7nr	plugin::content-manager.explorer.update	{}	api::image-general.image-general	{"fields": ["imageGeneralName", "slug", "nameGeneralImage", "textGeneral", "links"]}	[]	2025-04-19 19:05:05.446	2025-04-19 19:05:05.446	2025-04-19 19:05:05.446	\N	\N	\N
110	bubdtxe59k41bfujo158goht	plugin::content-manager.explorer.delete	{}	api::image-general.image-general	{}	[]	2025-04-14 21:08:26.138	2025-04-14 21:08:26.138	2025-04-14 21:08:26.139	\N	\N	\N
111	oz7vmbn5xjxkee34ds9zyuzv	plugin::content-manager.explorer.publish	{}	api::image-general.image-general	{}	[]	2025-04-14 21:08:26.141	2025-04-14 21:08:26.141	2025-04-14 21:08:26.141	\N	\N	\N
188	o6ugn0ioj15011pxwh1limhy	plugin::content-manager.explorer.delete	{}	api::shipping-type.shipping-type	{}	[]	2025-04-14 21:40:57.673	2025-04-14 21:40:57.673	2025-04-14 21:40:57.673	\N	\N	\N
189	wvb6bmmfcoy1x1psuaczua3n	plugin::content-manager.explorer.publish	{}	api::shipping-type.shipping-type	{}	[]	2025-04-14 21:40:57.676	2025-04-14 21:40:57.676	2025-04-14 21:40:57.676	\N	\N	\N
220	wdvat847ei2sufeg0wkqld3z	plugin::content-manager.explorer.create	{}	api::shipping-type.shipping-type	{"fields": ["shippingType", "slug", "nameShippingType", "mediaShippingType", "products"]}	[]	2025-04-14 22:10:49.066	2025-04-14 22:10:49.066	2025-04-14 22:10:49.066	\N	\N	\N
222	kr8r0bbmpjvckmyzl5xz5z40	plugin::content-manager.explorer.read	{}	api::shipping-type.shipping-type	{"fields": ["shippingType", "slug", "nameShippingType", "mediaShippingType", "products"]}	[]	2025-04-14 22:10:49.07	2025-04-14 22:10:49.07	2025-04-14 22:10:49.07	\N	\N	\N
346	a0u5z46j8j1r38x4pt96lcvs	plugin::content-manager.explorer.update	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 21:37:32.868	2025-05-01 21:37:32.868	2025-05-01 21:37:32.868	\N	\N	\N
347	rml8w7cfgjhl805zlxxcjt16	plugin::content-manager.explorer.delete	{}	api::reaction.reaction	{}	[]	2025-05-01 21:37:32.871	2025-05-01 21:37:32.871	2025-05-01 21:37:32.871	\N	\N	\N
348	r7cl7bgodqz74t8t97q3z10i	plugin::content-manager.explorer.publish	{}	api::reaction.reaction	{}	[]	2025-05-01 21:37:32.873	2025-05-01 21:37:32.873	2025-05-01 21:37:32.873	\N	\N	\N
349	q072vorq767rqxouha9re9uj	plugin::content-manager.explorer.create	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 21:37:41.307	2025-05-01 21:37:41.307	2025-05-01 21:37:41.307	\N	\N	\N
350	dqypmyayhzz7ms7c8ozuorle	plugin::content-manager.explorer.read	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 21:37:41.31	2025-05-01 21:37:41.31	2025-05-01 21:37:41.31	\N	\N	\N
224	ydfyao95i0kin8cbes8dnv16	plugin::content-manager.explorer.update	{}	api::shipping-type.shipping-type	{"fields": ["shippingType", "slug", "nameShippingType", "mediaShippingType", "products"]}	[]	2025-04-14 22:10:49.074	2025-04-14 22:10:49.074	2025-04-14 22:10:49.074	\N	\N	\N
231	m68io5n2khe89t6y0riby1wt	plugin::content-manager.explorer.create	{}	api::brand.brand	{"fields": ["brandName", "slug", "mainimage", "products"]}	[]	2025-04-23 20:10:54.86	2025-04-23 20:10:54.86	2025-04-23 20:10:54.86	\N	\N	\N
233	zhdyk10b3627vsgdot1sis2a	plugin::content-manager.explorer.read	{}	api::brand.brand	{"fields": ["brandName", "slug", "mainimage", "products"]}	[]	2025-04-23 20:10:54.866	2025-04-23 20:10:54.866	2025-04-23 20:10:54.866	\N	\N	\N
235	aoemppgwkyumahi7h3cp2g0d	plugin::content-manager.explorer.update	{}	api::brand.brand	{"fields": ["brandName", "slug", "mainimage", "products"]}	[]	2025-04-23 20:10:54.871	2025-04-23 20:10:54.871	2025-04-23 20:10:54.871	\N	\N	\N
246	y03wn97kibld561hix783s7z	plugin::content-manager.explorer.delete	{}	api::product-rating.product-rating	{}	[]	2025-04-26 09:30:07.714	2025-04-26 09:30:07.714	2025-04-26 09:30:07.714	\N	\N	\N
247	vwyj6gy73lxede3ufaxgl6nc	plugin::content-manager.explorer.publish	{}	api::product-rating.product-rating	{}	[]	2025-04-26 09:30:07.716	2025-04-26 09:30:07.716	2025-04-26 09:30:07.716	\N	\N	\N
264	fupxrig816qi8g1q0fibkxja	plugin::content-manager.explorer.delete	{}	api::product-rating.product-rating	{}	[]	2025-04-26 10:26:23.753	2025-04-26 10:26:23.753	2025-04-26 10:26:23.753	\N	\N	\N
265	f5ztoo6h7nwb6tmo6tk4bl1q	plugin::content-manager.explorer.publish	{}	api::product-rating.product-rating	{}	[]	2025-04-26 10:26:23.756	2025-04-26 10:26:23.756	2025-04-26 10:26:23.756	\N	\N	\N
269	ss62cx051tcyhn8rfgeixl80	plugin::content-manager.explorer.delete	{}	api::product-rating.product-rating	{}	[]	2025-04-26 10:26:33.89	2025-04-26 10:26:33.89	2025-04-26 10:26:33.89	\N	\N	\N
270	ucoqrtf5h1fv7w6f9ibxiiet	plugin::content-manager.explorer.publish	{}	api::product-rating.product-rating	{}	[]	2025-04-26 10:26:33.894	2025-04-26 10:26:33.894	2025-04-26 10:26:33.894	\N	\N	\N
272	z1zsch3v7ev9c2r76nzgz90q	plugin::content-manager.explorer.create	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-04-26 10:50:22.226	2025-04-26 10:50:22.226	2025-04-26 10:50:22.226	\N	\N	\N
274	sfigln7pzckqfjhlxxdzfp8s	plugin::content-manager.explorer.read	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-04-26 10:50:22.231	2025-04-26 10:50:22.231	2025-04-26 10:50:22.231	\N	\N	\N
276	sbo2pdv4bzw4sxqi2c48oud0	plugin::content-manager.explorer.update	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-04-26 10:50:22.235	2025-04-26 10:50:22.235	2025-04-26 10:50:22.235	\N	\N	\N
283	lgejok1yvenl149otwstaip9	plugin::content-manager.explorer.create	{}	api::favorite.favorite	{"fields": ["products", "users_permissions_user"]}	[]	2025-04-27 18:47:41.084	2025-04-27 18:47:41.084	2025-04-27 18:47:41.084	\N	\N	\N
285	w4all7a2l5frtjmd6phf763w	plugin::content-manager.explorer.read	{}	api::favorite.favorite	{"fields": ["products", "users_permissions_user"]}	[]	2025-04-27 18:47:41.091	2025-04-27 18:47:41.091	2025-04-27 18:47:41.091	\N	\N	\N
287	j99sbrtzshb14on3f224qr32	plugin::content-manager.explorer.update	{}	api::favorite.favorite	{"fields": ["products", "users_permissions_user"]}	[]	2025-04-27 18:47:41.095	2025-04-27 18:47:41.095	2025-04-27 18:47:41.095	\N	\N	\N
289	dypp0x0rq29klqpsk35f1wqp	plugin::content-manager.explorer.delete	{}	api::favorite.favorite	{}	[]	2025-04-27 18:47:41.099	2025-04-27 18:47:41.099	2025-04-27 18:47:41.099	\N	\N	\N
290	n33jhdzllv318fugsdd573iu	plugin::content-manager.explorer.publish	{}	api::favorite.favorite	{}	[]	2025-04-27 18:47:41.101	2025-04-27 18:47:41.101	2025-04-27 18:47:41.101	\N	\N	\N
334	jrrrsr4jnc3hzg5ga3kni2my	plugin::content-manager.explorer.delete	{}	api::reaction.reaction	{}	[]	2025-05-01 21:37:13.389	2025-05-01 21:37:13.389	2025-05-01 21:37:13.389	\N	\N	\N
335	qvp09031gpfsysgmmrf6eoke	plugin::content-manager.explorer.publish	{}	api::reaction.reaction	{}	[]	2025-05-01 21:37:13.393	2025-05-01 21:37:13.393	2025-05-01 21:37:13.393	\N	\N	\N
336	v2d2hmmyt5t501jws88541n5	plugin::content-manager.explorer.create	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 21:37:32.842	2025-05-01 21:37:32.842	2025-05-01 21:37:32.842	\N	\N	\N
337	kkp3he4in0zuhyhjik4usc15	plugin::content-manager.explorer.read	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 21:37:32.845	2025-05-01 21:37:32.845	2025-05-01 21:37:32.845	\N	\N	\N
338	qcgm2w0va5rg5act8r98rkt9	plugin::content-manager.explorer.update	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 21:37:32.847	2025-05-01 21:37:32.847	2025-05-01 21:37:32.847	\N	\N	\N
339	aelkyg6w8wnpcienitkm2063	plugin::content-manager.explorer.delete	{}	api::product.product	{}	[]	2025-05-01 21:37:32.85	2025-05-01 21:37:32.85	2025-05-01 21:37:32.85	\N	\N	\N
340	cgklq3jpcn9dcftgrrki7ykw	plugin::content-manager.explorer.publish	{}	api::product.product	{}	[]	2025-05-01 21:37:32.853	2025-05-01 21:37:32.853	2025-05-01 21:37:32.853	\N	\N	\N
341	eqwha2ht6hxi50ar339puhls	plugin::content-manager.explorer.create	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-05-01 21:37:32.855	2025-05-01 21:37:32.855	2025-05-01 21:37:32.855	\N	\N	\N
342	wk2ym48c4jve1f8ab0ggbmli	plugin::content-manager.explorer.read	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-05-01 21:37:32.858	2025-05-01 21:37:32.858	2025-05-01 21:37:32.858	\N	\N	\N
343	d5w55858gtx03l1zrqnw3klx	plugin::content-manager.explorer.update	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-05-01 21:37:32.861	2025-05-01 21:37:32.861	2025-05-01 21:37:32.861	\N	\N	\N
344	kmq1la5lrnyqx0plbxw7oikk	plugin::content-manager.explorer.create	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 21:37:32.863	2025-05-01 21:37:32.863	2025-05-01 21:37:32.863	\N	\N	\N
345	pfkrdn3661y9g1wq8v6so1w8	plugin::content-manager.explorer.read	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 21:37:32.866	2025-05-01 21:37:32.866	2025-05-01 21:37:32.866	\N	\N	\N
297	chewjl5xhhcbaqv7r8rpzbo8	plugin::content-manager.explorer.delete	{}	api::product.product	{}	[]	2025-04-27 21:59:45.062	2025-04-27 21:59:45.062	2025-04-27 21:59:45.062	\N	\N	\N
298	wdd0ftcth9ea5xpwjc6odqke	plugin::content-manager.explorer.publish	{}	api::product.product	{}	[]	2025-04-27 21:59:45.064	2025-04-27 21:59:45.064	2025-04-27 21:59:45.064	\N	\N	\N
299	e3x96vilbcojaoe2vj836xy5	plugin::content-manager.explorer.create	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-04-27 21:59:45.067	2025-04-27 21:59:45.067	2025-04-27 21:59:45.067	\N	\N	\N
300	iyox7p4dxjsawpibg6km5j6x	plugin::content-manager.explorer.read	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-04-27 21:59:45.069	2025-04-27 21:59:45.069	2025-04-27 21:59:45.069	\N	\N	\N
301	s18m6qv3wdg1w9l6tic1hf2w	plugin::content-manager.explorer.update	{}	api::product-rating.product-rating	{"fields": ["rating", "users_permissions_users", "products"]}	[]	2025-04-27 21:59:45.071	2025-04-27 21:59:45.071	2025-04-27 21:59:45.071	\N	\N	\N
320	d5vcybzb48fswupnr0246zlc	plugin::content-manager.explorer.create	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "product_ratings", "avatar", "products", "userId", "reactions"]}	[]	2025-05-01 17:49:10.469	2025-05-01 17:49:10.469	2025-05-01 17:49:10.469	\N	\N	\N
321	x1ld97svsads2f273hv23fxr	plugin::content-manager.explorer.create	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 17:49:10.472	2025-05-01 17:49:10.472	2025-05-01 17:49:10.472	\N	\N	\N
322	hz30shs4aocz8v1i863n7ngi	plugin::content-manager.explorer.create	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 17:49:10.474	2025-05-01 17:49:10.474	2025-05-01 17:49:10.474	\N	\N	\N
323	u9bkzapifngje8dfmlk9m7da	plugin::content-manager.explorer.read	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "product_ratings", "avatar", "products", "userId", "reactions"]}	[]	2025-05-01 17:49:10.476	2025-05-01 17:49:10.476	2025-05-01 17:49:10.476	\N	\N	\N
324	qjt03ojjtco9rvmdo2cii2cd	plugin::content-manager.explorer.read	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 17:49:10.478	2025-05-01 17:49:10.478	2025-05-01 17:49:10.478	\N	\N	\N
325	fkgzhlwy2wtvk7a1yxruibth	plugin::content-manager.explorer.read	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 17:49:10.48	2025-05-01 17:49:10.48	2025-05-01 17:49:10.48	\N	\N	\N
326	y12j9w43zwosxtcz9nqqoiod	plugin::content-manager.explorer.update	{}	plugin::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role", "product_ratings", "avatar", "products", "userId", "reactions"]}	[]	2025-05-01 17:49:10.482	2025-05-01 17:49:10.482	2025-05-01 17:49:10.483	\N	\N	\N
327	msasdvvzkivhwyabc1ablybu	plugin::content-manager.explorer.update	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 17:49:10.485	2025-05-01 17:49:10.485	2025-05-01 17:49:10.485	\N	\N	\N
328	ewz3qo85ovjtjhy5o1vcgqss	plugin::content-manager.explorer.update	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 17:49:10.487	2025-05-01 17:49:10.487	2025-05-01 17:49:10.487	\N	\N	\N
329	icqdbsiupkih9gzsezg5nep7	plugin::content-manager.explorer.delete	{}	api::reaction.reaction	{}	[]	2025-05-01 17:49:10.489	2025-05-01 17:49:10.489	2025-05-01 17:49:10.489	\N	\N	\N
330	qqiv1oyjjix83mnansfsa3pj	plugin::content-manager.explorer.publish	{}	api::reaction.reaction	{}	[]	2025-05-01 17:49:10.493	2025-05-01 17:49:10.493	2025-05-01 17:49:10.493	\N	\N	\N
331	yw2tjczzkorhcrfok1ao8vcc	plugin::content-manager.explorer.create	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 21:37:13.374	2025-05-01 21:37:13.374	2025-05-01 21:37:13.374	\N	\N	\N
332	r48cxbjesntioie8fccimoq0	plugin::content-manager.explorer.read	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 21:37:13.381	2025-05-01 21:37:13.381	2025-05-01 21:37:13.382	\N	\N	\N
333	kj37piy3eduq38bih4vjs8y8	plugin::content-manager.explorer.update	{}	api::reaction.reaction	{"fields": ["nombre", "Tipo", "Descripcion", "product", "users_permissions_user", "timestamp", "type", "active"]}	[]	2025-05-01 21:37:13.385	2025-05-01 21:37:13.385	2025-05-01 21:37:13.385	\N	\N	\N
351	zecivt9fh00wtjcc79r0m5zd	plugin::content-manager.explorer.update	{}	api::product.product	{"fields": ["productName", "slug", "description", "images", "active", "price", "isFeatured", "categories", "weight", "dimensions", "dateManufactured", "remaininWarranty", "State", "cityName", "provinceName", "countryName", "directionName", "latitud", "longitud", "shipping_types", "brands", "product_ratings", "averageRating", "totalRatings", "views", "favorites", "createBy", "users_permissions_users", "owner_id", "reactions"]}	[]	2025-05-01 21:37:41.312	2025-05-01 21:37:41.312	2025-05-01 21:37:41.312	\N	\N	\N
\.


--
-- Data for Name: admin_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	2	1
2	2	2	2
3	3	2	3
4	4	2	4
5	5	2	5
6	6	2	6
7	7	3	1
8	8	3	2
9	9	3	3
10	10	3	4
11	11	3	5
12	12	3	6
16	16	1	4
17	17	1	5
18	18	1	6
19	19	1	7
20	20	1	8
21	21	1	9
22	22	1	10
23	23	1	11
24	24	1	12
25	25	1	13
26	26	1	14
27	27	1	15
28	28	1	16
29	29	1	17
30	30	1	18
31	31	1	19
32	32	1	20
33	33	1	21
34	34	1	22
35	35	1	23
36	36	1	24
37	37	1	25
38	38	1	26
39	39	1	27
40	40	1	28
41	41	1	29
42	42	1	30
43	43	1	31
44	44	1	32
45	45	1	33
46	46	1	34
47	47	1	35
48	48	1	36
49	49	1	37
50	50	1	38
51	51	1	39
52	52	1	40
53	53	1	41
54	54	1	42
55	55	1	43
56	56	1	44
57	57	1	45
58	58	1	46
59	59	1	47
60	60	1	48
61	61	1	49
62	62	1	50
63	63	1	51
64	64	1	52
65	65	1	53
66	66	1	54
67	67	1	55
68	68	1	56
69	69	1	57
70	70	1	58
74	74	1	62
75	75	1	63
79	79	1	67
80	80	1	68
188	188	1	99
189	189	1	100
90	90	1	75
91	91	1	76
92	92	1	77
94	94	1	79
96	96	1	81
110	110	1	91
111	111	1	92
220	220	1	102
222	222	1	104
224	224	1	106
225	225	1	107
226	226	1	108
227	227	1	109
231	231	1	110
233	233	1	112
235	235	1	114
246	246	1	124
247	247	1	125
264	264	3	10
265	265	3	11
269	269	2	10
270	270	2	11
272	272	1	127
274	274	1	129
276	276	1	131
283	283	1	135
285	285	1	137
287	287	1	139
289	289	1	141
290	290	1	142
297	297	3	15
298	298	3	16
299	299	3	17
300	300	3	18
301	301	3	19
320	320	1	143
321	321	1	144
322	322	1	145
323	323	1	146
324	324	1	147
325	325	1	148
326	326	1	149
327	327	1	150
328	328	1	151
329	329	1	152
330	330	1	153
331	331	3	23
332	332	3	24
333	333	3	25
334	334	3	26
335	335	3	27
336	336	2	12
337	337	2	13
338	338	2	14
339	339	2	15
340	340	2	16
341	341	2	17
342	342	2	18
343	343	2	19
344	344	2	20
345	345	2	21
346	346	2	22
347	347	2	23
348	348	2	24
349	349	3	28
350	350	3	29
351	351	3	30
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_roles (id, document_id, name, code, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	kwxnfwus418dm0a1p9xnwitk	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2025-04-14 19:18:04.343	2025-04-14 19:18:04.343	2025-04-14 19:18:04.343	\N	\N	\N
2	pqu7z7ictgrwd52vetg1rcsp	VIP	strapi-editor	Editors can manage and publish contents including those of other users.	2025-04-14 19:18:04.345	2025-05-01 21:37:32.772	2025-04-14 19:18:04.346	\N	\N	\N
3	tumm3tffzf5i3lrpmhk8e0yh	User	strapi-author	Authors can manage the content they have created.	2025-04-14 19:18:04.347	2025-05-01 21:37:41.241	2025-04-14 19:18:04.347	\N	\N	\N
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_users (id, document_id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	xwxrgcvo1ep19030czw334zf	Voro	Moran	\N	voromb@hotmail.com	$2a$10$z9zgMYpxgIQ0n2FHJ4yr7.tStmOzZpZtmwghvMpj3cCqgUOgVME6W	\N	\N	t	f	\N	2025-04-14 19:18:51.974	2025-04-14 19:18:51.974	2025-04-14 19:18:51.974	\N	\N	\N
\.


--
-- Data for Name: admin_users_roles_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_users_roles_lnk (id, user_id, role_id, role_ord, user_ord) FROM stdin;
1	1	1	1	1
\.


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.brands (id, document_id, brand_name, slug, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	j6o9z18jnz0mvi1kvmq4eew7	8020	8020	2025-04-14 22:25:24.545	2025-04-15 17:37:45.044	\N	1	1	\N
17	j6o9z18jnz0mvi1kvmq4eew7	8020	8020	2025-04-14 22:25:24.545	2025-04-15 17:37:45.044	2025-04-15 17:37:45.064	1	1	\N
3	zzrwmcom0o7f7gw94eagdbhn	Anycubic	anycubic	2025-04-14 22:25:39.783	2025-04-15 17:38:49.76	\N	1	1	\N
18	zzrwmcom0o7f7gw94eagdbhn	Anycubic	anycubic	2025-04-14 22:25:39.783	2025-04-15 17:38:49.76	2025-04-15 17:38:49.779	1	1	\N
7	lwb2mcgr8kkvwo7nr60bh90v	BIGTREETECH	bigtreetech	2025-04-14 22:26:22.958	2025-04-15 17:39:37.632	\N	1	1	\N
19	lwb2mcgr8kkvwo7nr60bh90v	BIGTREETECH	bigtreetech	2025-04-14 22:26:22.958	2025-04-15 17:39:37.632	2025-04-15 17:39:37.647	1	1	\N
9	yftc01lw23yxe70dznmpvmuc	BLTouch	bl-touch	2025-04-14 22:26:47.955	2025-04-15 17:40:44.306	\N	1	1	\N
20	yftc01lw23yxe70dznmpvmuc	BLTouch	bl-touch	2025-04-14 22:26:47.955	2025-04-15 17:40:44.306	2025-04-15 17:40:44.326	1	1	\N
5	z5yoffhell6fes7ioagqu3gb	BambuLab	bambu-lab	2025-04-14 22:25:59.68	2025-04-15 17:41:27.302	\N	1	1	\N
21	z5yoffhell6fes7ioagqu3gb	BambuLab	bambu-lab	2025-04-14 22:25:59.68	2025-04-15 17:41:27.302	2025-04-15 17:41:27.322	1	1	\N
11	mwvz8saj8ccr6bgck5lq8x0e	Creality	creality	2025-04-15 17:34:48.502	2025-04-15 17:42:14.083	\N	1	1	\N
22	mwvz8saj8ccr6bgck5lq8x0e	Creality	creality	2025-04-15 17:34:48.502	2025-04-15 17:42:14.083	2025-04-15 17:42:14.099	1	1	\N
13	iorwiyezv3mpyigkr3m0n3n4	E3D	e3-d	2025-04-15 17:35:12.959	2025-04-15 17:42:53.621	\N	1	1	\N
23	iorwiyezv3mpyigkr3m0n3n4	E3D	e3-d	2025-04-15 17:35:12.959	2025-04-15 17:42:53.621	2025-04-15 17:42:53.639	1	1	\N
15	v6278duwihowgyamvrgsbgup	Elegoo	elegoo	2025-04-15 17:35:32.679	2025-04-15 17:43:36.657	\N	1	1	\N
24	v6278duwihowgyamvrgsbgup	Elegoo	elegoo	2025-04-15 17:35:32.679	2025-04-15 17:43:36.657	2025-04-15 17:43:36.676	1	1	\N
25	wzs8hujksapas4gt70hcbqge	Epax 3D	epax-3-d	2025-04-15 17:46:17.828	2025-04-15 17:46:17.828	\N	1	1	\N
26	wzs8hujksapas4gt70hcbqge	Epax 3D	epax-3-d	2025-04-15 17:46:17.828	2025-04-15 17:46:17.828	2025-04-15 17:46:17.844	1	1	\N
27	tmlvjj8ufqfjlfdk7lmh12vz	formlabs	formlabs	2025-04-15 17:47:32.777	2025-04-15 17:47:32.777	\N	1	1	\N
28	tmlvjj8ufqfjlfdk7lmh12vz	formlabs	formlabs	2025-04-15 17:47:32.777	2025-04-15 17:47:32.777	2025-04-15 17:47:32.791	1	1	\N
29	stgrjjkoiwdcdva54ch7fyh2	Fysetc	fysetc	2025-04-15 17:49:56.857	2025-04-15 17:49:56.857	\N	1	1	\N
30	stgrjjkoiwdcdva54ch7fyh2	Fysetc	fysetc	2025-04-15 17:49:56.857	2025-04-15 17:49:56.857	2025-04-15 17:49:56.876	1	1	\N
31	wqadn651lkj7tv72r203v9vf	Hiwin	hiwin	2025-04-15 17:51:45.41	2025-04-15 17:51:45.41	\N	1	1	\N
32	wqadn651lkj7tv72r203v9vf	Hiwin	hiwin	2025-04-15 17:51:45.41	2025-04-15 17:51:45.41	2025-04-15 17:51:45.424	1	1	\N
33	qrx3768ss5lmls8sikzcwchk	Noctua	noctua	2025-04-15 17:52:58.842	2025-04-15 17:52:58.842	\N	1	1	\N
34	qrx3768ss5lmls8sikzcwchk	Noctua	noctua	2025-04-15 17:52:58.842	2025-04-15 17:52:58.842	2025-04-15 17:52:58.852	1	1	\N
35	xhl18fb46bexvptb8y9dkcew	Nova3D	nova3-d	2025-04-15 17:54:37.338	2025-04-15 17:54:37.338	\N	1	1	\N
36	xhl18fb46bexvptb8y9dkcew	Nova3D	nova3-d	2025-04-15 17:54:37.338	2025-04-15 17:54:37.338	2025-04-15 17:54:37.356	1	1	\N
37	ye5hig1jvrfiadzy8bgb4y1o	Phrozen	phrozen	2025-04-15 17:55:50.609	2025-04-15 17:55:50.609	\N	1	1	\N
38	ye5hig1jvrfiadzy8bgb4y1o	Phrozen	phrozen	2025-04-15 17:55:50.609	2025-04-15 17:55:50.609	2025-04-15 17:55:50.622	1	1	\N
39	z1krhcqpgth9jkaifxrxlvvq	Prusa	prusa	2025-04-15 17:56:45.175	2025-04-15 17:56:45.175	\N	1	1	\N
40	z1krhcqpgth9jkaifxrxlvvq	Prusa	prusa	2025-04-15 17:56:45.175	2025-04-15 17:56:45.175	2025-04-15 17:56:45.19	1	1	\N
41	nzx7yaqwl8c916e954w4t7ft	Qidi	qidi	2025-04-15 17:58:26.936	2025-04-15 17:58:26.936	\N	1	1	\N
42	nzx7yaqwl8c916e954w4t7ft	Qidi	qidi	2025-04-15 17:58:26.936	2025-04-15 17:58:26.936	2025-04-15 17:58:26.953	1	1	\N
43	mlbuhmoibqdqmyg3vug5zprp	Reprap	reprap	2025-04-15 17:59:29.159	2025-04-15 17:59:29.159	\N	1	1	\N
44	mlbuhmoibqdqmyg3vug5zprp	Reprap	reprap	2025-04-15 17:59:29.159	2025-04-15 17:59:29.159	2025-04-15 17:59:29.172	1	1	\N
45	l2dac6cpc161z49bu53lrc43	Trianglelab	trianglelab	2025-04-15 18:00:54.043	2025-04-15 18:00:54.043	\N	1	1	\N
46	l2dac6cpc161z49bu53lrc43	Trianglelab	trianglelab	2025-04-15 18:00:54.043	2025-04-15 18:00:54.043	2025-04-15 18:00:54.056	1	1	\N
47	wvf6505iv3ek108vs1spqvpx	Ultimaker	ultimaker	2025-04-15 18:01:47.349	2025-04-15 18:01:47.349	\N	1	1	\N
48	wvf6505iv3ek108vs1spqvpx	Ultimaker	ultimaker	2025-04-15 18:01:47.349	2025-04-15 18:01:47.349	2025-04-15 18:01:47.367	1	1	\N
49	l6jrqy7oxkiwqafo5nl6erzd	3DFils	3-d-fils	2025-04-15 18:03:28.002	2025-04-15 18:03:28.002	\N	1	1	\N
50	l6jrqy7oxkiwqafo5nl6erzd	3DFils	3-d-fils	2025-04-15 18:03:28.002	2025-04-15 18:03:28.002	2025-04-15 18:03:28.014	1	1	\N
51	trpl7c1yolt9ein1qysa8cx8	Filamentum	filamentum	2025-04-15 18:04:34.486	2025-04-15 18:04:34.486	\N	1	1	\N
52	trpl7c1yolt9ein1qysa8cx8	Filamentum	filamentum	2025-04-15 18:04:34.486	2025-04-15 18:04:34.486	2025-04-15 18:04:34.504	1	1	\N
53	wxhmiqrd5f0xe29xn9ijl1f8	Polymaker	polymaker	2025-04-15 18:05:48.381	2025-04-15 18:05:48.381	\N	1	1	\N
54	wxhmiqrd5f0xe29xn9ijl1f8	Polymaker	polymaker	2025-04-15 18:05:48.381	2025-04-15 18:05:48.381	2025-04-15 18:05:48.391	1	1	\N
\.


--
-- Data for Name: brands_products_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.brands_products_lnk (id, brand_id, product_id, product_ord, brand_ord) FROM stdin;
1	3	9	1	1
3	3	37	2	1
4	18	149	2	1
5	3	50	3	1
371	18	486	4	1
7	3	11	4	1
9	3	58	5	1
11	5	13	1	1
375	18	490	1	1
13	39	123	1	1
14	40	154	1	1
15	49	129	1	1
248	18	329	3	1
17	49	119	2	1
18	50	156	2	1
380	24	495	2	1
19	49	127	3	1
20	50	157	3	1
21	49	121	4	1
23	49	113	5	1
24	50	159	5	1
25	49	115	6	1
26	50	160	6	1
254	54	335	4	1
27	49	117	7	1
28	50	161	7	1
218	48	299	1	1
29	5	125	2	1
30	21	162	2	1
31	5	131	3	1
32	21	163	3	1
385	19	504	2	1
33	7	76	1	1
34	19	164	1	1
35	13	82	1	1
36	23	165	1	1
37	11	15	1	1
38	22	166	1	1
39	11	39	2	1
40	22	167	2	1
41	11	52	3	1
42	22	168	3	1
43	1	109	1	1
44	17	169	1	1
45	1	111	2	1
46	17	170	2	1
47	15	33	1	1
48	24	171	1	1
49	15	17	2	1
51	15	54	3	1
52	24	173	3	1
53	11	3	4	1
55	25	44	1	1
56	26	175	1	1
57	13	68	2	1
58	23	176	2	1
59	13	86	3	1
60	23	177	3	1
61	27	7	1	1
63	13	72	4	1
64	23	179	4	1
65	1	107	3	1
66	17	180	3	1
67	39	31	2	1
68	40	181	2	1
69	13	84	5	1
70	23	182	5	1
280	17	395	4	1
71	7	90	2	1
73	1	103	4	1
75	1	96	5	1
76	17	185	5	1
77	13	74	6	1
78	23	186	6	1
79	35	42	1	1
80	36	187	1	1
81	13	62	7	1
82	23	188	7	1
83	7	66	3	1
84	19	189	3	1
85	1	92	6	1
86	17	190	6	1
87	1	94	7	1
88	17	191	7	1
89	37	56	1	1
90	38	192	1	1
91	37	48	2	1
92	38	193	2	1
93	37	35	3	1
94	38	194	3	1
95	7	64	4	1
96	19	195	4	1
97	1	98	8	1
98	17	196	8	1
99	1	100	9	1
100	17	197	9	1
101	39	19	3	1
102	40	198	3	1
103	39	1	4	1
105	41	21	1	1
106	42	200	1	1
107	53	133	1	1
108	54	201	1	1
109	53	139	2	1
110	54	202	2	1
111	53	135	3	1
112	54	203	3	1
113	53	137	4	1
115	7	88	5	1
116	19	205	5	1
117	1	105	10	1
118	17	206	10	1
119	9	70	1	1
120	20	207	1	1
121	7	80	6	1
123	45	25	1	1
124	46	209	1	1
125	45	27	2	1
126	46	210	2	1
127	47	5	1	1
129	33	78	1	1
130	34	212	1	1
131	45	46	3	1
132	46	213	3	1
373	22	488	4	1
258	50	358	1	1
384	18	499	5	1
144	19	225	6	1
208	50	289	4	1
309	40	424	4	1
277	28	392	1	1
189	21	270	1	1
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.categories (id, document_id, category_name, slug, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
9	twygwxhdlslelyhoszr5i4h7	Electronica	electronica	2025-04-14 22:05:03.196	2025-04-17 11:53:24.885	\N	1	1	\N
14	twygwxhdlslelyhoszr5i4h7	Electronica	electronica	2025-04-14 22:05:03.196	2025-04-17 11:53:24.885	2025-04-17 11:53:24.911	1	1	\N
5	lteac4os3dpa56vrcbakwllz	Filamento	filamento	2025-04-14 22:04:02.997	2025-04-17 11:54:42.351	\N	1	1	\N
15	lteac4os3dpa56vrcbakwllz	Filamento	filamento	2025-04-14 22:04:02.997	2025-04-17 11:54:42.351	2025-04-17 11:54:42.386	1	1	\N
1	t7ck4hno082vire29xgkq31i	Impresora FDM	impresora-filamento	2025-04-14 22:02:39.574	2025-04-17 11:55:11.888	\N	1	1	\N
16	t7ck4hno082vire29xgkq31i	Impresora FDM	impresora-filamento	2025-04-14 22:02:39.574	2025-04-17 11:55:11.888	2025-04-17 11:55:11.915	1	1	\N
3	l3573v4umfeofpqzdysv09xe	Impresora Resina	impresora-resina	2025-04-14 22:03:13.296	2025-04-17 11:55:25.093	\N	1	1	\N
17	l3573v4umfeofpqzdysv09xe	Impresora Resina	impresora-resina	2025-04-14 22:03:13.296	2025-04-17 11:55:25.093	2025-04-17 11:55:25.116	1	1	\N
7	jdnh39wg2s92bxtpx1rfr0v3	Perfileria	perfileria	2025-04-14 22:04:48.882	2025-04-17 11:55:39.358	\N	1	1	\N
18	jdnh39wg2s92bxtpx1rfr0v3	Perfileria	perfileria	2025-04-14 22:04:48.882	2025-04-17 11:55:39.358	2025-04-17 11:55:39.389	1	1	\N
12	x51mhb37hao5lqay75hb404t	Resina	resina	2025-04-17 11:34:42.663	2025-04-17 11:55:59.973	\N	1	1	\N
19	x51mhb37hao5lqay75hb404t	Resina	resina	2025-04-17 11:34:42.663	2025-04-17 11:55:59.973	2025-04-17 11:56:00.011	1	1	\N
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.favorites (id, document_id, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	nm521972dutg8kdpjbc9imrg	2025-04-27 19:03:24.665	2025-04-27 19:03:24.665	\N	\N	\N	\N
2	nm521972dutg8kdpjbc9imrg	2025-04-27 19:03:24.665	2025-04-27 19:03:24.665	2025-04-27 19:03:24.672	\N	\N	\N
3	twjg4k3tdam8o5w4p8zxua9j	2025-04-27 19:08:36.794	2025-04-27 19:08:36.794	\N	\N	\N	\N
4	twjg4k3tdam8o5w4p8zxua9j	2025-04-27 19:08:36.794	2025-04-27 19:08:36.794	2025-04-27 19:08:36.8	\N	\N	\N
11	kerg03a8bdkt17jte3i5atd0	2025-04-27 19:20:05.598	2025-04-27 19:20:05.598	\N	\N	\N	\N
12	kerg03a8bdkt17jte3i5atd0	2025-04-27 19:20:05.598	2025-04-27 19:20:05.598	2025-04-27 19:20:05.606	\N	\N	\N
15	tke75h9drt1h1bxfe07dzfon	2025-04-27 19:24:33.794	2025-04-27 19:24:33.794	\N	\N	\N	\N
16	tke75h9drt1h1bxfe07dzfon	2025-04-27 19:24:33.794	2025-04-27 19:24:33.794	2025-04-27 19:24:33.801	\N	\N	\N
17	uj99vsvk36lq2jj38dp1mes9	2025-04-27 19:26:37.387	2025-04-27 19:26:37.387	\N	\N	\N	\N
18	uj99vsvk36lq2jj38dp1mes9	2025-04-27 19:26:37.387	2025-04-27 19:26:37.387	2025-04-27 19:26:37.394	\N	\N	\N
21	bkvoscha9eilj2h3170gx31h	2025-05-01 21:58:52.073	2025-05-01 21:58:52.073	\N	\N	\N	\N
22	bkvoscha9eilj2h3170gx31h	2025-05-01 21:58:52.073	2025-05-01 21:58:52.073	2025-05-01 21:58:52.081	\N	\N	\N
23	edkq9c7cecq1a3s0kbvlwoqd	2025-05-01 21:59:04.008	2025-05-01 21:59:04.008	\N	\N	\N	\N
24	edkq9c7cecq1a3s0kbvlwoqd	2025-05-01 21:59:04.008	2025-05-01 21:59:04.008	2025-05-01 21:59:04.015	\N	\N	\N
\.


--
-- Data for Name: favorites_products_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.favorites_products_lnk (id, favorite_id, product_id, product_ord, favorite_ord) FROM stdin;
1	1	129	1	1
3	3	9	1	1
13	11	7	1	1
19	15	137	1	2
20	16	335	1	2
21	17	3	1	1
24	2	358	1	1
64	18	488	1	1
39	12	392	1	1
66	4	490	1	1
69	21	17	1	1
70	22	495	1	1
71	23	58	1	1
74	24	499	1	1
\.


--
-- Data for Name: favorites_users_permissions_user_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.favorites_users_permissions_user_lnk (id, favorite_id, user_id) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.files (id, document_id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	dxor7s7wevyuacsi4lje4rw3	8020.jpeg	\N	\N	720	480	{"small": {"ext": ".jpeg", "url": "/uploads/small_8020_ca6c5f366e.jpeg", "hash": "small_8020_ca6c5f366e", "mime": "image/jpeg", "name": "small_8020.jpeg", "path": null, "size": 14.43, "width": 500, "height": 333, "sizeInBytes": 14425}, "thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_8020_ca6c5f366e.jpeg", "hash": "thumbnail_8020_ca6c5f366e", "mime": "image/jpeg", "name": "thumbnail_8020.jpeg", "path": null, "size": 4.81, "width": 234, "height": 156, "sizeInBytes": 4808}}	8020_ca6c5f366e	.jpeg	image/jpeg	26.49	/uploads/8020_ca6c5f366e.jpeg	\N	local	\N	/1	2025-04-15 17:37:41.189	2025-04-15 17:37:41.189	2025-04-15 17:37:41.189	1	1	\N
2	ka51189sa3d2mos67mlz3cck	Anycubiclogo.jpg	\N	\N	2048	2048	{"large": {"ext": ".jpg", "url": "/uploads/large_Anycubiclogo_7020be7f10.jpg", "hash": "large_Anycubiclogo_7020be7f10", "mime": "image/jpeg", "name": "large_Anycubiclogo.jpg", "path": null, "size": 37.52, "width": 1000, "height": 1000, "sizeInBytes": 37516}, "small": {"ext": ".jpg", "url": "/uploads/small_Anycubiclogo_7020be7f10.jpg", "hash": "small_Anycubiclogo_7020be7f10", "mime": "image/jpeg", "name": "small_Anycubiclogo.jpg", "path": null, "size": 15.83, "width": 500, "height": 500, "sizeInBytes": 15831}, "medium": {"ext": ".jpg", "url": "/uploads/medium_Anycubiclogo_7020be7f10.jpg", "hash": "medium_Anycubiclogo_7020be7f10", "mime": "image/jpeg", "name": "medium_Anycubiclogo.jpg", "path": null, "size": 26.07, "width": 750, "height": 750, "sizeInBytes": 26067}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_Anycubiclogo_7020be7f10.jpg", "hash": "thumbnail_Anycubiclogo_7020be7f10", "mime": "image/jpeg", "name": "thumbnail_Anycubiclogo.jpg", "path": null, "size": 3.73, "width": 156, "height": 156, "sizeInBytes": 3728}}	Anycubiclogo_7020be7f10	.jpg	image/jpeg	101.79	/uploads/Anycubiclogo_7020be7f10.jpg	\N	local	\N	/1	2025-04-15 17:38:46.526	2025-04-15 17:38:46.526	2025-04-15 17:38:46.526	1	1	\N
3	edlafocgigmi4x3t84b4xsy0	BIGTREETECH.png	\N	\N	225	225	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_BIGTREETECH_f10a81322f.png", "hash": "thumbnail_BIGTREETECH_f10a81322f", "mime": "image/png", "name": "thumbnail_BIGTREETECH.png", "path": null, "size": 9.38, "width": 156, "height": 156, "sizeInBytes": 9382}}	BIGTREETECH_f10a81322f	.png	image/png	2.72	/uploads/BIGTREETECH_f10a81322f.png	\N	local	\N	/1	2025-04-15 17:39:34.924	2025-04-15 17:39:34.924	2025-04-15 17:39:34.924	1	1	\N
4	jfd7c10y4btiozm3whg53xbn	BLTouch.png	\N	\N	2188	1185	{"large": {"ext": ".png", "url": "/uploads/large_BL_Touch_2c9bca689f.png", "hash": "large_BL_Touch_2c9bca689f", "mime": "image/png", "name": "large_BLTouch.png", "path": null, "size": 69.67, "width": 1000, "height": 542, "sizeInBytes": 69672}, "small": {"ext": ".png", "url": "/uploads/small_BL_Touch_2c9bca689f.png", "hash": "small_BL_Touch_2c9bca689f", "mime": "image/png", "name": "small_BLTouch.png", "path": null, "size": 33.13, "width": 500, "height": 271, "sizeInBytes": 33134}, "medium": {"ext": ".png", "url": "/uploads/medium_BL_Touch_2c9bca689f.png", "hash": "medium_BL_Touch_2c9bca689f", "mime": "image/png", "name": "medium_BLTouch.png", "path": null, "size": 51.03, "width": 750, "height": 406, "sizeInBytes": 51027}, "thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_BL_Touch_2c9bca689f.png", "hash": "thumbnail_BL_Touch_2c9bca689f", "mime": "image/png", "name": "thumbnail_BLTouch.png", "path": null, "size": 14.91, "width": 245, "height": 133, "sizeInBytes": 14907}}	BL_Touch_2c9bca689f	.png	image/png	28.20	/uploads/BL_Touch_2c9bca689f.png	\N	local	\N	/1	2025-04-15 17:40:40.864	2025-04-15 17:40:40.864	2025-04-15 17:40:40.864	1	1	\N
5	l1vb0tzd5sjegc8xri40bw93	bambu-lab.webp	\N	\N	500	500	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bambu_lab_aaf9b6a493.webp", "hash": "thumbnail_bambu_lab_aaf9b6a493", "mime": "image/webp", "name": "thumbnail_bambu-lab.webp", "path": null, "size": 1.02, "width": 156, "height": 156, "sizeInBytes": 1022}}	bambu_lab_aaf9b6a493	.webp	image/webp	3.00	/uploads/bambu_lab_aaf9b6a493.webp	\N	local	\N	/1	2025-04-15 17:41:23.703	2025-04-15 17:41:23.703	2025-04-15 17:41:23.703	1	1	\N
6	x4j9wee2hto729y4e3kzxrhf	creality.webp	\N	\N	512	512	{"small": {"ext": ".webp", "url": "/uploads/small_creality_68e99b5f90.webp", "hash": "small_creality_68e99b5f90", "mime": "image/webp", "name": "small_creality.webp", "path": null, "size": 4.93, "width": 500, "height": 500, "sizeInBytes": 4928}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_creality_68e99b5f90.webp", "hash": "thumbnail_creality_68e99b5f90", "mime": "image/webp", "name": "thumbnail_creality.webp", "path": null, "size": 1.55, "width": 156, "height": 156, "sizeInBytes": 1546}}	creality_68e99b5f90	.webp	image/webp	5.51	/uploads/creality_68e99b5f90.webp	\N	local	\N	/1	2025-04-15 17:42:10.765	2025-04-15 17:42:10.765	2025-04-15 17:42:10.765	1	1	\N
7	zat25jxgwqa3qxfn3aphwm51	e3d.png	\N	\N	900	500	{"small": {"ext": ".png", "url": "/uploads/small_e3d_d36710c1ce.png", "hash": "small_e3d_d36710c1ce", "mime": "image/png", "name": "small_e3d.png", "path": null, "size": 11.29, "width": 500, "height": 278, "sizeInBytes": 11289}, "medium": {"ext": ".png", "url": "/uploads/medium_e3d_d36710c1ce.png", "hash": "medium_e3d_d36710c1ce", "mime": "image/png", "name": "medium_e3d.png", "path": null, "size": 18.42, "width": 750, "height": 417, "sizeInBytes": 18423}, "thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_e3d_d36710c1ce.png", "hash": "thumbnail_e3d_d36710c1ce", "mime": "image/png", "name": "thumbnail_e3d.png", "path": null, "size": 5.98, "width": 245, "height": 136, "sizeInBytes": 5980}}	e3d_d36710c1ce	.png	image/png	4.22	/uploads/e3d_d36710c1ce.png	\N	local	\N	/1	2025-04-15 17:42:49.98	2025-04-15 17:42:49.98	2025-04-15 17:42:49.98	1	1	\N
8	c9ew5oas5pz1182b4gnh7sem	elegoo.webp	\N	\N	256	256	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_elegoo_05b8399f7e.webp", "hash": "thumbnail_elegoo_05b8399f7e", "mime": "image/webp", "name": "thumbnail_elegoo.webp", "path": null, "size": 1.61, "width": 156, "height": 156, "sizeInBytes": 1606}}	elegoo_05b8399f7e	.webp	image/webp	2.67	/uploads/elegoo_05b8399f7e.webp	\N	local	\N	/1	2025-04-15 17:43:33.731	2025-04-15 17:43:33.731	2025-04-15 17:43:33.731	1	1	\N
9	o6vt8nump4twc4tiojn74c2o	epax.png	\N	\N	311	162	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_epax_74d55837c3.png", "hash": "thumbnail_epax_74d55837c3", "mime": "image/png", "name": "thumbnail_epax.png", "path": null, "size": 5.32, "width": 245, "height": 128, "sizeInBytes": 5316}}	epax_74d55837c3	.png	image/png	1.68	/uploads/epax_74d55837c3.png	\N	local	\N	/1	2025-04-15 17:46:14.523	2025-04-15 17:46:14.523	2025-04-15 17:46:14.523	1	1	\N
10	jwa0w8ojs4pstyjqqg5n5f5p	formlabs.jpeg	\N	\N	180	180	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_formlabs_3de6d666e7.jpeg", "hash": "thumbnail_formlabs_3de6d666e7", "mime": "image/jpeg", "name": "thumbnail_formlabs.jpeg", "path": null, "size": 4.05, "width": 156, "height": 156, "sizeInBytes": 4045}}	formlabs_3de6d666e7	.jpeg	image/jpeg	4.57	/uploads/formlabs_3de6d666e7.jpeg	\N	local	\N	/1	2025-04-15 17:47:29.162	2025-04-15 17:47:29.162	2025-04-15 17:47:29.162	1	1	\N
11	d8d5u9o74d27tgrdt7rxyp92	fysetc.png	\N	\N	224	224	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_fysetc_d83cdc2afb.png", "hash": "thumbnail_fysetc_d83cdc2afb", "mime": "image/png", "name": "thumbnail_fysetc.png", "path": null, "size": 6.92, "width": 156, "height": 156, "sizeInBytes": 6919}}	fysetc_d83cdc2afb	.png	image/png	2.64	/uploads/fysetc_d83cdc2afb.png	\N	local	\N	/1	2025-04-15 17:49:53.653	2025-04-15 17:49:53.653	2025-04-15 17:49:53.653	1	1	\N
12	u7mnce2fxyzkljewd6j1f26c	hiwin.jpeg	\N	\N	278	181	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_hiwin_e750cb70a4.jpeg", "hash": "thumbnail_hiwin_e750cb70a4", "mime": "image/jpeg", "name": "thumbnail_hiwin.jpeg", "path": null, "size": 8.61, "width": 240, "height": 156, "sizeInBytes": 8608}}	hiwin_e750cb70a4	.jpeg	image/jpeg	10.53	/uploads/hiwin_e750cb70a4.jpeg	\N	local	\N	/1	2025-04-15 17:51:40.666	2025-04-15 17:51:40.666	2025-04-15 17:51:40.666	1	1	\N
13	esxwtc1jnojecido1jaau68g	noctua_logo.webp	\N	\N	500	235	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_noctua_logo_0fde551047.webp", "hash": "thumbnail_noctua_logo_0fde551047", "mime": "image/webp", "name": "thumbnail_noctua_logo.webp", "path": null, "size": 2.34, "width": 245, "height": 115, "sizeInBytes": 2340}}	noctua_logo_0fde551047	.webp	image/webp	4.21	/uploads/noctua_logo_0fde551047.webp	\N	local	\N	/1	2025-04-15 17:52:56.178	2025-04-15 17:52:56.178	2025-04-15 17:52:56.178	1	1	\N
14	j8693mp2hed6sizir956qd7p	nova3d.webp	\N	\N	1500	1500	{"large": {"ext": ".webp", "url": "/uploads/large_nova3d_d96c3e1969.webp", "hash": "large_nova3d_d96c3e1969", "mime": "image/webp", "name": "large_nova3d.webp", "path": null, "size": 14.9, "width": 1000, "height": 1000, "sizeInBytes": 14898}, "small": {"ext": ".webp", "url": "/uploads/small_nova3d_d96c3e1969.webp", "hash": "small_nova3d_d96c3e1969", "mime": "image/webp", "name": "small_nova3d.webp", "path": null, "size": 7.44, "width": 500, "height": 500, "sizeInBytes": 7438}, "medium": {"ext": ".webp", "url": "/uploads/medium_nova3d_d96c3e1969.webp", "hash": "medium_nova3d_d96c3e1969", "mime": "image/webp", "name": "medium_nova3d.webp", "path": null, "size": 11.25, "width": 750, "height": 750, "sizeInBytes": 11248}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nova3d_d96c3e1969.webp", "hash": "thumbnail_nova3d_d96c3e1969", "mime": "image/webp", "name": "thumbnail_nova3d.webp", "path": null, "size": 2.41, "width": 156, "height": 156, "sizeInBytes": 2414}}	nova3d_d96c3e1969	.webp	image/webp	24.61	/uploads/nova3d_d96c3e1969.webp	\N	local	\N	/1	2025-04-15 17:54:34.324	2025-04-15 17:54:34.324	2025-04-15 17:54:34.324	1	1	\N
15	t8b9xid37lqo668q09fgh5dt	phrozen.png	\N	\N	512	212	{"small": {"ext": ".png", "url": "/uploads/small_phrozen_70f1704006.png", "hash": "small_phrozen_70f1704006", "mime": "image/png", "name": "small_phrozen.png", "path": null, "size": 20.43, "width": 500, "height": 207, "sizeInBytes": 20433}, "thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_phrozen_70f1704006.png", "hash": "thumbnail_phrozen_70f1704006", "mime": "image/png", "name": "thumbnail_phrozen.png", "path": null, "size": 9.11, "width": 245, "height": 101, "sizeInBytes": 9106}}	phrozen_70f1704006	.png	image/png	3.27	/uploads/phrozen_70f1704006.png	\N	local	\N	/1	2025-04-15 17:55:47.984	2025-04-15 17:55:47.984	2025-04-15 17:55:47.984	1	1	\N
16	kge0jg65npxyb6lqcapwd9tm	prusa.png	\N	\N	299	168	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_prusa_dab94fd52b.png", "hash": "thumbnail_prusa_dab94fd52b", "mime": "image/png", "name": "thumbnail_prusa.png", "path": null, "size": 14.48, "width": 245, "height": 138, "sizeInBytes": 14478}}	prusa_dab94fd52b	.png	image/png	4.18	/uploads/prusa_dab94fd52b.png	\N	local	\N	/1	2025-04-15 17:56:40.498	2025-04-15 17:56:40.498	2025-04-15 17:56:40.498	1	1	\N
17	rtpbct13cnygyl35h7vy2abu	qidi.avif	\N	\N	\N	\N	\N	qidi_06b6995d3a	.avif	image/avif	18.01	/uploads/qidi_06b6995d3a.avif	\N	local	\N	/1	2025-04-15 17:58:23.523	2025-04-15 17:58:23.523	2025-04-15 17:58:23.523	1	1	\N
18	pujfy2zhfg7ma9puectsj674	reprap.jpg	\N	\N	380	220	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_reprap_a3dc88edad.jpg", "hash": "thumbnail_reprap_a3dc88edad", "mime": "image/jpeg", "name": "thumbnail_reprap.jpg", "path": null, "size": 3.25, "width": 245, "height": 142, "sizeInBytes": 3254}}	reprap_a3dc88edad	.jpg	image/jpeg	5.43	/uploads/reprap_a3dc88edad.jpg	\N	local	\N	/1	2025-04-15 17:59:25.96	2025-04-15 17:59:25.96	2025-04-15 17:59:25.96	1	1	\N
19	ai7j93js4gz77852xho2rj2d	trianglelab.png	\N	\N	600	315	{"small": {"ext": ".png", "url": "/uploads/small_trianglelab_260f77b71f.png", "hash": "small_trianglelab_260f77b71f", "mime": "image/png", "name": "small_trianglelab.png", "path": null, "size": 46.74, "width": 500, "height": 263, "sizeInBytes": 46743}, "thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_trianglelab_260f77b71f.png", "hash": "thumbnail_trianglelab_260f77b71f", "mime": "image/png", "name": "thumbnail_trianglelab.png", "path": null, "size": 15.59, "width": 245, "height": 129, "sizeInBytes": 15589}}	trianglelab_260f77b71f	.png	image/png	8.81	/uploads/trianglelab_260f77b71f.png	\N	local	\N	/1	2025-04-15 18:00:45.078	2025-04-15 18:00:45.078	2025-04-15 18:00:45.078	1	1	\N
20	l8mczlay8tms56wu26dnk4ts	UltiMaker.jpg	\N	\N	1371	719	{"large": {"ext": ".jpg", "url": "/uploads/large_Ulti_Maker_a7d46c3b51.jpg", "hash": "large_Ulti_Maker_a7d46c3b51", "mime": "image/jpeg", "name": "large_UltiMaker.jpg", "path": null, "size": 17.8, "width": 1000, "height": 524, "sizeInBytes": 17798}, "small": {"ext": ".jpg", "url": "/uploads/small_Ulti_Maker_a7d46c3b51.jpg", "hash": "small_Ulti_Maker_a7d46c3b51", "mime": "image/jpeg", "name": "small_UltiMaker.jpg", "path": null, "size": 7.97, "width": 500, "height": 262, "sizeInBytes": 7970}, "medium": {"ext": ".jpg", "url": "/uploads/medium_Ulti_Maker_a7d46c3b51.jpg", "hash": "medium_Ulti_Maker_a7d46c3b51", "mime": "image/jpeg", "name": "medium_UltiMaker.jpg", "path": null, "size": 12.72, "width": 750, "height": 393, "sizeInBytes": 12718}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_Ulti_Maker_a7d46c3b51.jpg", "hash": "thumbnail_Ulti_Maker_a7d46c3b51", "mime": "image/jpeg", "name": "thumbnail_UltiMaker.jpg", "path": null, "size": 3.13, "width": 245, "height": 128, "sizeInBytes": 3130}}	Ulti_Maker_a7d46c3b51	.jpg	image/jpeg	25.83	/uploads/Ulti_Maker_a7d46c3b51.jpg	\N	local	\N	/1	2025-04-15 18:01:44.663	2025-04-15 18:01:44.663	2025-04-15 18:01:44.663	1	1	\N
21	z1i5v1oxwkrmkpcmfs3gv9i3	3DFils.jpg	\N	\N	300	200	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_3_D_Fils_deb58abfcd.jpg", "hash": "thumbnail_3_D_Fils_deb58abfcd", "mime": "image/jpeg", "name": "thumbnail_3DFils.jpg", "path": null, "size": 3.77, "width": 234, "height": 156, "sizeInBytes": 3765}}	3_D_Fils_deb58abfcd	.jpg	image/jpeg	5.37	/uploads/3_D_Fils_deb58abfcd.jpg	\N	local	\N	/1	2025-04-15 18:03:24.954	2025-04-15 18:03:24.954	2025-04-15 18:03:24.954	1	1	\N
22	yk8bya9yqsehlxot38ug9s6b	filamentum.png	\N	\N	337	192	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_filamentum_e50bfec318.png", "hash": "thumbnail_filamentum_e50bfec318", "mime": "image/png", "name": "thumbnail_filamentum.png", "path": null, "size": 14.85, "width": 245, "height": 140, "sizeInBytes": 14849}}	filamentum_e50bfec318	.png	image/png	5.68	/uploads/filamentum_e50bfec318.png	\N	local	\N	/1	2025-04-15 18:04:31.069	2025-04-15 18:04:31.069	2025-04-15 18:04:31.069	1	1	\N
23	kpxzywpf99beyrukgsjk1abl	polymaker.png	\N	\N	225	225	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_polymaker_7d611d0b69.png", "hash": "thumbnail_polymaker_7d611d0b69", "mime": "image/png", "name": "thumbnail_polymaker.png", "path": null, "size": 6.82, "width": 156, "height": 156, "sizeInBytes": 6819}}	polymaker_7d611d0b69	.png	image/png	2.71	/uploads/polymaker_7d611d0b69.png	\N	local	\N	/1	2025-04-15 18:05:45.027	2025-04-15 18:05:45.027	2025-04-15 18:05:45.027	1	1	\N
24	cg6fnuywtyimj1yhwlhqkiu5	prusa2.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_prusa2_abc3ff7116.webp", "hash": "small_prusa2_abc3ff7116", "mime": "image/webp", "name": "small_prusa2.webp", "path": null, "size": 12.34, "width": 500, "height": 375, "sizeInBytes": 12336}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_prusa2_abc3ff7116.webp", "hash": "thumbnail_prusa2_abc3ff7116", "mime": "image/webp", "name": "thumbnail_prusa2.webp", "path": null, "size": 3.94, "width": 208, "height": 156, "sizeInBytes": 3938}}	prusa2_abc3ff7116	.webp	image/webp	20.15	/uploads/prusa2_abc3ff7116.webp	\N	local	\N	/2/3	2025-04-15 20:17:14.163	2025-04-15 20:17:14.163	2025-04-15 20:17:14.163	1	1	\N
25	jenjhhe8w28y5teb1zvx2wlg	prusa3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_prusa3_d73196b9e5.webp", "hash": "small_prusa3_d73196b9e5", "mime": "image/webp", "name": "small_prusa3.webp", "path": null, "size": 13.08, "width": 375, "height": 500, "sizeInBytes": 13076}, "medium": {"ext": ".webp", "url": "/uploads/medium_prusa3_d73196b9e5.webp", "hash": "medium_prusa3_d73196b9e5", "mime": "image/webp", "name": "medium_prusa3.webp", "path": null, "size": 20.12, "width": 563, "height": 750, "sizeInBytes": 20118}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_prusa3_d73196b9e5.webp", "hash": "thumbnail_prusa3_d73196b9e5", "mime": "image/webp", "name": "thumbnail_prusa3.webp", "path": null, "size": 3.06, "width": 117, "height": 156, "sizeInBytes": 3064}}	prusa3_d73196b9e5	.webp	image/webp	27.22	/uploads/prusa3_d73196b9e5.webp	\N	local	\N	/2/3	2025-04-15 20:17:14.181	2025-04-15 20:17:14.181	2025-04-15 20:17:14.181	1	1	\N
26	z6wurdfl1staaub0elxnhgur	prusa1.webp	\N	\N	640	1031	{"large": {"ext": ".webp", "url": "/uploads/large_prusa1_9254fe62e2.webp", "hash": "large_prusa1_9254fe62e2", "mime": "image/webp", "name": "large_prusa1.webp", "path": null, "size": 42.98, "width": 621, "height": 1000, "sizeInBytes": 42982}, "small": {"ext": ".webp", "url": "/uploads/small_prusa1_9254fe62e2.webp", "hash": "small_prusa1_9254fe62e2", "mime": "image/webp", "name": "small_prusa1.webp", "path": null, "size": 15.43, "width": 310, "height": 500, "sizeInBytes": 15430}, "medium": {"ext": ".webp", "url": "/uploads/medium_prusa1_9254fe62e2.webp", "hash": "medium_prusa1_9254fe62e2", "mime": "image/webp", "name": "medium_prusa1.webp", "path": null, "size": 28.59, "width": 466, "height": 750, "sizeInBytes": 28590}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_prusa1_9254fe62e2.webp", "hash": "thumbnail_prusa1_9254fe62e2", "mime": "image/webp", "name": "thumbnail_prusa1.webp", "path": null, "size": 2.93, "width": 97, "height": 156, "sizeInBytes": 2934}}	prusa1_9254fe62e2	.webp	image/webp	57.13	/uploads/prusa1_9254fe62e2.webp	\N	local	\N	/2/3	2025-04-15 20:17:14.218	2025-04-15 20:17:14.218	2025-04-15 20:17:14.218	1	1	\N
27	nwe4f73emz2p5aupo83re944	prusa5.webp	\N	\N	640	823	{"small": {"ext": ".webp", "url": "/uploads/small_prusa5_91f6e4089f.webp", "hash": "small_prusa5_91f6e4089f", "mime": "image/webp", "name": "small_prusa5.webp", "path": null, "size": 22.36, "width": 389, "height": 500, "sizeInBytes": 22360}, "medium": {"ext": ".webp", "url": "/uploads/medium_prusa5_91f6e4089f.webp", "hash": "medium_prusa5_91f6e4089f", "mime": "image/webp", "name": "medium_prusa5.webp", "path": null, "size": 43.67, "width": 583, "height": 750, "sizeInBytes": 43670}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_prusa5_91f6e4089f.webp", "hash": "thumbnail_prusa5_91f6e4089f", "mime": "image/webp", "name": "thumbnail_prusa5.webp", "path": null, "size": 2.81, "width": 121, "height": 156, "sizeInBytes": 2812}}	prusa5_91f6e4089f	.webp	image/webp	68.56	/uploads/prusa5_91f6e4089f.webp	\N	local	\N	/2/3	2025-04-15 20:17:14.219	2025-04-15 20:17:14.219	2025-04-15 20:17:14.219	1	1	\N
28	g9eaaq21z8bwap6s5c6x3obm	prusa4.webp	\N	\N	640	1180	{"large": {"ext": ".webp", "url": "/uploads/large_prusa4_61e2ed5e0c.webp", "hash": "large_prusa4_61e2ed5e0c", "mime": "image/webp", "name": "large_prusa4.webp", "path": null, "size": 28.3, "width": 542, "height": 1000, "sizeInBytes": 28296}, "small": {"ext": ".webp", "url": "/uploads/small_prusa4_61e2ed5e0c.webp", "hash": "small_prusa4_61e2ed5e0c", "mime": "image/webp", "name": "small_prusa4.webp", "path": null, "size": 11.67, "width": 271, "height": 500, "sizeInBytes": 11668}, "medium": {"ext": ".webp", "url": "/uploads/medium_prusa4_61e2ed5e0c.webp", "hash": "medium_prusa4_61e2ed5e0c", "mime": "image/webp", "name": "medium_prusa4.webp", "path": null, "size": 19.66, "width": 407, "height": 750, "sizeInBytes": 19658}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_prusa4_61e2ed5e0c.webp", "hash": "thumbnail_prusa4_61e2ed5e0c", "mime": "image/webp", "name": "thumbnail_prusa4.webp", "path": null, "size": 2.67, "width": 85, "height": 156, "sizeInBytes": 2672}}	prusa4_61e2ed5e0c	.webp	image/webp	39.72	/uploads/prusa4_61e2ed5e0c.webp	\N	local	\N	/2/3	2025-04-15 20:17:14.233	2025-04-15 20:17:14.233	2025-04-15 20:17:14.233	1	1	\N
29	lccpc69l0uxfhq50n25bomah	ender4.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_ender4_d5cc0c3054.webp", "hash": "small_ender4_d5cc0c3054", "mime": "image/webp", "name": "small_ender4.webp", "path": null, "size": 17.03, "width": 500, "height": 375, "sizeInBytes": 17028}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ender4_d5cc0c3054.webp", "hash": "thumbnail_ender4_d5cc0c3054", "mime": "image/webp", "name": "thumbnail_ender4.webp", "path": null, "size": 4.99, "width": 208, "height": 156, "sizeInBytes": 4988}}	ender4_d5cc0c3054	.webp	image/webp	29.52	/uploads/ender4_d5cc0c3054.webp	\N	local	\N	/2/4	2025-04-15 20:23:52.746	2025-04-15 20:23:52.746	2025-04-15 20:23:52.746	1	1	\N
30	avq4jtpkeshv2dzk58bnzlkf	ender3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ender3_b0bcbcd378.webp", "hash": "small_ender3_b0bcbcd378", "mime": "image/webp", "name": "small_ender3.webp", "path": null, "size": 20.15, "width": 375, "height": 500, "sizeInBytes": 20150}, "medium": {"ext": ".webp", "url": "/uploads/medium_ender3_b0bcbcd378.webp", "hash": "medium_ender3_b0bcbcd378", "mime": "image/webp", "name": "medium_ender3.webp", "path": null, "size": 33.51, "width": 563, "height": 750, "sizeInBytes": 33510}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ender3_b0bcbcd378.webp", "hash": "thumbnail_ender3_b0bcbcd378", "mime": "image/webp", "name": "thumbnail_ender3.webp", "path": null, "size": 3.96, "width": 117, "height": 156, "sizeInBytes": 3960}}	ender3_b0bcbcd378	.webp	image/webp	49.26	/uploads/ender3_b0bcbcd378.webp	\N	local	\N	/2/4	2025-04-15 20:23:52.787	2025-04-15 20:23:52.787	2025-04-15 20:23:52.787	1	1	\N
31	g3x0x899w7e5vagbat1gp55m	ender6.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ender6_6f6b9a3902.webp", "hash": "small_ender6_6f6b9a3902", "mime": "image/webp", "name": "small_ender6.webp", "path": null, "size": 13.73, "width": 375, "height": 500, "sizeInBytes": 13732}, "medium": {"ext": ".webp", "url": "/uploads/medium_ender6_6f6b9a3902.webp", "hash": "medium_ender6_6f6b9a3902", "mime": "image/webp", "name": "medium_ender6.webp", "path": null, "size": 21.02, "width": 563, "height": 750, "sizeInBytes": 21020}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ender6_6f6b9a3902.webp", "hash": "thumbnail_ender6_6f6b9a3902", "mime": "image/webp", "name": "thumbnail_ender6.webp", "path": null, "size": 3.49, "width": 117, "height": 156, "sizeInBytes": 3488}}	ender6_6f6b9a3902	.webp	image/webp	26.50	/uploads/ender6_6f6b9a3902.webp	\N	local	\N	/2/4	2025-04-15 20:23:52.788	2025-04-15 20:23:52.788	2025-04-15 20:23:52.788	1	1	\N
32	zc9be5b3gseomdxgsxv4suzr	ender2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ender2_a013be39b5.webp", "hash": "small_ender2_a013be39b5", "mime": "image/webp", "name": "small_ender2.webp", "path": null, "size": 27.31, "width": 375, "height": 500, "sizeInBytes": 27314}, "medium": {"ext": ".webp", "url": "/uploads/medium_ender2_a013be39b5.webp", "hash": "medium_ender2_a013be39b5", "mime": "image/webp", "name": "medium_ender2.webp", "path": null, "size": 47.41, "width": 563, "height": 750, "sizeInBytes": 47412}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ender2_a013be39b5.webp", "hash": "thumbnail_ender2_a013be39b5", "mime": "image/webp", "name": "thumbnail_ender2.webp", "path": null, "size": 4.93, "width": 117, "height": 156, "sizeInBytes": 4932}}	ender2_a013be39b5	.webp	image/webp	69.14	/uploads/ender2_a013be39b5.webp	\N	local	\N	/2/4	2025-04-15 20:23:52.8	2025-04-15 20:23:52.8	2025-04-15 20:23:52.801	1	1	\N
33	ucyrellf5vek7ekejutcvguo	ender1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ender1_65f8700898.webp", "hash": "small_ender1_65f8700898", "mime": "image/webp", "name": "small_ender1.webp", "path": null, "size": 20.72, "width": 375, "height": 500, "sizeInBytes": 20722}, "medium": {"ext": ".webp", "url": "/uploads/medium_ender1_65f8700898.webp", "hash": "medium_ender1_65f8700898", "mime": "image/webp", "name": "medium_ender1.webp", "path": null, "size": 41.99, "width": 563, "height": 750, "sizeInBytes": 41988}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ender1_65f8700898.webp", "hash": "thumbnail_ender1_65f8700898", "mime": "image/webp", "name": "thumbnail_ender1.webp", "path": null, "size": 3.42, "width": 117, "height": 156, "sizeInBytes": 3420}}	ender1_65f8700898	.webp	image/webp	75.68	/uploads/ender1_65f8700898.webp	\N	local	\N	/2/4	2025-04-15 20:23:52.813	2025-04-15 20:23:52.813	2025-04-15 20:23:52.813	1	1	\N
34	nig3blo5zi0rb3bdxnmum0at	ender5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ender5_4b300446dc.webp", "hash": "small_ender5_4b300446dc", "mime": "image/webp", "name": "small_ender5.webp", "path": null, "size": 21.44, "width": 375, "height": 500, "sizeInBytes": 21436}, "medium": {"ext": ".webp", "url": "/uploads/medium_ender5_4b300446dc.webp", "hash": "medium_ender5_4b300446dc", "mime": "image/webp", "name": "medium_ender5.webp", "path": null, "size": 35, "width": 563, "height": 750, "sizeInBytes": 34998}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ender5_4b300446dc.webp", "hash": "thumbnail_ender5_4b300446dc", "mime": "image/webp", "name": "thumbnail_ender5.webp", "path": null, "size": 4.11, "width": 117, "height": 156, "sizeInBytes": 4110}}	ender5_4b300446dc	.webp	image/webp	51.00	/uploads/ender5_4b300446dc.webp	\N	local	\N	/2/4	2025-04-15 20:23:52.829	2025-04-15 20:23:52.829	2025-04-15 20:23:52.829	1	1	\N
35	cokumz5t5lax2ty5ke8qxpem	ultimaker4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ultimaker4_6200637190.webp", "hash": "small_ultimaker4_6200637190", "mime": "image/webp", "name": "small_ultimaker4.webp", "path": null, "size": 11.27, "width": 375, "height": 500, "sizeInBytes": 11268}, "medium": {"ext": ".webp", "url": "/uploads/medium_ultimaker4_6200637190.webp", "hash": "medium_ultimaker4_6200637190", "mime": "image/webp", "name": "medium_ultimaker4.webp", "path": null, "size": 18.82, "width": 563, "height": 750, "sizeInBytes": 18820}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ultimaker4_6200637190.webp", "hash": "thumbnail_ultimaker4_6200637190", "mime": "image/webp", "name": "thumbnail_ultimaker4.webp", "path": null, "size": 2.34, "width": 117, "height": 156, "sizeInBytes": 2342}}	ultimaker4_6200637190	.webp	image/webp	26.07	/uploads/ultimaker4_6200637190.webp	\N	local	\N	/2/5	2025-04-15 20:28:44.354	2025-04-15 20:28:44.354	2025-04-15 20:28:44.355	1	1	\N
36	l2re3zkibeo7iu62nqqxzrq0	ultimaker3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ultimaker3_5bee80051f.webp", "hash": "small_ultimaker3_5bee80051f", "mime": "image/webp", "name": "small_ultimaker3.webp", "path": null, "size": 11.42, "width": 375, "height": 500, "sizeInBytes": 11418}, "medium": {"ext": ".webp", "url": "/uploads/medium_ultimaker3_5bee80051f.webp", "hash": "medium_ultimaker3_5bee80051f", "mime": "image/webp", "name": "medium_ultimaker3.webp", "path": null, "size": 18.25, "width": 563, "height": 750, "sizeInBytes": 18250}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ultimaker3_5bee80051f.webp", "hash": "thumbnail_ultimaker3_5bee80051f", "mime": "image/webp", "name": "thumbnail_ultimaker3.webp", "path": null, "size": 2.28, "width": 117, "height": 156, "sizeInBytes": 2278}}	ultimaker3_5bee80051f	.webp	image/webp	25.06	/uploads/ultimaker3_5bee80051f.webp	\N	local	\N	/2/5	2025-04-15 20:28:44.354	2025-04-15 20:28:44.354	2025-04-15 20:28:44.354	1	1	\N
37	ynz95f1t9j588z8vy85tyx3e	ultimaker1.webp	\N	\N	640	1044	{"large": {"ext": ".webp", "url": "/uploads/large_ultimaker1_d259cebda9.webp", "hash": "large_ultimaker1_d259cebda9", "mime": "image/webp", "name": "large_ultimaker1.webp", "path": null, "size": 31.72, "width": 613, "height": 1000, "sizeInBytes": 31716}, "small": {"ext": ".webp", "url": "/uploads/small_ultimaker1_d259cebda9.webp", "hash": "small_ultimaker1_d259cebda9", "mime": "image/webp", "name": "small_ultimaker1.webp", "path": null, "size": 12.54, "width": 307, "height": 500, "sizeInBytes": 12536}, "medium": {"ext": ".webp", "url": "/uploads/medium_ultimaker1_d259cebda9.webp", "hash": "medium_ultimaker1_d259cebda9", "mime": "image/webp", "name": "medium_ultimaker1.webp", "path": null, "size": 21.35, "width": 460, "height": 750, "sizeInBytes": 21352}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ultimaker1_d259cebda9.webp", "hash": "thumbnail_ultimaker1_d259cebda9", "mime": "image/webp", "name": "thumbnail_ultimaker1.webp", "path": null, "size": 2.35, "width": 96, "height": 156, "sizeInBytes": 2352}}	ultimaker1_d259cebda9	.webp	image/webp	40.05	/uploads/ultimaker1_d259cebda9.webp	\N	local	\N	/2/5	2025-04-15 20:28:44.358	2025-04-15 20:28:44.358	2025-04-15 20:28:44.358	1	1	\N
38	q16lzlx4dde88y19k7j0cw4m	ultimaker2.webp	\N	\N	640	903	{"small": {"ext": ".webp", "url": "/uploads/small_ultimaker2_937d0a5722.webp", "hash": "small_ultimaker2_937d0a5722", "mime": "image/webp", "name": "small_ultimaker2.webp", "path": null, "size": 19.52, "width": 354, "height": 500, "sizeInBytes": 19524}, "medium": {"ext": ".webp", "url": "/uploads/medium_ultimaker2_937d0a5722.webp", "hash": "medium_ultimaker2_937d0a5722", "mime": "image/webp", "name": "medium_ultimaker2.webp", "path": null, "size": 33.47, "width": 532, "height": 750, "sizeInBytes": 33470}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ultimaker2_937d0a5722.webp", "hash": "thumbnail_ultimaker2_937d0a5722", "mime": "image/webp", "name": "thumbnail_ultimaker2.webp", "path": null, "size": 3.46, "width": 111, "height": 156, "sizeInBytes": 3460}}	ultimaker2_937d0a5722	.webp	image/webp	52.43	/uploads/ultimaker2_937d0a5722.webp	\N	local	\N	/2/5	2025-04-15 20:28:44.367	2025-04-15 20:28:44.367	2025-04-15 20:28:44.367	1	1	\N
39	o50xmrr7j77f47s2g9939gpk	form3.webp	\N	\N	640	440	{"small": {"ext": ".webp", "url": "/uploads/small_form3_69c69eafde.webp", "hash": "small_form3_69c69eafde", "mime": "image/webp", "name": "small_form3.webp", "path": null, "size": 5.77, "width": 500, "height": 344, "sizeInBytes": 5770}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_form3_69c69eafde.webp", "hash": "thumbnail_form3_69c69eafde", "mime": "image/webp", "name": "thumbnail_form3.webp", "path": null, "size": 2.19, "width": 227, "height": 156, "sizeInBytes": 2188}}	form3_69c69eafde	.webp	image/webp	9.09	/uploads/form3_69c69eafde.webp	\N	local	\N	/2/6	2025-04-15 20:33:19.506	2025-04-15 20:33:19.506	2025-04-15 20:33:19.506	1	1	\N
40	f3zzdrud467608vrrtj7sg7k	form2.webp	\N	\N	640	434	{"small": {"ext": ".webp", "url": "/uploads/small_form2_d168239057.webp", "hash": "small_form2_d168239057", "mime": "image/webp", "name": "small_form2.webp", "path": null, "size": 12.14, "width": 500, "height": 339, "sizeInBytes": 12144}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_form2_d168239057.webp", "hash": "thumbnail_form2_d168239057", "mime": "image/webp", "name": "thumbnail_form2.webp", "path": null, "size": 4.85, "width": 230, "height": 156, "sizeInBytes": 4852}}	form2_d168239057	.webp	image/webp	18.79	/uploads/form2_d168239057.webp	\N	local	\N	/2/6	2025-04-15 20:33:19.508	2025-04-15 20:33:19.508	2025-04-15 20:33:19.508	1	1	\N
41	y9o457pm41qet0l1x5v3i9um	form1.webp	\N	\N	640	895	{"small": {"ext": ".webp", "url": "/uploads/small_form1_2e42508172.webp", "hash": "small_form1_2e42508172", "mime": "image/webp", "name": "small_form1.webp", "path": null, "size": 10.35, "width": 358, "height": 500, "sizeInBytes": 10346}, "medium": {"ext": ".webp", "url": "/uploads/medium_form1_2e42508172.webp", "hash": "medium_form1_2e42508172", "mime": "image/webp", "name": "medium_form1.webp", "path": null, "size": 16.67, "width": 536, "height": 750, "sizeInBytes": 16672}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_form1_2e42508172.webp", "hash": "thumbnail_form1_2e42508172", "mime": "image/webp", "name": "thumbnail_form1.webp", "path": null, "size": 2.37, "width": 112, "height": 156, "sizeInBytes": 2370}}	form1_2e42508172	.webp	image/webp	24.06	/uploads/form1_2e42508172.webp	\N	local	\N	/2/6	2025-04-15 20:33:19.536	2025-04-15 20:33:19.536	2025-04-15 20:33:19.536	1	1	\N
42	xsn900c2p3uh5sqpxc8emhm4	kobra1.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_kobra1_550e7c6fbc.webp", "hash": "small_kobra1_550e7c6fbc", "mime": "image/webp", "name": "small_kobra1.webp", "path": null, "size": 12.09, "width": 500, "height": 375, "sizeInBytes": 12090}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra1_550e7c6fbc.webp", "hash": "thumbnail_kobra1_550e7c6fbc", "mime": "image/webp", "name": "thumbnail_kobra1.webp", "path": null, "size": 4.2, "width": 208, "height": 156, "sizeInBytes": 4202}}	kobra1_550e7c6fbc	.webp	image/webp	18.69	/uploads/kobra1_550e7c6fbc.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.492	2025-04-15 20:39:01.492	2025-04-15 20:39:01.492	1	1	\N
43	ypdsl8j9g1boevfv1lr28z41	kobra2.webp	\N	\N	640	524	{"small": {"ext": ".webp", "url": "/uploads/small_kobra2_49aa776d22.webp", "hash": "small_kobra2_49aa776d22", "mime": "image/webp", "name": "small_kobra2.webp", "path": null, "size": 14.36, "width": 500, "height": 409, "sizeInBytes": 14356}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra2_49aa776d22.webp", "hash": "thumbnail_kobra2_49aa776d22", "mime": "image/webp", "name": "thumbnail_kobra2.webp", "path": null, "size": 4.06, "width": 191, "height": 156, "sizeInBytes": 4062}}	kobra2_49aa776d22	.webp	image/webp	23.47	/uploads/kobra2_49aa776d22.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.525	2025-04-15 20:39:01.525	2025-04-15 20:39:01.525	1	1	\N
44	ul4y3018t9llaq1hyj3rmn1c	kobra4.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_kobra4_026d29b6c3.webp", "hash": "small_kobra4_026d29b6c3", "mime": "image/webp", "name": "small_kobra4.webp", "path": null, "size": 14.14, "width": 500, "height": 375, "sizeInBytes": 14144}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra4_026d29b6c3.webp", "hash": "thumbnail_kobra4_026d29b6c3", "mime": "image/webp", "name": "thumbnail_kobra4.webp", "path": null, "size": 4.32, "width": 208, "height": 156, "sizeInBytes": 4318}}	kobra4_026d29b6c3	.webp	image/webp	22.54	/uploads/kobra4_026d29b6c3.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.542	2025-04-15 20:39:01.542	2025-04-15 20:39:01.543	1	1	\N
45	ivoakwxgjrwnc8pz0zz0uler	kobra5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_kobra5_729716f59d.webp", "hash": "small_kobra5_729716f59d", "mime": "image/webp", "name": "small_kobra5.webp", "path": null, "size": 9.05, "width": 375, "height": 500, "sizeInBytes": 9048}, "medium": {"ext": ".webp", "url": "/uploads/medium_kobra5_729716f59d.webp", "hash": "medium_kobra5_729716f59d", "mime": "image/webp", "name": "medium_kobra5.webp", "path": null, "size": 16.25, "width": 563, "height": 750, "sizeInBytes": 16252}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra5_729716f59d.webp", "hash": "thumbnail_kobra5_729716f59d", "mime": "image/webp", "name": "thumbnail_kobra5.webp", "path": null, "size": 1.76, "width": 117, "height": 156, "sizeInBytes": 1760}}	kobra5_729716f59d	.webp	image/webp	24.65	/uploads/kobra5_729716f59d.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.55	2025-04-15 20:39:01.55	2025-04-15 20:39:01.55	1	1	\N
48	anvctomdv7fdseld7vieeo5g	kobra7.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_kobra7_37afc15b5a.webp", "hash": "small_kobra7_37afc15b5a", "mime": "image/webp", "name": "small_kobra7.webp", "path": null, "size": 13.34, "width": 500, "height": 375, "sizeInBytes": 13336}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra7_37afc15b5a.webp", "hash": "thumbnail_kobra7_37afc15b5a", "mime": "image/webp", "name": "thumbnail_kobra7.webp", "path": null, "size": 4.45, "width": 208, "height": 156, "sizeInBytes": 4450}}	kobra7_37afc15b5a	.webp	image/webp	20.98	/uploads/kobra7_37afc15b5a.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.61	2025-04-15 20:39:01.61	2025-04-15 20:39:01.61	1	1	\N
46	t7h2z2bpjbrfbjx1s6pibwbr	kobra6.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_kobra6_35ebfae7c5.webp", "hash": "small_kobra6_35ebfae7c5", "mime": "image/webp", "name": "small_kobra6.webp", "path": null, "size": 11.62, "width": 375, "height": 500, "sizeInBytes": 11620}, "medium": {"ext": ".webp", "url": "/uploads/medium_kobra6_35ebfae7c5.webp", "hash": "medium_kobra6_35ebfae7c5", "mime": "image/webp", "name": "medium_kobra6.webp", "path": null, "size": 19.49, "width": 563, "height": 750, "sizeInBytes": 19490}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra6_35ebfae7c5.webp", "hash": "thumbnail_kobra6_35ebfae7c5", "mime": "image/webp", "name": "thumbnail_kobra6.webp", "path": null, "size": 2.63, "width": 117, "height": 156, "sizeInBytes": 2634}}	kobra6_35ebfae7c5	.webp	image/webp	28.21	/uploads/kobra6_35ebfae7c5.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.557	2025-04-15 20:39:01.557	2025-04-15 20:39:01.557	1	1	\N
47	hoxsn4f6u6p2bn6sbrrq1h2u	kobra3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_kobra3_1641889c7f.webp", "hash": "small_kobra3_1641889c7f", "mime": "image/webp", "name": "small_kobra3.webp", "path": null, "size": 40.84, "width": 375, "height": 500, "sizeInBytes": 40842}, "medium": {"ext": ".webp", "url": "/uploads/medium_kobra3_1641889c7f.webp", "hash": "medium_kobra3_1641889c7f", "mime": "image/webp", "name": "medium_kobra3.webp", "path": null, "size": 94.42, "width": 563, "height": 750, "sizeInBytes": 94416}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra3_1641889c7f.webp", "hash": "thumbnail_kobra3_1641889c7f", "mime": "image/webp", "name": "thumbnail_kobra3.webp", "path": null, "size": 3.57, "width": 117, "height": 156, "sizeInBytes": 3566}}	kobra3_1641889c7f	.webp	image/webp	157.79	/uploads/kobra3_1641889c7f.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.602	2025-04-15 20:39:01.602	2025-04-15 20:39:01.602	1	1	\N
49	ivvo3b3sv2dp1cyq1ec8dlyz	kobra8.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_kobra8_32bd100fc8.webp", "hash": "small_kobra8_32bd100fc8", "mime": "image/webp", "name": "small_kobra8.webp", "path": null, "size": 12.69, "width": 500, "height": 375, "sizeInBytes": 12686}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_kobra8_32bd100fc8.webp", "hash": "thumbnail_kobra8_32bd100fc8", "mime": "image/webp", "name": "thumbnail_kobra8.webp", "path": null, "size": 4.06, "width": 208, "height": 156, "sizeInBytes": 4058}}	kobra8_32bd100fc8	.webp	image/webp	19.90	/uploads/kobra8_32bd100fc8.webp	\N	local	\N	/2/7	2025-04-15 20:39:01.632	2025-04-15 20:39:01.632	2025-04-15 20:39:01.633	1	1	\N
50	gehmcp6c69rg4954yk1f4w0b	photon4.webp	\N	\N	640	482	{"small": {"ext": ".webp", "url": "/uploads/small_photon4_714ac211a9.webp", "hash": "small_photon4_714ac211a9", "mime": "image/webp", "name": "small_photon4.webp", "path": null, "size": 10.35, "width": 500, "height": 377, "sizeInBytes": 10346}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon4_714ac211a9.webp", "hash": "thumbnail_photon4_714ac211a9", "mime": "image/webp", "name": "thumbnail_photon4.webp", "path": null, "size": 3.89, "width": 207, "height": 156, "sizeInBytes": 3894}}	photon4_714ac211a9	.webp	image/webp	15.34	/uploads/photon4_714ac211a9.webp	\N	local	\N	/2/7	2025-04-15 20:44:01.777	2025-04-15 20:44:01.777	2025-04-15 20:44:01.777	1	1	\N
51	cqlk1ctz1m6ozivaeo2m4wma	photon1.webp	\N	\N	640	851	{"small": {"ext": ".webp", "url": "/uploads/small_photon1_45d865fcfe.webp", "hash": "small_photon1_45d865fcfe", "mime": "image/webp", "name": "small_photon1.webp", "path": null, "size": 13.76, "width": 376, "height": 500, "sizeInBytes": 13756}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon1_45d865fcfe.webp", "hash": "medium_photon1_45d865fcfe", "mime": "image/webp", "name": "medium_photon1.webp", "path": null, "size": 21.46, "width": 564, "height": 750, "sizeInBytes": 21460}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon1_45d865fcfe.webp", "hash": "thumbnail_photon1_45d865fcfe", "mime": "image/webp", "name": "thumbnail_photon1.webp", "path": null, "size": 3.11, "width": 117, "height": 156, "sizeInBytes": 3108}}	photon1_45d865fcfe	.webp	image/webp	28.29	/uploads/photon1_45d865fcfe.webp	\N	local	\N	/2/7	2025-04-15 20:44:01.778	2025-04-15 20:44:01.778	2025-04-15 20:44:01.778	1	1	\N
52	vdvz5ym4zampo82yfkzq7w9r	photon6.webp	\N	\N	640	482	{"small": {"ext": ".webp", "url": "/uploads/small_photon6_78bbe4612d.webp", "hash": "small_photon6_78bbe4612d", "mime": "image/webp", "name": "small_photon6.webp", "path": null, "size": 12.88, "width": 500, "height": 377, "sizeInBytes": 12884}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon6_78bbe4612d.webp", "hash": "thumbnail_photon6_78bbe4612d", "mime": "image/webp", "name": "thumbnail_photon6.webp", "path": null, "size": 3.58, "width": 207, "height": 156, "sizeInBytes": 3576}}	photon6_78bbe4612d	.webp	image/webp	23.83	/uploads/photon6_78bbe4612d.webp	\N	local	\N	/2/7	2025-04-15 20:44:01.794	2025-04-15 20:44:01.794	2025-04-15 20:44:01.794	1	1	\N
53	ws3wc3hqb227hbffhxpay33y	photon5.webp	\N	\N	640	482	{"small": {"ext": ".webp", "url": "/uploads/small_photon5_5da2d6c437.webp", "hash": "small_photon5_5da2d6c437", "mime": "image/webp", "name": "small_photon5.webp", "path": null, "size": 15.5, "width": 500, "height": 377, "sizeInBytes": 15496}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon5_5da2d6c437.webp", "hash": "thumbnail_photon5_5da2d6c437", "mime": "image/webp", "name": "thumbnail_photon5.webp", "path": null, "size": 5.25, "width": 207, "height": 156, "sizeInBytes": 5246}}	photon5_5da2d6c437	.webp	image/webp	24.43	/uploads/photon5_5da2d6c437.webp	\N	local	\N	/2/7	2025-04-15 20:44:01.805	2025-04-15 20:44:01.805	2025-04-15 20:44:01.805	1	1	\N
54	lmn3vv1hwy9fwt99u6iljr36	photon2.webp	\N	\N	640	851	{"small": {"ext": ".webp", "url": "/uploads/small_photon2_650ec00e6f.webp", "hash": "small_photon2_650ec00e6f", "mime": "image/webp", "name": "small_photon2.webp", "path": null, "size": 17.02, "width": 376, "height": 500, "sizeInBytes": 17020}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon2_650ec00e6f.webp", "hash": "medium_photon2_650ec00e6f", "mime": "image/webp", "name": "medium_photon2.webp", "path": null, "size": 26.77, "width": 564, "height": 750, "sizeInBytes": 26772}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon2_650ec00e6f.webp", "hash": "thumbnail_photon2_650ec00e6f", "mime": "image/webp", "name": "thumbnail_photon2.webp", "path": null, "size": 3.64, "width": 117, "height": 156, "sizeInBytes": 3644}}	photon2_650ec00e6f	.webp	image/webp	36.84	/uploads/photon2_650ec00e6f.webp	\N	local	\N	/2/7	2025-04-15 20:44:01.805	2025-04-15 20:44:01.805	2025-04-15 20:44:01.805	1	1	\N
273	ttmafli3yri54rjydxjb1xnv	verd2.webp	\N	\N	304	304	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_verd2_b5e94cf330.webp", "hash": "thumbnail_verd2_b5e94cf330", "mime": "image/webp", "name": "thumbnail_verd2.webp", "path": null, "size": 4.07, "width": 156, "height": 156, "sizeInBytes": 4066}}	verd2_b5e94cf330	.webp	image/webp	12.45	/uploads/verd2_b5e94cf330.webp	\N	local	\N	/2/7	2025-04-17 11:46:39.912	2025-04-17 11:46:39.912	2025-04-17 11:46:39.912	1	1	\N
55	pafek8wga33vkc7qhyorlavt	photon3.webp	\N	\N	640	851	{"small": {"ext": ".webp", "url": "/uploads/small_photon3_49dd9a86a6.webp", "hash": "small_photon3_49dd9a86a6", "mime": "image/webp", "name": "small_photon3.webp", "path": null, "size": 10.74, "width": 376, "height": 500, "sizeInBytes": 10738}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon3_49dd9a86a6.webp", "hash": "medium_photon3_49dd9a86a6", "mime": "image/webp", "name": "medium_photon3.webp", "path": null, "size": 17.28, "width": 564, "height": 750, "sizeInBytes": 17280}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon3_49dd9a86a6.webp", "hash": "thumbnail_photon3_49dd9a86a6", "mime": "image/webp", "name": "thumbnail_photon3.webp", "path": null, "size": 2.37, "width": 117, "height": 156, "sizeInBytes": 2372}}	photon3_49dd9a86a6	.webp	image/webp	24.34	/uploads/photon3_49dd9a86a6.webp	\N	local	\N	/2/7	2025-04-15 20:44:01.805	2025-04-15 20:44:01.805	2025-04-15 20:44:01.805	1	1	\N
56	ppllw26x3a8go67jnie8zdbu	photon7.webp	\N	\N	640	851	{"small": {"ext": ".webp", "url": "/uploads/small_photon7_99172542bb.webp", "hash": "small_photon7_99172542bb", "mime": "image/webp", "name": "small_photon7.webp", "path": null, "size": 15.87, "width": 376, "height": 500, "sizeInBytes": 15870}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon7_99172542bb.webp", "hash": "medium_photon7_99172542bb", "mime": "image/webp", "name": "medium_photon7.webp", "path": null, "size": 25.63, "width": 564, "height": 750, "sizeInBytes": 25630}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon7_99172542bb.webp", "hash": "thumbnail_photon7_99172542bb", "mime": "image/webp", "name": "thumbnail_photon7.webp", "path": null, "size": 3.4, "width": 117, "height": 156, "sizeInBytes": 3398}}	photon7_99172542bb	.webp	image/webp	34.83	/uploads/photon7_99172542bb.webp	\N	local	\N	/2/7	2025-04-15 20:44:01.895	2025-04-15 20:44:01.895	2025-04-15 20:44:01.895	1	1	\N
254	aw33bd7x4euv1fclynnqz7ya	petg2.webp	\N	\N	304	304	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_petg2_b4e81e45d5.webp", "hash": "thumbnail_petg2_b4e81e45d5", "mime": "image/webp", "name": "thumbnail_petg2.webp", "path": null, "size": 4.71, "width": 156, "height": 156, "sizeInBytes": 4714}}	petg2_b4e81e45d5	.webp	image/webp	14.74	/uploads/petg2_b4e81e45d5.webp	\N	local	\N	/2/8	2025-04-17 11:05:20.404	2025-04-17 11:05:20.404	2025-04-17 11:05:20.405	1	1	\N
57	c7ts2g4f4v8s5b1qeqhckghb	bambu2.webp	\N	\N	640	481	{"small": {"ext": ".webp", "url": "/uploads/small_bambu2_7a5f185bbe.webp", "hash": "small_bambu2_7a5f185bbe", "mime": "image/webp", "name": "small_bambu2.webp", "path": null, "size": 10.45, "width": 500, "height": 376, "sizeInBytes": 10454}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bambu2_7a5f185bbe.webp", "hash": "thumbnail_bambu2_7a5f185bbe", "mime": "image/webp", "name": "thumbnail_bambu2.webp", "path": null, "size": 2.96, "width": 208, "height": 156, "sizeInBytes": 2956}}	bambu2_7a5f185bbe	.webp	image/webp	16.81	/uploads/bambu2_7a5f185bbe.webp	\N	local	\N	/2/8	2025-04-15 20:48:09.819	2025-04-15 20:48:09.819	2025-04-15 20:48:09.819	1	1	\N
58	slti5n1lzasvwthzs2gzrggu	bambu4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bambu4_c432fe04fd.webp", "hash": "small_bambu4_c432fe04fd", "mime": "image/webp", "name": "small_bambu4.webp", "path": null, "size": 9.87, "width": 375, "height": 500, "sizeInBytes": 9874}, "medium": {"ext": ".webp", "url": "/uploads/medium_bambu4_c432fe04fd.webp", "hash": "medium_bambu4_c432fe04fd", "mime": "image/webp", "name": "medium_bambu4.webp", "path": null, "size": 16.23, "width": 563, "height": 750, "sizeInBytes": 16232}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bambu4_c432fe04fd.webp", "hash": "thumbnail_bambu4_c432fe04fd", "mime": "image/webp", "name": "thumbnail_bambu4.webp", "path": null, "size": 2.16, "width": 117, "height": 156, "sizeInBytes": 2158}}	bambu4_c432fe04fd	.webp	image/webp	24.90	/uploads/bambu4_c432fe04fd.webp	\N	local	\N	/2/8	2025-04-15 20:48:09.853	2025-04-15 20:48:09.853	2025-04-15 20:48:09.853	1	1	\N
59	rwbx1ubi6jxo23iv890itax4	bambu3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bambu3_3dbb488a39.webp", "hash": "small_bambu3_3dbb488a39", "mime": "image/webp", "name": "small_bambu3.webp", "path": null, "size": 15.85, "width": 375, "height": 500, "sizeInBytes": 15848}, "medium": {"ext": ".webp", "url": "/uploads/medium_bambu3_3dbb488a39.webp", "hash": "medium_bambu3_3dbb488a39", "mime": "image/webp", "name": "medium_bambu3.webp", "path": null, "size": 28.46, "width": 563, "height": 750, "sizeInBytes": 28464}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bambu3_3dbb488a39.webp", "hash": "thumbnail_bambu3_3dbb488a39", "mime": "image/webp", "name": "thumbnail_bambu3.webp", "path": null, "size": 2.71, "width": 117, "height": 156, "sizeInBytes": 2706}}	bambu3_3dbb488a39	.webp	image/webp	43.44	/uploads/bambu3_3dbb488a39.webp	\N	local	\N	/2/8	2025-04-15 20:48:09.858	2025-04-15 20:48:09.858	2025-04-15 20:48:09.858	1	1	\N
60	seee1o8uwavveqt32r3qf2gj	bambu1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bambu1_5c29c7b71c.webp", "hash": "small_bambu1_5c29c7b71c", "mime": "image/webp", "name": "small_bambu1.webp", "path": null, "size": 18.01, "width": 375, "height": 500, "sizeInBytes": 18006}, "medium": {"ext": ".webp", "url": "/uploads/medium_bambu1_5c29c7b71c.webp", "hash": "medium_bambu1_5c29c7b71c", "mime": "image/webp", "name": "medium_bambu1.webp", "path": null, "size": 31.94, "width": 563, "height": 750, "sizeInBytes": 31944}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bambu1_5c29c7b71c.webp", "hash": "thumbnail_bambu1_5c29c7b71c", "mime": "image/webp", "name": "thumbnail_bambu1.webp", "path": null, "size": 3.17, "width": 117, "height": 156, "sizeInBytes": 3174}}	bambu1_5c29c7b71c	.webp	image/webp	48.19	/uploads/bambu1_5c29c7b71c.webp	\N	local	\N	/2/8	2025-04-15 20:48:09.872	2025-04-15 20:48:09.872	2025-04-15 20:48:09.872	1	1	\N
61	y3f0248z9yqlidaf4x1tfujz	cr10-1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_cr10_1_2cf7f08f2a.webp", "hash": "small_cr10_1_2cf7f08f2a", "mime": "image/webp", "name": "small_cr10-1.webp", "path": null, "size": 20.24, "width": 375, "height": 500, "sizeInBytes": 20240}, "medium": {"ext": ".webp", "url": "/uploads/medium_cr10_1_2cf7f08f2a.webp", "hash": "medium_cr10_1_2cf7f08f2a", "mime": "image/webp", "name": "medium_cr10-1.webp", "path": null, "size": 37, "width": 563, "height": 750, "sizeInBytes": 36998}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cr10_1_2cf7f08f2a.webp", "hash": "thumbnail_cr10_1_2cf7f08f2a", "mime": "image/webp", "name": "thumbnail_cr10-1.webp", "path": null, "size": 3.62, "width": 117, "height": 156, "sizeInBytes": 3622}}	cr10_1_2cf7f08f2a	.webp	image/webp	56.20	/uploads/cr10_1_2cf7f08f2a.webp	\N	local	\N	/2/4	2025-04-15 20:52:51.961	2025-04-15 20:52:51.961	2025-04-15 20:52:51.961	1	1	\N
62	tpj7lyunh1fw466rz6ajedv9	cr10-3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_cr10_3_1849c3b9fc.webp", "hash": "small_cr10_3_1849c3b9fc", "mime": "image/webp", "name": "small_cr10-3.webp", "path": null, "size": 18.74, "width": 375, "height": 500, "sizeInBytes": 18736}, "medium": {"ext": ".webp", "url": "/uploads/medium_cr10_3_1849c3b9fc.webp", "hash": "medium_cr10_3_1849c3b9fc", "mime": "image/webp", "name": "medium_cr10-3.webp", "path": null, "size": 37.12, "width": 563, "height": 750, "sizeInBytes": 37120}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cr10_3_1849c3b9fc.webp", "hash": "thumbnail_cr10_3_1849c3b9fc", "mime": "image/webp", "name": "thumbnail_cr10-3.webp", "path": null, "size": 2.34, "width": 117, "height": 156, "sizeInBytes": 2336}}	cr10_3_1849c3b9fc	.webp	image/webp	58.63	/uploads/cr10_3_1849c3b9fc.webp	\N	local	\N	/2/4	2025-04-15 20:52:51.961	2025-04-15 20:52:51.961	2025-04-15 20:52:51.961	1	1	\N
63	vfh4p0so99c0e04jbv9fguyb	cr10-4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_cr10_4_f7ff115cce.webp", "hash": "small_cr10_4_f7ff115cce", "mime": "image/webp", "name": "small_cr10-4.webp", "path": null, "size": 16.16, "width": 375, "height": 500, "sizeInBytes": 16164}, "medium": {"ext": ".webp", "url": "/uploads/medium_cr10_4_f7ff115cce.webp", "hash": "medium_cr10_4_f7ff115cce", "mime": "image/webp", "name": "medium_cr10-4.webp", "path": null, "size": 25.08, "width": 563, "height": 750, "sizeInBytes": 25078}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cr10_4_f7ff115cce.webp", "hash": "thumbnail_cr10_4_f7ff115cce", "mime": "image/webp", "name": "thumbnail_cr10-4.webp", "path": null, "size": 3.17, "width": 117, "height": 156, "sizeInBytes": 3166}}	cr10_4_f7ff115cce	.webp	image/webp	34.12	/uploads/cr10_4_f7ff115cce.webp	\N	local	\N	/2/4	2025-04-15 20:52:51.983	2025-04-15 20:52:51.983	2025-04-15 20:52:51.983	1	1	\N
107	v2pmywciw0l92ekqyfcyjhjc	phrozen3.webp	\N	\N	640	511	{"small": {"ext": ".webp", "url": "/uploads/small_phrozen3_9014a789c3.webp", "hash": "small_phrozen3_9014a789c3", "mime": "image/webp", "name": "small_phrozen3.webp", "path": null, "size": 15.38, "width": 500, "height": 399, "sizeInBytes": 15384}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_phrozen3_9014a789c3.webp", "hash": "thumbnail_phrozen3_9014a789c3", "mime": "image/webp", "name": "thumbnail_phrozen3.webp", "path": null, "size": 4.4, "width": 195, "height": 156, "sizeInBytes": 4396}}	phrozen3_9014a789c3	.webp	image/webp	25.49	/uploads/phrozen3_9014a789c3.webp	\N	local	\N	/2/15	2025-04-15 21:57:16.569	2025-04-15 21:57:16.569	2025-04-15 21:57:16.57	1	1	\N
64	ogvyejgm9vnxk38pzgvhxnb8	cr10-2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_cr10_2_880cb24d11.webp", "hash": "small_cr10_2_880cb24d11", "mime": "image/webp", "name": "small_cr10-2.webp", "path": null, "size": 21.03, "width": 375, "height": 500, "sizeInBytes": 21026}, "medium": {"ext": ".webp", "url": "/uploads/medium_cr10_2_880cb24d11.webp", "hash": "medium_cr10_2_880cb24d11", "mime": "image/webp", "name": "medium_cr10-2.webp", "path": null, "size": 40.91, "width": 563, "height": 750, "sizeInBytes": 40912}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cr10_2_880cb24d11.webp", "hash": "thumbnail_cr10_2_880cb24d11", "mime": "image/webp", "name": "thumbnail_cr10-2.webp", "path": null, "size": 2.92, "width": 117, "height": 156, "sizeInBytes": 2920}}	cr10_2_880cb24d11	.webp	image/webp	66.50	/uploads/cr10_2_880cb24d11.webp	\N	local	\N	/2/4	2025-04-15 20:52:51.983	2025-04-15 20:52:51.983	2025-04-15 20:52:51.984	1	1	\N
65	d6suraylc9k3gad9b0ort4f3	cr10-6.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_cr10_6_2b244b3f42.webp", "hash": "small_cr10_6_2b244b3f42", "mime": "image/webp", "name": "small_cr10-6.webp", "path": null, "size": 17.89, "width": 375, "height": 500, "sizeInBytes": 17892}, "medium": {"ext": ".webp", "url": "/uploads/medium_cr10_6_2b244b3f42.webp", "hash": "medium_cr10_6_2b244b3f42", "mime": "image/webp", "name": "medium_cr10-6.webp", "path": null, "size": 27.57, "width": 563, "height": 750, "sizeInBytes": 27572}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cr10_6_2b244b3f42.webp", "hash": "thumbnail_cr10_6_2b244b3f42", "mime": "image/webp", "name": "thumbnail_cr10-6.webp", "path": null, "size": 3.85, "width": 117, "height": 156, "sizeInBytes": 3850}}	cr10_6_2b244b3f42	.webp	image/webp	36.66	/uploads/cr10_6_2b244b3f42.webp	\N	local	\N	/2/4	2025-04-15 20:52:51.989	2025-04-15 20:52:51.989	2025-04-15 20:52:51.989	1	1	\N
66	kg9c5swqqacz4w7ydnm6ri5d	cr10-5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_cr10_5_6d50dd16fd.webp", "hash": "small_cr10_5_6d50dd16fd", "mime": "image/webp", "name": "small_cr10-5.webp", "path": null, "size": 16.01, "width": 375, "height": 500, "sizeInBytes": 16012}, "medium": {"ext": ".webp", "url": "/uploads/medium_cr10_5_6d50dd16fd.webp", "hash": "medium_cr10_5_6d50dd16fd", "mime": "image/webp", "name": "medium_cr10-5.webp", "path": null, "size": 24.51, "width": 563, "height": 750, "sizeInBytes": 24506}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cr10_5_6d50dd16fd.webp", "hash": "thumbnail_cr10_5_6d50dd16fd", "mime": "image/webp", "name": "thumbnail_cr10-5.webp", "path": null, "size": 3.48, "width": 117, "height": 156, "sizeInBytes": 3476}}	cr10_5_6d50dd16fd	.webp	image/webp	32.49	/uploads/cr10_5_6d50dd16fd.webp	\N	local	\N	/2/4	2025-04-15 20:52:51.996	2025-04-15 20:52:51.996	2025-04-15 20:52:51.996	1	1	\N
67	y3r2ety59ieluurgzhu1yp71	eleg3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_eleg3_4c5e24c93f.webp", "hash": "small_eleg3_4c5e24c93f", "mime": "image/webp", "name": "small_eleg3.webp", "path": null, "size": 8.6, "width": 500, "height": 375, "sizeInBytes": 8600}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_eleg3_4c5e24c93f.webp", "hash": "thumbnail_eleg3_4c5e24c93f", "mime": "image/webp", "name": "thumbnail_eleg3.webp", "path": null, "size": 2.56, "width": 208, "height": 156, "sizeInBytes": 2562}}	eleg3_4c5e24c93f	.webp	image/webp	14.20	/uploads/eleg3_4c5e24c93f.webp	\N	local	\N	/2/9	2025-04-15 20:57:53.962	2025-04-15 20:57:53.962	2025-04-15 20:57:53.962	1	1	\N
68	b40afrumv0x0agnlvu6cb0os	eleg2.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_eleg2_fe31262583.webp", "hash": "small_eleg2_fe31262583", "mime": "image/webp", "name": "small_eleg2.webp", "path": null, "size": 12.16, "width": 500, "height": 375, "sizeInBytes": 12164}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_eleg2_fe31262583.webp", "hash": "thumbnail_eleg2_fe31262583", "mime": "image/webp", "name": "thumbnail_eleg2.webp", "path": null, "size": 3.64, "width": 208, "height": 156, "sizeInBytes": 3640}}	eleg2_fe31262583	.webp	image/webp	20.41	/uploads/eleg2_fe31262583.webp	\N	local	\N	/2/9	2025-04-15 20:57:53.985	2025-04-15 20:57:53.985	2025-04-15 20:57:53.985	1	1	\N
69	s0hepnn9wklh444c2f1qnez8	eleg1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_eleg1_7dc26f2a51.webp", "hash": "small_eleg1_7dc26f2a51", "mime": "image/webp", "name": "small_eleg1.webp", "path": null, "size": 11.86, "width": 375, "height": 500, "sizeInBytes": 11864}, "medium": {"ext": ".webp", "url": "/uploads/medium_eleg1_7dc26f2a51.webp", "hash": "medium_eleg1_7dc26f2a51", "mime": "image/webp", "name": "medium_eleg1.webp", "path": null, "size": 19.37, "width": 563, "height": 750, "sizeInBytes": 19368}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_eleg1_7dc26f2a51.webp", "hash": "thumbnail_eleg1_7dc26f2a51", "mime": "image/webp", "name": "thumbnail_eleg1.webp", "path": null, "size": 2.67, "width": 117, "height": 156, "sizeInBytes": 2670}}	eleg1_7dc26f2a51	.webp	image/webp	27.11	/uploads/eleg1_7dc26f2a51.webp	\N	local	\N	/2/9	2025-04-15 20:57:53.993	2025-04-15 20:57:53.993	2025-04-15 20:57:53.993	1	1	\N
70	yo54bbqpni52posz0zz81qgi	eleg5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_eleg5_1baf346d70.webp", "hash": "small_eleg5_1baf346d70", "mime": "image/webp", "name": "small_eleg5.webp", "path": null, "size": 23.09, "width": 375, "height": 500, "sizeInBytes": 23088}, "medium": {"ext": ".webp", "url": "/uploads/medium_eleg5_1baf346d70.webp", "hash": "medium_eleg5_1baf346d70", "mime": "image/webp", "name": "medium_eleg5.webp", "path": null, "size": 57.29, "width": 563, "height": 750, "sizeInBytes": 57294}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_eleg5_1baf346d70.webp", "hash": "thumbnail_eleg5_1baf346d70", "mime": "image/webp", "name": "thumbnail_eleg5.webp", "path": null, "size": 1.51, "width": 117, "height": 156, "sizeInBytes": 1514}}	eleg5_1baf346d70	.webp	image/webp	104.87	/uploads/eleg5_1baf346d70.webp	\N	local	\N	/2/9	2025-04-15 20:57:54.025	2025-04-15 20:57:54.025	2025-04-15 20:57:54.025	1	1	\N
71	c4i6evtvvs2hft7uc59nq34h	eleg4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_eleg4_b5270a6e7b.webp", "hash": "small_eleg4_b5270a6e7b", "mime": "image/webp", "name": "small_eleg4.webp", "path": null, "size": 37.08, "width": 375, "height": 500, "sizeInBytes": 37078}, "medium": {"ext": ".webp", "url": "/uploads/medium_eleg4_b5270a6e7b.webp", "hash": "medium_eleg4_b5270a6e7b", "mime": "image/webp", "name": "medium_eleg4.webp", "path": null, "size": 82.68, "width": 563, "height": 750, "sizeInBytes": 82678}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_eleg4_b5270a6e7b.webp", "hash": "thumbnail_eleg4_b5270a6e7b", "mime": "image/webp", "name": "thumbnail_eleg4.webp", "path": null, "size": 3.04, "width": 117, "height": 156, "sizeInBytes": 3044}}	eleg4_b5270a6e7b	.webp	image/webp	137.00	/uploads/eleg4_b5270a6e7b.webp	\N	local	\N	/2/9	2025-04-15 20:57:54.043	2025-04-15 20:57:54.043	2025-04-15 20:57:54.043	1	1	\N
72	luk11sa15w632cs7qgd89329	mini2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mini2_7d6be5eb2b.webp", "hash": "small_mini2_7d6be5eb2b", "mime": "image/webp", "name": "small_mini2.webp", "path": null, "size": 18.55, "width": 375, "height": 500, "sizeInBytes": 18554}, "medium": {"ext": ".webp", "url": "/uploads/medium_mini2_7d6be5eb2b.webp", "hash": "medium_mini2_7d6be5eb2b", "mime": "image/webp", "name": "medium_mini2.webp", "path": null, "size": 31.62, "width": 563, "height": 750, "sizeInBytes": 31620}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mini2_7d6be5eb2b.webp", "hash": "thumbnail_mini2_7d6be5eb2b", "mime": "image/webp", "name": "thumbnail_mini2.webp", "path": null, "size": 4.02, "width": 117, "height": 156, "sizeInBytes": 4022}}	mini2_7d6be5eb2b	.webp	image/webp	43.84	/uploads/mini2_7d6be5eb2b.webp	\N	local	\N	/2/3	2025-04-15 21:02:33.008	2025-04-15 21:02:33.008	2025-04-15 21:02:33.008	1	1	\N
73	tamnj3he6wwauca7xmmv6ars	mini1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mini1_1a97470663.webp", "hash": "small_mini1_1a97470663", "mime": "image/webp", "name": "small_mini1.webp", "path": null, "size": 26.29, "width": 375, "height": 500, "sizeInBytes": 26290}, "medium": {"ext": ".webp", "url": "/uploads/medium_mini1_1a97470663.webp", "hash": "medium_mini1_1a97470663", "mime": "image/webp", "name": "medium_mini1.webp", "path": null, "size": 43.7, "width": 563, "height": 750, "sizeInBytes": 43700}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mini1_1a97470663.webp", "hash": "thumbnail_mini1_1a97470663", "mime": "image/webp", "name": "thumbnail_mini1.webp", "path": null, "size": 4.93, "width": 117, "height": 156, "sizeInBytes": 4934}}	mini1_1a97470663	.webp	image/webp	61.21	/uploads/mini1_1a97470663.webp	\N	local	\N	/2/3	2025-04-15 21:02:33.012	2025-04-15 21:02:33.012	2025-04-15 21:02:33.012	1	1	\N
74	c8k9ii4htqfhc8skc2pmtiel	mini3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mini3_ab700f0ad2.webp", "hash": "small_mini3_ab700f0ad2", "mime": "image/webp", "name": "small_mini3.webp", "path": null, "size": 22.54, "width": 375, "height": 500, "sizeInBytes": 22536}, "medium": {"ext": ".webp", "url": "/uploads/medium_mini3_ab700f0ad2.webp", "hash": "medium_mini3_ab700f0ad2", "mime": "image/webp", "name": "medium_mini3.webp", "path": null, "size": 38.94, "width": 563, "height": 750, "sizeInBytes": 38936}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mini3_ab700f0ad2.webp", "hash": "thumbnail_mini3_ab700f0ad2", "mime": "image/webp", "name": "thumbnail_mini3.webp", "path": null, "size": 3.91, "width": 117, "height": 156, "sizeInBytes": 3908}}	mini3_ab700f0ad2	.webp	image/webp	59.29	/uploads/mini3_ab700f0ad2.webp	\N	local	\N	/2/3	2025-04-15 21:02:33.026	2025-04-15 21:02:33.026	2025-04-15 21:02:33.026	1	1	\N
75	tlhnhux84jamslxa9zo2lfuf	qidi3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_qidi3_5b909a002c.webp", "hash": "small_qidi3_5b909a002c", "mime": "image/webp", "name": "small_qidi3.webp", "path": null, "size": 18.26, "width": 375, "height": 500, "sizeInBytes": 18262}, "medium": {"ext": ".webp", "url": "/uploads/medium_qidi3_5b909a002c.webp", "hash": "medium_qidi3_5b909a002c", "mime": "image/webp", "name": "medium_qidi3.webp", "path": null, "size": 30.54, "width": 563, "height": 750, "sizeInBytes": 30544}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_qidi3_5b909a002c.webp", "hash": "thumbnail_qidi3_5b909a002c", "mime": "image/webp", "name": "thumbnail_qidi3.webp", "path": null, "size": 3.25, "width": 117, "height": 156, "sizeInBytes": 3248}}	qidi3_5b909a002c	.webp	image/webp	42.76	/uploads/qidi3_5b909a002c.webp	\N	local	\N	/2/10	2025-04-15 21:06:42.455	2025-04-15 21:06:42.455	2025-04-15 21:06:42.455	1	1	\N
90	fn8vr2z8ne6rfe7bnex6b7l1	flsun4.webp	\N	\N	480	640	{"small": {"ext": ".webp", "url": "/uploads/small_flsun4_d432341783.webp", "hash": "small_flsun4_d432341783", "mime": "image/webp", "name": "small_flsun4.webp", "path": null, "size": 33.37, "width": 375, "height": 500, "sizeInBytes": 33366}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_flsun4_d432341783.webp", "hash": "thumbnail_flsun4_d432341783", "mime": "image/webp", "name": "thumbnail_flsun4.webp", "path": null, "size": 4.83, "width": 117, "height": 156, "sizeInBytes": 4828}}	flsun4_d432341783	.webp	image/webp	66.58	/uploads/flsun4_d432341783.webp	\N	local	\N	/2/13	2025-04-15 21:29:10.182	2025-04-15 21:29:10.182	2025-04-15 21:29:10.182	1	1	\N
76	cnlavh6z9o0o271uo9n6iq49	qidi2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_qidi2_9b7e89415b.webp", "hash": "small_qidi2_9b7e89415b", "mime": "image/webp", "name": "small_qidi2.webp", "path": null, "size": 12.89, "width": 375, "height": 500, "sizeInBytes": 12894}, "medium": {"ext": ".webp", "url": "/uploads/medium_qidi2_9b7e89415b.webp", "hash": "medium_qidi2_9b7e89415b", "mime": "image/webp", "name": "medium_qidi2.webp", "path": null, "size": 22.76, "width": 563, "height": 750, "sizeInBytes": 22758}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_qidi2_9b7e89415b.webp", "hash": "thumbnail_qidi2_9b7e89415b", "mime": "image/webp", "name": "thumbnail_qidi2.webp", "path": null, "size": 2.53, "width": 117, "height": 156, "sizeInBytes": 2534}}	qidi2_9b7e89415b	.webp	image/webp	35.09	/uploads/qidi2_9b7e89415b.webp	\N	local	\N	/2/10	2025-04-15 21:06:42.454	2025-04-15 21:06:42.454	2025-04-15 21:06:42.455	1	1	\N
77	yb1uljrqbhsc1p6m4yclhxkq	qidi1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_qidi1_b79748d9a5.webp", "hash": "small_qidi1_b79748d9a5", "mime": "image/webp", "name": "small_qidi1.webp", "path": null, "size": 22.93, "width": 375, "height": 500, "sizeInBytes": 22930}, "medium": {"ext": ".webp", "url": "/uploads/medium_qidi1_b79748d9a5.webp", "hash": "medium_qidi1_b79748d9a5", "mime": "image/webp", "name": "medium_qidi1.webp", "path": null, "size": 40.9, "width": 563, "height": 750, "sizeInBytes": 40900}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_qidi1_b79748d9a5.webp", "hash": "thumbnail_qidi1_b79748d9a5", "mime": "image/webp", "name": "thumbnail_qidi1.webp", "path": null, "size": 3.65, "width": 117, "height": 156, "sizeInBytes": 3650}}	qidi1_b79748d9a5	.webp	image/webp	63.32	/uploads/qidi1_b79748d9a5.webp	\N	local	\N	/2/10	2025-04-15 21:06:42.459	2025-04-15 21:06:42.459	2025-04-15 21:06:42.459	1	1	\N
78	f1g22lyuo9npsjwtdhlj755m	qidi4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_qidi4_f05f9fc9b8.webp", "hash": "small_qidi4_f05f9fc9b8", "mime": "image/webp", "name": "small_qidi4.webp", "path": null, "size": 19.63, "width": 375, "height": 500, "sizeInBytes": 19626}, "medium": {"ext": ".webp", "url": "/uploads/medium_qidi4_f05f9fc9b8.webp", "hash": "medium_qidi4_f05f9fc9b8", "mime": "image/webp", "name": "medium_qidi4.webp", "path": null, "size": 33.33, "width": 563, "height": 750, "sizeInBytes": 33326}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_qidi4_f05f9fc9b8.webp", "hash": "thumbnail_qidi4_f05f9fc9b8", "mime": "image/webp", "name": "thumbnail_qidi4.webp", "path": null, "size": 3.85, "width": 117, "height": 156, "sizeInBytes": 3850}}	qidi4_f05f9fc9b8	.webp	image/webp	49.20	/uploads/qidi4_f05f9fc9b8.webp	\N	local	\N	/2/10	2025-04-15 21:06:42.468	2025-04-15 21:06:42.468	2025-04-15 21:06:42.468	1	1	\N
179	d5xrnnzs1p5psiacpk6qb77l	extru1.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_extru1_8680932944.webp", "hash": "small_extru1_8680932944", "mime": "image/webp", "name": "small_extru1.webp", "path": null, "size": 21.58, "width": 500, "height": 500, "sizeInBytes": 21576}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_extru1_8680932944.webp", "hash": "thumbnail_extru1_8680932944", "mime": "image/webp", "name": "thumbnail_extru1.webp", "path": null, "size": 2.81, "width": 156, "height": 156, "sizeInBytes": 2810}}	extru1_8680932944	.webp	image/webp	45.04	/uploads/extru1_8680932944.webp	\N	local	\N	/2/20	2025-04-16 21:05:13.383	2025-04-16 21:05:13.383	2025-04-16 21:05:13.383	1	1	\N
79	rj4k6l8izmwf8jlnw1rc7j7n	genius2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_genius2_40a106bd27.webp", "hash": "small_genius2_40a106bd27", "mime": "image/webp", "name": "small_genius2.webp", "path": null, "size": 20.65, "width": 375, "height": 500, "sizeInBytes": 20654}, "medium": {"ext": ".webp", "url": "/uploads/medium_genius2_40a106bd27.webp", "hash": "medium_genius2_40a106bd27", "mime": "image/webp", "name": "medium_genius2.webp", "path": null, "size": 35.13, "width": 563, "height": 750, "sizeInBytes": 35126}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_genius2_40a106bd27.webp", "hash": "thumbnail_genius2_40a106bd27", "mime": "image/webp", "name": "thumbnail_genius2.webp", "path": null, "size": 3.94, "width": 117, "height": 156, "sizeInBytes": 3940}}	genius2_40a106bd27	.webp	image/webp	51.11	/uploads/genius2_40a106bd27.webp	\N	local	\N	/2/11	2025-04-15 21:10:51.263	2025-04-15 21:10:51.263	2025-04-15 21:10:51.263	1	1	\N
81	upjqb0x0fo9xz5witp0l1aia	two.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_two_3c0431563f.webp", "hash": "small_two_3c0431563f", "mime": "image/webp", "name": "small_two.webp", "path": null, "size": 9.91, "width": 375, "height": 500, "sizeInBytes": 9910}, "medium": {"ext": ".webp", "url": "/uploads/medium_two_3c0431563f.webp", "hash": "medium_two_3c0431563f", "mime": "image/webp", "name": "medium_two.webp", "path": null, "size": 15.84, "width": 563, "height": 750, "sizeInBytes": 15838}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_two_3c0431563f.webp", "hash": "thumbnail_two_3c0431563f", "mime": "image/webp", "name": "thumbnail_two.webp", "path": null, "size": 2.46, "width": 117, "height": 156, "sizeInBytes": 2458}}	two_3c0431563f	.webp	image/webp	21.14	/uploads/two_3c0431563f.webp	\N	local	\N	/2	2025-04-15 21:19:41.646	2025-04-15 21:19:41.646	2025-04-15 21:19:41.646	1	1	\N
108	jzkxc045svsz4gcrorfxzlp5	phrozen2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_phrozen2_8ced55c491.webp", "hash": "small_phrozen2_8ced55c491", "mime": "image/webp", "name": "small_phrozen2.webp", "path": null, "size": 17.03, "width": 375, "height": 500, "sizeInBytes": 17028}, "medium": {"ext": ".webp", "url": "/uploads/medium_phrozen2_8ced55c491.webp", "hash": "medium_phrozen2_8ced55c491", "mime": "image/webp", "name": "medium_phrozen2.webp", "path": null, "size": 28.5, "width": 563, "height": 750, "sizeInBytes": 28504}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_phrozen2_8ced55c491.webp", "hash": "thumbnail_phrozen2_8ced55c491", "mime": "image/webp", "name": "thumbnail_phrozen2.webp", "path": null, "size": 3.51, "width": 117, "height": 156, "sizeInBytes": 3510}}	phrozen2_8ced55c491	.webp	image/webp	39.95	/uploads/phrozen2_8ced55c491.webp	\N	local	\N	/2/15	2025-04-15 21:57:16.601	2025-04-15 21:57:16.601	2025-04-15 21:57:16.601	1	1	\N
154	ln6ksiq4hrd23v1ozc1c7cr7	mega5.webp	\N	\N	640	478	{"small": {"ext": ".webp", "url": "/uploads/small_mega5_e260dda4a6.webp", "hash": "small_mega5_e260dda4a6", "mime": "image/webp", "name": "small_mega5.webp", "path": null, "size": 12.22, "width": 500, "height": 373, "sizeInBytes": 12224}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mega5_e260dda4a6.webp", "hash": "thumbnail_mega5_e260dda4a6", "mime": "image/webp", "name": "thumbnail_mega5.webp", "path": null, "size": 3.93, "width": 209, "height": 156, "sizeInBytes": 3932}}	mega5_e260dda4a6	.webp	image/webp	19.13	/uploads/mega5_e260dda4a6.webp	\N	local	\N	/2/15	2025-04-16 19:32:51.198	2025-04-16 19:32:51.198	2025-04-16 19:32:51.198	1	1	\N
110	keh6aiaxpt22qujr4s4ilej2	photon1.webp	\N	\N	640	786	{"small": {"ext": ".webp", "url": "/uploads/small_photon1_ae28080ee4.webp", "hash": "small_photon1_ae28080ee4", "mime": "image/webp", "name": "small_photon1.webp", "path": null, "size": 20.09, "width": 407, "height": 500, "sizeInBytes": 20094}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon1_ae28080ee4.webp", "hash": "medium_photon1_ae28080ee4", "mime": "image/webp", "name": "medium_photon1.webp", "path": null, "size": 31.45, "width": 611, "height": 750, "sizeInBytes": 31452}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon1_ae28080ee4.webp", "hash": "thumbnail_photon1_ae28080ee4", "mime": "image/webp", "name": "thumbnail_photon1.webp", "path": null, "size": 3.9, "width": 127, "height": 156, "sizeInBytes": 3898}}	photon1_ae28080ee4	.webp	image/webp	39.82	/uploads/photon1_ae28080ee4.webp	\N	local	\N	/2/7	2025-04-15 22:01:21.621	2025-04-15 22:01:21.621	2025-04-15 22:01:21.622	1	1	\N
111	m0dxnw2usmeaq25u0r57vf3c	photon2.webp	\N	\N	640	788	{"small": {"ext": ".webp", "url": "/uploads/small_photon2_03bc8c9947.webp", "hash": "small_photon2_03bc8c9947", "mime": "image/webp", "name": "small_photon2.webp", "path": null, "size": 17.36, "width": 406, "height": 500, "sizeInBytes": 17358}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon2_03bc8c9947.webp", "hash": "medium_photon2_03bc8c9947", "mime": "image/webp", "name": "medium_photon2.webp", "path": null, "size": 27.18, "width": 609, "height": 750, "sizeInBytes": 27182}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon2_03bc8c9947.webp", "hash": "thumbnail_photon2_03bc8c9947", "mime": "image/webp", "name": "thumbnail_photon2.webp", "path": null, "size": 3.8, "width": 127, "height": 156, "sizeInBytes": 3802}}	photon2_03bc8c9947	.webp	image/webp	33.08	/uploads/photon2_03bc8c9947.webp	\N	local	\N	/2/7	2025-04-15 22:01:21.68	2025-04-15 22:01:21.68	2025-04-15 22:01:21.681	1	1	\N
146	z5hmtrl7wwl0dfkq62bczb4b	ld1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ld1_f610dc4cd6.webp", "hash": "small_ld1_f610dc4cd6", "mime": "image/webp", "name": "small_ld1.webp", "path": null, "size": 15.64, "width": 375, "height": 500, "sizeInBytes": 15640}, "medium": {"ext": ".webp", "url": "/uploads/medium_ld1_f610dc4cd6.webp", "hash": "medium_ld1_f610dc4cd6", "mime": "image/webp", "name": "medium_ld1.webp", "path": null, "size": 27.11, "width": 563, "height": 750, "sizeInBytes": 27108}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ld1_f610dc4cd6.webp", "hash": "thumbnail_ld1_f610dc4cd6", "mime": "image/webp", "name": "thumbnail_ld1.webp", "path": null, "size": 3.09, "width": 117, "height": 156, "sizeInBytes": 3094}}	ld1_f610dc4cd6	.webp	image/webp	39.51	/uploads/ld1_f610dc4cd6.webp	\N	local	\N	/2/4	2025-04-16 19:22:30.392	2025-04-16 19:22:30.392	2025-04-16 19:22:30.392	1	1	\N
180	h2ht2ue7ak7lo9wlq12o10nr	extru3.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_extru3_336e4049ea.webp", "hash": "small_extru3_336e4049ea", "mime": "image/webp", "name": "small_extru3.webp", "path": null, "size": 16.9, "width": 500, "height": 500, "sizeInBytes": 16898}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_extru3_336e4049ea.webp", "hash": "thumbnail_extru3_336e4049ea", "mime": "image/webp", "name": "thumbnail_extru3.webp", "path": null, "size": 2.72, "width": 156, "height": 156, "sizeInBytes": 2722}}	extru3_336e4049ea	.webp	image/webp	30.22	/uploads/extru3_336e4049ea.webp	\N	local	\N	/2/20	2025-04-16 21:05:13.402	2025-04-16 21:05:13.402	2025-04-16 21:05:13.402	1	1	\N
184	meoow34vdg16opea9pn9842e	extru5.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_extru5_0df84703c1.webp", "hash": "small_extru5_0df84703c1", "mime": "image/webp", "name": "small_extru5.webp", "path": null, "size": 36.92, "width": 500, "height": 500, "sizeInBytes": 36924}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_extru5_0df84703c1.webp", "hash": "thumbnail_extru5_0df84703c1", "mime": "image/webp", "name": "thumbnail_extru5.webp", "path": null, "size": 4.41, "width": 156, "height": 156, "sizeInBytes": 4408}}	extru5_0df84703c1	.webp	image/webp	69.19	/uploads/extru5_0df84703c1.webp	\N	local	\N	/2/20	2025-04-16 21:05:13.428	2025-04-16 21:05:13.428	2025-04-16 21:05:13.428	1	1	\N
185	cuys5h867yqghb78vjni63o3	extru7.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_extru7_77200aa32a.webp", "hash": "small_extru7_77200aa32a", "mime": "image/webp", "name": "small_extru7.webp", "path": null, "size": 18.2, "width": 500, "height": 500, "sizeInBytes": 18204}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_extru7_77200aa32a.webp", "hash": "thumbnail_extru7_77200aa32a", "mime": "image/webp", "name": "thumbnail_extru7.webp", "path": null, "size": 2.77, "width": 156, "height": 156, "sizeInBytes": 2768}}	extru7_77200aa32a	.webp	image/webp	35.55	/uploads/extru7_77200aa32a.webp	\N	local	\N	/2/20	2025-04-16 21:05:13.482	2025-04-16 21:05:13.482	2025-04-16 21:05:13.482	1	1	\N
266	qgran7k38pt56j7qhdgekn6g	2.jpg	\N	\N	300	300	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_2_ab70df6b4f.jpg", "hash": "thumbnail_2_ab70df6b4f", "mime": "image/jpeg", "name": "thumbnail_2.jpg", "path": null, "size": 3.58, "width": 156, "height": 156, "sizeInBytes": 3575}}	2_ab70df6b4f	.jpg	image/jpeg	9.91	/uploads/2_ab70df6b4f.jpg	\N	local	\N	/2/24	2025-04-17 11:34:05.197	2025-04-17 11:34:05.197	2025-04-17 11:34:05.197	1	1	\N
82	r3x6gfblmvkylsxsv0p7o9sw	sovol1.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_sovol1_351f897a85.webp", "hash": "small_sovol1_351f897a85", "mime": "image/webp", "name": "small_sovol1.webp", "path": null, "size": 20.91, "width": 500, "height": 375, "sizeInBytes": 20912}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sovol1_351f897a85.webp", "hash": "thumbnail_sovol1_351f897a85", "mime": "image/webp", "name": "thumbnail_sovol1.webp", "path": null, "size": 5.97, "width": 208, "height": 156, "sizeInBytes": 5972}}	sovol1_351f897a85	.webp	image/webp	34.60	/uploads/sovol1_351f897a85.webp	\N	local	\N	/2/12	2025-04-15 21:23:59.758	2025-04-15 21:23:59.758	2025-04-15 21:23:59.758	1	1	\N
83	yls65zpwdr127ekptx4j42e2	sovol3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sovol3_e0a6a7a618.webp", "hash": "small_sovol3_e0a6a7a618", "mime": "image/webp", "name": "small_sovol3.webp", "path": null, "size": 12.97, "width": 375, "height": 500, "sizeInBytes": 12970}, "medium": {"ext": ".webp", "url": "/uploads/medium_sovol3_e0a6a7a618.webp", "hash": "medium_sovol3_e0a6a7a618", "mime": "image/webp", "name": "medium_sovol3.webp", "path": null, "size": 22.36, "width": 563, "height": 750, "sizeInBytes": 22360}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sovol3_e0a6a7a618.webp", "hash": "thumbnail_sovol3_e0a6a7a618", "mime": "image/webp", "name": "thumbnail_sovol3.webp", "path": null, "size": 2.58, "width": 117, "height": 156, "sizeInBytes": 2578}}	sovol3_e0a6a7a618	.webp	image/webp	33.38	/uploads/sovol3_e0a6a7a618.webp	\N	local	\N	/2/12	2025-04-15 21:23:59.79	2025-04-15 21:23:59.79	2025-04-15 21:23:59.79	1	1	\N
109	nq6yiev91bg9lv0vshioc3c5	phrozen1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_phrozen1_fbb40feb85.webp", "hash": "small_phrozen1_fbb40feb85", "mime": "image/webp", "name": "small_phrozen1.webp", "path": null, "size": 17.21, "width": 375, "height": 500, "sizeInBytes": 17210}, "medium": {"ext": ".webp", "url": "/uploads/medium_phrozen1_fbb40feb85.webp", "hash": "medium_phrozen1_fbb40feb85", "mime": "image/webp", "name": "medium_phrozen1.webp", "path": null, "size": 28.89, "width": 563, "height": 750, "sizeInBytes": 28890}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_phrozen1_fbb40feb85.webp", "hash": "thumbnail_phrozen1_fbb40feb85", "mime": "image/webp", "name": "thumbnail_phrozen1.webp", "path": null, "size": 3.26, "width": 117, "height": 156, "sizeInBytes": 3264}}	phrozen1_fbb40feb85	.webp	image/webp	39.51	/uploads/phrozen1_fbb40feb85.webp	\N	local	\N	/2/15	2025-04-15 21:57:16.603	2025-04-15 21:57:16.603	2025-04-15 21:57:16.603	1	1	\N
150	yvt1hh9zvhminml655gjpoj5	saturn2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_saturn2_6d85e635ab.webp", "hash": "small_saturn2_6d85e635ab", "mime": "image/webp", "name": "small_saturn2.webp", "path": null, "size": 9.79, "width": 375, "height": 500, "sizeInBytes": 9786}, "medium": {"ext": ".webp", "url": "/uploads/medium_saturn2_6d85e635ab.webp", "hash": "medium_saturn2_6d85e635ab", "mime": "image/webp", "name": "medium_saturn2.webp", "path": null, "size": 15.89, "width": 563, "height": 750, "sizeInBytes": 15886}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_saturn2_6d85e635ab.webp", "hash": "thumbnail_saturn2_6d85e635ab", "mime": "image/webp", "name": "thumbnail_saturn2.webp", "path": null, "size": 2.42, "width": 117, "height": 156, "sizeInBytes": 2424}}	saturn2_6d85e635ab	.webp	image/webp	22.25	/uploads/saturn2_6d85e635ab.webp	\N	local	\N	/2/9	2025-04-16 19:28:24.697	2025-04-16 19:28:24.697	2025-04-16 19:28:24.697	1	1	\N
181	zoi44xwiogjbwu2qce975sgd	extru2.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_extru2_b27603cbd4.webp", "hash": "small_extru2_b27603cbd4", "mime": "image/webp", "name": "small_extru2.webp", "path": null, "size": 19.04, "width": 500, "height": 500, "sizeInBytes": 19040}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_extru2_b27603cbd4.webp", "hash": "thumbnail_extru2_b27603cbd4", "mime": "image/webp", "name": "thumbnail_extru2.webp", "path": null, "size": 2.48, "width": 156, "height": 156, "sizeInBytes": 2482}}	extru2_b27603cbd4	.webp	image/webp	39.56	/uploads/extru2_b27603cbd4.webp	\N	local	\N	/2/20	2025-04-16 21:05:13.403	2025-04-16 21:05:13.403	2025-04-16 21:05:13.403	1	1	\N
208	lqddq2gsxhde25xjrmuv0i6w	hemera1.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_hemera1_e09b276fa5.webp", "hash": "small_hemera1_e09b276fa5", "mime": "image/webp", "name": "small_hemera1.webp", "path": null, "size": 6.66, "width": 500, "height": 375, "sizeInBytes": 6656}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_hemera1_e09b276fa5.webp", "hash": "thumbnail_hemera1_e09b276fa5", "mime": "image/webp", "name": "thumbnail_hemera1.webp", "path": null, "size": 1.99, "width": 208, "height": 156, "sizeInBytes": 1992}}	hemera1_e09b276fa5	.webp	image/webp	10.86	/uploads/hemera1_e09b276fa5.webp	\N	local	\N	/2/20	2025-04-16 21:51:18.485	2025-04-16 21:51:18.485	2025-04-16 21:51:18.485	1	1	\N
211	r3oty4mz52yei7ujghltspcw	sensor2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sensor2_eba4f79993.webp", "hash": "small_sensor2_eba4f79993", "mime": "image/webp", "name": "small_sensor2.webp", "path": null, "size": 10.45, "width": 375, "height": 500, "sizeInBytes": 10454}, "medium": {"ext": ".webp", "url": "/uploads/medium_sensor2_eba4f79993.webp", "hash": "medium_sensor2_eba4f79993", "mime": "image/webp", "name": "medium_sensor2.webp", "path": null, "size": 19.56, "width": 563, "height": 750, "sizeInBytes": 19560}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sensor2_eba4f79993.webp", "hash": "thumbnail_sensor2_eba4f79993", "mime": "image/webp", "name": "thumbnail_sensor2.webp", "path": null, "size": 1.91, "width": 117, "height": 156, "sizeInBytes": 1908}}	sensor2_eba4f79993	.webp	image/webp	30.55	/uploads/sensor2_eba4f79993.webp	\N	local	\N	/2/21	2025-04-16 21:53:59.989	2025-04-16 21:53:59.989	2025-04-16 21:53:59.989	1	1	\N
212	c4zup9mhyejnr29303h1uros	sensor1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sensor1_950b2bacc2.webp", "hash": "small_sensor1_950b2bacc2", "mime": "image/webp", "name": "small_sensor1.webp", "path": null, "size": 22.4, "width": 375, "height": 500, "sizeInBytes": 22402}, "medium": {"ext": ".webp", "url": "/uploads/medium_sensor1_950b2bacc2.webp", "hash": "medium_sensor1_950b2bacc2", "mime": "image/webp", "name": "medium_sensor1.webp", "path": null, "size": 40.58, "width": 563, "height": 750, "sizeInBytes": 40578}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sensor1_950b2bacc2.webp", "hash": "thumbnail_sensor1_950b2bacc2", "mime": "image/webp", "name": "thumbnail_sensor1.webp", "path": null, "size": 3.56, "width": 117, "height": 156, "sizeInBytes": 3564}}	sensor1_950b2bacc2	.webp	image/webp	62.58	/uploads/sensor1_950b2bacc2.webp	\N	local	\N	/2/21	2025-04-16 21:53:59.999	2025-04-16 21:53:59.999	2025-04-16 21:54:00	1	1	\N
84	jaohtamdnnzo1zsfuxbnmt14	sovol2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sovol2_452a3a85ff.webp", "hash": "small_sovol2_452a3a85ff", "mime": "image/webp", "name": "small_sovol2.webp", "path": null, "size": 23.11, "width": 375, "height": 500, "sizeInBytes": 23112}, "medium": {"ext": ".webp", "url": "/uploads/medium_sovol2_452a3a85ff.webp", "hash": "medium_sovol2_452a3a85ff", "mime": "image/webp", "name": "medium_sovol2.webp", "path": null, "size": 40.84, "width": 563, "height": 750, "sizeInBytes": 40844}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sovol2_452a3a85ff.webp", "hash": "thumbnail_sovol2_452a3a85ff", "mime": "image/webp", "name": "thumbnail_sovol2.webp", "path": null, "size": 3.89, "width": 117, "height": 156, "sizeInBytes": 3890}}	sovol2_452a3a85ff	.webp	image/webp	62.37	/uploads/sovol2_452a3a85ff.webp	\N	local	\N	/2/12	2025-04-15 21:23:59.794	2025-04-15 21:23:59.794	2025-04-15 21:23:59.794	1	1	\N
85	jbyza24oynqlhtpui396wm6c	sovol4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sovol4_2b04eb13e7.webp", "hash": "small_sovol4_2b04eb13e7", "mime": "image/webp", "name": "small_sovol4.webp", "path": null, "size": 28.61, "width": 375, "height": 500, "sizeInBytes": 28608}, "medium": {"ext": ".webp", "url": "/uploads/medium_sovol4_2b04eb13e7.webp", "hash": "medium_sovol4_2b04eb13e7", "mime": "image/webp", "name": "medium_sovol4.webp", "path": null, "size": 45.35, "width": 563, "height": 750, "sizeInBytes": 45352}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sovol4_2b04eb13e7.webp", "hash": "thumbnail_sovol4_2b04eb13e7", "mime": "image/webp", "name": "thumbnail_sovol4.webp", "path": null, "size": 5.38, "width": 117, "height": 156, "sizeInBytes": 5378}}	sovol4_2b04eb13e7	.webp	image/webp	61.81	/uploads/sovol4_2b04eb13e7.webp	\N	local	\N	/2/12	2025-04-15 21:23:59.81	2025-04-15 21:23:59.81	2025-04-15 21:23:59.81	1	1	\N
112	epfyzghhg0nl5c8dmbkvzs7n	photon3.webp	\N	\N	640	781	{"small": {"ext": ".webp", "url": "/uploads/small_photon3_cd25e0f4c8.webp", "hash": "small_photon3_cd25e0f4c8", "mime": "image/webp", "name": "small_photon3.webp", "path": null, "size": 18.69, "width": 410, "height": 500, "sizeInBytes": 18690}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon3_cd25e0f4c8.webp", "hash": "medium_photon3_cd25e0f4c8", "mime": "image/webp", "name": "medium_photon3.webp", "path": null, "size": 29.8, "width": 615, "height": 750, "sizeInBytes": 29804}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon3_cd25e0f4c8.webp", "hash": "thumbnail_photon3_cd25e0f4c8", "mime": "image/webp", "name": "thumbnail_photon3.webp", "path": null, "size": 3.49, "width": 128, "height": 156, "sizeInBytes": 3486}}	photon3_cd25e0f4c8	.webp	image/webp	36.75	/uploads/photon3_cd25e0f4c8.webp	\N	local	\N	/2/7	2025-04-15 22:01:21.68	2025-04-15 22:01:21.68	2025-04-15 22:01:21.68	1	1	\N
151	kgfkylsjufzqd1d277k1qwbv	saturn3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_saturn3_5e8177137c.webp", "hash": "small_saturn3_5e8177137c", "mime": "image/webp", "name": "small_saturn3.webp", "path": null, "size": 20.62, "width": 375, "height": 500, "sizeInBytes": 20624}, "medium": {"ext": ".webp", "url": "/uploads/medium_saturn3_5e8177137c.webp", "hash": "medium_saturn3_5e8177137c", "mime": "image/webp", "name": "medium_saturn3.webp", "path": null, "size": 34.89, "width": 563, "height": 750, "sizeInBytes": 34888}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_saturn3_5e8177137c.webp", "hash": "thumbnail_saturn3_5e8177137c", "mime": "image/webp", "name": "thumbnail_saturn3.webp", "path": null, "size": 3.98, "width": 117, "height": 156, "sizeInBytes": 3984}}	saturn3_5e8177137c	.webp	image/webp	50.98	/uploads/saturn3_5e8177137c.webp	\N	local	\N	/2/9	2025-04-16 19:28:24.697	2025-04-16 19:28:24.697	2025-04-16 19:28:24.697	1	1	\N
182	hi0t9ov5ui4zx6rwn3e76nu1	extru4.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_extru4_2c20f79905.webp", "hash": "small_extru4_2c20f79905", "mime": "image/webp", "name": "small_extru4.webp", "path": null, "size": 35.1, "width": 500, "height": 500, "sizeInBytes": 35096}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_extru4_2c20f79905.webp", "hash": "thumbnail_extru4_2c20f79905", "mime": "image/webp", "name": "thumbnail_extru4.webp", "path": null, "size": 4.49, "width": 156, "height": 156, "sizeInBytes": 4492}}	extru4_2c20f79905	.webp	image/webp	68.45	/uploads/extru4_2c20f79905.webp	\N	local	\N	/2/20	2025-04-16 21:05:13.411	2025-04-16 21:05:13.411	2025-04-16 21:05:13.411	1	1	\N
183	qh7wjvegot7k4g34knihk27b	extru6.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_extru6_7d16a47e2d.webp", "hash": "small_extru6_7d16a47e2d", "mime": "image/webp", "name": "small_extru6.webp", "path": null, "size": 22.92, "width": 500, "height": 500, "sizeInBytes": 22916}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_extru6_7d16a47e2d.webp", "hash": "thumbnail_extru6_7d16a47e2d", "mime": "image/webp", "name": "thumbnail_extru6.webp", "path": null, "size": 3.86, "width": 156, "height": 156, "sizeInBytes": 3860}}	extru6_7d16a47e2d	.webp	image/webp	43.32	/uploads/extru6_7d16a47e2d.webp	\N	local	\N	/2/20	2025-04-16 21:05:13.42	2025-04-16 21:05:13.42	2025-04-16 21:05:13.42	1	1	\N
210	bmb71h0sb7si5yboym7ixytb	hemera2.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_hemera2_5a8cf73df5.webp", "hash": "small_hemera2_5a8cf73df5", "mime": "image/webp", "name": "small_hemera2.webp", "path": null, "size": 10.38, "width": 500, "height": 375, "sizeInBytes": 10380}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_hemera2_5a8cf73df5.webp", "hash": "thumbnail_hemera2_5a8cf73df5", "mime": "image/webp", "name": "thumbnail_hemera2.webp", "path": null, "size": 3.44, "width": 208, "height": 156, "sizeInBytes": 3444}}	hemera2_5a8cf73df5	.webp	image/webp	16.55	/uploads/hemera2_5a8cf73df5.webp	\N	local	\N	/2/20	2025-04-16 21:51:18.488	2025-04-16 21:51:18.488	2025-04-16 21:51:18.488	1	1	\N
230	s4qvp7190sl35u4bl666fy8w	bas2.jpg	\N	\N	750	750	{"small": {"ext": ".jpg", "url": "/uploads/small_bas2_d2691c68f7.jpg", "hash": "small_bas2_d2691c68f7", "mime": "image/jpeg", "name": "small_bas2.jpg", "path": null, "size": 14.01, "width": 500, "height": 500, "sizeInBytes": 14005}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_bas2_d2691c68f7.jpg", "hash": "thumbnail_bas2_d2691c68f7", "mime": "image/jpeg", "name": "thumbnail_bas2.jpg", "path": null, "size": 2.77, "width": 156, "height": 156, "sizeInBytes": 2771}}	bas2_d2691c68f7	.jpg	image/jpeg	22.43	/uploads/bas2_d2691c68f7.jpg	\N	local	\N	/2/23	2025-04-16 22:11:41.08	2025-04-16 22:11:41.08	2025-04-16 22:11:41.08	1	1	\N
255	v58agkz40e6ypg0ehn6jxxn0	asa2.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_asa2_fe7b123c17.webp", "hash": "thumbnail_asa2_fe7b123c17", "mime": "image/webp", "name": "thumbnail_asa2.webp", "path": null, "size": 4.18, "width": 158, "height": 156, "sizeInBytes": 4176}}	asa2_fe7b123c17	.webp	image/webp	10.92	/uploads/asa2_fe7b123c17.webp	\N	local	\N	/2/7	2025-04-17 11:08:12.836	2025-04-17 11:08:12.836	2025-04-17 11:08:12.836	1	1	\N
86	rc0bsluogm5z1s8ppujuytmy	flsun1.webp	\N	\N	360	640	{"small": {"ext": ".webp", "url": "/uploads/small_flsun1_6f6fc2dd7f.webp", "hash": "small_flsun1_6f6fc2dd7f", "mime": "image/webp", "name": "small_flsun1.webp", "path": null, "size": 20.45, "width": 281, "height": 500, "sizeInBytes": 20446}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_flsun1_6f6fc2dd7f.webp", "hash": "thumbnail_flsun1_6f6fc2dd7f", "mime": "image/webp", "name": "thumbnail_flsun1.webp", "path": null, "size": 3.54, "width": 88, "height": 156, "sizeInBytes": 3542}}	flsun1_6f6fc2dd7f	.webp	image/webp	38.52	/uploads/flsun1_6f6fc2dd7f.webp	\N	local	\N	/2/13	2025-04-15 21:29:10.151	2025-04-15 21:29:10.151	2025-04-15 21:29:10.151	1	1	\N
88	dthb4jbzk5p12uzslqjwx9i8	flsun5.webp	\N	\N	480	640	{"small": {"ext": ".webp", "url": "/uploads/small_flsun5_67d8f9a0a8.webp", "hash": "small_flsun5_67d8f9a0a8", "mime": "image/webp", "name": "small_flsun5.webp", "path": null, "size": 26, "width": 375, "height": 500, "sizeInBytes": 26004}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_flsun5_67d8f9a0a8.webp", "hash": "thumbnail_flsun5_67d8f9a0a8", "mime": "image/webp", "name": "thumbnail_flsun5.webp", "path": null, "size": 2.09, "width": 117, "height": 156, "sizeInBytes": 2088}}	flsun5_67d8f9a0a8	.webp	image/webp	57.77	/uploads/flsun5_67d8f9a0a8.webp	\N	local	\N	/2/13	2025-04-15 21:29:10.169	2025-04-15 21:29:10.169	2025-04-15 21:29:10.169	1	1	\N
89	u2czdgkl3ptz8wyhtad6i5d9	flsun2.webp	\N	\N	480	640	{"small": {"ext": ".webp", "url": "/uploads/small_flsun2_37a95409ca.webp", "hash": "small_flsun2_37a95409ca", "mime": "image/webp", "name": "small_flsun2.webp", "path": null, "size": 36.58, "width": 375, "height": 500, "sizeInBytes": 36576}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_flsun2_37a95409ca.webp", "hash": "thumbnail_flsun2_37a95409ca", "mime": "image/webp", "name": "thumbnail_flsun2.webp", "path": null, "size": 5, "width": 117, "height": 156, "sizeInBytes": 5004}}	flsun2_37a95409ca	.webp	image/webp	66.20	/uploads/flsun2_37a95409ca.webp	\N	local	\N	/2/13	2025-04-15 21:29:10.174	2025-04-15 21:29:10.174	2025-04-15 21:29:10.174	1	1	\N
113	nbstq3fcxwww90ucwc7quosr	photon4.webp	\N	\N	640	819	{"small": {"ext": ".webp", "url": "/uploads/small_photon4_d44a81bef5.webp", "hash": "small_photon4_d44a81bef5", "mime": "image/webp", "name": "small_photon4.webp", "path": null, "size": 15.87, "width": 391, "height": 500, "sizeInBytes": 15868}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon4_d44a81bef5.webp", "hash": "medium_photon4_d44a81bef5", "mime": "image/webp", "name": "medium_photon4.webp", "path": null, "size": 24.84, "width": 586, "height": 750, "sizeInBytes": 24838}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon4_d44a81bef5.webp", "hash": "thumbnail_photon4_d44a81bef5", "mime": "image/webp", "name": "thumbnail_photon4.webp", "path": null, "size": 3.21, "width": 122, "height": 156, "sizeInBytes": 3206}}	photon4_d44a81bef5	.webp	image/webp	32.12	/uploads/photon4_d44a81bef5.webp	\N	local	\N	/2/7	2025-04-15 22:01:21.681	2025-04-15 22:01:21.681	2025-04-15 22:01:21.681	1	1	\N
152	m9ysj3wuqb4l6unprk7qfvm5	saturn4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_saturn4_1dfddb44d6.webp", "hash": "small_saturn4_1dfddb44d6", "mime": "image/webp", "name": "small_saturn4.webp", "path": null, "size": 21.2, "width": 375, "height": 500, "sizeInBytes": 21202}, "medium": {"ext": ".webp", "url": "/uploads/medium_saturn4_1dfddb44d6.webp", "hash": "medium_saturn4_1dfddb44d6", "mime": "image/webp", "name": "medium_saturn4.webp", "path": null, "size": 35.49, "width": 563, "height": 750, "sizeInBytes": 35492}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_saturn4_1dfddb44d6.webp", "hash": "thumbnail_saturn4_1dfddb44d6", "mime": "image/webp", "name": "thumbnail_saturn4.webp", "path": null, "size": 4.08, "width": 117, "height": 156, "sizeInBytes": 4076}}	saturn4_1dfddb44d6	.webp	image/webp	52.66	/uploads/saturn4_1dfddb44d6.webp	\N	local	\N	/2/9	2025-04-16 19:28:24.706	2025-04-16 19:28:24.706	2025-04-16 19:28:24.706	1	1	\N
153	biwxl2hdorovme48t07uker9	saturn1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_saturn1_bc8c2b730a.webp", "hash": "small_saturn1_bc8c2b730a", "mime": "image/webp", "name": "small_saturn1.webp", "path": null, "size": 16.46, "width": 375, "height": 500, "sizeInBytes": 16462}, "medium": {"ext": ".webp", "url": "/uploads/medium_saturn1_bc8c2b730a.webp", "hash": "medium_saturn1_bc8c2b730a", "mime": "image/webp", "name": "medium_saturn1.webp", "path": null, "size": 28.32, "width": 563, "height": 750, "sizeInBytes": 28318}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_saturn1_bc8c2b730a.webp", "hash": "thumbnail_saturn1_bc8c2b730a", "mime": "image/webp", "name": "thumbnail_saturn1.webp", "path": null, "size": 3.52, "width": 117, "height": 156, "sizeInBytes": 3516}}	saturn1_bc8c2b730a	.webp	image/webp	39.65	/uploads/saturn1_bc8c2b730a.webp	\N	local	\N	/2/9	2025-04-16 19:28:24.714	2025-04-16 19:28:24.714	2025-04-16 19:28:24.714	1	1	\N
186	a51oc6h39a9fdcwmne8lk274	bl2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bl2_3cc39fd19a.webp", "hash": "small_bl2_3cc39fd19a", "mime": "image/webp", "name": "small_bl2.webp", "path": null, "size": 18.75, "width": 375, "height": 500, "sizeInBytes": 18746}, "medium": {"ext": ".webp", "url": "/uploads/medium_bl2_3cc39fd19a.webp", "hash": "medium_bl2_3cc39fd19a", "mime": "image/webp", "name": "medium_bl2.webp", "path": null, "size": 35.97, "width": 563, "height": 750, "sizeInBytes": 35972}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bl2_3cc39fd19a.webp", "hash": "thumbnail_bl2_3cc39fd19a", "mime": "image/webp", "name": "thumbnail_bl2.webp", "path": null, "size": 2.82, "width": 117, "height": 156, "sizeInBytes": 2822}}	bl2_3cc39fd19a	.webp	image/webp	59.17	/uploads/bl2_3cc39fd19a.webp	\N	local	\N	/2/21	2025-04-16 21:11:46.031	2025-04-16 21:11:46.031	2025-04-16 21:11:46.031	1	1	\N
231	zfuqp8qv7ry82x60k3hfc7fd	base1.avif	\N	\N	\N	\N	\N	base1_59b6c2a2e8	.avif	image/avif	1.23	/uploads/base1_59b6c2a2e8.avif	\N	local	\N	/2/23	2025-04-16 22:14:33.111	2025-04-16 22:14:33.111	2025-04-16 22:14:33.112	1	1	\N
256	usepkeda97bcyvi9o7tfhwuy	asa1.webp	\N	\N	304	304	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_asa1_27bf3eb1a3.webp", "hash": "thumbnail_asa1_27bf3eb1a3", "mime": "image/webp", "name": "thumbnail_asa1.webp", "path": null, "size": 5.99, "width": 156, "height": 156, "sizeInBytes": 5990}}	asa1_27bf3eb1a3	.webp	image/webp	19.29	/uploads/asa1_27bf3eb1a3.webp	\N	local	\N	/2/7	2025-04-17 11:08:12.838	2025-04-17 11:08:12.838	2025-04-17 11:08:12.838	1	1	\N
87	dtqy2m8z8g2dew4f8bfwmo2n	flsun3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_flsun3_aa3082fce4.webp", "hash": "small_flsun3_aa3082fce4", "mime": "image/webp", "name": "small_flsun3.webp", "path": null, "size": 15.33, "width": 500, "height": 375, "sizeInBytes": 15328}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_flsun3_aa3082fce4.webp", "hash": "thumbnail_flsun3_aa3082fce4", "mime": "image/webp", "name": "thumbnail_flsun3.webp", "path": null, "size": 5, "width": 208, "height": 156, "sizeInBytes": 4998}}	flsun3_aa3082fce4	.webp	image/webp	26.12	/uploads/flsun3_aa3082fce4.webp	\N	local	\N	/2/13	2025-04-15 21:29:10.151	2025-04-15 21:29:10.151	2025-04-15 21:29:10.151	1	1	\N
114	fy15pk9eldk46b3gtnwfevjd	photon5.webp	\N	\N	640	902	{"small": {"ext": ".webp", "url": "/uploads/small_photon5_6675dfafda.webp", "hash": "small_photon5_6675dfafda", "mime": "image/webp", "name": "small_photon5.webp", "path": null, "size": 19.35, "width": 355, "height": 500, "sizeInBytes": 19350}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon5_6675dfafda.webp", "hash": "medium_photon5_6675dfafda", "mime": "image/webp", "name": "medium_photon5.webp", "path": null, "size": 31.56, "width": 532, "height": 750, "sizeInBytes": 31556}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon5_6675dfafda.webp", "hash": "thumbnail_photon5_6675dfafda", "mime": "image/webp", "name": "thumbnail_photon5.webp", "path": null, "size": 3.49, "width": 111, "height": 156, "sizeInBytes": 3490}}	photon5_6675dfafda	.webp	image/webp	47.28	/uploads/photon5_6675dfafda.webp	\N	local	\N	/2/7	2025-04-15 22:01:21.687	2025-04-15 22:01:21.687	2025-04-15 22:01:21.687	1	1	\N
115	dgl4w10viwb3l6hr4re3nmzd	photon6.webp	\N	\N	640	913	{"small": {"ext": ".webp", "url": "/uploads/small_photon6_ad4e813ada.webp", "hash": "small_photon6_ad4e813ada", "mime": "image/webp", "name": "small_photon6.webp", "path": null, "size": 15.68, "width": 350, "height": 500, "sizeInBytes": 15676}, "medium": {"ext": ".webp", "url": "/uploads/medium_photon6_ad4e813ada.webp", "hash": "medium_photon6_ad4e813ada", "mime": "image/webp", "name": "medium_photon6.webp", "path": null, "size": 26, "width": 526, "height": 750, "sizeInBytes": 26002}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_photon6_ad4e813ada.webp", "hash": "thumbnail_photon6_ad4e813ada", "mime": "image/webp", "name": "thumbnail_photon6.webp", "path": null, "size": 2.92, "width": 109, "height": 156, "sizeInBytes": 2920}}	photon6_ad4e813ada	.webp	image/webp	39.70	/uploads/photon6_ad4e813ada.webp	\N	local	\N	/2/7	2025-04-15 22:01:21.71	2025-04-15 22:01:21.71	2025-04-15 22:01:21.71	1	1	\N
156	we0083lr4xpp3iac42lfikuj	mega4.webp	\N	\N	640	469	{"small": {"ext": ".webp", "url": "/uploads/small_mega4_d4909bf42f.webp", "hash": "small_mega4_d4909bf42f", "mime": "image/webp", "name": "small_mega4.webp", "path": null, "size": 17.93, "width": 500, "height": 366, "sizeInBytes": 17930}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mega4_d4909bf42f.webp", "hash": "thumbnail_mega4_d4909bf42f", "mime": "image/webp", "name": "thumbnail_mega4.webp", "path": null, "size": 5.33, "width": 213, "height": 156, "sizeInBytes": 5328}}	mega4_d4909bf42f	.webp	image/webp	29.84	/uploads/mega4_d4909bf42f.webp	\N	local	\N	/2/15	2025-04-16 19:32:51.207	2025-04-16 19:32:51.207	2025-04-16 19:32:51.207	1	1	\N
157	pa46td18yf33apswqhfw6xdk	mega1.webp	\N	\N	640	848	{"small": {"ext": ".webp", "url": "/uploads/small_mega1_62180c41b4.webp", "hash": "small_mega1_62180c41b4", "mime": "image/webp", "name": "small_mega1.webp", "path": null, "size": 23.83, "width": 377, "height": 500, "sizeInBytes": 23832}, "medium": {"ext": ".webp", "url": "/uploads/medium_mega1_62180c41b4.webp", "hash": "medium_mega1_62180c41b4", "mime": "image/webp", "name": "medium_mega1.webp", "path": null, "size": 41.04, "width": 566, "height": 750, "sizeInBytes": 41042}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mega1_62180c41b4.webp", "hash": "thumbnail_mega1_62180c41b4", "mime": "image/webp", "name": "thumbnail_mega1.webp", "path": null, "size": 3.46, "width": 118, "height": 156, "sizeInBytes": 3458}}	mega1_62180c41b4	.webp	image/webp	58.61	/uploads/mega1_62180c41b4.webp	\N	local	\N	/2/15	2025-04-16 19:32:51.232	2025-04-16 19:32:51.232	2025-04-16 19:32:51.232	1	1	\N
158	gmqjn0mo34bgb9qmaugg19lq	mega3.webp	\N	\N	640	847	{"small": {"ext": ".webp", "url": "/uploads/small_mega3_a2c885d84f.webp", "hash": "small_mega3_a2c885d84f", "mime": "image/webp", "name": "small_mega3.webp", "path": null, "size": 23.03, "width": 378, "height": 500, "sizeInBytes": 23030}, "medium": {"ext": ".webp", "url": "/uploads/medium_mega3_a2c885d84f.webp", "hash": "medium_mega3_a2c885d84f", "mime": "image/webp", "name": "medium_mega3.webp", "path": null, "size": 37.58, "width": 567, "height": 750, "sizeInBytes": 37580}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mega3_a2c885d84f.webp", "hash": "thumbnail_mega3_a2c885d84f", "mime": "image/webp", "name": "thumbnail_mega3.webp", "path": null, "size": 3.7, "width": 118, "height": 156, "sizeInBytes": 3702}}	mega3_a2c885d84f	.webp	image/webp	53.65	/uploads/mega3_a2c885d84f.webp	\N	local	\N	/2/15	2025-04-16 19:32:51.256	2025-04-16 19:32:51.256	2025-04-16 19:32:51.256	1	1	\N
187	o7m1mo9ceymomziqjyxdt8ji	bl3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bl3_90d8625263.webp", "hash": "small_bl3_90d8625263", "mime": "image/webp", "name": "small_bl3.webp", "path": null, "size": 23.31, "width": 375, "height": 500, "sizeInBytes": 23312}, "medium": {"ext": ".webp", "url": "/uploads/medium_bl3_90d8625263.webp", "hash": "medium_bl3_90d8625263", "mime": "image/webp", "name": "medium_bl3.webp", "path": null, "size": 43.17, "width": 563, "height": 750, "sizeInBytes": 43174}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bl3_90d8625263.webp", "hash": "thumbnail_bl3_90d8625263", "mime": "image/webp", "name": "thumbnail_bl3.webp", "path": null, "size": 3.33, "width": 117, "height": 156, "sizeInBytes": 3332}}	bl3_90d8625263	.webp	image/webp	68.22	/uploads/bl3_90d8625263.webp	\N	local	\N	/2/21	2025-04-16 21:11:46.036	2025-04-16 21:11:46.036	2025-04-16 21:11:46.036	1	1	\N
257	j5qw1540y2elfoqko3z5h23r	pet1.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pet1_b94ee4888c.webp", "hash": "thumbnail_pet1_b94ee4888c", "mime": "image/webp", "name": "thumbnail_pet1.webp", "path": null, "size": 6.19, "width": 158, "height": 156, "sizeInBytes": 6194}}	pet1_b94ee4888c	.webp	image/webp	18.29	/uploads/pet1_b94ee4888c.webp	\N	local	\N	/2/24	2025-04-17 11:12:31.682	2025-04-17 11:12:31.682	2025-04-17 11:12:31.682	1	1	\N
91	x5ijs9s8gc0s3tmgdqg9i2vr	king1.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king1_a3d995dfa5.webp", "hash": "small_king1_a3d995dfa5", "mime": "image/webp", "name": "small_king1.webp", "path": null, "size": 17.38, "width": 500, "height": 500, "sizeInBytes": 17384}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king1_a3d995dfa5.webp", "hash": "thumbnail_king1_a3d995dfa5", "mime": "image/webp", "name": "thumbnail_king1.webp", "path": null, "size": 2.67, "width": 156, "height": 156, "sizeInBytes": 2668}}	king1_a3d995dfa5	.webp	image/webp	37.53	/uploads/king1_a3d995dfa5.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.513	2025-04-15 21:33:51.513	2025-04-15 21:33:51.513	1	1	\N
93	fsfxknvvoiy1t0j98eltx3an	king3.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king3_6d03a0acd2.webp", "hash": "small_king3_6d03a0acd2", "mime": "image/webp", "name": "small_king3.webp", "path": null, "size": 21.48, "width": 500, "height": 500, "sizeInBytes": 21480}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king3_6d03a0acd2.webp", "hash": "thumbnail_king3_6d03a0acd2", "mime": "image/webp", "name": "thumbnail_king3.webp", "path": null, "size": 4.12, "width": 156, "height": 156, "sizeInBytes": 4122}}	king3_6d03a0acd2	.webp	image/webp	35.79	/uploads/king3_6d03a0acd2.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.531	2025-04-15 21:33:51.531	2025-04-15 21:33:51.531	1	1	\N
116	n559amz7vdfup2cmgheuzrkv	halot2.webp	\N	\N	573	409	{"small": {"ext": ".webp", "url": "/uploads/small_halot2_c0c6ca3552.webp", "hash": "small_halot2_c0c6ca3552", "mime": "image/webp", "name": "small_halot2.webp", "path": null, "size": 4.37, "width": 500, "height": 357, "sizeInBytes": 4374}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_halot2_c0c6ca3552.webp", "hash": "thumbnail_halot2_c0c6ca3552", "mime": "image/webp", "name": "thumbnail_halot2.webp", "path": null, "size": 1.74, "width": 219, "height": 156, "sizeInBytes": 1736}}	halot2_c0c6ca3552	.webp	image/webp	5.85	/uploads/halot2_c0c6ca3552.webp	\N	local	\N	/2/4	2025-04-15 22:08:01.688	2025-04-15 22:08:01.688	2025-04-15 22:08:01.688	1	1	\N
118	zv3vxwwo20q85wqagp8c9zf3	halot1.webp	\N	\N	640	360	{"small": {"ext": ".webp", "url": "/uploads/small_halot1_5d8657be1a.webp", "hash": "small_halot1_5d8657be1a", "mime": "image/webp", "name": "small_halot1.webp", "path": null, "size": 20.46, "width": 500, "height": 281, "sizeInBytes": 20464}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_halot1_5d8657be1a.webp", "hash": "thumbnail_halot1_5d8657be1a", "mime": "image/webp", "name": "thumbnail_halot1.webp", "path": null, "size": 5.77, "width": 245, "height": 138, "sizeInBytes": 5772}}	halot1_5d8657be1a	.webp	image/webp	44.31	/uploads/halot1_5d8657be1a.webp	\N	local	\N	/2/4	2025-04-15 22:08:01.698	2025-04-15 22:08:01.698	2025-04-15 22:08:01.698	1	1	\N
274	sncyzudqudvj7rh51wwulgah	carn2.jpeg	\N	\N	236	214	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_carn2_ce6eea7a8e.jpeg", "hash": "thumbnail_carn2_ce6eea7a8e", "mime": "image/jpeg", "name": "thumbnail_carn2.jpeg", "path": null, "size": 5.17, "width": 172, "height": 156, "sizeInBytes": 5174}}	carn2_ce6eea7a8e	.jpeg	image/jpeg	7.40	/uploads/carn2_ce6eea7a8e.jpeg	\N	local	\N	/2/7	2025-04-17 11:48:16.936	2025-04-17 11:48:16.936	2025-04-17 11:48:16.936	1	1	\N
119	yxk6og2evg794x4ki13a4tfv	halot4.webp	\N	\N	566	552	{"small": {"ext": ".webp", "url": "/uploads/small_halot4_be19d59eb6.webp", "hash": "small_halot4_be19d59eb6", "mime": "image/webp", "name": "small_halot4.webp", "path": null, "size": 26.04, "width": 500, "height": 488, "sizeInBytes": 26044}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_halot4_be19d59eb6.webp", "hash": "thumbnail_halot4_be19d59eb6", "mime": "image/webp", "name": "thumbnail_halot4.webp", "path": null, "size": 6.09, "width": 160, "height": 156, "sizeInBytes": 6086}}	halot4_be19d59eb6	.webp	image/webp	34.97	/uploads/halot4_be19d59eb6.webp	\N	local	\N	/2/4	2025-04-15 22:08:01.704	2025-04-15 22:08:01.704	2025-04-15 22:08:01.704	1	1	\N
155	hdkofgve09imyl4kqdo9cdur	mega2.webp	\N	\N	640	472	{"small": {"ext": ".webp", "url": "/uploads/small_mega2_91b9437c75.webp", "hash": "small_mega2_91b9437c75", "mime": "image/webp", "name": "small_mega2.webp", "path": null, "size": 21.5, "width": 500, "height": 369, "sizeInBytes": 21500}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mega2_91b9437c75.webp", "hash": "thumbnail_mega2_91b9437c75", "mime": "image/webp", "name": "thumbnail_mega2.webp", "path": null, "size": 6.22, "width": 212, "height": 156, "sizeInBytes": 6222}}	mega2_91b9437c75	.webp	image/webp	35.36	/uploads/mega2_91b9437c75.webp	\N	local	\N	/2/15	2025-04-16 19:32:51.198	2025-04-16 19:32:51.198	2025-04-16 19:32:51.198	1	1	\N
188	f1natehaenl96nss6owkz7z8	bl1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bl1_326f748a7f.webp", "hash": "small_bl1_326f748a7f", "mime": "image/webp", "name": "small_bl1.webp", "path": null, "size": 25.53, "width": 375, "height": 500, "sizeInBytes": 25528}, "medium": {"ext": ".webp", "url": "/uploads/medium_bl1_326f748a7f.webp", "hash": "medium_bl1_326f748a7f", "mime": "image/webp", "name": "medium_bl1.webp", "path": null, "size": 47.02, "width": 563, "height": 750, "sizeInBytes": 47018}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bl1_326f748a7f.webp", "hash": "thumbnail_bl1_326f748a7f", "mime": "image/webp", "name": "thumbnail_bl1.webp", "path": null, "size": 3.68, "width": 117, "height": 156, "sizeInBytes": 3678}}	bl1_326f748a7f	.webp	image/webp	72.82	/uploads/bl1_326f748a7f.webp	\N	local	\N	/2/21	2025-04-16 21:11:46.046	2025-04-16 21:11:46.046	2025-04-16 21:11:46.047	1	1	\N
189	pa5iljeyr2sov600v5rlzba5	bl4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bl4_5474cbf9fc.webp", "hash": "small_bl4_5474cbf9fc", "mime": "image/webp", "name": "small_bl4.webp", "path": null, "size": 23.48, "width": 375, "height": 500, "sizeInBytes": 23484}, "medium": {"ext": ".webp", "url": "/uploads/medium_bl4_5474cbf9fc.webp", "hash": "medium_bl4_5474cbf9fc", "mime": "image/webp", "name": "medium_bl4.webp", "path": null, "size": 43.92, "width": 563, "height": 750, "sizeInBytes": 43916}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bl4_5474cbf9fc.webp", "hash": "thumbnail_bl4_5474cbf9fc", "mime": "image/webp", "name": "thumbnail_bl4.webp", "path": null, "size": 3.75, "width": 117, "height": 156, "sizeInBytes": 3752}}	bl4_5474cbf9fc	.webp	image/webp	71.70	/uploads/bl4_5474cbf9fc.webp	\N	local	\N	/2/21	2025-04-16 21:11:46.065	2025-04-16 21:11:46.065	2025-04-16 21:11:46.065	1	1	\N
213	u8tq1ln76069z0q15j17ijd1	sensor3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sensor3_b43d4ac46c.webp", "hash": "small_sensor3_b43d4ac46c", "mime": "image/webp", "name": "small_sensor3.webp", "path": null, "size": 23.42, "width": 375, "height": 500, "sizeInBytes": 23420}, "medium": {"ext": ".webp", "url": "/uploads/medium_sensor3_b43d4ac46c.webp", "hash": "medium_sensor3_b43d4ac46c", "mime": "image/webp", "name": "medium_sensor3.webp", "path": null, "size": 40.96, "width": 563, "height": 750, "sizeInBytes": 40962}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sensor3_b43d4ac46c.webp", "hash": "thumbnail_sensor3_b43d4ac46c", "mime": "image/webp", "name": "thumbnail_sensor3.webp", "path": null, "size": 4.06, "width": 117, "height": 156, "sizeInBytes": 4062}}	sensor3_b43d4ac46c	.webp	image/webp	64.20	/uploads/sensor3_b43d4ac46c.webp	\N	local	\N	/2/21	2025-04-16 21:54:00.006	2025-04-16 21:54:00.006	2025-04-16 21:54:00.006	1	1	\N
92	kkshxnvpoq3xqw9o9g2cgn2d	king2.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king2_1b640c4ef6.webp", "hash": "small_king2_1b640c4ef6", "mime": "image/webp", "name": "small_king2.webp", "path": null, "size": 17.38, "width": 500, "height": 500, "sizeInBytes": 17376}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king2_1b640c4ef6.webp", "hash": "thumbnail_king2_1b640c4ef6", "mime": "image/webp", "name": "thumbnail_king2.webp", "path": null, "size": 3.79, "width": 156, "height": 156, "sizeInBytes": 3786}}	king2_1b640c4ef6	.webp	image/webp	28.26	/uploads/king2_1b640c4ef6.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.514	2025-04-15 21:33:51.514	2025-04-15 21:33:51.514	1	1	\N
117	yvkiqkyqr7hd9ioku4pru50d	halot3.webp	\N	\N	569	548	{"small": {"ext": ".webp", "url": "/uploads/small_halot3_fa824e3d28.webp", "hash": "small_halot3_fa824e3d28", "mime": "image/webp", "name": "small_halot3.webp", "path": null, "size": 3.93, "width": 500, "height": 482, "sizeInBytes": 3926}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_halot3_fa824e3d28.webp", "hash": "thumbnail_halot3_fa824e3d28", "mime": "image/webp", "name": "thumbnail_halot3.webp", "path": null, "size": 1.02, "width": 162, "height": 156, "sizeInBytes": 1020}}	halot3_fa824e3d28	.webp	image/webp	5.69	/uploads/halot3_fa824e3d28.webp	\N	local	\N	/2/4	2025-04-15 22:08:01.695	2025-04-15 22:08:01.695	2025-04-15 22:08:01.695	1	1	\N
159	o5d3zoc69fq620baojjl5rt5	mono4.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_mono4_1c40316360.webp", "hash": "small_mono4_1c40316360", "mime": "image/webp", "name": "small_mono4.webp", "path": null, "size": 8, "width": 500, "height": 375, "sizeInBytes": 8000}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono4_1c40316360.webp", "hash": "thumbnail_mono4_1c40316360", "mime": "image/webp", "name": "thumbnail_mono4.webp", "path": null, "size": 2.85, "width": 208, "height": 156, "sizeInBytes": 2848}}	mono4_1c40316360	.webp	image/webp	12.13	/uploads/mono4_1c40316360.webp	\N	local	\N	/2/7	2025-04-16 19:37:06.659	2025-04-16 19:37:06.659	2025-04-16 19:37:06.66	1	1	\N
160	w0dl1dx2hqvjczrbddya7lgu	mono2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mono2_f238d80cf7.webp", "hash": "small_mono2_f238d80cf7", "mime": "image/webp", "name": "small_mono2.webp", "path": null, "size": 14.4, "width": 375, "height": 500, "sizeInBytes": 14402}, "medium": {"ext": ".webp", "url": "/uploads/medium_mono2_f238d80cf7.webp", "hash": "medium_mono2_f238d80cf7", "mime": "image/webp", "name": "medium_mono2.webp", "path": null, "size": 23.68, "width": 563, "height": 750, "sizeInBytes": 23684}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono2_f238d80cf7.webp", "hash": "thumbnail_mono2_f238d80cf7", "mime": "image/webp", "name": "thumbnail_mono2.webp", "path": null, "size": 3.1, "width": 117, "height": 156, "sizeInBytes": 3098}}	mono2_f238d80cf7	.webp	image/webp	32.92	/uploads/mono2_f238d80cf7.webp	\N	local	\N	/2/7	2025-04-16 19:37:06.695	2025-04-16 19:37:06.695	2025-04-16 19:37:06.695	1	1	\N
190	fg28lkxfi5b4g9bjv5uaav68	font3.webp	\N	\N	640	481	{"small": {"ext": ".webp", "url": "/uploads/small_font3_e7f5d2ae0f.webp", "hash": "small_font3_e7f5d2ae0f", "mime": "image/webp", "name": "small_font3.webp", "path": null, "size": 7.6, "width": 500, "height": 376, "sizeInBytes": 7604}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_font3_e7f5d2ae0f.webp", "hash": "thumbnail_font3_e7f5d2ae0f", "mime": "image/webp", "name": "thumbnail_font3.webp", "path": null, "size": 2.96, "width": 208, "height": 156, "sizeInBytes": 2956}}	font3_e7f5d2ae0f	.webp	image/webp	10.93	/uploads/font3_e7f5d2ae0f.webp	\N	local	\N	/2/21	2025-04-16 21:15:02.844	2025-04-16 21:15:02.844	2025-04-16 21:15:02.844	1	1	\N
192	qhfqc5va8j4yo5vwdn4zkkho	font4.webp	\N	\N	640	481	{"small": {"ext": ".webp", "url": "/uploads/small_font4_43432aabe0.webp", "hash": "small_font4_43432aabe0", "mime": "image/webp", "name": "small_font4.webp", "path": null, "size": 14.94, "width": 500, "height": 376, "sizeInBytes": 14936}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_font4_43432aabe0.webp", "hash": "thumbnail_font4_43432aabe0", "mime": "image/webp", "name": "thumbnail_font4.webp", "path": null, "size": 4.99, "width": 208, "height": 156, "sizeInBytes": 4988}}	font4_43432aabe0	.webp	image/webp	22.82	/uploads/font4_43432aabe0.webp	\N	local	\N	/2/21	2025-04-16 21:15:02.851	2025-04-16 21:15:02.851	2025-04-16 21:15:02.851	1	1	\N
193	cbtzehooxtbxfmxd3fwoidfs	font1.webp	\N	\N	640	852	{"small": {"ext": ".webp", "url": "/uploads/small_font1_e48052c30e.webp", "hash": "small_font1_e48052c30e", "mime": "image/webp", "name": "small_font1.webp", "path": null, "size": 32.78, "width": 376, "height": 500, "sizeInBytes": 32776}, "medium": {"ext": ".webp", "url": "/uploads/medium_font1_e48052c30e.webp", "hash": "medium_font1_e48052c30e", "mime": "image/webp", "name": "medium_font1.webp", "path": null, "size": 56.96, "width": 563, "height": 750, "sizeInBytes": 56960}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_font1_e48052c30e.webp", "hash": "thumbnail_font1_e48052c30e", "mime": "image/webp", "name": "thumbnail_font1.webp", "path": null, "size": 4.86, "width": 117, "height": 156, "sizeInBytes": 4864}}	font1_e48052c30e	.webp	image/webp	82.66	/uploads/font1_e48052c30e.webp	\N	local	\N	/2/21	2025-04-16 21:15:02.897	2025-04-16 21:15:02.897	2025-04-16 21:15:02.897	1	1	\N
214	ismfpy83q4qxg1m10jtjrg2l	pi4.webp	\N	\N	640	508	{"small": {"ext": ".webp", "url": "/uploads/small_pi4_d194ffca6a.webp", "hash": "small_pi4_d194ffca6a", "mime": "image/webp", "name": "small_pi4.webp", "path": null, "size": 15.01, "width": 500, "height": 397, "sizeInBytes": 15008}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pi4_d194ffca6a.webp", "hash": "thumbnail_pi4_d194ffca6a", "mime": "image/webp", "name": "thumbnail_pi4.webp", "path": null, "size": 5.04, "width": 197, "height": 156, "sizeInBytes": 5038}}	pi4_d194ffca6a	.webp	image/webp	22.69	/uploads/pi4_d194ffca6a.webp	\N	local	\N	/2	2025-04-16 21:57:48.572	2025-04-16 21:57:48.572	2025-04-16 21:57:48.572	1	1	\N
215	kb0c9tl753x82fmqze7j7aqv	pi1.webp	\N	\N	640	597	{"small": {"ext": ".webp", "url": "/uploads/small_pi1_d189c4e62c.webp", "hash": "small_pi1_d189c4e62c", "mime": "image/webp", "name": "small_pi1.webp", "path": null, "size": 15.06, "width": 500, "height": 466, "sizeInBytes": 15062}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pi1_d189c4e62c.webp", "hash": "thumbnail_pi1_d189c4e62c", "mime": "image/webp", "name": "thumbnail_pi1.webp", "path": null, "size": 4.1, "width": 167, "height": 156, "sizeInBytes": 4104}}	pi1_d189c4e62c	.webp	image/webp	22.65	/uploads/pi1_d189c4e62c.webp	\N	local	\N	/2	2025-04-16 21:57:48.587	2025-04-16 21:57:48.587	2025-04-16 21:57:48.587	1	1	\N
258	crpmihfgp9qbr0y8qh5hrzz9	pet2.webp	\N	\N	304	304	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pet2_1dd614c847.webp", "hash": "thumbnail_pet2_1dd614c847", "mime": "image/webp", "name": "thumbnail_pet2.webp", "path": null, "size": 4.61, "width": 156, "height": 156, "sizeInBytes": 4612}}	pet2_1dd614c847	.webp	image/webp	15.12	/uploads/pet2_1dd614c847.webp	\N	local	\N	/2/24	2025-04-17 11:12:31.682	2025-04-17 11:12:31.682	2025-04-17 11:12:31.682	1	1	\N
94	i7sp9lk3kxyf0vq9cpxk7jti	king5.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king5_892b8ef13e.webp", "hash": "small_king5_892b8ef13e", "mime": "image/webp", "name": "small_king5.webp", "path": null, "size": 15.79, "width": 500, "height": 500, "sizeInBytes": 15786}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king5_892b8ef13e.webp", "hash": "thumbnail_king5_892b8ef13e", "mime": "image/webp", "name": "thumbnail_king5.webp", "path": null, "size": 3.68, "width": 156, "height": 156, "sizeInBytes": 3682}}	king5_892b8ef13e	.webp	image/webp	23.90	/uploads/king5_892b8ef13e.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.536	2025-04-15 21:33:51.536	2025-04-15 21:33:51.536	1	1	\N
98	ag842ree1rslp5cans89wyvw	king9.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king9_f7eba2895d.webp", "hash": "small_king9_f7eba2895d", "mime": "image/webp", "name": "small_king9.webp", "path": null, "size": 11.02, "width": 500, "height": 500, "sizeInBytes": 11022}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king9_f7eba2895d.webp", "hash": "thumbnail_king9_f7eba2895d", "mime": "image/webp", "name": "thumbnail_king9.webp", "path": null, "size": 3.07, "width": 156, "height": 156, "sizeInBytes": 3070}}	king9_f7eba2895d	.webp	image/webp	16.34	/uploads/king9_f7eba2895d.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.636	2025-04-15 21:33:51.636	2025-04-15 21:33:51.636	1	1	\N
120	fids6pzckgi7wdd5e8i0xoof	nova1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nova1_c801993a7d.webp", "hash": "small_nova1_c801993a7d", "mime": "image/webp", "name": "small_nova1.webp", "path": null, "size": 6.49, "width": 375, "height": 500, "sizeInBytes": 6490}, "medium": {"ext": ".webp", "url": "/uploads/medium_nova1_c801993a7d.webp", "hash": "medium_nova1_c801993a7d", "mime": "image/webp", "name": "medium_nova1.webp", "path": null, "size": 10.53, "width": 563, "height": 750, "sizeInBytes": 10528}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nova1_c801993a7d.webp", "hash": "thumbnail_nova1_c801993a7d", "mime": "image/webp", "name": "thumbnail_nova1.webp", "path": null, "size": 1.55, "width": 117, "height": 156, "sizeInBytes": 1552}}	nova1_c801993a7d	.webp	image/webp	15.45	/uploads/nova1_c801993a7d.webp	\N	local	\N	/2/16	2025-04-15 22:11:55.169	2025-04-15 22:11:55.169	2025-04-15 22:11:55.169	1	1	\N
125	sg2l7ol2du9jv7rr1jsjr6vh	epax2.webp	\N	\N	433	577	{"small": {"ext": ".webp", "url": "/uploads/small_epax2_25213c0f56.webp", "hash": "small_epax2_25213c0f56", "mime": "image/webp", "name": "small_epax2.webp", "path": null, "size": 2.17, "width": 375, "height": 500, "sizeInBytes": 2170}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_epax2_25213c0f56.webp", "hash": "thumbnail_epax2_25213c0f56", "mime": "image/webp", "name": "thumbnail_epax2.webp", "path": null, "size": 0.56, "width": 117, "height": 156, "sizeInBytes": 560}}	epax2_25213c0f56	.webp	image/webp	3.18	/uploads/epax2_25213c0f56.webp	\N	local	\N	/2/17	2025-04-15 22:16:13.979	2025-04-15 22:16:13.979	2025-04-15 22:16:13.979	1	1	\N
121	kabm018apflr48ucx1ngwisk	nova2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nova2_8d95a38c30.webp", "hash": "small_nova2_8d95a38c30", "mime": "image/webp", "name": "small_nova2.webp", "path": null, "size": 8.34, "width": 375, "height": 500, "sizeInBytes": 8338}, "medium": {"ext": ".webp", "url": "/uploads/medium_nova2_8d95a38c30.webp", "hash": "medium_nova2_8d95a38c30", "mime": "image/webp", "name": "medium_nova2.webp", "path": null, "size": 12.53, "width": 563, "height": 750, "sizeInBytes": 12528}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nova2_8d95a38c30.webp", "hash": "thumbnail_nova2_8d95a38c30", "mime": "image/webp", "name": "thumbnail_nova2.webp", "path": null, "size": 2.14, "width": 117, "height": 156, "sizeInBytes": 2144}}	nova2_8d95a38c30	.webp	image/webp	16.96	/uploads/nova2_8d95a38c30.webp	\N	local	\N	/2/16	2025-04-15 22:11:55.184	2025-04-15 22:11:55.184	2025-04-15 22:11:55.184	1	1	\N
122	vqhdwewrazxuq2qus4kehpf3	nova4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nova4_97aeae5876.webp", "hash": "small_nova4_97aeae5876", "mime": "image/webp", "name": "small_nova4.webp", "path": null, "size": 6.52, "width": 375, "height": 500, "sizeInBytes": 6520}, "medium": {"ext": ".webp", "url": "/uploads/medium_nova4_97aeae5876.webp", "hash": "medium_nova4_97aeae5876", "mime": "image/webp", "name": "medium_nova4.webp", "path": null, "size": 11.03, "width": 563, "height": 750, "sizeInBytes": 11028}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nova4_97aeae5876.webp", "hash": "thumbnail_nova4_97aeae5876", "mime": "image/webp", "name": "thumbnail_nova4.webp", "path": null, "size": 1.5, "width": 117, "height": 156, "sizeInBytes": 1498}}	nova4_97aeae5876	.webp	image/webp	16.45	/uploads/nova4_97aeae5876.webp	\N	local	\N	/2/16	2025-04-15 22:11:55.194	2025-04-15 22:11:55.194	2025-04-15 22:11:55.195	1	1	\N
161	jrmsvtk2an3ja3pnb3g01f22	mono1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mono1_1776c507cc.webp", "hash": "small_mono1_1776c507cc", "mime": "image/webp", "name": "small_mono1.webp", "path": null, "size": 12.77, "width": 375, "height": 500, "sizeInBytes": 12770}, "medium": {"ext": ".webp", "url": "/uploads/medium_mono1_1776c507cc.webp", "hash": "medium_mono1_1776c507cc", "mime": "image/webp", "name": "medium_mono1.webp", "path": null, "size": 20.38, "width": 563, "height": 750, "sizeInBytes": 20382}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono1_1776c507cc.webp", "hash": "thumbnail_mono1_1776c507cc", "mime": "image/webp", "name": "thumbnail_mono1.webp", "path": null, "size": 2.91, "width": 117, "height": 156, "sizeInBytes": 2908}}	mono1_1776c507cc	.webp	image/webp	26.76	/uploads/mono1_1776c507cc.webp	\N	local	\N	/2/7	2025-04-16 19:37:06.695	2025-04-16 19:37:06.695	2025-04-16 19:37:06.695	1	1	\N
191	k8cewl16o1hkodd8j7vuh3tr	font2.webp	\N	\N	640	481	{"small": {"ext": ".webp", "url": "/uploads/small_font2_da55721e85.webp", "hash": "small_font2_da55721e85", "mime": "image/webp", "name": "small_font2.webp", "path": null, "size": 12.68, "width": 500, "height": 376, "sizeInBytes": 12676}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_font2_da55721e85.webp", "hash": "thumbnail_font2_da55721e85", "mime": "image/webp", "name": "thumbnail_font2.webp", "path": null, "size": 4.68, "width": 208, "height": 156, "sizeInBytes": 4680}}	font2_da55721e85	.webp	image/webp	19.56	/uploads/font2_da55721e85.webp	\N	local	\N	/2/21	2025-04-16 21:15:02.848	2025-04-16 21:15:02.848	2025-04-16 21:15:02.848	1	1	\N
216	tr3g6np4kpelrycbt8he3cqt	pi3.webp	\N	\N	640	802	{"small": {"ext": ".webp", "url": "/uploads/small_pi3_745791160b.webp", "hash": "small_pi3_745791160b", "mime": "image/webp", "name": "small_pi3.webp", "path": null, "size": 15.27, "width": 399, "height": 500, "sizeInBytes": 15268}, "medium": {"ext": ".webp", "url": "/uploads/medium_pi3_745791160b.webp", "hash": "medium_pi3_745791160b", "mime": "image/webp", "name": "medium_pi3.webp", "path": null, "size": 24.13, "width": 599, "height": 750, "sizeInBytes": 24126}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pi3_745791160b.webp", "hash": "thumbnail_pi3_745791160b", "mime": "image/webp", "name": "thumbnail_pi3.webp", "path": null, "size": 3.14, "width": 124, "height": 156, "sizeInBytes": 3140}}	pi3_745791160b	.webp	image/webp	31.99	/uploads/pi3_745791160b.webp	\N	local	\N	/2	2025-04-16 21:57:48.598	2025-04-16 21:57:48.598	2025-04-16 21:57:48.598	1	1	\N
259	ewx3cbbc3wl7cnzp7qie8euk	pc2.jpeg	\N	\N	225	225	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_pc2_e04280fe07.jpeg", "hash": "thumbnail_pc2_e04280fe07", "mime": "image/jpeg", "name": "thumbnail_pc2.jpeg", "path": null, "size": 3.41, "width": 156, "height": 156, "sizeInBytes": 3414}}	pc2_e04280fe07	.jpeg	image/jpeg	5.66	/uploads/pc2_e04280fe07.jpeg	\N	local	\N	/2/3	2025-04-17 11:15:44.789	2025-04-17 11:15:44.789	2025-04-17 11:15:44.789	1	1	\N
95	eypgbvhld86wkjmz2hqdshhy	king4.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king4_722806e859.webp", "hash": "small_king4_722806e859", "mime": "image/webp", "name": "small_king4.webp", "path": null, "size": 11.79, "width": 500, "height": 500, "sizeInBytes": 11786}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king4_722806e859.webp", "hash": "thumbnail_king4_722806e859", "mime": "image/webp", "name": "thumbnail_king4.webp", "path": null, "size": 2.55, "width": 156, "height": 156, "sizeInBytes": 2554}}	king4_722806e859	.webp	image/webp	20.18	/uploads/king4_722806e859.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.536	2025-04-15 21:33:51.536	2025-04-15 21:33:51.536	1	1	\N
123	puagfgwjotrm4vafyyw13tl3	nova5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nova5_f3a7d5cdda.webp", "hash": "small_nova5_f3a7d5cdda", "mime": "image/webp", "name": "small_nova5.webp", "path": null, "size": 11.7, "width": 375, "height": 500, "sizeInBytes": 11702}, "medium": {"ext": ".webp", "url": "/uploads/medium_nova5_f3a7d5cdda.webp", "hash": "medium_nova5_f3a7d5cdda", "mime": "image/webp", "name": "medium_nova5.webp", "path": null, "size": 18.78, "width": 563, "height": 750, "sizeInBytes": 18780}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nova5_f3a7d5cdda.webp", "hash": "thumbnail_nova5_f3a7d5cdda", "mime": "image/webp", "name": "thumbnail_nova5.webp", "path": null, "size": 2.75, "width": 117, "height": 156, "sizeInBytes": 2754}}	nova5_f3a7d5cdda	.webp	image/webp	26.40	/uploads/nova5_f3a7d5cdda.webp	\N	local	\N	/2/16	2025-04-15 22:11:55.198	2025-04-15 22:11:55.198	2025-04-15 22:11:55.198	1	1	\N
105	hc6l40g9cfk4fvasglqayhze	ele5.webp	\N	\N	640	482	{"small": {"ext": ".webp", "url": "/uploads/small_ele5_6bb4bc8665.webp", "hash": "small_ele5_6bb4bc8665", "mime": "image/webp", "name": "small_ele5.webp", "path": null, "size": 6.21, "width": 500, "height": 377, "sizeInBytes": 6214}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ele5_6bb4bc8665.webp", "hash": "thumbnail_ele5_6bb4bc8665", "mime": "image/webp", "name": "thumbnail_ele5.webp", "path": null, "size": 1.82, "width": 207, "height": 156, "sizeInBytes": 1818}}	ele5_6bb4bc8665	.webp	image/webp	12.07	/uploads/ele5_6bb4bc8665.webp	\N	local	\N	/2/9	2025-04-15 21:38:29.384	2025-04-15 21:38:29.384	2025-04-15 21:38:29.384	1	1	\N
124	dow7ud8q2wha7men002xorkn	nova3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nova3_20f6f45def.webp", "hash": "small_nova3_20f6f45def", "mime": "image/webp", "name": "small_nova3.webp", "path": null, "size": 23.78, "width": 375, "height": 500, "sizeInBytes": 23784}, "medium": {"ext": ".webp", "url": "/uploads/medium_nova3_20f6f45def.webp", "hash": "medium_nova3_20f6f45def", "mime": "image/webp", "name": "medium_nova3.webp", "path": null, "size": 43.6, "width": 563, "height": 750, "sizeInBytes": 43600}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nova3_20f6f45def.webp", "hash": "thumbnail_nova3_20f6f45def", "mime": "image/webp", "name": "thumbnail_nova3.webp", "path": null, "size": 4.22, "width": 117, "height": 156, "sizeInBytes": 4220}}	nova3_20f6f45def	.webp	image/webp	68.05	/uploads/nova3_20f6f45def.webp	\N	local	\N	/2/16	2025-04-15 22:11:55.222	2025-04-15 22:11:55.222	2025-04-15 22:11:55.223	1	1	\N
162	uovbla4nlmj5wy2z6cqnh7ui	mono3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mono3_f0b9565b4a.webp", "hash": "small_mono3_f0b9565b4a", "mime": "image/webp", "name": "small_mono3.webp", "path": null, "size": 12.05, "width": 375, "height": 500, "sizeInBytes": 12046}, "medium": {"ext": ".webp", "url": "/uploads/medium_mono3_f0b9565b4a.webp", "hash": "medium_mono3_f0b9565b4a", "mime": "image/webp", "name": "medium_mono3.webp", "path": null, "size": 19.39, "width": 563, "height": 750, "sizeInBytes": 19394}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono3_f0b9565b4a.webp", "hash": "thumbnail_mono3_f0b9565b4a", "mime": "image/webp", "name": "thumbnail_mono3.webp", "path": null, "size": 2.63, "width": 117, "height": 156, "sizeInBytes": 2634}}	mono3_f0b9565b4a	.webp	image/webp	27.42	/uploads/mono3_f0b9565b4a.webp	\N	local	\N	/2/7	2025-04-16 19:37:06.696	2025-04-16 19:37:06.696	2025-04-16 19:37:06.696	1	1	\N
163	r8ve2ii4sv3v3t9zdlesrxl2	mono5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mono5_46d3adb1c6.webp", "hash": "small_mono5_46d3adb1c6", "mime": "image/webp", "name": "small_mono5.webp", "path": null, "size": 20.16, "width": 375, "height": 500, "sizeInBytes": 20164}, "medium": {"ext": ".webp", "url": "/uploads/medium_mono5_46d3adb1c6.webp", "hash": "medium_mono5_46d3adb1c6", "mime": "image/webp", "name": "medium_mono5.webp", "path": null, "size": 35.02, "width": 563, "height": 750, "sizeInBytes": 35018}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono5_46d3adb1c6.webp", "hash": "thumbnail_mono5_46d3adb1c6", "mime": "image/webp", "name": "thumbnail_mono5.webp", "path": null, "size": 3.9, "width": 117, "height": 156, "sizeInBytes": 3900}}	mono5_46d3adb1c6	.webp	image/webp	52.75	/uploads/mono5_46d3adb1c6.webp	\N	local	\N	/2/7	2025-04-16 19:37:06.704	2025-04-16 19:37:06.704	2025-04-16 19:37:06.704	1	1	\N
194	qbw8ojgy8zyutzhd1dyjp3jj	nema2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nema2_2987779adc.webp", "hash": "small_nema2_2987779adc", "mime": "image/webp", "name": "small_nema2.webp", "path": null, "size": 16.8, "width": 375, "height": 500, "sizeInBytes": 16804}, "medium": {"ext": ".webp", "url": "/uploads/medium_nema2_2987779adc.webp", "hash": "medium_nema2_2987779adc", "mime": "image/webp", "name": "medium_nema2.webp", "path": null, "size": 29.32, "width": 563, "height": 750, "sizeInBytes": 29318}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nema2_2987779adc.webp", "hash": "thumbnail_nema2_2987779adc", "mime": "image/webp", "name": "thumbnail_nema2.webp", "path": null, "size": 3.43, "width": 117, "height": 156, "sizeInBytes": 3434}}	nema2_2987779adc	.webp	image/webp	42.85	/uploads/nema2_2987779adc.webp	\N	local	\N	/2/20	2025-04-16 21:22:00.278	2025-04-16 21:22:00.278	2025-04-16 21:22:00.279	1	1	\N
217	xay6deh5onvvzgixap0bu7wo	pi5.webp	\N	\N	640	516	{"small": {"ext": ".webp", "url": "/uploads/small_pi5_7d12ab5cfc.webp", "hash": "small_pi5_7d12ab5cfc", "mime": "image/webp", "name": "small_pi5.webp", "path": null, "size": 15.72, "width": 500, "height": 403, "sizeInBytes": 15720}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pi5_7d12ab5cfc.webp", "hash": "thumbnail_pi5_7d12ab5cfc", "mime": "image/webp", "name": "thumbnail_pi5.webp", "path": null, "size": 4.82, "width": 193, "height": 156, "sizeInBytes": 4822}}	pi5_7d12ab5cfc	.webp	image/webp	24.81	/uploads/pi5_7d12ab5cfc.webp	\N	local	\N	/2	2025-04-16 21:57:48.602	2025-04-16 21:57:48.602	2025-04-16 21:57:48.603	1	1	\N
233	yptwvzepofkh9pwf4atamff8	tor1.webp	\N	\N	640	1136	{"large": {"ext": ".webp", "url": "/uploads/large_tor1_8df7112887.webp", "hash": "large_tor1_8df7112887", "mime": "image/webp", "name": "large_tor1.webp", "path": null, "size": 64.04, "width": 563, "height": 1000, "sizeInBytes": 64040}, "small": {"ext": ".webp", "url": "/uploads/small_tor1_8df7112887.webp", "hash": "small_tor1_8df7112887", "mime": "image/webp", "name": "small_tor1.webp", "path": null, "size": 23.71, "width": 282, "height": 500, "sizeInBytes": 23708}, "medium": {"ext": ".webp", "url": "/uploads/medium_tor1_8df7112887.webp", "hash": "medium_tor1_8df7112887", "mime": "image/webp", "name": "medium_tor1.webp", "path": null, "size": 42.58, "width": 423, "height": 750, "sizeInBytes": 42580}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_tor1_8df7112887.webp", "hash": "thumbnail_tor1_8df7112887", "mime": "image/webp", "name": "thumbnail_tor1.webp", "path": null, "size": 3.85, "width": 88, "height": 156, "sizeInBytes": 3848}}	tor1_8df7112887	.webp	image/webp	96.95	/uploads/tor1_8df7112887.webp	\N	local	\N	/2/23	2025-04-16 22:18:07.899	2025-04-16 22:18:07.899	2025-04-16 22:18:07.899	1	1	\N
96	ay5gnue5c3xrcwz75bxo5jin	king6.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king6_fc4f62643b.webp", "hash": "small_king6_fc4f62643b", "mime": "image/webp", "name": "small_king6.webp", "path": null, "size": 15.64, "width": 500, "height": 500, "sizeInBytes": 15636}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king6_fc4f62643b.webp", "hash": "thumbnail_king6_fc4f62643b", "mime": "image/webp", "name": "thumbnail_king6.webp", "path": null, "size": 4.12, "width": 156, "height": 156, "sizeInBytes": 4120}}	king6_fc4f62643b	.webp	image/webp	22.21	/uploads/king6_fc4f62643b.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.539	2025-04-15 21:33:51.539	2025-04-15 21:33:51.539	1	1	\N
97	gpaoz78jwvw7mn8o5cl4g73x	king8.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king8_44e3227d02.webp", "hash": "small_king8_44e3227d02", "mime": "image/webp", "name": "small_king8.webp", "path": null, "size": 13.59, "width": 500, "height": 500, "sizeInBytes": 13588}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king8_44e3227d02.webp", "hash": "thumbnail_king8_44e3227d02", "mime": "image/webp", "name": "thumbnail_king8.webp", "path": null, "size": 3.36, "width": 156, "height": 156, "sizeInBytes": 3360}}	king8_44e3227d02	.webp	image/webp	19.85	/uploads/king8_44e3227d02.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.636	2025-04-15 21:33:51.636	2025-04-15 21:33:51.636	1	1	\N
166	kcwbijyeir0h8mci54o5ie7d	bene5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bene5_07c46c9b48.webp", "hash": "small_bene5_07c46c9b48", "mime": "image/webp", "name": "small_bene5.webp", "path": null, "size": 9.1, "width": 375, "height": 500, "sizeInBytes": 9104}, "medium": {"ext": ".webp", "url": "/uploads/medium_bene5_07c46c9b48.webp", "hash": "medium_bene5_07c46c9b48", "mime": "image/webp", "name": "medium_bene5.webp", "path": null, "size": 14.59, "width": 563, "height": 750, "sizeInBytes": 14592}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bene5_07c46c9b48.webp", "hash": "thumbnail_bene5_07c46c9b48", "mime": "image/webp", "name": "thumbnail_bene5.webp", "path": null, "size": 2.29, "width": 117, "height": 156, "sizeInBytes": 2288}}	bene5_07c46c9b48	.webp	image/webp	19.57	/uploads/bene5_07c46c9b48.webp	\N	local	\N	/2/16	2025-04-16 19:44:16.158	2025-04-16 19:44:16.158	2025-04-16 19:44:16.158	1	1	\N
195	kdwdyb6gdcwy6grtxff7bice	nema4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nema4_1171d37c3c.webp", "hash": "small_nema4_1171d37c3c", "mime": "image/webp", "name": "small_nema4.webp", "path": null, "size": 16.92, "width": 375, "height": 500, "sizeInBytes": 16916}, "medium": {"ext": ".webp", "url": "/uploads/medium_nema4_1171d37c3c.webp", "hash": "medium_nema4_1171d37c3c", "mime": "image/webp", "name": "medium_nema4.webp", "path": null, "size": 29.83, "width": 563, "height": 750, "sizeInBytes": 29830}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nema4_1171d37c3c.webp", "hash": "thumbnail_nema4_1171d37c3c", "mime": "image/webp", "name": "thumbnail_nema4.webp", "path": null, "size": 3.47, "width": 117, "height": 156, "sizeInBytes": 3472}}	nema4_1171d37c3c	.webp	image/webp	43.01	/uploads/nema4_1171d37c3c.webp	\N	local	\N	/2/20	2025-04-16 21:22:00.279	2025-04-16 21:22:00.279	2025-04-16 21:22:00.279	1	1	\N
196	ltr0sxr7eqb7wrh90zzse2q6	nema3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nema3_7cd7916f6a.webp", "hash": "small_nema3_7cd7916f6a", "mime": "image/webp", "name": "small_nema3.webp", "path": null, "size": 19.03, "width": 375, "height": 500, "sizeInBytes": 19028}, "medium": {"ext": ".webp", "url": "/uploads/medium_nema3_7cd7916f6a.webp", "hash": "medium_nema3_7cd7916f6a", "mime": "image/webp", "name": "medium_nema3.webp", "path": null, "size": 32.74, "width": 563, "height": 750, "sizeInBytes": 32744}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nema3_7cd7916f6a.webp", "hash": "thumbnail_nema3_7cd7916f6a", "mime": "image/webp", "name": "thumbnail_nema3.webp", "path": null, "size": 3.55, "width": 117, "height": 156, "sizeInBytes": 3548}}	nema3_7cd7916f6a	.webp	image/webp	48.80	/uploads/nema3_7cd7916f6a.webp	\N	local	\N	/2/20	2025-04-16 21:22:00.291	2025-04-16 21:22:00.291	2025-04-16 21:22:00.291	1	1	\N
197	hqy88i7jtth6e7k83w52salx	nema1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_nema1_423223fd2e.webp", "hash": "small_nema1_423223fd2e", "mime": "image/webp", "name": "small_nema1.webp", "path": null, "size": 19.33, "width": 375, "height": 500, "sizeInBytes": 19330}, "medium": {"ext": ".webp", "url": "/uploads/medium_nema1_423223fd2e.webp", "hash": "medium_nema1_423223fd2e", "mime": "image/webp", "name": "medium_nema1.webp", "path": null, "size": 33.27, "width": 563, "height": 750, "sizeInBytes": 33270}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nema1_423223fd2e.webp", "hash": "thumbnail_nema1_423223fd2e", "mime": "image/webp", "name": "thumbnail_nema1.webp", "path": null, "size": 3.56, "width": 117, "height": 156, "sizeInBytes": 3560}}	nema1_423223fd2e	.webp	image/webp	49.95	/uploads/nema1_423223fd2e.webp	\N	local	\N	/2/20	2025-04-16 21:22:00.302	2025-04-16 21:22:00.302	2025-04-16 21:22:00.302	1	1	\N
218	dcuryi1ashro41xnj0gb3xw7	pi2.webp	\N	\N	640	856	{"small": {"ext": ".webp", "url": "/uploads/small_pi2_38f275da59.webp", "hash": "small_pi2_38f275da59", "mime": "image/webp", "name": "small_pi2.webp", "path": null, "size": 17.28, "width": 374, "height": 500, "sizeInBytes": 17280}, "medium": {"ext": ".webp", "url": "/uploads/medium_pi2_38f275da59.webp", "hash": "medium_pi2_38f275da59", "mime": "image/webp", "name": "medium_pi2.webp", "path": null, "size": 26.03, "width": 561, "height": 750, "sizeInBytes": 26028}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pi2_38f275da59.webp", "hash": "thumbnail_pi2_38f275da59", "mime": "image/webp", "name": "thumbnail_pi2.webp", "path": null, "size": 4.25, "width": 117, "height": 156, "sizeInBytes": 4254}}	pi2_38f275da59	.webp	image/webp	33.08	/uploads/pi2_38f275da59.webp	\N	local	\N	/2	2025-04-16 21:57:48.605	2025-04-16 21:57:48.605	2025-04-16 21:57:48.605	1	1	\N
260	z66of3pit90c83m8jwshlx1d	pc1.jpeg	\N	\N	329	153	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_pc1_903f249bd1.jpeg", "hash": "thumbnail_pc1_903f249bd1", "mime": "image/jpeg", "name": "thumbnail_pc1.jpeg", "path": null, "size": 4.74, "width": 245, "height": 114, "sizeInBytes": 4739}}	pc1_903f249bd1	.jpeg	image/jpeg	7.08	/uploads/pc1_903f249bd1.jpeg	\N	local	\N	/2/3	2025-04-17 11:15:44.79	2025-04-17 11:15:44.79	2025-04-17 11:15:44.79	1	1	\N
99	l2jh3zmapatoqupetpnbhemf	king7.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_king7_73a4cd2d6c.webp", "hash": "small_king7_73a4cd2d6c", "mime": "image/webp", "name": "small_king7.webp", "path": null, "size": 19.22, "width": 500, "height": 500, "sizeInBytes": 19224}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_king7_73a4cd2d6c.webp", "hash": "thumbnail_king7_73a4cd2d6c", "mime": "image/webp", "name": "thumbnail_king7.webp", "path": null, "size": 4.59, "width": 156, "height": 156, "sizeInBytes": 4586}}	king7_73a4cd2d6c	.webp	image/webp	30.67	/uploads/king7_73a4cd2d6c.webp	\N	local	\N	/2/14	2025-04-15 21:33:51.637	2025-04-15 21:33:51.637	2025-04-15 21:33:51.637	1	1	\N
126	kj537si7gng90jwnqqq7bg29	epx1.webp	\N	\N	433	577	{"small": {"ext": ".webp", "url": "/uploads/small_epx1_a7913a812d.webp", "hash": "small_epx1_a7913a812d", "mime": "image/webp", "name": "small_epx1.webp", "path": null, "size": 2.59, "width": 375, "height": 500, "sizeInBytes": 2586}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_epx1_a7913a812d.webp", "hash": "thumbnail_epx1_a7913a812d", "mime": "image/webp", "name": "thumbnail_epx1.webp", "path": null, "size": 0.48, "width": 117, "height": 156, "sizeInBytes": 482}}	epx1_a7913a812d	.webp	image/webp	5.03	/uploads/epx1_a7913a812d.webp	\N	local	\N	/2/17	2025-04-15 22:16:13.979	2025-04-15 22:16:13.979	2025-04-15 22:16:13.979	1	1	\N
133	z1nqae5mazg8a1kot1b5vk6y	sonic3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_sonic3_f30257c0a0.webp", "hash": "small_sonic3_f30257c0a0", "mime": "image/webp", "name": "small_sonic3.webp", "path": null, "size": 15.74, "width": 500, "height": 375, "sizeInBytes": 15742}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sonic3_f30257c0a0.webp", "hash": "thumbnail_sonic3_f30257c0a0", "mime": "image/webp", "name": "thumbnail_sonic3.webp", "path": null, "size": 4.3, "width": 208, "height": 156, "sizeInBytes": 4296}}	sonic3_f30257c0a0	.webp	image/webp	28.41	/uploads/sonic3_f30257c0a0.webp	\N	local	\N	/2/15	2025-04-16 19:01:33.475	2025-04-16 19:01:33.475	2025-04-16 19:01:33.475	1	1	\N
127	utglcas3mwqaeathufx3rs5n	epax3.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_epax3_d155929f6a.webp", "hash": "small_epax3_d155929f6a", "mime": "image/webp", "name": "small_epax3.webp", "path": null, "size": 10.69, "width": 376, "height": 500, "sizeInBytes": 10688}, "medium": {"ext": ".webp", "url": "/uploads/medium_epax3_d155929f6a.webp", "hash": "medium_epax3_d155929f6a", "mime": "image/webp", "name": "medium_epax3.webp", "path": null, "size": 17.27, "width": 565, "height": 750, "sizeInBytes": 17274}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_epax3_d155929f6a.webp", "hash": "thumbnail_epax3_d155929f6a", "mime": "image/webp", "name": "thumbnail_epax3.webp", "path": null, "size": 2.23, "width": 117, "height": 156, "sizeInBytes": 2232}}	epax3_d155929f6a	.webp	image/webp	23.27	/uploads/epax3_d155929f6a.webp	\N	local	\N	/2/17	2025-04-15 22:16:14.025	2025-04-15 22:16:14.025	2025-04-15 22:16:14.025	1	1	\N
167	w7nu1qtpjm2h2eohnz022pok	bene3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bene3_4cf223d191.webp", "hash": "small_bene3_4cf223d191", "mime": "image/webp", "name": "small_bene3.webp", "path": null, "size": 7.68, "width": 375, "height": 500, "sizeInBytes": 7682}, "medium": {"ext": ".webp", "url": "/uploads/medium_bene3_4cf223d191.webp", "hash": "medium_bene3_4cf223d191", "mime": "image/webp", "name": "medium_bene3.webp", "path": null, "size": 12.05, "width": 563, "height": 750, "sizeInBytes": 12054}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bene3_4cf223d191.webp", "hash": "thumbnail_bene3_4cf223d191", "mime": "image/webp", "name": "thumbnail_bene3.webp", "path": null, "size": 1.92, "width": 117, "height": 156, "sizeInBytes": 1922}}	bene3_4cf223d191	.webp	image/webp	15.16	/uploads/bene3_4cf223d191.webp	\N	local	\N	/2/16	2025-04-16 19:44:16.158	2025-04-16 19:44:16.158	2025-04-16 19:44:16.158	1	1	\N
198	edgnltaaxagb1iyuq440rzom	cable.webp	\N	\N	640	855	{"small": {"ext": ".webp", "url": "/uploads/small_cable_df97184708.webp", "hash": "small_cable_df97184708", "mime": "image/webp", "name": "small_cable.webp", "path": null, "size": 15.42, "width": 374, "height": 500, "sizeInBytes": 15418}, "medium": {"ext": ".webp", "url": "/uploads/medium_cable_df97184708.webp", "hash": "medium_cable_df97184708", "mime": "image/webp", "name": "medium_cable.webp", "path": null, "size": 28.46, "width": 561, "height": 750, "sizeInBytes": 28462}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cable_df97184708.webp", "hash": "thumbnail_cable_df97184708", "mime": "image/webp", "name": "thumbnail_cable.webp", "path": null, "size": 2.25, "width": 117, "height": 156, "sizeInBytes": 2246}}	cable_df97184708	.webp	image/webp	44.83	/uploads/cable_df97184708.webp	\N	local	\N	/2	2025-04-16 21:25:09.614	2025-04-16 21:25:09.614	2025-04-16 21:25:09.614	1	1	\N
219	tt9nsfcoc99o4gvbkk4em5ul	perf1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_perf1_f230df4ec7.webp", "hash": "small_perf1_f230df4ec7", "mime": "image/webp", "name": "small_perf1.webp", "path": null, "size": 11.72, "width": 375, "height": 500, "sizeInBytes": 11722}, "medium": {"ext": ".webp", "url": "/uploads/medium_perf1_f230df4ec7.webp", "hash": "medium_perf1_f230df4ec7", "mime": "image/webp", "name": "medium_perf1.webp", "path": null, "size": 21.39, "width": 563, "height": 750, "sizeInBytes": 21392}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_perf1_f230df4ec7.webp", "hash": "thumbnail_perf1_f230df4ec7", "mime": "image/webp", "name": "thumbnail_perf1.webp", "path": null, "size": 1.93, "width": 117, "height": 156, "sizeInBytes": 1932}}	perf1_f230df4ec7	.webp	image/webp	33.81	/uploads/perf1_f230df4ec7.webp	\N	local	\N	/2/23	2025-04-16 22:01:37.688	2025-04-16 22:01:37.688	2025-04-16 22:01:37.688	1	1	\N
232	c3kh9l5fgmoasg6qycme3k3d	tor2.webp	\N	\N	640	1136	{"large": {"ext": ".webp", "url": "/uploads/large_tor2_2901aa7847.webp", "hash": "large_tor2_2901aa7847", "mime": "image/webp", "name": "large_tor2.webp", "path": null, "size": 28.22, "width": 563, "height": 1000, "sizeInBytes": 28216}, "small": {"ext": ".webp", "url": "/uploads/small_tor2_2901aa7847.webp", "hash": "small_tor2_2901aa7847", "mime": "image/webp", "name": "small_tor2.webp", "path": null, "size": 10.8, "width": 282, "height": 500, "sizeInBytes": 10802}, "medium": {"ext": ".webp", "url": "/uploads/medium_tor2_2901aa7847.webp", "hash": "medium_tor2_2901aa7847", "mime": "image/webp", "name": "medium_tor2.webp", "path": null, "size": 19.38, "width": 423, "height": 750, "sizeInBytes": 19376}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_tor2_2901aa7847.webp", "hash": "thumbnail_tor2_2901aa7847", "mime": "image/webp", "name": "thumbnail_tor2.webp", "path": null, "size": 2.03, "width": 88, "height": 156, "sizeInBytes": 2028}}	tor2_2901aa7847	.webp	image/webp	41.65	/uploads/tor2_2901aa7847.webp	\N	local	\N	/2/23	2025-04-16 22:18:07.899	2025-04-16 22:18:07.899	2025-04-16 22:18:07.9	1	1	\N
240	se6gidzsopaj21ih8k3gaxkf	goma2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_goma2_b7f530ce7c.webp", "hash": "small_goma2_b7f530ce7c", "mime": "image/webp", "name": "small_goma2.webp", "path": null, "size": 15.48, "width": 375, "height": 500, "sizeInBytes": 15484}, "medium": {"ext": ".webp", "url": "/uploads/medium_goma2_b7f530ce7c.webp", "hash": "medium_goma2_b7f530ce7c", "mime": "image/webp", "name": "medium_goma2.webp", "path": null, "size": 24.1, "width": 563, "height": 750, "sizeInBytes": 24102}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_goma2_b7f530ce7c.webp", "hash": "thumbnail_goma2_b7f530ce7c", "mime": "image/webp", "name": "thumbnail_goma2.webp", "path": null, "size": 3.33, "width": 117, "height": 156, "sizeInBytes": 3328}}	goma2_b7f530ce7c	.webp	image/webp	33.42	/uploads/goma2_b7f530ce7c.webp	\N	local	\N	/2/23	2025-04-16 22:26:06.221	2025-04-16 22:26:06.221	2025-04-16 22:26:06.221	1	1	\N
100	d51jlbmkz8tz00slo7pks0eb	ele2.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_ele2_011891e766.webp", "hash": "small_ele2_011891e766", "mime": "image/webp", "name": "small_ele2.webp", "path": null, "size": 11.28, "width": 376, "height": 500, "sizeInBytes": 11284}, "medium": {"ext": ".webp", "url": "/uploads/medium_ele2_011891e766.webp", "hash": "medium_ele2_011891e766", "mime": "image/webp", "name": "medium_ele2.webp", "path": null, "size": 17.4, "width": 565, "height": 750, "sizeInBytes": 17398}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ele2_011891e766.webp", "hash": "thumbnail_ele2_011891e766", "mime": "image/webp", "name": "thumbnail_ele2.webp", "path": null, "size": 2.73, "width": 117, "height": 156, "sizeInBytes": 2730}}	ele2_011891e766	.webp	image/webp	24.96	/uploads/ele2_011891e766.webp	\N	local	\N	/2/9	2025-04-15 21:38:29.369	2025-04-15 21:38:29.369	2025-04-15 21:38:29.369	1	1	\N
269	a8aqorioarjwa30ce05y8v9o	any1.webp	\N	\N	304	304	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_any1_cac48621ad.webp", "hash": "thumbnail_any1_cac48621ad", "mime": "image/webp", "name": "thumbnail_any1.webp", "path": null, "size": 4.05, "width": 156, "height": 156, "sizeInBytes": 4050}}	any1_cac48621ad	.webp	image/webp	11.48	/uploads/any1_cac48621ad.webp	\N	local	\N	/2/7	2025-04-17 11:38:40.43	2025-04-17 11:38:40.43	2025-04-17 11:38:40.43	1	1	\N
106	p529mlsb560gq7bc4uhq7cpn	ele7.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_ele7_ed3f441cb2.webp", "hash": "small_ele7_ed3f441cb2", "mime": "image/webp", "name": "small_ele7.webp", "path": null, "size": 16.16, "width": 376, "height": 500, "sizeInBytes": 16160}, "medium": {"ext": ".webp", "url": "/uploads/medium_ele7_ed3f441cb2.webp", "hash": "medium_ele7_ed3f441cb2", "mime": "image/webp", "name": "medium_ele7.webp", "path": null, "size": 27.18, "width": 565, "height": 750, "sizeInBytes": 27184}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ele7_ed3f441cb2.webp", "hash": "thumbnail_ele7_ed3f441cb2", "mime": "image/webp", "name": "thumbnail_ele7.webp", "path": null, "size": 3.22, "width": 117, "height": 156, "sizeInBytes": 3218}}	ele7_ed3f441cb2	.webp	image/webp	41.36	/uploads/ele7_ed3f441cb2.webp	\N	local	\N	/2/9	2025-04-15 21:38:29.481	2025-04-15 21:38:29.481	2025-04-15 21:38:29.481	1	1	\N
128	u99o7u25kbik3o5l24a2ymtq	voxe1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_voxe1_6a26f3b32a.webp", "hash": "small_voxe1_6a26f3b32a", "mime": "image/webp", "name": "small_voxe1.webp", "path": null, "size": 13.91, "width": 375, "height": 500, "sizeInBytes": 13908}, "medium": {"ext": ".webp", "url": "/uploads/medium_voxe1_6a26f3b32a.webp", "hash": "medium_voxe1_6a26f3b32a", "mime": "image/webp", "name": "medium_voxe1.webp", "path": null, "size": 26.85, "width": 563, "height": 750, "sizeInBytes": 26852}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_voxe1_6a26f3b32a.webp", "hash": "thumbnail_voxe1_6a26f3b32a", "mime": "image/webp", "name": "thumbnail_voxe1.webp", "path": null, "size": 1.91, "width": 117, "height": 156, "sizeInBytes": 1908}}	voxe1_6a26f3b32a	.webp	image/webp	43.67	/uploads/voxe1_6a26f3b32a.webp	\N	local	\N	/2/18	2025-04-15 22:21:31.904	2025-04-15 22:21:31.904	2025-04-15 22:21:31.904	1	1	\N
165	ucnlu0ob5o49v3ojot1zs57i	bene1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bene1_102c8b00c6.webp", "hash": "small_bene1_102c8b00c6", "mime": "image/webp", "name": "small_bene1.webp", "path": null, "size": 7.65, "width": 375, "height": 500, "sizeInBytes": 7648}, "medium": {"ext": ".webp", "url": "/uploads/medium_bene1_102c8b00c6.webp", "hash": "medium_bene1_102c8b00c6", "mime": "image/webp", "name": "medium_bene1.webp", "path": null, "size": 11.88, "width": 563, "height": 750, "sizeInBytes": 11882}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bene1_102c8b00c6.webp", "hash": "thumbnail_bene1_102c8b00c6", "mime": "image/webp", "name": "thumbnail_bene1.webp", "path": null, "size": 1.85, "width": 117, "height": 156, "sizeInBytes": 1854}}	bene1_102c8b00c6	.webp	image/webp	15.52	/uploads/bene1_102c8b00c6.webp	\N	local	\N	/2/16	2025-04-16 19:44:16.157	2025-04-16 19:44:16.157	2025-04-16 19:44:16.157	1	1	\N
164	galxzsdanho9ybknuqn70qrs	bene2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bene2_94f058ca54.webp", "hash": "small_bene2_94f058ca54", "mime": "image/webp", "name": "small_bene2.webp", "path": null, "size": 9.8, "width": 375, "height": 500, "sizeInBytes": 9798}, "medium": {"ext": ".webp", "url": "/uploads/medium_bene2_94f058ca54.webp", "hash": "medium_bene2_94f058ca54", "mime": "image/webp", "name": "medium_bene2.webp", "path": null, "size": 14.9, "width": 563, "height": 750, "sizeInBytes": 14904}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bene2_94f058ca54.webp", "hash": "thumbnail_bene2_94f058ca54", "mime": "image/webp", "name": "thumbnail_bene2.webp", "path": null, "size": 2.46, "width": 117, "height": 156, "sizeInBytes": 2464}}	bene2_94f058ca54	.webp	image/webp	19.29	/uploads/bene2_94f058ca54.webp	\N	local	\N	/2/16	2025-04-16 19:44:16.158	2025-04-16 19:44:16.158	2025-04-16 19:44:16.158	1	1	\N
199	mqgxci02hw2f8mvw8hon76ur	noctua2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_noctua2_cfadac7760.webp", "hash": "small_noctua2_cfadac7760", "mime": "image/webp", "name": "small_noctua2.webp", "path": null, "size": 20.53, "width": 375, "height": 500, "sizeInBytes": 20530}, "medium": {"ext": ".webp", "url": "/uploads/medium_noctua2_cfadac7760.webp", "hash": "medium_noctua2_cfadac7760", "mime": "image/webp", "name": "medium_noctua2.webp", "path": null, "size": 37.94, "width": 563, "height": 750, "sizeInBytes": 37944}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_noctua2_cfadac7760.webp", "hash": "thumbnail_noctua2_cfadac7760", "mime": "image/webp", "name": "thumbnail_noctua2.webp", "path": null, "size": 3.77, "width": 117, "height": 156, "sizeInBytes": 3766}}	noctua2_cfadac7760	.webp	image/webp	63.65	/uploads/noctua2_cfadac7760.webp	\N	local	\N	/2/22	2025-04-16 21:28:07.93	2025-04-16 21:28:07.93	2025-04-16 21:28:07.93	1	1	\N
220	uuw4blyl28ecaokq9phl6ydr	perf4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_perf4_d973c8507d.webp", "hash": "small_perf4_d973c8507d", "mime": "image/webp", "name": "small_perf4.webp", "path": null, "size": 14.96, "width": 375, "height": 500, "sizeInBytes": 14964}, "medium": {"ext": ".webp", "url": "/uploads/medium_perf4_d973c8507d.webp", "hash": "medium_perf4_d973c8507d", "mime": "image/webp", "name": "medium_perf4.webp", "path": null, "size": 24.68, "width": 563, "height": 750, "sizeInBytes": 24678}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_perf4_d973c8507d.webp", "hash": "thumbnail_perf4_d973c8507d", "mime": "image/webp", "name": "thumbnail_perf4.webp", "path": null, "size": 3.18, "width": 117, "height": 156, "sizeInBytes": 3178}}	perf4_d973c8507d	.webp	image/webp	35.28	/uploads/perf4_d973c8507d.webp	\N	local	\N	/2/23	2025-04-16 22:01:37.688	2025-04-16 22:01:37.688	2025-04-16 22:01:37.688	1	1	\N
223	yo5l0uq0nbk4vqrt3gezg6ug	perfil1.webp	\N	\N	640	360	{"small": {"ext": ".webp", "url": "/uploads/small_perfil1_389c10c4f3.webp", "hash": "small_perfil1_389c10c4f3", "mime": "image/webp", "name": "small_perfil1.webp", "path": null, "size": 6.71, "width": 500, "height": 281, "sizeInBytes": 6712}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_perfil1_389c10c4f3.webp", "hash": "thumbnail_perfil1_389c10c4f3", "mime": "image/webp", "name": "thumbnail_perfil1.webp", "path": null, "size": 2.61, "width": 245, "height": 138, "sizeInBytes": 2614}}	perfil1_389c10c4f3	.webp	image/webp	12.55	/uploads/perfil1_389c10c4f3.webp	\N	local	\N	/2/23	2025-04-16 22:05:07.915	2025-04-16 22:05:07.915	2025-04-16 22:05:07.915	1	1	\N
101	vzp01bqp7mayeqqxucb6ae5c	ele4.webp	\N	\N	640	482	{"small": {"ext": ".webp", "url": "/uploads/small_ele4_5bba6aef15.webp", "hash": "small_ele4_5bba6aef15", "mime": "image/webp", "name": "small_ele4.webp", "path": null, "size": 10.66, "width": 500, "height": 377, "sizeInBytes": 10658}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ele4_5bba6aef15.webp", "hash": "thumbnail_ele4_5bba6aef15", "mime": "image/webp", "name": "thumbnail_ele4.webp", "path": null, "size": 3.3, "width": 207, "height": 156, "sizeInBytes": 3296}}	ele4_5bba6aef15	.webp	image/webp	18.91	/uploads/ele4_5bba6aef15.webp	\N	local	\N	/2/9	2025-04-15 21:38:29.37	2025-04-15 21:38:29.37	2025-04-15 21:38:29.37	1	1	\N
129	akr9fo4uv2jwd6qcjcxtuz4w	voxe2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_voxe2_d4debbc536.webp", "hash": "small_voxe2_d4debbc536", "mime": "image/webp", "name": "small_voxe2.webp", "path": null, "size": 17.15, "width": 375, "height": 500, "sizeInBytes": 17150}, "medium": {"ext": ".webp", "url": "/uploads/medium_voxe2_d4debbc536.webp", "hash": "medium_voxe2_d4debbc536", "mime": "image/webp", "name": "medium_voxe2.webp", "path": null, "size": 31.56, "width": 563, "height": 750, "sizeInBytes": 31556}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_voxe2_d4debbc536.webp", "hash": "thumbnail_voxe2_d4debbc536", "mime": "image/webp", "name": "thumbnail_voxe2.webp", "path": null, "size": 1.98, "width": 117, "height": 156, "sizeInBytes": 1980}}	voxe2_d4debbc536	.webp	image/webp	51.68	/uploads/voxe2_d4debbc536.webp	\N	local	\N	/2/18	2025-04-15 22:21:31.904	2025-04-15 22:21:31.904	2025-04-15 22:21:31.904	1	1	\N
130	drm2j78jxa9a0ta5su2cm0oj	voxe3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_voxe3_29a6c553a2.webp", "hash": "small_voxe3_29a6c553a2", "mime": "image/webp", "name": "small_voxe3.webp", "path": null, "size": 16.46, "width": 375, "height": 500, "sizeInBytes": 16462}, "medium": {"ext": ".webp", "url": "/uploads/medium_voxe3_29a6c553a2.webp", "hash": "medium_voxe3_29a6c553a2", "mime": "image/webp", "name": "medium_voxe3.webp", "path": null, "size": 30.88, "width": 563, "height": 750, "sizeInBytes": 30880}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_voxe3_29a6c553a2.webp", "hash": "thumbnail_voxe3_29a6c553a2", "mime": "image/webp", "name": "thumbnail_voxe3.webp", "path": null, "size": 2.14, "width": 117, "height": 156, "sizeInBytes": 2138}}	voxe3_29a6c553a2	.webp	image/webp	48.51	/uploads/voxe3_29a6c553a2.webp	\N	local	\N	/2/18	2025-04-15 22:21:31.913	2025-04-15 22:21:31.913	2025-04-15 22:21:31.913	1	1	\N
131	qfgnb8gs8bd4vnnueykya134	voxe4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_voxe4_a02554bbd8.webp", "hash": "small_voxe4_a02554bbd8", "mime": "image/webp", "name": "small_voxe4.webp", "path": null, "size": 19.61, "width": 375, "height": 500, "sizeInBytes": 19612}, "medium": {"ext": ".webp", "url": "/uploads/medium_voxe4_a02554bbd8.webp", "hash": "medium_voxe4_a02554bbd8", "mime": "image/webp", "name": "medium_voxe4.webp", "path": null, "size": 37.95, "width": 563, "height": 750, "sizeInBytes": 37948}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_voxe4_a02554bbd8.webp", "hash": "thumbnail_voxe4_a02554bbd8", "mime": "image/webp", "name": "thumbnail_voxe4.webp", "path": null, "size": 2.13, "width": 117, "height": 156, "sizeInBytes": 2128}}	voxe4_a02554bbd8	.webp	image/webp	58.89	/uploads/voxe4_a02554bbd8.webp	\N	local	\N	/2/18	2025-04-15 22:21:31.924	2025-04-15 22:21:31.924	2025-04-15 22:21:31.924	1	1	\N
132	lucr16tq81vbrh701b0x4uqy	voxe5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_voxe5_e6f47da6cd.webp", "hash": "small_voxe5_e6f47da6cd", "mime": "image/webp", "name": "small_voxe5.webp", "path": null, "size": 16.88, "width": 375, "height": 500, "sizeInBytes": 16880}, "medium": {"ext": ".webp", "url": "/uploads/medium_voxe5_e6f47da6cd.webp", "hash": "medium_voxe5_e6f47da6cd", "mime": "image/webp", "name": "medium_voxe5.webp", "path": null, "size": 32.6, "width": 563, "height": 750, "sizeInBytes": 32596}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_voxe5_e6f47da6cd.webp", "hash": "thumbnail_voxe5_e6f47da6cd", "mime": "image/webp", "name": "thumbnail_voxe5.webp", "path": null, "size": 2.04, "width": 117, "height": 156, "sizeInBytes": 2044}}	voxe5_e6f47da6cd	.webp	image/webp	51.11	/uploads/voxe5_e6f47da6cd.webp	\N	local	\N	/2/18	2025-04-15 22:21:31.934	2025-04-15 22:21:31.934	2025-04-15 22:21:31.934	1	1	\N
168	fmd5o75mwomz7x6fy27wf35a	bene4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bene4_4389d1bc6b.webp", "hash": "small_bene4_4389d1bc6b", "mime": "image/webp", "name": "small_bene4.webp", "path": null, "size": 11.73, "width": 375, "height": 500, "sizeInBytes": 11730}, "medium": {"ext": ".webp", "url": "/uploads/medium_bene4_4389d1bc6b.webp", "hash": "medium_bene4_4389d1bc6b", "mime": "image/webp", "name": "medium_bene4.webp", "path": null, "size": 18.4, "width": 563, "height": 750, "sizeInBytes": 18404}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bene4_4389d1bc6b.webp", "hash": "thumbnail_bene4_4389d1bc6b", "mime": "image/webp", "name": "thumbnail_bene4.webp", "path": null, "size": 2.87, "width": 117, "height": 156, "sizeInBytes": 2872}}	bene4_4389d1bc6b	.webp	image/webp	25.04	/uploads/bene4_4389d1bc6b.webp	\N	local	\N	/2/16	2025-04-16 19:44:16.165	2025-04-16 19:44:16.165	2025-04-16 19:44:16.165	1	1	\N
169	sxrhpurbgc4j6bu092yd53ci	bene6.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_bene6_8e41613085.webp", "hash": "small_bene6_8e41613085", "mime": "image/webp", "name": "small_bene6.webp", "path": null, "size": 7.22, "width": 375, "height": 500, "sizeInBytes": 7222}, "medium": {"ext": ".webp", "url": "/uploads/medium_bene6_8e41613085.webp", "hash": "medium_bene6_8e41613085", "mime": "image/webp", "name": "medium_bene6.webp", "path": null, "size": 11.18, "width": 563, "height": 750, "sizeInBytes": 11184}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_bene6_8e41613085.webp", "hash": "thumbnail_bene6_8e41613085", "mime": "image/webp", "name": "thumbnail_bene6.webp", "path": null, "size": 1.93, "width": 117, "height": 156, "sizeInBytes": 1934}}	bene6_8e41613085	.webp	image/webp	14.18	/uploads/bene6_8e41613085.webp	\N	local	\N	/2/16	2025-04-16 19:44:16.176	2025-04-16 19:44:16.176	2025-04-16 19:44:16.176	1	1	\N
102	kypsfz100iyl16bfutxphopw	ele6.webp	\N	\N	640	482	{"small": {"ext": ".webp", "url": "/uploads/small_ele6_742340621f.webp", "hash": "small_ele6_742340621f", "mime": "image/webp", "name": "small_ele6.webp", "path": null, "size": 18.59, "width": 500, "height": 377, "sizeInBytes": 18592}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ele6_742340621f.webp", "hash": "thumbnail_ele6_742340621f", "mime": "image/webp", "name": "thumbnail_ele6.webp", "path": null, "size": 4.6, "width": 207, "height": 156, "sizeInBytes": 4602}}	ele6_742340621f	.webp	image/webp	37.81	/uploads/ele6_742340621f.webp	\N	local	\N	/2/9	2025-04-15 21:38:29.369	2025-04-15 21:38:29.369	2025-04-15 21:38:29.37	1	1	\N
104	hrb10mvjir6cdhi52o1buis4	ele1.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_ele1_d2e51d7d6f.webp", "hash": "small_ele1_d2e51d7d6f", "mime": "image/webp", "name": "small_ele1.webp", "path": null, "size": 12.49, "width": 376, "height": 500, "sizeInBytes": 12490}, "medium": {"ext": ".webp", "url": "/uploads/medium_ele1_d2e51d7d6f.webp", "hash": "medium_ele1_d2e51d7d6f", "mime": "image/webp", "name": "medium_ele1.webp", "path": null, "size": 20.66, "width": 565, "height": 750, "sizeInBytes": 20656}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ele1_d2e51d7d6f.webp", "hash": "thumbnail_ele1_d2e51d7d6f", "mime": "image/webp", "name": "thumbnail_ele1.webp", "path": null, "size": 2.71, "width": 117, "height": 156, "sizeInBytes": 2712}}	ele1_d2e51d7d6f	.webp	image/webp	28.68	/uploads/ele1_d2e51d7d6f.webp	\N	local	\N	/2/9	2025-04-15 21:38:29.384	2025-04-15 21:38:29.384	2025-04-15 21:38:29.384	1	1	\N
134	mcek3o7o2kn9ufhckugvu8g3	sonic1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sonic1_3abea40350.webp", "hash": "small_sonic1_3abea40350", "mime": "image/webp", "name": "small_sonic1.webp", "path": null, "size": 9.23, "width": 375, "height": 500, "sizeInBytes": 9226}, "medium": {"ext": ".webp", "url": "/uploads/medium_sonic1_3abea40350.webp", "hash": "medium_sonic1_3abea40350", "mime": "image/webp", "name": "medium_sonic1.webp", "path": null, "size": 15.35, "width": 563, "height": 750, "sizeInBytes": 15348}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sonic1_3abea40350.webp", "hash": "thumbnail_sonic1_3abea40350", "mime": "image/webp", "name": "thumbnail_sonic1.webp", "path": null, "size": 2, "width": 117, "height": 156, "sizeInBytes": 1998}}	sonic1_3abea40350	.webp	image/webp	20.84	/uploads/sonic1_3abea40350.webp	\N	local	\N	/2/15	2025-04-16 19:01:33.488	2025-04-16 19:01:33.488	2025-04-16 19:01:33.488	1	1	\N
136	y5lf8kkezdijd0z2zyw1elkh	mono6.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_mono6_0a34b50d70.webp", "hash": "small_mono6_0a34b50d70", "mime": "image/webp", "name": "small_mono6.webp", "path": null, "size": 11.26, "width": 500, "height": 375, "sizeInBytes": 11264}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono6_0a34b50d70.webp", "hash": "thumbnail_mono6_0a34b50d70", "mime": "image/webp", "name": "thumbnail_mono6.webp", "path": null, "size": 3.01, "width": 208, "height": 156, "sizeInBytes": 3012}}	mono6_0a34b50d70	.webp	image/webp	19.30	/uploads/mono6_0a34b50d70.webp	\N	local	\N	/2/7	2025-04-16 19:17:29.254	2025-04-16 19:17:29.254	2025-04-16 19:17:29.254	1	1	\N
170	tnx1kqw1h71ky6j06gv06ux8	nozle2.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_nozle2_0bfdcd8284.webp", "hash": "small_nozle2_0bfdcd8284", "mime": "image/webp", "name": "small_nozle2.webp", "path": null, "size": 12.31, "width": 500, "height": 500, "sizeInBytes": 12314}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nozle2_0bfdcd8284.webp", "hash": "thumbnail_nozle2_0bfdcd8284", "mime": "image/webp", "name": "thumbnail_nozle2.webp", "path": null, "size": 2.46, "width": 156, "height": 156, "sizeInBytes": 2456}}	nozle2_0bfdcd8284	.webp	image/webp	19.57	/uploads/nozle2_0bfdcd8284.webp	\N	local	\N	/2/4	2025-04-16 19:48:17.604	2025-04-16 19:48:17.604	2025-04-16 19:48:17.604	1	1	\N
200	a07myy5ybkrfbse5198pfu01	noctua1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_noctua1_b2a6948f96.webp", "hash": "small_noctua1_b2a6948f96", "mime": "image/webp", "name": "small_noctua1.webp", "path": null, "size": 16.51, "width": 375, "height": 500, "sizeInBytes": 16512}, "medium": {"ext": ".webp", "url": "/uploads/medium_noctua1_b2a6948f96.webp", "hash": "medium_noctua1_b2a6948f96", "mime": "image/webp", "name": "medium_noctua1.webp", "path": null, "size": 33.66, "width": 563, "height": 750, "sizeInBytes": 33658}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_noctua1_b2a6948f96.webp", "hash": "thumbnail_noctua1_b2a6948f96", "mime": "image/webp", "name": "thumbnail_noctua1.webp", "path": null, "size": 3.02, "width": 117, "height": 156, "sizeInBytes": 3020}}	noctua1_b2a6948f96	.webp	image/webp	63.22	/uploads/noctua1_b2a6948f96.webp	\N	local	\N	/2/22	2025-04-16 21:28:07.931	2025-04-16 21:28:07.931	2025-04-16 21:28:07.931	1	1	\N
221	qp4ieybgfjl743saknige5o5	perf2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_perf2_571ed987a1.webp", "hash": "small_perf2_571ed987a1", "mime": "image/webp", "name": "small_perf2.webp", "path": null, "size": 11.7, "width": 375, "height": 500, "sizeInBytes": 11704}, "medium": {"ext": ".webp", "url": "/uploads/medium_perf2_571ed987a1.webp", "hash": "medium_perf2_571ed987a1", "mime": "image/webp", "name": "medium_perf2.webp", "path": null, "size": 20.91, "width": 563, "height": 750, "sizeInBytes": 20914}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_perf2_571ed987a1.webp", "hash": "thumbnail_perf2_571ed987a1", "mime": "image/webp", "name": "thumbnail_perf2.webp", "path": null, "size": 1.93, "width": 117, "height": 156, "sizeInBytes": 1930}}	perf2_571ed987a1	.webp	image/webp	34.00	/uploads/perf2_571ed987a1.webp	\N	local	\N	/2/23	2025-04-16 22:01:37.693	2025-04-16 22:01:37.693	2025-04-16 22:01:37.693	1	1	\N
246	f4el6qumwtig7nczbywuva0z	tap2.webp	\N	\N	640	580	{"small": {"ext": ".webp", "url": "/uploads/small_tap2_cc031e184d.webp", "hash": "small_tap2_cc031e184d", "mime": "image/webp", "name": "small_tap2.webp", "path": null, "size": 6.49, "width": 500, "height": 453, "sizeInBytes": 6488}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_tap2_cc031e184d.webp", "hash": "thumbnail_tap2_cc031e184d", "mime": "image/webp", "name": "thumbnail_tap2.webp", "path": null, "size": 1.95, "width": 172, "height": 156, "sizeInBytes": 1946}}	tap2_cc031e184d	.webp	image/webp	10.00	/uploads/tap2_cc031e184d.webp	\N	local	\N	/2/23	2025-04-16 22:32:00.005	2025-04-16 22:32:00.005	2025-04-16 22:32:00.005	1	1	\N
103	fzofsopw01n7safj2vh2djgv	ele3.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_ele3_aedf799e57.webp", "hash": "small_ele3_aedf799e57", "mime": "image/webp", "name": "small_ele3.webp", "path": null, "size": 13.4, "width": 376, "height": 500, "sizeInBytes": 13396}, "medium": {"ext": ".webp", "url": "/uploads/medium_ele3_aedf799e57.webp", "hash": "medium_ele3_aedf799e57", "mime": "image/webp", "name": "medium_ele3.webp", "path": null, "size": 20.51, "width": 565, "height": 750, "sizeInBytes": 20512}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ele3_aedf799e57.webp", "hash": "thumbnail_ele3_aedf799e57", "mime": "image/webp", "name": "thumbnail_ele3.webp", "path": null, "size": 3.29, "width": 117, "height": 156, "sizeInBytes": 3288}}	ele3_aedf799e57	.webp	image/webp	27.81	/uploads/ele3_aedf799e57.webp	\N	local	\N	/2/9	2025-04-15 21:38:29.378	2025-04-15 21:38:29.378	2025-04-15 21:38:29.378	1	1	\N
135	uc0y2oo7bjd1d94q35u3c9t1	sonic2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_sonic2_c83b0b73a7.webp", "hash": "small_sonic2_c83b0b73a7", "mime": "image/webp", "name": "small_sonic2.webp", "path": null, "size": 11.75, "width": 375, "height": 500, "sizeInBytes": 11750}, "medium": {"ext": ".webp", "url": "/uploads/medium_sonic2_c83b0b73a7.webp", "hash": "medium_sonic2_c83b0b73a7", "mime": "image/webp", "name": "medium_sonic2.webp", "path": null, "size": 19.1, "width": 563, "height": 750, "sizeInBytes": 19098}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sonic2_c83b0b73a7.webp", "hash": "thumbnail_sonic2_c83b0b73a7", "mime": "image/webp", "name": "thumbnail_sonic2.webp", "path": null, "size": 2.6, "width": 117, "height": 156, "sizeInBytes": 2600}}	sonic2_c83b0b73a7	.webp	image/webp	25.94	/uploads/sonic2_c83b0b73a7.webp	\N	local	\N	/2/15	2025-04-16 19:01:33.49	2025-04-16 19:01:33.49	2025-04-16 19:01:33.49	1	1	\N
270	wo2nkizlau39lpoelal99tcq	trans1.jpeg	\N	\N	297	170	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_trans1_d00777e125.jpeg", "hash": "thumbnail_trans1_d00777e125", "mime": "image/jpeg", "name": "thumbnail_trans1.jpeg", "path": null, "size": 8.22, "width": 245, "height": 140, "sizeInBytes": 8215}}	trans1_d00777e125	.jpeg	image/jpeg	10.14	/uploads/trans1_d00777e125.jpeg	\N	local	\N	/2/7	2025-04-17 11:44:01.676	2025-04-17 11:44:01.676	2025-04-17 11:44:01.676	1	1	\N
171	c2msiag31m4dkixq5chjeba6	nozle1.webp	\N	\N	640	640	{"small": {"ext": ".webp", "url": "/uploads/small_nozle1_39f881ab21.webp", "hash": "small_nozle1_39f881ab21", "mime": "image/webp", "name": "small_nozle1.webp", "path": null, "size": 8.43, "width": 500, "height": 500, "sizeInBytes": 8432}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nozle1_39f881ab21.webp", "hash": "thumbnail_nozle1_39f881ab21", "mime": "image/webp", "name": "thumbnail_nozle1.webp", "path": null, "size": 1.75, "width": 156, "height": 156, "sizeInBytes": 1750}}	nozle1_39f881ab21	.webp	image/webp	14.36	/uploads/nozle1_39f881ab21.webp	\N	local	\N	/2/4	2025-04-16 19:48:17.604	2025-04-16 19:48:17.604	2025-04-16 19:48:17.604	1	1	\N
201	rnjgfpeqbdu2333qj2up8ct4	termi2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_termi2_12f8ae0e59.webp", "hash": "small_termi2_12f8ae0e59", "mime": "image/webp", "name": "small_termi2.webp", "path": null, "size": 10.65, "width": 375, "height": 500, "sizeInBytes": 10654}, "medium": {"ext": ".webp", "url": "/uploads/medium_termi2_12f8ae0e59.webp", "hash": "medium_termi2_12f8ae0e59", "mime": "image/webp", "name": "medium_termi2.webp", "path": null, "size": 18.62, "width": 563, "height": 750, "sizeInBytes": 18620}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_termi2_12f8ae0e59.webp", "hash": "thumbnail_termi2_12f8ae0e59", "mime": "image/webp", "name": "thumbnail_termi2.webp", "path": null, "size": 1.89, "width": 117, "height": 156, "sizeInBytes": 1890}}	termi2_12f8ae0e59	.webp	image/webp	25.79	/uploads/termi2_12f8ae0e59.webp	\N	local	\N	/2/20	2025-04-16 21:31:00.874	2025-04-16 21:31:00.874	2025-04-16 21:31:00.874	1	1	\N
202	o6siny703xpxvinohv4agy6h	termi1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_termi1_17429210fa.webp", "hash": "small_termi1_17429210fa", "mime": "image/webp", "name": "small_termi1.webp", "path": null, "size": 21.12, "width": 375, "height": 500, "sizeInBytes": 21124}, "medium": {"ext": ".webp", "url": "/uploads/medium_termi1_17429210fa.webp", "hash": "medium_termi1_17429210fa", "mime": "image/webp", "name": "medium_termi1.webp", "path": null, "size": 36.2, "width": 563, "height": 750, "sizeInBytes": 36200}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_termi1_17429210fa.webp", "hash": "thumbnail_termi1_17429210fa", "mime": "image/webp", "name": "thumbnail_termi1.webp", "path": null, "size": 3.51, "width": 117, "height": 156, "sizeInBytes": 3508}}	termi1_17429210fa	.webp	image/webp	52.28	/uploads/termi1_17429210fa.webp	\N	local	\N	/2/20	2025-04-16 21:31:00.885	2025-04-16 21:31:00.885	2025-04-16 21:31:00.885	1	1	\N
222	cp03xvxvd9rdwqtxtp62cetm	perf3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_perf3_41e3425a3e.webp", "hash": "small_perf3_41e3425a3e", "mime": "image/webp", "name": "small_perf3.webp", "path": null, "size": 13.37, "width": 375, "height": 500, "sizeInBytes": 13370}, "medium": {"ext": ".webp", "url": "/uploads/medium_perf3_41e3425a3e.webp", "hash": "medium_perf3_41e3425a3e", "mime": "image/webp", "name": "medium_perf3.webp", "path": null, "size": 21.86, "width": 563, "height": 750, "sizeInBytes": 21856}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_perf3_41e3425a3e.webp", "hash": "thumbnail_perf3_41e3425a3e", "mime": "image/webp", "name": "thumbnail_perf3.webp", "path": null, "size": 2.94, "width": 117, "height": 156, "sizeInBytes": 2942}}	perf3_41e3425a3e	.webp	image/webp	30.46	/uploads/perf3_41e3425a3e.webp	\N	local	\N	/2/23	2025-04-16 22:01:37.707	2025-04-16 22:01:37.707	2025-04-16 22:01:37.707	1	1	\N
234	yn3n65h86q03mamttae14w4k	tor3.webp	\N	\N	640	1136	{"large": {"ext": ".webp", "url": "/uploads/large_tor3_b4d2b8621b.webp", "hash": "large_tor3_b4d2b8621b", "mime": "image/webp", "name": "large_tor3.webp", "path": null, "size": 64.54, "width": 563, "height": 1000, "sizeInBytes": 64544}, "small": {"ext": ".webp", "url": "/uploads/small_tor3_b4d2b8621b.webp", "hash": "small_tor3_b4d2b8621b", "mime": "image/webp", "name": "small_tor3.webp", "path": null, "size": 19.51, "width": 282, "height": 500, "sizeInBytes": 19508}, "medium": {"ext": ".webp", "url": "/uploads/medium_tor3_b4d2b8621b.webp", "hash": "medium_tor3_b4d2b8621b", "mime": "image/webp", "name": "medium_tor3.webp", "path": null, "size": 40.81, "width": 423, "height": 750, "sizeInBytes": 40806}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_tor3_b4d2b8621b.webp", "hash": "thumbnail_tor3_b4d2b8621b", "mime": "image/webp", "name": "thumbnail_tor3.webp", "path": null, "size": 2.68, "width": 88, "height": 156, "sizeInBytes": 2680}}	tor3_b4d2b8621b	.webp	image/webp	102.81	/uploads/tor3_b4d2b8621b.webp	\N	local	\N	/2/23	2025-04-16 22:18:07.92	2025-04-16 22:18:07.92	2025-04-16 22:18:07.92	1	1	\N
261	strlm4ow6ijgunrwjv2j7sow	sopor1.webp	\N	\N	304	304	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sopor1_95f163b045.webp", "hash": "thumbnail_sopor1_95f163b045", "mime": "image/webp", "name": "thumbnail_sopor1.webp", "path": null, "size": 2.18, "width": 156, "height": 156, "sizeInBytes": 2180}}	sopor1_95f163b045	.webp	image/webp	6.10	/uploads/sopor1_95f163b045.webp	\N	local	\N	/2/8	2025-04-17 11:19:54.422	2025-04-17 11:19:54.422	2025-04-17 11:19:54.422	1	1	\N
137	yylk8y2745699om66bc4hpbt	mono2.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_mono2_3271796b69.webp", "hash": "small_mono2_3271796b69", "mime": "image/webp", "name": "small_mono2.webp", "path": null, "size": 11.6, "width": 500, "height": 375, "sizeInBytes": 11600}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono2_3271796b69.webp", "hash": "thumbnail_mono2_3271796b69", "mime": "image/webp", "name": "thumbnail_mono2.webp", "path": null, "size": 4.18, "width": 208, "height": 156, "sizeInBytes": 4180}}	mono2_3271796b69	.webp	image/webp	17.30	/uploads/mono2_3271796b69.webp	\N	local	\N	/2/7	2025-04-16 19:17:29.253	2025-04-16 19:17:29.253	2025-04-16 19:17:29.253	1	1	\N
140	ga8xdaedmk7sgplbsvoq9uys	mono1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mono1_dc4bd5d8ba.webp", "hash": "small_mono1_dc4bd5d8ba", "mime": "image/webp", "name": "small_mono1.webp", "path": null, "size": 15.21, "width": 375, "height": 500, "sizeInBytes": 15208}, "medium": {"ext": ".webp", "url": "/uploads/medium_mono1_dc4bd5d8ba.webp", "hash": "medium_mono1_dc4bd5d8ba", "mime": "image/webp", "name": "medium_mono1.webp", "path": null, "size": 29.11, "width": 563, "height": 750, "sizeInBytes": 29112}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono1_dc4bd5d8ba.webp", "hash": "thumbnail_mono1_dc4bd5d8ba", "mime": "image/webp", "name": "thumbnail_mono1.webp", "path": null, "size": 2.6, "width": 117, "height": 156, "sizeInBytes": 2598}}	mono1_dc4bd5d8ba	.webp	image/webp	44.32	/uploads/mono1_dc4bd5d8ba.webp	\N	local	\N	/2/7	2025-04-16 19:17:29.281	2025-04-16 19:17:29.281	2025-04-16 19:17:29.281	1	1	\N
271	j8vgb6bfzd9wnh7utqbniz2f	trans1.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_trans1_8bdff91f15.webp", "hash": "thumbnail_trans1_8bdff91f15", "mime": "image/webp", "name": "thumbnail_trans1.webp", "path": null, "size": 2.99, "width": 158, "height": 156, "sizeInBytes": 2988}}	trans1_8bdff91f15	.webp	image/webp	8.27	/uploads/trans1_8bdff91f15.webp	\N	local	\N	/2/7	2025-04-17 11:44:01.685	2025-04-17 11:44:01.685	2025-04-17 11:44:01.685	1	1	\N
172	dxpx1md6mlziybuqx6ih8ihg	nozle3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_nozle3_1982a8155a.webp", "hash": "small_nozle3_1982a8155a", "mime": "image/webp", "name": "small_nozle3.webp", "path": null, "size": 13.68, "width": 500, "height": 375, "sizeInBytes": 13680}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_nozle3_1982a8155a.webp", "hash": "thumbnail_nozle3_1982a8155a", "mime": "image/webp", "name": "thumbnail_nozle3.webp", "path": null, "size": 3.23, "width": 208, "height": 156, "sizeInBytes": 3234}}	nozle3_1982a8155a	.webp	image/webp	28.13	/uploads/nozle3_1982a8155a.webp	\N	local	\N	/2/4	2025-04-16 19:48:17.608	2025-04-16 19:48:17.608	2025-04-16 19:48:17.609	1	1	\N
203	z08ftqoku1rbqzh01kwjm26h	pei4.webp	\N	\N	411	376	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pei4_42ac7dd670.webp", "hash": "thumbnail_pei4_42ac7dd670", "mime": "image/webp", "name": "thumbnail_pei4.webp", "path": null, "size": 1.64, "width": 171, "height": 156, "sizeInBytes": 1644}}	pei4_42ac7dd670	.webp	image/webp	5.18	/uploads/pei4_42ac7dd670.webp	\N	local	\N	/2/19	2025-04-16 21:43:48.038	2025-04-16 21:43:48.038	2025-04-16 21:43:48.038	1	1	\N
205	h36gdvtbdfhzw7x9otgg4gdj	pei3.webp	\N	\N	640	712	{"small": {"ext": ".webp", "url": "/uploads/small_pei3_9eedc92f10.webp", "hash": "small_pei3_9eedc92f10", "mime": "image/webp", "name": "small_pei3.webp", "path": null, "size": 6.75, "width": 449, "height": 500, "sizeInBytes": 6746}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pei3_9eedc92f10.webp", "hash": "thumbnail_pei3_9eedc92f10", "mime": "image/webp", "name": "thumbnail_pei3.webp", "path": null, "size": 1.68, "width": 140, "height": 156, "sizeInBytes": 1680}}	pei3_9eedc92f10	.webp	image/webp	11.37	/uploads/pei3_9eedc92f10.webp	\N	local	\N	/2/19	2025-04-16 21:43:48.064	2025-04-16 21:43:48.064	2025-04-16 21:43:48.064	1	1	\N
224	wvwr396ragvsnncyo3nvrfw0	perfil2.webp	\N	\N	640	360	{"small": {"ext": ".webp", "url": "/uploads/small_perfil2_c1232ebabd.webp", "hash": "small_perfil2_c1232ebabd", "mime": "image/webp", "name": "small_perfil2.webp", "path": null, "size": 8.21, "width": 500, "height": 281, "sizeInBytes": 8212}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_perfil2_c1232ebabd.webp", "hash": "thumbnail_perfil2_c1232ebabd", "mime": "image/webp", "name": "thumbnail_perfil2.webp", "path": null, "size": 3.04, "width": 245, "height": 138, "sizeInBytes": 3042}}	perfil2_c1232ebabd	.webp	image/webp	14.24	/uploads/perfil2_c1232ebabd.webp	\N	local	\N	/2/23	2025-04-16 22:05:07.915	2025-04-16 22:05:07.915	2025-04-16 22:05:07.915	1	1	\N
235	x2ifjittn192sk0qpmxsdixw	angul1.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_angul1_4467e0306d.webp", "hash": "small_angul1_4467e0306d", "mime": "image/webp", "name": "small_angul1.webp", "path": null, "size": 34.54, "width": 500, "height": 375, "sizeInBytes": 34540}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_angul1_4467e0306d.webp", "hash": "thumbnail_angul1_4467e0306d", "mime": "image/webp", "name": "thumbnail_angul1.webp", "path": null, "size": 6.74, "width": 208, "height": 156, "sizeInBytes": 6736}}	angul1_4467e0306d	.webp	image/webp	68.33	/uploads/angul1_4467e0306d.webp	\N	local	\N	/2/23	2025-04-16 22:22:49.108	2025-04-16 22:22:49.108	2025-04-16 22:22:49.109	1	1	\N
241	ji7jo22mfl05nf47odf3z4c5	goma1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_goma1_550f118316.webp", "hash": "small_goma1_550f118316", "mime": "image/webp", "name": "small_goma1.webp", "path": null, "size": 23.47, "width": 375, "height": 500, "sizeInBytes": 23466}, "medium": {"ext": ".webp", "url": "/uploads/medium_goma1_550f118316.webp", "hash": "medium_goma1_550f118316", "mime": "image/webp", "name": "medium_goma1.webp", "path": null, "size": 43.92, "width": 563, "height": 750, "sizeInBytes": 43920}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_goma1_550f118316.webp", "hash": "thumbnail_goma1_550f118316", "mime": "image/webp", "name": "thumbnail_goma1.webp", "path": null, "size": 3.77, "width": 117, "height": 156, "sizeInBytes": 3774}}	goma1_550f118316	.webp	image/webp	67.46	/uploads/goma1_550f118316.webp	\N	local	\N	/2/23	2025-04-16 22:26:06.232	2025-04-16 22:26:06.232	2025-04-16 22:26:06.232	1	1	\N
244	pphqhr5ww3ijhq2l88ylluwp	cubre1.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_cubre1_f36a81b4ee.webp", "hash": "small_cubre1_f36a81b4ee", "mime": "image/webp", "name": "small_cubre1.webp", "path": null, "size": 20.93, "width": 376, "height": 500, "sizeInBytes": 20926}, "medium": {"ext": ".webp", "url": "/uploads/medium_cubre1_f36a81b4ee.webp", "hash": "medium_cubre1_f36a81b4ee", "mime": "image/webp", "name": "medium_cubre1.webp", "path": null, "size": 35.84, "width": 565, "height": 750, "sizeInBytes": 35838}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cubre1_f36a81b4ee.webp", "hash": "thumbnail_cubre1_f36a81b4ee", "mime": "image/webp", "name": "thumbnail_cubre1.webp", "path": null, "size": 4.27, "width": 117, "height": 156, "sizeInBytes": 4274}}	cubre1_f36a81b4ee	.webp	image/webp	56.49	/uploads/cubre1_f36a81b4ee.webp	\N	local	\N	/2/23	2025-04-16 22:29:21.57	2025-04-16 22:29:21.57	2025-04-16 22:29:21.57	1	1	\N
262	pj3vdeeeyti4ki71n3v9pcpl	sopor2.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_sopor2_9a9209ba19.webp", "hash": "thumbnail_sopor2_9a9209ba19", "mime": "image/webp", "name": "thumbnail_sopor2.webp", "path": null, "size": 1.58, "width": 158, "height": 156, "sizeInBytes": 1578}}	sopor2_9a9209ba19	.webp	image/webp	3.94	/uploads/sopor2_9a9209ba19.webp	\N	local	\N	/2/8	2025-04-17 11:19:54.422	2025-04-17 11:19:54.422	2025-04-17 11:19:54.423	1	1	\N
138	s5iopyw2br87yvc31s70g5pm	mono3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_mono3_44acd7b571.webp", "hash": "small_mono3_44acd7b571", "mime": "image/webp", "name": "small_mono3.webp", "path": null, "size": 5.76, "width": 500, "height": 375, "sizeInBytes": 5760}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono3_44acd7b571.webp", "hash": "thumbnail_mono3_44acd7b571", "mime": "image/webp", "name": "thumbnail_mono3.webp", "path": null, "size": 2, "width": 208, "height": 156, "sizeInBytes": 2002}}	mono3_44acd7b571	.webp	image/webp	8.89	/uploads/mono3_44acd7b571.webp	\N	local	\N	/2/7	2025-04-16 19:17:29.253	2025-04-16 19:17:29.253	2025-04-16 19:17:29.253	1	1	\N
139	crbxszzl0yaksv31q0qxaej7	mono4.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_mono4_dbd52b9761.webp", "hash": "small_mono4_dbd52b9761", "mime": "image/webp", "name": "small_mono4.webp", "path": null, "size": 5.96, "width": 500, "height": 375, "sizeInBytes": 5960}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono4_dbd52b9761.webp", "hash": "thumbnail_mono4_dbd52b9761", "mime": "image/webp", "name": "thumbnail_mono4.webp", "path": null, "size": 2.08, "width": 208, "height": 156, "sizeInBytes": 2082}}	mono4_dbd52b9761	.webp	image/webp	9.31	/uploads/mono4_dbd52b9761.webp	\N	local	\N	/2/7	2025-04-16 19:17:29.268	2025-04-16 19:17:29.268	2025-04-16 19:17:29.268	1	1	\N
141	tkqyaxffpzoja4j082rwrcop	mono5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mono5_2e2d002a50.webp", "hash": "small_mono5_2e2d002a50", "mime": "image/webp", "name": "small_mono5.webp", "path": null, "size": 16.22, "width": 375, "height": 500, "sizeInBytes": 16218}, "medium": {"ext": ".webp", "url": "/uploads/medium_mono5_2e2d002a50.webp", "hash": "medium_mono5_2e2d002a50", "mime": "image/webp", "name": "medium_mono5.webp", "path": null, "size": 32.85, "width": 563, "height": 750, "sizeInBytes": 32850}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono5_2e2d002a50.webp", "hash": "thumbnail_mono5_2e2d002a50", "mime": "image/webp", "name": "thumbnail_mono5.webp", "path": null, "size": 2.15, "width": 117, "height": 156, "sizeInBytes": 2154}}	mono5_2e2d002a50	.webp	image/webp	53.33	/uploads/mono5_2e2d002a50.webp	\N	local	\N	/2/7	2025-04-16 19:17:29.284	2025-04-16 19:17:29.284	2025-04-16 19:17:29.284	1	1	\N
142	knnzp4owilsbx1c2l2ac1vxo	mono7.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_mono7_8342f88499.webp", "hash": "small_mono7_8342f88499", "mime": "image/webp", "name": "small_mono7.webp", "path": null, "size": 11.79, "width": 375, "height": 500, "sizeInBytes": 11792}, "medium": {"ext": ".webp", "url": "/uploads/medium_mono7_8342f88499.webp", "hash": "medium_mono7_8342f88499", "mime": "image/webp", "name": "medium_mono7.webp", "path": null, "size": 19.61, "width": 563, "height": 750, "sizeInBytes": 19614}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_mono7_8342f88499.webp", "hash": "thumbnail_mono7_8342f88499", "mime": "image/webp", "name": "thumbnail_mono7.webp", "path": null, "size": 2.12, "width": 117, "height": 156, "sizeInBytes": 2122}}	mono7_8342f88499	.webp	image/webp	28.98	/uploads/mono7_8342f88499.webp	\N	local	\N	/2/7	2025-04-16 19:17:29.369	2025-04-16 19:17:29.369	2025-04-16 19:17:29.369	1	1	\N
173	s0qdlf3tdbw4pbek22y63ctk	big3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_big3_b157c1e16f.webp", "hash": "small_big3_b157c1e16f", "mime": "image/webp", "name": "small_big3.webp", "path": null, "size": 19.51, "width": 375, "height": 500, "sizeInBytes": 19512}, "medium": {"ext": ".webp", "url": "/uploads/medium_big3_b157c1e16f.webp", "hash": "medium_big3_b157c1e16f", "mime": "image/webp", "name": "medium_big3.webp", "path": null, "size": 32.97, "width": 563, "height": 750, "sizeInBytes": 32970}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_big3_b157c1e16f.webp", "hash": "thumbnail_big3_b157c1e16f", "mime": "image/webp", "name": "thumbnail_big3.webp", "path": null, "size": 3.66, "width": 117, "height": 156, "sizeInBytes": 3660}}	big3_b157c1e16f	.webp	image/webp	47.95	/uploads/big3_b157c1e16f.webp	\N	local	\N	/2/19	2025-04-16 20:57:09.764	2025-04-16 20:57:09.764	2025-04-16 20:57:09.764	1	1	\N
204	k71lb5vbgxe05i7634uq4k1m	pei1.webp	\N	\N	631	602	{"small": {"ext": ".webp", "url": "/uploads/small_pei1_d40004fdab.webp", "hash": "small_pei1_d40004fdab", "mime": "image/webp", "name": "small_pei1.webp", "path": null, "size": 4.5, "width": 500, "height": 477, "sizeInBytes": 4496}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pei1_d40004fdab.webp", "hash": "thumbnail_pei1_d40004fdab", "mime": "image/webp", "name": "thumbnail_pei1.webp", "path": null, "size": 1.18, "width": 164, "height": 156, "sizeInBytes": 1180}}	pei1_d40004fdab	.webp	image/webp	7.17	/uploads/pei1_d40004fdab.webp	\N	local	\N	/2/19	2025-04-16 21:43:48.063	2025-04-16 21:43:48.063	2025-04-16 21:43:48.063	1	1	\N
225	hmistlac48831ji2ah1wxry3	uni2.webp	\N	\N	640	438	{"small": {"ext": ".webp", "url": "/uploads/small_uni2_4c0bf2934d.webp", "hash": "small_uni2_4c0bf2934d", "mime": "image/webp", "name": "small_uni2.webp", "path": null, "size": 10.72, "width": 500, "height": 342, "sizeInBytes": 10724}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_uni2_4c0bf2934d.webp", "hash": "thumbnail_uni2_4c0bf2934d", "mime": "image/webp", "name": "thumbnail_uni2.webp", "path": null, "size": 3.71, "width": 228, "height": 156, "sizeInBytes": 3710}}	uni2_4c0bf2934d	.webp	image/webp	17.71	/uploads/uni2_4c0bf2934d.webp	\N	local	\N	/2/23	2025-04-16 22:08:06.282	2025-04-16 22:08:06.282	2025-04-16 22:08:06.282	1	1	\N
226	ezccpsvfww562thk7b8ysmos	uni4.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_uni4_3423c62bd3.webp", "hash": "small_uni4_3423c62bd3", "mime": "image/webp", "name": "small_uni4.webp", "path": null, "size": 10.71, "width": 500, "height": 375, "sizeInBytes": 10712}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_uni4_3423c62bd3.webp", "hash": "thumbnail_uni4_3423c62bd3", "mime": "image/webp", "name": "thumbnail_uni4.webp", "path": null, "size": 2.92, "width": 208, "height": 156, "sizeInBytes": 2922}}	uni4_3423c62bd3	.webp	image/webp	20.65	/uploads/uni4_3423c62bd3.webp	\N	local	\N	/2/23	2025-04-16 22:08:06.29	2025-04-16 22:08:06.29	2025-04-16 22:08:06.29	1	1	\N
236	ay9dtps51rlfb1edgyie58a0	angul3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_angul3_96633db024.webp", "hash": "small_angul3_96633db024", "mime": "image/webp", "name": "small_angul3.webp", "path": null, "size": 21.79, "width": 500, "height": 375, "sizeInBytes": 21790}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_angul3_96633db024.webp", "hash": "thumbnail_angul3_96633db024", "mime": "image/webp", "name": "thumbnail_angul3.webp", "path": null, "size": 6.28, "width": 208, "height": 156, "sizeInBytes": 6284}}	angul3_96633db024	.webp	image/webp	37.22	/uploads/angul3_96633db024.webp	\N	local	\N	/2/23	2025-04-16 22:22:49.109	2025-04-16 22:22:49.109	2025-04-16 22:22:49.109	1	1	\N
143	a32tji45p5irnn9br7xia6g3	ld5.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ld5_8072a79c7f.webp", "hash": "small_ld5_8072a79c7f", "mime": "image/webp", "name": "small_ld5.webp", "path": null, "size": 10.34, "width": 375, "height": 500, "sizeInBytes": 10342}, "medium": {"ext": ".webp", "url": "/uploads/medium_ld5_8072a79c7f.webp", "hash": "medium_ld5_8072a79c7f", "mime": "image/webp", "name": "medium_ld5.webp", "path": null, "size": 16.16, "width": 563, "height": 750, "sizeInBytes": 16156}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ld5_8072a79c7f.webp", "hash": "thumbnail_ld5_8072a79c7f", "mime": "image/webp", "name": "thumbnail_ld5.webp", "path": null, "size": 2.32, "width": 117, "height": 156, "sizeInBytes": 2318}}	ld5_8072a79c7f	.webp	image/webp	21.36	/uploads/ld5_8072a79c7f.webp	\N	local	\N	/2/4	2025-04-16 19:22:30.377	2025-04-16 19:22:30.377	2025-04-16 19:22:30.377	1	1	\N
272	cp377h5dcepx8fu310l4vroq	verd1.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_verd1_729da85da0.webp", "hash": "thumbnail_verd1_729da85da0", "mime": "image/webp", "name": "thumbnail_verd1.webp", "path": null, "size": 4.37, "width": 158, "height": 156, "sizeInBytes": 4372}}	verd1_729da85da0	.webp	image/webp	11.77	/uploads/verd1_729da85da0.webp	\N	local	\N	/2/7	2025-04-17 11:46:39.911	2025-04-17 11:46:39.911	2025-04-17 11:46:39.911	1	1	\N
147	ctpm8h8i93r06wo1ivofqalt	ld3.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ld3_967a8409c7.webp", "hash": "small_ld3_967a8409c7", "mime": "image/webp", "name": "small_ld3.webp", "path": null, "size": 16.07, "width": 375, "height": 500, "sizeInBytes": 16068}, "medium": {"ext": ".webp", "url": "/uploads/medium_ld3_967a8409c7.webp", "hash": "medium_ld3_967a8409c7", "mime": "image/webp", "name": "medium_ld3.webp", "path": null, "size": 27.92, "width": 563, "height": 750, "sizeInBytes": 27924}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ld3_967a8409c7.webp", "hash": "thumbnail_ld3_967a8409c7", "mime": "image/webp", "name": "thumbnail_ld3.webp", "path": null, "size": 2.56, "width": 117, "height": 156, "sizeInBytes": 2562}}	ld3_967a8409c7	.webp	image/webp	44.38	/uploads/ld3_967a8409c7.webp	\N	local	\N	/2/4	2025-04-16 19:22:30.392	2025-04-16 19:22:30.392	2025-04-16 19:22:30.392	1	1	\N
174	cusqwf75wylqe6tdr7oxj3v3	big4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_big4_4beb23b8dd.webp", "hash": "small_big4_4beb23b8dd", "mime": "image/webp", "name": "small_big4.webp", "path": null, "size": 10.04, "width": 375, "height": 500, "sizeInBytes": 10040}, "medium": {"ext": ".webp", "url": "/uploads/medium_big4_4beb23b8dd.webp", "hash": "medium_big4_4beb23b8dd", "mime": "image/webp", "name": "medium_big4.webp", "path": null, "size": 16.07, "width": 563, "height": 750, "sizeInBytes": 16072}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_big4_4beb23b8dd.webp", "hash": "thumbnail_big4_4beb23b8dd", "mime": "image/webp", "name": "thumbnail_big4.webp", "path": null, "size": 2.02, "width": 117, "height": 156, "sizeInBytes": 2020}}	big4_4beb23b8dd	.webp	image/webp	24.02	/uploads/big4_4beb23b8dd.webp	\N	local	\N	/2/19	2025-04-16 20:57:09.763	2025-04-16 20:57:09.763	2025-04-16 20:57:09.763	1	1	\N
176	c3nv4c464fd8ovjv3l4migor	big1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_big1_296d8045b0.webp", "hash": "small_big1_296d8045b0", "mime": "image/webp", "name": "small_big1.webp", "path": null, "size": 30.29, "width": 375, "height": 500, "sizeInBytes": 30286}, "medium": {"ext": ".webp", "url": "/uploads/medium_big1_296d8045b0.webp", "hash": "medium_big1_296d8045b0", "mime": "image/webp", "name": "medium_big1.webp", "path": null, "size": 52.63, "width": 563, "height": 750, "sizeInBytes": 52626}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_big1_296d8045b0.webp", "hash": "thumbnail_big1_296d8045b0", "mime": "image/webp", "name": "thumbnail_big1.webp", "path": null, "size": 5.18, "width": 117, "height": 156, "sizeInBytes": 5176}}	big1_296d8045b0	.webp	image/webp	76.94	/uploads/big1_296d8045b0.webp	\N	local	\N	/2/19	2025-04-16 20:57:09.783	2025-04-16 20:57:09.783	2025-04-16 20:57:09.783	1	1	\N
177	h8gommdf6eqy8fetwtau8a3b	panta2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_panta2_0f98de2720.webp", "hash": "small_panta2_0f98de2720", "mime": "image/webp", "name": "small_panta2.webp", "path": null, "size": 24.34, "width": 375, "height": 500, "sizeInBytes": 24338}, "medium": {"ext": ".webp", "url": "/uploads/medium_panta2_0f98de2720.webp", "hash": "medium_panta2_0f98de2720", "mime": "image/webp", "name": "medium_panta2.webp", "path": null, "size": 47.01, "width": 563, "height": 750, "sizeInBytes": 47014}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_panta2_0f98de2720.webp", "hash": "thumbnail_panta2_0f98de2720", "mime": "image/webp", "name": "thumbnail_panta2.webp", "path": null, "size": 2.67, "width": 117, "height": 156, "sizeInBytes": 2674}}	panta2_0f98de2720	.webp	image/webp	76.54	/uploads/panta2_0f98de2720.webp	\N	local	\N	/2/19	2025-04-16 21:00:32.946	2025-04-16 21:00:32.946	2025-04-16 21:00:32.946	1	1	\N
206	q9mb8tp8qsxjgcs6tc0ijata	pei2.webp	\N	\N	628	678	{"small": {"ext": ".webp", "url": "/uploads/small_pei2_d75aee43b5.webp", "hash": "small_pei2_d75aee43b5", "mime": "image/webp", "name": "small_pei2.webp", "path": null, "size": 6.14, "width": 463, "height": 500, "sizeInBytes": 6142}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pei2_d75aee43b5.webp", "hash": "thumbnail_pei2_d75aee43b5", "mime": "image/webp", "name": "thumbnail_pei2.webp", "path": null, "size": 1.36, "width": 144, "height": 156, "sizeInBytes": 1360}}	pei2_d75aee43b5	.webp	image/webp	10.20	/uploads/pei2_d75aee43b5.webp	\N	local	\N	/2/19	2025-04-16 21:43:48.066	2025-04-16 21:43:48.066	2025-04-16 21:43:48.066	1	1	\N
227	w31m086kvidxi7192to6j62g	uni1.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_uni1_d74099083e.webp", "hash": "small_uni1_d74099083e", "mime": "image/webp", "name": "small_uni1.webp", "path": null, "size": 14.49, "width": 500, "height": 375, "sizeInBytes": 14494}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_uni1_d74099083e.webp", "hash": "thumbnail_uni1_d74099083e", "mime": "image/webp", "name": "thumbnail_uni1.webp", "path": null, "size": 3.86, "width": 208, "height": 156, "sizeInBytes": 3860}}	uni1_d74099083e	.webp	image/webp	27.17	/uploads/uni1_d74099083e.webp	\N	local	\N	/2/23	2025-04-16 22:08:06.292	2025-04-16 22:08:06.292	2025-04-16 22:08:06.292	1	1	\N
237	fsojql7vwkbz1j9240wwy0ih	angul2.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_angul2_80f34c6e4e.webp", "hash": "small_angul2_80f34c6e4e", "mime": "image/webp", "name": "small_angul2.webp", "path": null, "size": 33.61, "width": 500, "height": 375, "sizeInBytes": 33612}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_angul2_80f34c6e4e.webp", "hash": "thumbnail_angul2_80f34c6e4e", "mime": "image/webp", "name": "thumbnail_angul2.webp", "path": null, "size": 7.24, "width": 208, "height": 156, "sizeInBytes": 7236}}	angul2_80f34c6e4e	.webp	image/webp	64.41	/uploads/angul2_80f34c6e4e.webp	\N	local	\N	/2/23	2025-04-16 22:22:49.112	2025-04-16 22:22:49.112	2025-04-16 22:22:49.112	1	1	\N
263	mo32n6lbi67bkv4lkmbqts5v	asa1.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_asa1_9d8c215c91.webp", "hash": "thumbnail_asa1_9d8c215c91", "mime": "image/webp", "name": "thumbnail_asa1.webp", "path": null, "size": 4.83, "width": 158, "height": 156, "sizeInBytes": 4828}}	asa1_9d8c215c91	.webp	image/webp	15.42	/uploads/asa1_9d8c215c91.webp	\N	local	\N	/2/24	2025-04-17 11:25:06.389	2025-04-17 11:25:06.389	2025-04-17 11:25:06.389	1	1	\N
144	ujxo6rugj9lwxruwsmjjsbku	ld4.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ld4_3db01571d7.webp", "hash": "small_ld4_3db01571d7", "mime": "image/webp", "name": "small_ld4.webp", "path": null, "size": 17.4, "width": 375, "height": 500, "sizeInBytes": 17396}, "medium": {"ext": ".webp", "url": "/uploads/medium_ld4_3db01571d7.webp", "hash": "medium_ld4_3db01571d7", "mime": "image/webp", "name": "medium_ld4.webp", "path": null, "size": 29.57, "width": 563, "height": 750, "sizeInBytes": 29568}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ld4_3db01571d7.webp", "hash": "thumbnail_ld4_3db01571d7", "mime": "image/webp", "name": "thumbnail_ld4.webp", "path": null, "size": 3.1, "width": 117, "height": 156, "sizeInBytes": 3102}}	ld4_3db01571d7	.webp	image/webp	44.39	/uploads/ld4_3db01571d7.webp	\N	local	\N	/2/4	2025-04-16 19:22:30.39	2025-04-16 19:22:30.39	2025-04-16 19:22:30.39	1	1	\N
175	xsivgflg70njddknurp9551e	big2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_big2_afa5bbc232.webp", "hash": "small_big2_afa5bbc232", "mime": "image/webp", "name": "small_big2.webp", "path": null, "size": 21.99, "width": 375, "height": 500, "sizeInBytes": 21994}, "medium": {"ext": ".webp", "url": "/uploads/medium_big2_afa5bbc232.webp", "hash": "medium_big2_afa5bbc232", "mime": "image/webp", "name": "medium_big2.webp", "path": null, "size": 37.55, "width": 563, "height": 750, "sizeInBytes": 37550}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_big2_afa5bbc232.webp", "hash": "thumbnail_big2_afa5bbc232", "mime": "image/webp", "name": "thumbnail_big2.webp", "path": null, "size": 4.18, "width": 117, "height": 156, "sizeInBytes": 4184}}	big2_afa5bbc232	.webp	image/webp	52.11	/uploads/big2_afa5bbc232.webp	\N	local	\N	/2/19	2025-04-16 20:57:09.764	2025-04-16 20:57:09.764	2025-04-16 20:57:09.764	1	1	\N
207	arw8qzde0hjg8vf3vsat5cnn	cables.webp	\N	\N	640	863	{"small": {"ext": ".webp", "url": "/uploads/small_cables_852b14ab3a.webp", "hash": "small_cables_852b14ab3a", "mime": "image/webp", "name": "small_cables.webp", "path": null, "size": 12.42, "width": 371, "height": 500, "sizeInBytes": 12424}, "medium": {"ext": ".webp", "url": "/uploads/medium_cables_852b14ab3a.webp", "hash": "medium_cables_852b14ab3a", "mime": "image/webp", "name": "medium_cables.webp", "path": null, "size": 21.28, "width": 556, "height": 750, "sizeInBytes": 21284}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cables_852b14ab3a.webp", "hash": "thumbnail_cables_852b14ab3a", "mime": "image/webp", "name": "thumbnail_cables.webp", "path": null, "size": 2.09, "width": 116, "height": 156, "sizeInBytes": 2094}}	cables_852b14ab3a	.webp	image/webp	32.37	/uploads/cables_852b14ab3a.webp	\N	local	\N	/2/19	2025-04-16 21:46:36.444	2025-04-16 21:46:36.444	2025-04-16 21:46:36.444	1	1	\N
228	t2gddgpkt60fq136tna7xcdd	uni3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_uni3_02eb3a0baf.webp", "hash": "small_uni3_02eb3a0baf", "mime": "image/webp", "name": "small_uni3.webp", "path": null, "size": 14.74, "width": 500, "height": 375, "sizeInBytes": 14736}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_uni3_02eb3a0baf.webp", "hash": "thumbnail_uni3_02eb3a0baf", "mime": "image/webp", "name": "thumbnail_uni3.webp", "path": null, "size": 3.29, "width": 208, "height": 156, "sizeInBytes": 3286}}	uni3_02eb3a0baf	.webp	image/webp	27.58	/uploads/uni3_02eb3a0baf.webp	\N	local	\N	/2/23	2025-04-16 22:08:06.294	2025-04-16 22:08:06.294	2025-04-16 22:08:06.294	1	1	\N
238	mz5ldbr6waiv9zqoifjip04v	angul4.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_angul4_bcff65cb91.webp", "hash": "small_angul4_bcff65cb91", "mime": "image/webp", "name": "small_angul4.webp", "path": null, "size": 33.67, "width": 500, "height": 375, "sizeInBytes": 33672}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_angul4_bcff65cb91.webp", "hash": "thumbnail_angul4_bcff65cb91", "mime": "image/webp", "name": "thumbnail_angul4.webp", "path": null, "size": 6.76, "width": 208, "height": 156, "sizeInBytes": 6758}}	angul4_bcff65cb91	.webp	image/webp	66.98	/uploads/angul4_bcff65cb91.webp	\N	local	\N	/2/23	2025-04-16 22:22:49.126	2025-04-16 22:22:49.126	2025-04-16 22:22:49.126	1	1	\N
242	ahdi6gh11cbyib7g5y7z1saa	cubre2.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_cubre2_9b94398cb3.webp", "hash": "small_cubre2_9b94398cb3", "mime": "image/webp", "name": "small_cubre2.webp", "path": null, "size": 19.45, "width": 376, "height": 500, "sizeInBytes": 19446}, "medium": {"ext": ".webp", "url": "/uploads/medium_cubre2_9b94398cb3.webp", "hash": "medium_cubre2_9b94398cb3", "mime": "image/webp", "name": "medium_cubre2.webp", "path": null, "size": 30.14, "width": 565, "height": 750, "sizeInBytes": 30142}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cubre2_9b94398cb3.webp", "hash": "thumbnail_cubre2_9b94398cb3", "mime": "image/webp", "name": "thumbnail_cubre2.webp", "path": null, "size": 4.07, "width": 117, "height": 156, "sizeInBytes": 4074}}	cubre2_9b94398cb3	.webp	image/webp	41.44	/uploads/cubre2_9b94398cb3.webp	\N	local	\N	/2/23	2025-04-16 22:29:21.555	2025-04-16 22:29:21.555	2025-04-16 22:29:21.555	1	1	\N
245	v4l76c65dlj075n7urr4xucz	tap1.webp	\N	\N	640	427	{"small": {"ext": ".webp", "url": "/uploads/small_tap1_d8d192251d.webp", "hash": "small_tap1_d8d192251d", "mime": "image/webp", "name": "small_tap1.webp", "path": null, "size": 7.27, "width": 500, "height": 334, "sizeInBytes": 7268}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_tap1_d8d192251d.webp", "hash": "thumbnail_tap1_d8d192251d", "mime": "image/webp", "name": "thumbnail_tap1.webp", "path": null, "size": 2.91, "width": 234, "height": 156, "sizeInBytes": 2908}}	tap1_d8d192251d	.webp	image/webp	11.74	/uploads/tap1_d8d192251d.webp	\N	local	\N	/2/23	2025-04-16 22:31:59.998	2025-04-16 22:31:59.998	2025-04-16 22:31:59.998	1	1	\N
247	p2egtb3m7tsh7ylzpbbg46f8	tap3.webp	\N	\N	640	628	{"small": {"ext": ".webp", "url": "/uploads/small_tap3_87f43ccb7a.webp", "hash": "small_tap3_87f43ccb7a", "mime": "image/webp", "name": "small_tap3.webp", "path": null, "size": 10.1, "width": 500, "height": 491, "sizeInBytes": 10100}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_tap3_87f43ccb7a.webp", "hash": "thumbnail_tap3_87f43ccb7a", "mime": "image/webp", "name": "thumbnail_tap3.webp", "path": null, "size": 2.06, "width": 159, "height": 156, "sizeInBytes": 2064}}	tap3_87f43ccb7a	.webp	image/webp	16.78	/uploads/tap3_87f43ccb7a.webp	\N	local	\N	/2/23	2025-04-16 22:32:00.023	2025-04-16 22:32:00.023	2025-04-16 22:32:00.023	1	1	\N
248	e30wgho75kny5urjgsxsr1j0	tap4.webp	\N	\N	640	625	{"small": {"ext": ".webp", "url": "/uploads/small_tap4_1b50e0fefa.webp", "hash": "small_tap4_1b50e0fefa", "mime": "image/webp", "name": "small_tap4.webp", "path": null, "size": 10.38, "width": 500, "height": 488, "sizeInBytes": 10376}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_tap4_1b50e0fefa.webp", "hash": "thumbnail_tap4_1b50e0fefa", "mime": "image/webp", "name": "thumbnail_tap4.webp", "path": null, "size": 2.08, "width": 160, "height": 156, "sizeInBytes": 2078}}	tap4_1b50e0fefa	.webp	image/webp	18.39	/uploads/tap4_1b50e0fefa.webp	\N	local	\N	/2/23	2025-04-16 22:32:00.024	2025-04-16 22:32:00.024	2025-04-16 22:32:00.024	1	1	\N
145	o3eppx7nkwymr3b0wgkn3pja	ld2.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ld2_4d3c3bcc7f.webp", "hash": "small_ld2_4d3c3bcc7f", "mime": "image/webp", "name": "small_ld2.webp", "path": null, "size": 14.55, "width": 375, "height": 500, "sizeInBytes": 14548}, "medium": {"ext": ".webp", "url": "/uploads/medium_ld2_4d3c3bcc7f.webp", "hash": "medium_ld2_4d3c3bcc7f", "mime": "image/webp", "name": "medium_ld2.webp", "path": null, "size": 27.47, "width": 563, "height": 750, "sizeInBytes": 27474}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ld2_4d3c3bcc7f.webp", "hash": "thumbnail_ld2_4d3c3bcc7f", "mime": "image/webp", "name": "thumbnail_ld2.webp", "path": null, "size": 2.29, "width": 117, "height": 156, "sizeInBytes": 2292}}	ld2_4d3c3bcc7f	.webp	image/webp	45.30	/uploads/ld2_4d3c3bcc7f.webp	\N	local	\N	/2/4	2025-04-16 19:22:30.391	2025-04-16 19:22:30.391	2025-04-16 19:22:30.391	1	1	\N
148	zpi1jq17z7d9vkuxbogbn41c	ld6.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ld6_7b9b63c78a.webp", "hash": "small_ld6_7b9b63c78a", "mime": "image/webp", "name": "small_ld6.webp", "path": null, "size": 21.61, "width": 375, "height": 500, "sizeInBytes": 21606}, "medium": {"ext": ".webp", "url": "/uploads/medium_ld6_7b9b63c78a.webp", "hash": "medium_ld6_7b9b63c78a", "mime": "image/webp", "name": "medium_ld6.webp", "path": null, "size": 37.43, "width": 563, "height": 750, "sizeInBytes": 37428}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ld6_7b9b63c78a.webp", "hash": "thumbnail_ld6_7b9b63c78a", "mime": "image/webp", "name": "thumbnail_ld6.webp", "path": null, "size": 3.81, "width": 117, "height": 156, "sizeInBytes": 3812}}	ld6_7b9b63c78a	.webp	image/webp	54.79	/uploads/ld6_7b9b63c78a.webp	\N	local	\N	/2/4	2025-04-16 19:22:30.406	2025-04-16 19:22:30.406	2025-04-16 19:22:30.407	1	1	\N
149	ud9mnisb8as3ubo2wrd14bf1	ld7.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_ld7_98541839ed.webp", "hash": "small_ld7_98541839ed", "mime": "image/webp", "name": "small_ld7.webp", "path": null, "size": 19.24, "width": 375, "height": 500, "sizeInBytes": 19244}, "medium": {"ext": ".webp", "url": "/uploads/medium_ld7_98541839ed.webp", "hash": "medium_ld7_98541839ed", "mime": "image/webp", "name": "medium_ld7.webp", "path": null, "size": 33.48, "width": 563, "height": 750, "sizeInBytes": 33482}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_ld7_98541839ed.webp", "hash": "thumbnail_ld7_98541839ed", "mime": "image/webp", "name": "thumbnail_ld7.webp", "path": null, "size": 3.21, "width": 117, "height": 156, "sizeInBytes": 3212}}	ld7_98541839ed	.webp	image/webp	51.56	/uploads/ld7_98541839ed.webp	\N	local	\N	/2/4	2025-04-16 19:22:30.518	2025-04-16 19:22:30.518	2025-04-16 19:22:30.518	1	1	\N
178	ws1tus06uvu8e1ntxx0ppays	panta1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_panta1_3f3865c129.webp", "hash": "small_panta1_3f3865c129", "mime": "image/webp", "name": "small_panta1.webp", "path": null, "size": 29.83, "width": 375, "height": 500, "sizeInBytes": 29830}, "medium": {"ext": ".webp", "url": "/uploads/medium_panta1_3f3865c129.webp", "hash": "medium_panta1_3f3865c129", "mime": "image/webp", "name": "medium_panta1.webp", "path": null, "size": 55.52, "width": 563, "height": 750, "sizeInBytes": 55524}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_panta1_3f3865c129.webp", "hash": "thumbnail_panta1_3f3865c129", "mime": "image/webp", "name": "thumbnail_panta1.webp", "path": null, "size": 3.49, "width": 117, "height": 156, "sizeInBytes": 3490}}	panta1_3f3865c129	.webp	image/webp	82.63	/uploads/panta1_3f3865c129.webp	\N	local	\N	/2/19	2025-04-16 21:00:32.945	2025-04-16 21:00:32.945	2025-04-16 21:00:32.946	1	1	\N
209	uz3rsprrqzmmb0y58ciloug5	hemera3.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_hemera3_5459e58e09.webp", "hash": "small_hemera3_5459e58e09", "mime": "image/webp", "name": "small_hemera3.webp", "path": null, "size": 5.92, "width": 500, "height": 375, "sizeInBytes": 5920}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_hemera3_5459e58e09.webp", "hash": "thumbnail_hemera3_5459e58e09", "mime": "image/webp", "name": "thumbnail_hemera3.webp", "path": null, "size": 2.15, "width": 208, "height": 156, "sizeInBytes": 2150}}	hemera3_5459e58e09	.webp	image/webp	9.29	/uploads/hemera3_5459e58e09.webp	\N	local	\N	/2/20	2025-04-16 21:51:18.487	2025-04-16 21:51:18.487	2025-04-16 21:51:18.487	1	1	\N
229	l829zme04n8d1ejbat0ebpgd	bas1.jpg	\N	\N	650	650	{"small": {"ext": ".jpg", "url": "/uploads/small_bas1_067f9bf4bc.jpg", "hash": "small_bas1_067f9bf4bc", "mime": "image/jpeg", "name": "small_bas1.jpg", "path": null, "size": 15.63, "width": 500, "height": 500, "sizeInBytes": 15634}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_bas1_067f9bf4bc.jpg", "hash": "thumbnail_bas1_067f9bf4bc", "mime": "image/jpeg", "name": "thumbnail_bas1.jpg", "path": null, "size": 2.52, "width": 156, "height": 156, "sizeInBytes": 2520}}	bas1_067f9bf4bc	.jpg	image/jpeg	22.08	/uploads/bas1_067f9bf4bc.jpg	\N	local	\N	/2/23	2025-04-16 22:11:41.079	2025-04-16 22:11:41.079	2025-04-16 22:11:41.079	1	1	\N
239	m6ta95oaa1t4y6fk9wfhjdkz	angul5.webp	\N	\N	640	480	{"small": {"ext": ".webp", "url": "/uploads/small_angul5_b15082ffbc.webp", "hash": "small_angul5_b15082ffbc", "mime": "image/webp", "name": "small_angul5.webp", "path": null, "size": 31.21, "width": 500, "height": 375, "sizeInBytes": 31208}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_angul5_b15082ffbc.webp", "hash": "thumbnail_angul5_b15082ffbc", "mime": "image/webp", "name": "thumbnail_angul5.webp", "path": null, "size": 6.45, "width": 208, "height": 156, "sizeInBytes": 6446}}	angul5_b15082ffbc	.webp	image/webp	60.27	/uploads/angul5_b15082ffbc.webp	\N	local	\N	/2/23	2025-04-16 22:22:49.127	2025-04-16 22:22:49.127	2025-04-16 22:22:49.127	1	1	\N
243	rmhfuukilhgn5ebes8k69fuf	cubre3.webp	\N	\N	640	850	{"small": {"ext": ".webp", "url": "/uploads/small_cubre3_89c09e71ec.webp", "hash": "small_cubre3_89c09e71ec", "mime": "image/webp", "name": "small_cubre3.webp", "path": null, "size": 21.92, "width": 376, "height": 500, "sizeInBytes": 21920}, "medium": {"ext": ".webp", "url": "/uploads/medium_cubre3_89c09e71ec.webp", "hash": "medium_cubre3_89c09e71ec", "mime": "image/webp", "name": "medium_cubre3.webp", "path": null, "size": 35.91, "width": 565, "height": 750, "sizeInBytes": 35908}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_cubre3_89c09e71ec.webp", "hash": "thumbnail_cubre3_89c09e71ec", "mime": "image/webp", "name": "thumbnail_cubre3.webp", "path": null, "size": 4.23, "width": 117, "height": 156, "sizeInBytes": 4230}}	cubre3_89c09e71ec	.webp	image/webp	51.59	/uploads/cubre3_89c09e71ec.webp	\N	local	\N	/2/23	2025-04-16 22:29:21.558	2025-04-16 22:29:21.558	2025-04-16 22:29:21.558	1	1	\N
253	m54du81urgdhr6oxn60xi4cn	petg.webp	\N	\N	284	251	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_petg_5410da3477.webp", "hash": "thumbnail_petg_5410da3477", "mime": "image/webp", "name": "thumbnail_petg.webp", "path": null, "size": 4.19, "width": 177, "height": 156, "sizeInBytes": 4194}}	petg_5410da3477	.webp	image/webp	10.59	/uploads/petg_5410da3477.webp	\N	local	\N	/2/8	2025-04-17 11:05:20.403	2025-04-17 11:05:20.403	2025-04-17 11:05:20.403	1	1	\N
80	a1laobga1gc6va9nu10otuo1	genius1.webp	\N	\N	640	853	{"small": {"ext": ".webp", "url": "/uploads/small_genius1_a2861082ab.webp", "hash": "small_genius1_a2861082ab", "mime": "image/webp", "name": "small_genius1.webp", "path": null, "size": 19.02, "width": 375, "height": 500, "sizeInBytes": 19016}, "medium": {"ext": ".webp", "url": "/uploads/medium_genius1_a2861082ab.webp", "hash": "medium_genius1_a2861082ab", "mime": "image/webp", "name": "medium_genius1.webp", "path": null, "size": 32.75, "width": 563, "height": 750, "sizeInBytes": 32752}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_genius1_a2861082ab.webp", "hash": "thumbnail_genius1_a2861082ab", "mime": "image/webp", "name": "thumbnail_genius1.webp", "path": null, "size": 3.75, "width": 117, "height": 156, "sizeInBytes": 3752}}	genius1_a2861082ab	.webp	image/webp	47.13	/uploads/genius1_a2861082ab.webp	\N	local	\N	/2/11	2025-04-15 21:10:51.263	2025-04-15 21:10:51.263	2025-04-15 21:10:51.263	1	1	\N
250	d672xf5lrnlwdq757a35hj1i	pla3.webp	\N	\N	640	1136	{"large": {"ext": ".webp", "url": "/uploads/large_pla3_2c242f9fa8.webp", "hash": "large_pla3_2c242f9fa8", "mime": "image/webp", "name": "large_pla3.webp", "path": null, "size": 29.04, "width": 563, "height": 1000, "sizeInBytes": 29042}, "small": {"ext": ".webp", "url": "/uploads/small_pla3_2c242f9fa8.webp", "hash": "small_pla3_2c242f9fa8", "mime": "image/webp", "name": "small_pla3.webp", "path": null, "size": 12.11, "width": 282, "height": 500, "sizeInBytes": 12114}, "medium": {"ext": ".webp", "url": "/uploads/medium_pla3_2c242f9fa8.webp", "hash": "medium_pla3_2c242f9fa8", "mime": "image/webp", "name": "medium_pla3.webp", "path": null, "size": 20.25, "width": 423, "height": 750, "sizeInBytes": 20250}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pla3_2c242f9fa8.webp", "hash": "thumbnail_pla3_2c242f9fa8", "mime": "image/webp", "name": "thumbnail_pla3.webp", "path": null, "size": 2.55, "width": 88, "height": 156, "sizeInBytes": 2552}}	pla3_2c242f9fa8	.webp	image/webp	42.82	/uploads/pla3_2c242f9fa8.webp	\N	local	\N	/2/4	2025-04-17 10:55:37.034	2025-04-17 10:55:37.034	2025-04-17 10:55:37.034	1	1	\N
251	j6kf25c577umree3ukyyh1x1	pla1.webp	\N	\N	640	1136	{"large": {"ext": ".webp", "url": "/uploads/large_pla1_b7ec216f70.webp", "hash": "large_pla1_b7ec216f70", "mime": "image/webp", "name": "large_pla1.webp", "path": null, "size": 74.61, "width": 563, "height": 1000, "sizeInBytes": 74608}, "small": {"ext": ".webp", "url": "/uploads/small_pla1_b7ec216f70.webp", "hash": "small_pla1_b7ec216f70", "mime": "image/webp", "name": "small_pla1.webp", "path": null, "size": 23.95, "width": 282, "height": 500, "sizeInBytes": 23950}, "medium": {"ext": ".webp", "url": "/uploads/medium_pla1_b7ec216f70.webp", "hash": "medium_pla1_b7ec216f70", "mime": "image/webp", "name": "medium_pla1.webp", "path": null, "size": 48.13, "width": 423, "height": 750, "sizeInBytes": 48130}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pla1_b7ec216f70.webp", "hash": "thumbnail_pla1_b7ec216f70", "mime": "image/webp", "name": "thumbnail_pla1.webp", "path": null, "size": 2.56, "width": 88, "height": 156, "sizeInBytes": 2562}}	pla1_b7ec216f70	.webp	image/webp	113.70	/uploads/pla1_b7ec216f70.webp	\N	local	\N	/2/4	2025-04-17 10:55:37.083	2025-04-17 10:55:37.083	2025-04-17 10:55:37.083	1	1	\N
249	a1za2zoju86ytfilh4c7m87h	pla2.webp	\N	\N	640	1136	{"large": {"ext": ".webp", "url": "/uploads/large_pla2_ec10301867.webp", "hash": "large_pla2_ec10301867", "mime": "image/webp", "name": "large_pla2.webp", "path": null, "size": 22.53, "width": 563, "height": 1000, "sizeInBytes": 22528}, "small": {"ext": ".webp", "url": "/uploads/small_pla2_ec10301867.webp", "hash": "small_pla2_ec10301867", "mime": "image/webp", "name": "small_pla2.webp", "path": null, "size": 8.97, "width": 282, "height": 500, "sizeInBytes": 8968}, "medium": {"ext": ".webp", "url": "/uploads/medium_pla2_ec10301867.webp", "hash": "medium_pla2_ec10301867", "mime": "image/webp", "name": "medium_pla2.webp", "path": null, "size": 15.77, "width": 423, "height": 750, "sizeInBytes": 15768}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_pla2_ec10301867.webp", "hash": "thumbnail_pla2_ec10301867", "mime": "image/webp", "name": "thumbnail_pla2.webp", "path": null, "size": 1.62, "width": 88, "height": 156, "sizeInBytes": 1620}}	pla2_ec10301867	.webp	image/webp	33.30	/uploads/pla2_ec10301867.webp	\N	local	\N	/2/4	2025-04-17 10:55:37.033	2025-04-17 10:55:37.033	2025-04-17 10:55:37.033	1	1	\N
252	zhxuz89qgf1636lsou9a7o9x	plaelego.webp	\N	\N	640	686	{"small": {"ext": ".webp", "url": "/uploads/small_plaelego_faefb46a6d.webp", "hash": "small_plaelego_faefb46a6d", "mime": "image/webp", "name": "small_plaelego.webp", "path": null, "size": 20.74, "width": 466, "height": 500, "sizeInBytes": 20744}, "thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_plaelego_faefb46a6d.webp", "hash": "thumbnail_plaelego_faefb46a6d", "mime": "image/webp", "name": "thumbnail_plaelego.webp", "path": null, "size": 3.92, "width": 146, "height": 156, "sizeInBytes": 3924}}	plaelego_faefb46a6d	.webp	image/webp	38.44	/uploads/plaelego_faefb46a6d.webp	\N	local	\N	/2/9	2025-04-17 10:59:06.024	2025-04-17 10:59:06.024	2025-04-17 10:59:06.024	1	1	\N
264	xpo94gprrgujclm7nmt28007	nylon2.jpg	\N	\N	350	305	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_nylon2_c39d2945de.jpg", "hash": "thumbnail_nylon2_c39d2945de", "mime": "image/jpeg", "name": "thumbnail_nylon2.jpg", "path": null, "size": 7.18, "width": 179, "height": 156, "sizeInBytes": 7183}}	nylon2_c39d2945de	.jpg	image/jpeg	22.34	/uploads/nylon2_c39d2945de.jpg	\N	local	\N	/2/24	2025-04-17 11:30:37.055	2025-04-17 11:30:37.055	2025-04-17 11:30:37.055	1	1	\N
265	habzgmewh94by46y08lrkeps	nylon1.jpg	\N	\N	1600	1600	{"large": {"ext": ".jpg", "url": "/uploads/large_nylon1_38be5a2dd7.jpg", "hash": "large_nylon1_38be5a2dd7", "mime": "image/jpeg", "name": "large_nylon1.jpg", "path": null, "size": 122.76, "width": 1000, "height": 1000, "sizeInBytes": 122758}, "small": {"ext": ".jpg", "url": "/uploads/small_nylon1_38be5a2dd7.jpg", "hash": "small_nylon1_38be5a2dd7", "mime": "image/jpeg", "name": "small_nylon1.jpg", "path": null, "size": 43.14, "width": 500, "height": 500, "sizeInBytes": 43139}, "medium": {"ext": ".jpg", "url": "/uploads/medium_nylon1_38be5a2dd7.jpg", "hash": "medium_nylon1_38be5a2dd7", "mime": "image/jpeg", "name": "medium_nylon1.jpg", "path": null, "size": 80.36, "width": 750, "height": 750, "sizeInBytes": 80357}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_nylon1_38be5a2dd7.jpg", "hash": "thumbnail_nylon1_38be5a2dd7", "mime": "image/jpeg", "name": "thumbnail_nylon1.jpg", "path": null, "size": 5.87, "width": 156, "height": 156, "sizeInBytes": 5874}}	nylon1_38be5a2dd7	.jpg	image/jpeg	210.67	/uploads/nylon1_38be5a2dd7.jpg	\N	local	\N	/2/24	2025-04-17 11:30:37.117	2025-04-17 11:30:37.117	2025-04-17 11:30:37.117	1	1	\N
267	u99fpmw4dispatqaoerloz8y	1.jpg	\N	\N	560	374	{"small": {"ext": ".jpg", "url": "/uploads/small_1_31dd03bc1c.jpg", "hash": "small_1_31dd03bc1c", "mime": "image/jpeg", "name": "small_1.jpg", "path": null, "size": 22.64, "width": 500, "height": 334, "sizeInBytes": 22638}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_1_31dd03bc1c.jpg", "hash": "thumbnail_1_31dd03bc1c", "mime": "image/jpeg", "name": "thumbnail_1.jpg", "path": null, "size": 6.37, "width": 234, "height": 156, "sizeInBytes": 6367}}	1_31dd03bc1c	.jpg	image/jpeg	28.31	/uploads/1_31dd03bc1c.jpg	\N	local	\N	/2/24	2025-04-17 11:34:05.207	2025-04-17 11:34:05.207	2025-04-17 11:34:05.207	1	1	\N
268	y3g204tacnioxgu29i1mx8jh	any2.webp	\N	\N	282	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_any2_93cec44d42.webp", "hash": "thumbnail_any2_93cec44d42", "mime": "image/webp", "name": "thumbnail_any2.webp", "path": null, "size": 1.52, "width": 157, "height": 156, "sizeInBytes": 1518}}	any2_93cec44d42	.webp	image/webp	3.64	/uploads/any2_93cec44d42.webp	\N	local	\N	/2/7	2025-04-17 11:38:40.426	2025-04-17 11:38:40.426	2025-04-17 11:38:40.426	1	1	\N
275	sq1gw6xprtdat8kw3upslm76	carn1.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_carn1_9598b5b9c0.webp", "hash": "thumbnail_carn1_9598b5b9c0", "mime": "image/webp", "name": "thumbnail_carn1.webp", "path": null, "size": 1.84, "width": 158, "height": 156, "sizeInBytes": 1838}}	carn1_9598b5b9c0	.webp	image/webp	4.93	/uploads/carn1_9598b5b9c0.webp	\N	local	\N	/2/7	2025-04-17 11:48:16.943	2025-04-17 11:48:16.943	2025-04-17 11:48:16.943	1	1	\N
276	drth3l87vdnxw0b4aqi5m6ws	dent2.jpeg	\N	\N	276	183	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_dent2_f7ae3f3ca9.jpeg", "hash": "thumbnail_dent2_f7ae3f3ca9", "mime": "image/jpeg", "name": "thumbnail_dent2.jpeg", "path": null, "size": 4.77, "width": 235, "height": 156, "sizeInBytes": 4771}}	dent2_f7ae3f3ca9	.jpeg	image/jpeg	4.77	/uploads/dent2_f7ae3f3ca9.jpeg	\N	local	\N	/2/7	2025-04-17 11:51:37.206	2025-04-17 11:51:37.206	2025-04-17 11:51:37.206	1	1	\N
277	h0cb5tegfjp0jywthcm2nwzn	dent1.webp	\N	\N	284	280	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_dent1_e52b9ddd90.webp", "hash": "thumbnail_dent1_e52b9ddd90", "mime": "image/webp", "name": "thumbnail_dent1.webp", "path": null, "size": 2.77, "width": 158, "height": 156, "sizeInBytes": 2768}}	dent1_e52b9ddd90	.webp	image/webp	7.20	/uploads/dent1_e52b9ddd90.webp	\N	local	\N	/2/7	2025-04-17 11:51:37.215	2025-04-17 11:51:37.215	2025-04-17 11:51:37.215	1	1	\N
278	eb6ag1ipb8fhcq7n9bvsv2eh	electronica.jpg	\N	\N	225	225	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_electronica_3982ee4e9f.jpg", "hash": "thumbnail_electronica_3982ee4e9f", "mime": "image/jpeg", "name": "thumbnail_electronica.jpg", "path": null, "size": 7.38, "width": 156, "height": 156, "sizeInBytes": 7383}}	electronica_3982ee4e9f	.jpg	image/jpeg	12.08	/uploads/electronica_3982ee4e9f.jpg	\N	local	\N	/25	2025-04-17 11:53:17.841	2025-04-17 11:53:17.841	2025-04-17 11:53:17.841	1	1	\N
279	rr53c5c8llahobyf7qk99gmi	impresora.png	\N	\N	225	225	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_impresora_412a1fffbd.png", "hash": "thumbnail_impresora_412a1fffbd", "mime": "image/png", "name": "thumbnail_impresora.png", "path": null, "size": 5.79, "width": 156, "height": 156, "sizeInBytes": 5793}}	impresora_412a1fffbd	.png	image/png	1.88	/uploads/impresora_412a1fffbd.png	\N	local	\N	/25	2025-04-17 11:53:17.857	2025-04-17 11:53:17.857	2025-04-17 11:53:17.858	1	1	\N
280	dydzj9xtqm42uqz0jnenthan	perfileria.jpg	\N	\N	233	216	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_perfileria_7849befffd.jpg", "hash": "thumbnail_perfileria_7849befffd", "mime": "image/jpeg", "name": "thumbnail_perfileria.jpg", "path": null, "size": 6.5, "width": 168, "height": 156, "sizeInBytes": 6503}}	perfileria_7849befffd	.jpg	image/jpeg	9.61	/uploads/perfileria_7849befffd.jpg	\N	local	\N	/25	2025-04-17 11:53:17.858	2025-04-17 11:53:17.858	2025-04-17 11:53:17.858	1	1	\N
282	q7r1zpd9b2yix8fdgrte4xnv	filamento.webp	\N	\N	177	175	{"thumbnail": {"ext": ".webp", "url": "/uploads/thumbnail_filamento_d2a46f36a0.webp", "hash": "thumbnail_filamento_d2a46f36a0", "mime": "image/webp", "name": "thumbnail_filamento.webp", "path": null, "size": 4.76, "width": 158, "height": 156, "sizeInBytes": 4760}}	filamento_d2a46f36a0	.webp	image/webp	6.74	/uploads/filamento_d2a46f36a0.webp	\N	local	\N	/25	2025-04-17 11:53:17.859	2025-04-17 11:53:17.859	2025-04-17 11:53:17.859	1	1	\N
283	eagfds8l7qzwjqhrrofxkdi0	resina.png	\N	\N	225	225	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_resina_b0e9082e4f.png", "hash": "thumbnail_resina_b0e9082e4f", "mime": "image/png", "name": "thumbnail_resina.png", "path": null, "size": 11.03, "width": 156, "height": 156, "sizeInBytes": 11028}}	resina_b0e9082e4f	.png	image/png	2.92	/uploads/resina_b0e9082e4f.png	\N	local	\N	/25	2025-04-17 11:53:17.862	2025-04-17 11:53:17.862	2025-04-17 11:53:17.862	1	1	\N
281	m7ewav5j4m1zdsj8xp7jnph9	fdm.jpg	\N	\N	217	232	{"thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_fdm_cba4820577.jpg", "hash": "thumbnail_fdm_cba4820577", "mime": "image/jpeg", "name": "thumbnail_fdm.jpg", "path": null, "size": 5.48, "width": 146, "height": 156, "sizeInBytes": 5480}}	fdm_cba4820577	.jpg	image/jpeg	9.05	/uploads/fdm_cba4820577.jpg	\N	local	\N	/25	2025-04-17 11:53:17.858	2025-04-17 11:54:54.154	2025-04-17 11:53:17.858	1	1	\N
284	m6r1dm97snh46vmlntxnmqe3	sinImagen.png	\N	\N	344	361	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_sin_Imagen_6e992c81fa.png", "hash": "thumbnail_sin_Imagen_6e992c81fa", "mime": "image/png", "name": "thumbnail_sinImagen.png", "path": null, "size": 32.69, "width": 149, "height": 156, "sizeInBytes": 32689}}	sin_Imagen_6e992c81fa	.png	image/png	26.14	/uploads/sin_Imagen_6e992c81fa.png	\N	local	\N	/25	2025-04-17 11:53:17.906	2025-04-17 11:53:17.906	2025-04-17 11:53:17.907	1	1	\N
285	kiwkmbinrxggp7pe3tez8h7t	resina.jpeg	\N	\N	271	186	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_resina_37c257139f.jpeg", "hash": "thumbnail_resina_37c257139f", "mime": "image/jpeg", "name": "thumbnail_resina.jpeg", "path": null, "size": 4.47, "width": 227, "height": 156, "sizeInBytes": 4473}}	resina_37c257139f	.jpeg	image/jpeg	5.28	/uploads/resina_37c257139f.jpeg	\N	local	\N	/25	2025-04-17 11:55:57.249	2025-04-17 11:55:57.249	2025-04-17 11:55:57.249	1	1	\N
286	fnoz0r3f2lm2d2dfmlxv5ek7	enmano.jpeg	\N	\N	275	183	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_enmano_3bc1027cf3.jpeg", "hash": "thumbnail_enmano_3bc1027cf3", "mime": "image/jpeg", "name": "thumbnail_enmano.jpeg", "path": null, "size": 4.41, "width": 234, "height": 156, "sizeInBytes": 4407}}	enmano_3bc1027cf3	.jpeg	image/jpeg	4.93	/uploads/enmano_3bc1027cf3.jpeg	\N	local	\N	/26	2025-04-17 11:57:31.541	2025-04-17 11:57:31.541	2025-04-17 11:57:31.542	1	1	\N
287	zf5ffphaf8kxpd8jy5t70y1u	standard.png	\N	\N	225	225	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_standard_1c0c805d56.png", "hash": "thumbnail_standard_1c0c805d56", "mime": "image/png", "name": "thumbnail_standard.png", "path": null, "size": 6.69, "width": 156, "height": 156, "sizeInBytes": 6687}}	standard_1c0c805d56	.png	image/png	2.06	/uploads/standard_1c0c805d56.png	\N	local	\N	/26	2025-04-17 11:58:19.914	2025-04-17 11:58:19.914	2025-04-17 11:58:19.914	1	1	\N
288	ocpnp1pam0w87sbltf6tsqg0	express.jpeg	\N	\N	284	177	{"thumbnail": {"ext": ".jpeg", "url": "/uploads/thumbnail_express_a78afc7aa0.jpeg", "hash": "thumbnail_express_a78afc7aa0", "mime": "image/jpeg", "name": "thumbnail_express.jpeg", "path": null, "size": 6.32, "width": 245, "height": 153, "sizeInBytes": 6323}}	express_a78afc7aa0	.jpeg	image/jpeg	7.51	/uploads/express_a78afc7aa0.jpeg	\N	local	\N	/26	2025-04-17 11:58:52.427	2025-04-17 11:58:52.427	2025-04-17 11:58:52.427	1	1	\N
289	kbrfvoewpqhzgyn7v81441gk	entienda.png	\N	\N	225	225	{"thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_entienda_be1831bb3f.png", "hash": "thumbnail_entienda_be1831bb3f", "mime": "image/png", "name": "thumbnail_entienda.png", "path": null, "size": 6.28, "width": 156, "height": 156, "sizeInBytes": 6277}}	entienda_be1831bb3f	.png	image/png	2.45	/uploads/entienda_be1831bb3f.png	\N	local	\N	/26	2025-04-17 11:59:38.558	2025-04-17 12:00:05.547	2025-04-17 11:59:38.558	1	1	\N
290	k2ttpead8y6w7h12g4jang3k	idex_img1.jpg	\N	\N	1000	1000	{"small": {"ext": ".jpg", "url": "/uploads/small_idex_img1_beff556398.jpg", "hash": "small_idex_img1_beff556398", "mime": "image/jpeg", "name": "small_idex_img1.jpg", "path": null, "size": 40.78, "width": 500, "height": 500, "sizeInBytes": 40775}, "medium": {"ext": ".jpg", "url": "/uploads/medium_idex_img1_beff556398.jpg", "hash": "medium_idex_img1_beff556398", "mime": "image/jpeg", "name": "medium_idex_img1.jpg", "path": null, "size": 82.06, "width": 750, "height": 750, "sizeInBytes": 82056}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_idex_img1_beff556398.jpg", "hash": "thumbnail_idex_img1_beff556398", "mime": "image/jpeg", "name": "thumbnail_idex_img1.jpg", "path": null, "size": 6.24, "width": 156, "height": 156, "sizeInBytes": 6242}}	idex_img1_beff556398	.jpg	image/jpeg	138.25	/uploads/idex_img1_beff556398.jpg	\N	local	\N	/27	2025-04-19 19:06:48.737	2025-04-19 19:06:48.737	2025-04-19 19:06:48.737	1	1	\N
291	lt0e7zayg4rv1udxkh7h2tec	v-chonk_render_2.png	\N	\N	1000	1000	{"small": {"ext": ".png", "url": "/uploads/small_v_chonk_render_2_ab233678a2.png", "hash": "small_v_chonk_render_2_ab233678a2", "mime": "image/png", "name": "small_v-chonk_render_2.png", "path": null, "size": 192.51, "width": 500, "height": 500, "sizeInBytes": 192509}, "medium": {"ext": ".png", "url": "/uploads/medium_v_chonk_render_2_ab233678a2.png", "hash": "medium_v_chonk_render_2_ab233678a2", "mime": "image/png", "name": "medium_v-chonk_render_2.png", "path": null, "size": 396, "width": 750, "height": 750, "sizeInBytes": 396004}, "thumbnail": {"ext": ".png", "url": "/uploads/thumbnail_v_chonk_render_2_ab233678a2.png", "hash": "thumbnail_v_chonk_render_2_ab233678a2", "mime": "image/png", "name": "thumbnail_v-chonk_render_2.png", "path": null, "size": 27.15, "width": 156, "height": 156, "sizeInBytes": 27153}}	v_chonk_render_2_ab233678a2	.png	image/png	162.77	/uploads/v_chonk_render_2_ab233678a2.png	\N	local	\N	/27	2025-04-19 19:08:10.612	2025-04-19 19:08:10.612	2025-04-19 19:08:10.612	1	1	\N
292	rwztw0nlv5xzpo8kschvz7wn	vc4_004_2_1.jpg	\N	\N	1000	1000	{"small": {"ext": ".jpg", "url": "/uploads/small_vc4_004_2_1_4162418694.jpg", "hash": "small_vc4_004_2_1_4162418694", "mime": "image/jpeg", "name": "small_vc4_004_2_1.jpg", "path": null, "size": 21.16, "width": 500, "height": 500, "sizeInBytes": 21160}, "medium": {"ext": ".jpg", "url": "/uploads/medium_vc4_004_2_1_4162418694.jpg", "hash": "medium_vc4_004_2_1_4162418694", "mime": "image/jpeg", "name": "medium_vc4_004_2_1.jpg", "path": null, "size": 38.26, "width": 750, "height": 750, "sizeInBytes": 38256}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_vc4_004_2_1_4162418694.jpg", "hash": "thumbnail_vc4_004_2_1_4162418694", "mime": "image/jpeg", "name": "thumbnail_vc4_004_2_1.jpg", "path": null, "size": 3.65, "width": 156, "height": 156, "sizeInBytes": 3653}}	vc4_004_2_1_4162418694	.jpg	image/jpeg	59.26	/uploads/vc4_004_2_1_4162418694.jpg	\N	local	\N	/27	2025-04-19 19:09:00.997	2025-04-19 19:09:00.997	2025-04-19 19:09:00.997	1	1	\N
293	id93rj1c0a0aw4s40pp8pcl2	vc4_005_2_1.jpg	\N	\N	1000	1000	{"small": {"ext": ".jpg", "url": "/uploads/small_vc4_005_2_1_26f97109dc.jpg", "hash": "small_vc4_005_2_1_26f97109dc", "mime": "image/jpeg", "name": "small_vc4_005_2_1.jpg", "path": null, "size": 21.44, "width": 500, "height": 500, "sizeInBytes": 21442}, "medium": {"ext": ".jpg", "url": "/uploads/medium_vc4_005_2_1_26f97109dc.jpg", "hash": "medium_vc4_005_2_1_26f97109dc", "mime": "image/jpeg", "name": "medium_vc4_005_2_1.jpg", "path": null, "size": 43.71, "width": 750, "height": 750, "sizeInBytes": 43713}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_vc4_005_2_1_26f97109dc.jpg", "hash": "thumbnail_vc4_005_2_1_26f97109dc", "mime": "image/jpeg", "name": "thumbnail_vc4_005_2_1.jpg", "path": null, "size": 3.5, "width": 156, "height": 156, "sizeInBytes": 3498}}	vc4_005_2_1_26f97109dc	.jpg	image/jpeg	73.10	/uploads/vc4_005_2_1_26f97109dc.jpg	\N	local	\N	/27	2025-04-19 19:09:43.341	2025-04-19 19:09:43.341	2025-04-19 19:09:43.341	1	1	\N
294	tcjminbc0qbot8xqfwy1op2o	vc4_006_2_1.jpg	\N	\N	1000	1000	{"small": {"ext": ".jpg", "url": "/uploads/small_vc4_006_2_1_2debfb49df.jpg", "hash": "small_vc4_006_2_1_2debfb49df", "mime": "image/jpeg", "name": "small_vc4_006_2_1.jpg", "path": null, "size": 19.55, "width": 500, "height": 500, "sizeInBytes": 19554}, "medium": {"ext": ".jpg", "url": "/uploads/medium_vc4_006_2_1_2debfb49df.jpg", "hash": "medium_vc4_006_2_1_2debfb49df", "mime": "image/jpeg", "name": "medium_vc4_006_2_1.jpg", "path": null, "size": 35.79, "width": 750, "height": 750, "sizeInBytes": 35792}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_vc4_006_2_1_2debfb49df.jpg", "hash": "thumbnail_vc4_006_2_1_2debfb49df", "mime": "image/jpeg", "name": "thumbnail_vc4_006_2_1.jpg", "path": null, "size": 3.54, "width": 156, "height": 156, "sizeInBytes": 3535}}	vc4_006_2_1_2debfb49df	.jpg	image/jpeg	56.62	/uploads/vc4_006_2_1_2debfb49df.jpg	\N	local	\N	/27	2025-04-19 19:10:24.921	2025-04-19 19:10:24.921	2025-04-19 19:10:24.921	1	1	\N
295	cacxfejxbsz9w3z7p8grlndx	prusa.jpg	\N	\N	1118	1119	{"large": {"ext": ".jpg", "url": "/uploads/large_prusa_ba34cae5ad.jpg", "hash": "large_prusa_ba34cae5ad", "mime": "image/jpeg", "name": "large_prusa.jpg", "path": null, "size": 90.27, "width": 999, "height": 1000, "sizeInBytes": 90274}, "small": {"ext": ".jpg", "url": "/uploads/small_prusa_ba34cae5ad.jpg", "hash": "small_prusa_ba34cae5ad", "mime": "image/jpeg", "name": "small_prusa.jpg", "path": null, "size": 27.51, "width": 500, "height": 500, "sizeInBytes": 27510}, "medium": {"ext": ".jpg", "url": "/uploads/medium_prusa_ba34cae5ad.jpg", "hash": "medium_prusa_ba34cae5ad", "mime": "image/jpeg", "name": "medium_prusa.jpg", "path": null, "size": 54.51, "width": 749, "height": 750, "sizeInBytes": 54510}, "thumbnail": {"ext": ".jpg", "url": "/uploads/thumbnail_prusa_ba34cae5ad.jpg", "hash": "thumbnail_prusa_ba34cae5ad", "mime": "image/jpeg", "name": "thumbnail_prusa.jpg", "path": null, "size": 4.39, "width": 156, "height": 156, "sizeInBytes": 4394}}	prusa_ba34cae5ad	.jpg	image/jpeg	108.05	/uploads/prusa_ba34cae5ad.jpg	\N	local	\N	/27	2025-04-24 18:46:32.18	2025-04-24 18:46:32.18	2025-04-24 18:46:32.18	1	1	\N
\.


--
-- Data for Name: files_folder_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.files_folder_lnk (id, file_id, folder_id, file_ord) FROM stdin;
1	1	1	1
2	2	1	2
3	3	1	3
4	4	1	4
5	5	1	5
6	6	1	6
7	7	1	7
8	8	1	8
9	9	1	9
10	10	1	10
11	11	1	11
12	12	1	12
13	13	1	13
14	14	1	14
15	15	1	15
16	16	1	16
17	17	1	17
18	18	1	18
19	19	1	19
20	20	1	20
21	21	1	21
22	22	1	22
23	23	1	23
24	24	3	1
25	25	3	2
26	26	3	3
27	27	3	3
28	28	3	4
29	29	4	1
30	30	4	2
31	31	4	2
32	32	4	3
33	33	4	4
34	34	4	5
35	35	5	1
36	36	5	1
37	37	5	2
38	38	5	3
39	39	6	1
40	40	6	1
41	41	6	2
42	42	7	1
43	43	7	2
44	44	7	3
45	45	7	4
46	46	7	5
47	47	7	6
48	48	7	6
49	49	7	7
50	50	7	8
51	51	7	9
52	52	7	10
53	53	7	11
54	54	7	11
55	55	7	11
56	56	7	12
57	57	8	1
58	58	8	2
59	59	8	3
60	60	8	4
61	61	4	6
62	62	4	7
63	64	4	8
64	63	4	8
65	65	4	9
66	66	4	10
67	67	9	1
68	68	9	2
69	69	9	3
70	70	9	4
71	71	9	5
72	72	3	5
73	73	3	6
74	74	3	7
75	75	10	1
76	76	10	1
77	77	10	1
78	78	10	2
79	80	11	1
80	79	11	1
81	81	2	1
82	82	12	1
83	83	12	2
84	84	12	3
85	85	12	4
86	87	13	1
87	86	13	1
88	88	13	2
89	89	13	3
90	90	13	4
91	91	14	1
92	92	14	1
93	93	14	2
94	95	14	3
95	94	14	3
96	96	14	4
97	97	14	5
98	98	14	5
99	99	14	5
100	101	9	6
101	100	9	6
102	102	9	7
103	103	9	8
104	104	9	9
105	105	9	9
106	106	9	10
107	107	15	1
108	108	15	2
109	109	15	3
110	110	7	13
111	111	7	14
112	112	7	15
113	113	7	15
114	114	7	16
115	115	7	17
116	116	4	11
117	117	4	12
118	118	4	13
119	119	4	14
120	120	48	1
121	121	48	2
122	122	48	3
123	123	48	4
124	124	48	5
125	125	49	1
126	126	49	1
127	127	49	2
128	128	50	1
129	129	50	1
130	130	50	2
131	131	50	3
132	132	50	4
133	133	15	4
134	134	15	5
135	135	15	6
136	136	7	18
137	137	7	18
138	138	7	19
139	139	7	20
140	140	7	21
141	141	7	22
142	142	7	23
143	143	4	15
144	144	4	16
145	145	4	16
146	146	4	16
147	147	4	16
148	148	4	17
149	149	4	18
150	151	9	11
151	150	9	11
152	152	9	12
153	153	9	13
154	154	15	7
155	155	15	7
156	156	15	8
157	157	15	9
158	158	15	10
159	159	7	24
160	160	7	25
161	161	7	25
162	162	7	26
163	163	7	27
164	166	48	6
165	167	48	6
166	164	48	6
167	165	48	6
168	168	48	7
169	169	48	8
170	170	4	19
171	171	4	19
172	172	4	19
173	173	51	1
174	175	51	1
175	174	51	1
176	176	51	2
177	177	51	3
178	178	51	3
179	179	52	1
180	181	52	2
181	180	52	2
182	182	52	3
183	183	52	4
184	184	52	5
185	185	52	6
186	186	53	1
187	187	53	2
188	188	53	3
189	189	53	4
190	190	53	5
191	191	53	6
192	192	53	7
193	193	53	8
194	194	52	7
195	195	52	7
196	196	52	8
197	197	52	9
198	198	2	2
199	199	54	1
200	200	54	1
201	201	52	10
202	202	52	11
203	203	51	4
204	205	51	5
205	204	51	5
206	206	51	6
207	207	51	7
208	209	52	12
209	208	52	12
210	210	52	12
211	211	53	9
212	212	53	10
213	213	53	11
214	214	2	3
215	215	2	4
216	216	2	5
217	217	2	6
218	218	2	6
219	219	55	1
220	220	55	1
221	221	55	2
222	222	55	3
223	223	55	4
224	224	55	4
225	225	55	5
226	226	55	6
227	227	55	7
228	228	55	7
229	230	55	8
230	229	55	8
231	231	55	9
232	233	55	10
233	232	55	10
234	234	55	11
235	235	55	12
236	237	55	12
237	236	55	12
238	238	55	13
239	239	55	13
240	240	55	14
241	241	55	15
242	242	55	16
243	243	55	17
244	244	55	18
245	245	55	19
246	246	55	20
247	247	55	21
248	248	55	21
249	249	4	20
250	250	4	20
251	251	4	21
252	252	9	14
253	253	8	5
254	254	8	5
255	255	7	28
256	256	7	29
257	258	56	1
258	257	56	1
259	259	3	8
260	260	3	8
261	262	8	6
262	261	8	6
263	263	56	2
264	264	56	3
265	265	56	4
266	266	56	5
267	267	56	6
268	268	7	30
269	269	7	30
270	270	7	31
271	271	7	32
272	272	7	33
273	273	7	33
274	274	7	34
275	275	7	35
276	276	7	36
277	277	7	37
278	278	57	1
279	279	57	2
280	282	57	2
281	281	57	2
282	280	57	2
283	283	57	2
284	284	57	3
286	285	57	4
287	286	58	1
288	287	58	2
289	288	58	3
290	289	58	4
292	290	59	1
293	291	59	2
294	292	59	3
295	293	59	4
296	294	59	5
297	295	59	6
\.


--
-- Data for Name: files_related_mph; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.files_related_mph (id, file_id, related_id, related_type, field, "order") FROM stdin;
1	1	1	api::brand.brand	mainimage	1
2	1	17	api::brand.brand	mainimage	1
3	2	3	api::brand.brand	mainimage	1
4	2	18	api::brand.brand	mainimage	1
5	3	7	api::brand.brand	mainimage	1
6	3	19	api::brand.brand	mainimage	1
7	4	9	api::brand.brand	mainimage	1
8	4	20	api::brand.brand	mainimage	1
9	5	5	api::brand.brand	mainimage	1
10	5	21	api::brand.brand	mainimage	1
11	6	11	api::brand.brand	mainimage	1
12	6	22	api::brand.brand	mainimage	1
13	7	13	api::brand.brand	mainimage	1
14	7	23	api::brand.brand	mainimage	1
15	8	15	api::brand.brand	mainimage	1
16	8	24	api::brand.brand	mainimage	1
17	9	25	api::brand.brand	mainimage	1
18	9	26	api::brand.brand	mainimage	1
19	10	27	api::brand.brand	mainimage	1
20	10	28	api::brand.brand	mainimage	1
21	11	29	api::brand.brand	mainimage	1
22	11	30	api::brand.brand	mainimage	1
23	12	31	api::brand.brand	mainimage	1
24	12	32	api::brand.brand	mainimage	1
25	13	33	api::brand.brand	mainimage	1
26	13	34	api::brand.brand	mainimage	1
27	14	35	api::brand.brand	mainimage	1
28	14	36	api::brand.brand	mainimage	1
29	15	37	api::brand.brand	mainimage	1
30	15	38	api::brand.brand	mainimage	1
31	16	39	api::brand.brand	mainimage	1
32	16	40	api::brand.brand	mainimage	1
33	17	41	api::brand.brand	mainimage	1
34	17	42	api::brand.brand	mainimage	1
35	18	43	api::brand.brand	mainimage	1
36	18	44	api::brand.brand	mainimage	1
37	19	45	api::brand.brand	mainimage	1
38	19	46	api::brand.brand	mainimage	1
39	20	47	api::brand.brand	mainimage	1
40	20	48	api::brand.brand	mainimage	1
41	21	49	api::brand.brand	mainimage	1
42	21	50	api::brand.brand	mainimage	1
43	22	51	api::brand.brand	mainimage	1
44	22	52	api::brand.brand	mainimage	1
45	23	53	api::brand.brand	mainimage	1
46	23	54	api::brand.brand	mainimage	1
1689	272	335	api::product.product	images	1
1690	273	335	api::product.product	images	2
2374	50	486	api::product.product	images	1
2375	51	486	api::product.product	images	2
2376	52	486	api::product.product	images	3
2377	53	486	api::product.product	images	4
2378	54	486	api::product.product	images	5
979	223	94	api::product.product	images	1
980	224	94	api::product.product	images	2
981	223	191	api::product.product	images	1
982	224	191	api::product.product	images	2
993	133	48	api::product.product	images	1
994	134	48	api::product.product	images	2
995	135	48	api::product.product	images	3
996	133	193	api::product.product	images	1
997	134	193	api::product.product	images	2
998	135	193	api::product.product	images	3
1019	72	19	api::product.product	images	1
1020	73	19	api::product.product	images	2
1371	57	270	api::product.product	images	1
1372	58	270	api::product.product	images	2
1373	59	270	api::product.product	images	3
1374	60	270	api::product.product	images	4
1021	74	19	api::product.product	images	3
1022	72	198	api::product.product	images	1
1023	73	198	api::product.product	images	2
1024	74	198	api::product.product	images	3
1025	24	1	api::product.product	images	1
803	245	111	api::product.product	images	1
804	246	111	api::product.product	images	2
805	247	111	api::product.product	images	3
806	248	111	api::product.product	images	4
807	245	170	api::product.product	images	1
808	246	170	api::product.product	images	2
809	247	170	api::product.product	images	3
810	248	170	api::product.product	images	4
887	190	72	api::product.product	images	1
888	191	72	api::product.product	images	2
889	192	72	api::product.product	images	3
890	193	72	api::product.product	images	4
891	190	179	api::product.product	images	1
892	191	179	api::product.product	images	2
893	192	179	api::product.product	images	3
894	193	179	api::product.product	images	4
951	120	42	api::product.product	images	1
952	121	42	api::product.product	images	2
953	122	42	api::product.product	images	3
954	123	42	api::product.product	images	4
955	124	42	api::product.product	images	5
956	120	187	api::product.product	images	1
957	121	187	api::product.product	images	2
958	122	187	api::product.product	images	3
959	123	187	api::product.product	images	4
960	124	187	api::product.product	images	5
1507	35	299	api::product.product	images	1
1508	36	299	api::product.product	images	2
1509	37	299	api::product.product	images	3
1510	38	299	api::product.product	images	4
811	101	33	api::product.product	images	1
2379	55	486	api::product.product	images	6
2380	56	486	api::product.product	images	7
1705	264	358	api::product.product	images	1
1706	265	358	api::product.product	images	2
157	79	23	api::product.product	images	1
158	80	23	api::product.product	images	2
159	79	24	api::product.product	images	1
160	80	24	api::product.product	images	2
171	87	29	api::product.product	images	1
172	86	29	api::product.product	images	2
173	88	29	api::product.product	images	3
174	89	29	api::product.product	images	4
175	90	29	api::product.product	images	5
176	87	30	api::product.product	images	1
177	86	30	api::product.product	images	2
178	88	30	api::product.product	images	3
179	89	30	api::product.product	images	4
180	90	30	api::product.product	images	5
983	155	56	api::product.product	images	1
984	154	56	api::product.product	images	2
985	156	56	api::product.product	images	3
986	157	56	api::product.product	images	4
987	158	56	api::product.product	images	5
988	155	192	api::product.product	images	1
989	154	192	api::product.product	images	2
990	156	192	api::product.product	images	3
991	157	192	api::product.product	images	4
992	158	192	api::product.product	images	5
999	107	35	api::product.product	images	1
1000	108	35	api::product.product	images	2
1001	109	35	api::product.product	images	3
1002	107	194	api::product.product	images	1
1003	108	194	api::product.product	images	2
1004	109	194	api::product.product	images	3
1047	274	139	api::product.product	images	1
1048	275	139	api::product.product	images	2
1049	274	202	api::product.product	images	1
1050	275	202	api::product.product	images	2
1055	272	137	api::product.product	images	1
1056	273	137	api::product.product	images	2
1109	128	46	api::product.product	images	1
1110	129	46	api::product.product	images	2
1111	130	46	api::product.product	images	3
1112	131	46	api::product.product	images	4
1113	132	46	api::product.product	images	5
1114	128	213	api::product.product	images	1
1115	129	213	api::product.product	images	2
1116	130	213	api::product.product	images	3
812	100	33	api::product.product	images	2
813	102	33	api::product.product	images	3
814	103	33	api::product.product	images	4
815	104	33	api::product.product	images	5
816	105	33	api::product.product	images	6
817	106	33	api::product.product	images	7
818	101	171	api::product.product	images	1
819	100	171	api::product.product	images	2
820	102	171	api::product.product	images	3
821	103	171	api::product.product	images	4
822	104	171	api::product.product	images	5
823	105	171	api::product.product	images	6
824	106	171	api::product.product	images	7
895	240	107	api::product.product	images	1
896	241	107	api::product.product	images	2
897	240	180	api::product.product	images	1
898	241	180	api::product.product	images	2
961	170	62	api::product.product	images	1
962	172	62	api::product.product	images	2
963	171	62	api::product.product	images	3
1117	131	213	api::product.product	images	4
1118	132	213	api::product.product	images	5
964	170	188	api::product.product	images	1
965	172	188	api::product.product	images	2
966	171	188	api::product.product	images	3
1005	173	64	api::product.product	images	1
1006	175	64	api::product.product	images	2
1007	174	64	api::product.product	images	3
1008	176	64	api::product.product	images	4
1009	173	195	api::product.product	images	1
1010	175	195	api::product.product	images	2
2387	29	488	api::product.product	images	1
2388	30	488	api::product.product	images	2
2389	31	488	api::product.product	images	3
2390	32	488	api::product.product	images	4
2391	33	488	api::product.product	images	5
2392	34	488	api::product.product	images	6
825	67	17	api::product.product	images	1
826	68	17	api::product.product	images	2
827	69	17	api::product.product	images	3
828	70	17	api::product.product	images	4
829	71	17	api::product.product	images	5
917	207	84	api::product.product	images	1
918	207	182	api::product.product	images	1
967	177	66	api::product.product	images	1
968	178	66	api::product.product	images	2
969	177	189	api::product.product	images	1
970	178	189	api::product.product	images	2
1011	174	195	api::product.product	images	3
1012	176	195	api::product.product	images	4
1051	270	135	api::product.product	images	1
1052	271	135	api::product.product	images	2
1053	270	203	api::product.product	images	1
1054	271	203	api::product.product	images	2
1075	186	70	api::product.product	images	1
1076	187	70	api::product.product	images	2
1077	188	70	api::product.product	images	3
1078	189	70	api::product.product	images	4
1079	186	207	api::product.product	images	1
1080	187	207	api::product.product	images	2
1081	188	207	api::product.product	images	3
1082	189	207	api::product.product	images	4
1119	295	11	api::image-general.image-general	nameGeneralImage	1
1120	295	12	api::image-general.image-general	nameGeneralImage	1
327	166	60	api::product.product	images	1
328	167	60	api::product.product	images	2
329	165	60	api::product.product	images	3
330	164	60	api::product.product	images	4
331	168	60	api::product.product	images	5
332	169	60	api::product.product	images	6
333	166	61	api::product.product	images	1
334	167	61	api::product.product	images	2
335	165	61	api::product.product	images	3
336	164	61	api::product.product	images	4
337	168	61	api::product.product	images	5
338	169	61	api::product.product	images	6
1013	230	98	api::product.product	images	1
1014	229	98	api::product.product	images	2
1015	230	196	api::product.product	images	1
1016	229	196	api::product.product	images	2
1059	211	88	api::product.product	images	1
1185	201	225	api::product.product	images	1
1186	202	225	api::product.product	images	2
1060	212	88	api::product.product	images	2
1061	213	88	api::product.product	images	3
1062	211	205	api::product.product	images	1
1063	212	205	api::product.product	images	2
1064	213	205	api::product.product	images	3
2401	42	490	api::product.product	images	1
2402	43	490	api::product.product	images	2
1939	24	424	api::product.product	images	1
1792	233	395	api::product.product	images	1
1793	232	395	api::product.product	images	2
1794	234	395	api::product.product	images	3
1940	25	424	api::product.product	images	2
1941	26	424	api::product.product	images	3
1942	27	424	api::product.product	images	4
835	150	54	api::product.product	images	1
836	151	54	api::product.product	images	2
1943	28	424	api::product.product	images	5
2403	44	490	api::product.product	images	3
2404	45	490	api::product.product	images	4
2405	46	490	api::product.product	images	5
2406	47	490	api::product.product	images	6
2407	48	490	api::product.product	images	7
2408	49	490	api::product.product	images	8
2449	159	499	api::product.product	images	1
837	152	54	api::product.product	images	3
838	153	54	api::product.product	images	4
839	150	173	api::product.product	images	1
840	151	173	api::product.product	images	2
841	152	173	api::product.product	images	3
842	153	173	api::product.product	images	4
919	214	90	api::product.product	images	1
920	215	90	api::product.product	images	2
2450	160	499	api::product.product	images	2
2451	161	499	api::product.product	images	3
2452	162	499	api::product.product	images	4
2453	163	499	api::product.product	images	5
921	216	90	api::product.product	images	3
922	217	90	api::product.product	images	4
923	218	90	api::product.product	images	5
843	29	3	api::product.product	images	1
844	30	3	api::product.product	images	2
845	31	3	api::product.product	images	3
846	32	3	api::product.product	images	4
847	33	3	api::product.product	images	5
848	34	3	api::product.product	images	6
1017	231	100	api::product.product	images	1
1018	231	197	api::product.product	images	1
1083	201	80	api::product.product	images	1
1084	202	80	api::product.product	images	2
929	233	103	api::product.product	images	1
930	232	103	api::product.product	images	2
931	234	103	api::product.product	images	3
2454	214	504	api::product.product	images	1
2455	215	504	api::product.product	images	2
2456	216	504	api::product.product	images	3
971	219	92	api::product.product	images	1
972	220	92	api::product.product	images	2
973	221	92	api::product.product	images	3
974	222	92	api::product.product	images	4
975	219	190	api::product.product	images	1
976	220	190	api::product.product	images	2
977	221	190	api::product.product	images	3
978	222	190	api::product.product	images	4
2457	217	504	api::product.product	images	4
2458	218	504	api::product.product	images	5
1466	257	289	api::product.product	images	1
1467	258	289	api::product.product	images	2
1670	136	329	api::product.product	images	1
1671	137	329	api::product.product	images	2
1672	138	329	api::product.product	images	3
1673	139	329	api::product.product	images	4
1674	140	329	api::product.product	images	5
1675	141	329	api::product.product	images	6
553	276	141	api::product.product	images	1
554	277	141	api::product.product	images	2
555	276	142	api::product.product	images	1
556	277	142	api::product.product	images	2
557	278	9	api::category.category	mainimage	1
558	278	14	api::category.category	mainimage	1
559	282	5	api::category.category	mainimage	1
560	282	15	api::category.category	mainimage	1
561	281	1	api::category.category	mainimage	1
562	281	16	api::category.category	mainimage	1
563	283	3	api::category.category	mainimage	1
564	283	17	api::category.category	mainimage	1
565	280	7	api::category.category	mainimage	1
566	280	18	api::category.category	mainimage	1
567	285	12	api::category.category	mainimage	1
568	285	19	api::category.category	mainimage	1
569	286	1	api::shipping-type.shipping-type	mediaShippingType	1
570	286	10	api::shipping-type.shipping-type	mediaShippingType	1
571	287	3	api::shipping-type.shipping-type	mediaShippingType	1
572	287	11	api::shipping-type.shipping-type	mediaShippingType	1
573	288	5	api::shipping-type.shipping-type	mediaShippingType	1
574	288	12	api::shipping-type.shipping-type	mediaShippingType	1
575	289	7	api::shipping-type.shipping-type	mediaShippingType	1
576	289	13	api::shipping-type.shipping-type	mediaShippingType	1
577	290	1	api::image-general.image-general	nameGeneralImage	1
578	290	2	api::image-general.image-general	nameGeneralImage	1
579	291	3	api::image-general.image-general	nameGeneralImage	1
580	291	4	api::image-general.image-general	nameGeneralImage	1
581	292	5	api::image-general.image-general	nameGeneralImage	1
582	292	6	api::image-general.image-general	nameGeneralImage	1
583	293	7	api::image-general.image-general	nameGeneralImage	1
584	293	8	api::image-general.image-general	nameGeneralImage	1
1676	142	329	api::product.product	images	7
585	294	9	api::image-general.image-general	nameGeneralImage	1
586	294	10	api::image-general.image-general	nameGeneralImage	1
1026	25	1	api::product.product	images	2
1027	26	1	api::product.product	images	3
1028	27	1	api::product.product	images	4
1029	28	1	api::product.product	images	5
1087	81	25	api::product.product	images	1
1088	81	209	api::product.product	images	1
1105	199	78	api::product.product	images	1
1106	200	78	api::product.product	images	2
1107	199	212	api::product.product	images	1
1108	200	212	api::product.product	images	2
2429	67	495	api::product.product	images	1
2430	68	495	api::product.product	images	2
2431	69	495	api::product.product	images	3
2432	70	495	api::product.product	images	4
2433	71	495	api::product.product	images	5
657	110	37	api::product.product	images	1
658	111	37	api::product.product	images	2
659	112	37	api::product.product	images	3
660	113	37	api::product.product	images	4
661	114	37	api::product.product	images	5
662	115	37	api::product.product	images	6
663	110	149	api::product.product	images	1
664	111	149	api::product.product	images	2
665	112	149	api::product.product	images	3
666	113	149	api::product.product	images	4
667	114	149	api::product.product	images	5
668	115	149	api::product.product	images	6
669	136	50	api::product.product	images	1
670	137	50	api::product.product	images	2
671	138	50	api::product.product	images	3
672	139	50	api::product.product	images	4
673	140	50	api::product.product	images	5
674	141	50	api::product.product	images	6
675	142	50	api::product.product	images	7
683	50	11	api::product.product	images	1
684	51	11	api::product.product	images	2
685	52	11	api::product.product	images	3
686	53	11	api::product.product	images	4
687	54	11	api::product.product	images	5
688	55	11	api::product.product	images	6
689	56	11	api::product.product	images	7
697	159	58	api::product.product	images	1
698	160	58	api::product.product	images	2
699	161	58	api::product.product	images	3
700	162	58	api::product.product	images	4
701	163	58	api::product.product	images	5
715	259	123	api::product.product	images	1
716	260	123	api::product.product	images	2
717	259	154	api::product.product	images	1
718	260	154	api::product.product	images	2
719	264	129	api::product.product	images	1
720	265	129	api::product.product	images	2
723	255	119	api::product.product	images	1
724	256	119	api::product.product	images	2
725	255	156	api::product.product	images	1
726	256	156	api::product.product	images	2
727	263	127	api::product.product	images	1
728	263	157	api::product.product	images	1
729	257	121	api::product.product	images	1
730	258	121	api::product.product	images	2
733	249	113	api::product.product	images	1
734	250	113	api::product.product	images	2
735	251	113	api::product.product	images	3
736	249	159	api::product.product	images	1
737	250	159	api::product.product	images	2
738	251	159	api::product.product	images	3
741	253	117	api::product.product	images	1
742	254	117	api::product.product	images	2
743	253	161	api::product.product	images	1
744	254	161	api::product.product	images	2
855	125	44	api::product.product	images	1
856	126	44	api::product.product	images	2
857	127	44	api::product.product	images	3
858	125	175	api::product.product	images	1
859	126	175	api::product.product	images	2
860	127	175	api::product.product	images	3
861	179	68	api::product.product	images	1
862	181	68	api::product.product	images	2
863	180	68	api::product.product	images	3
864	182	68	api::product.product	images	4
865	183	68	api::product.product	images	5
866	184	68	api::product.product	images	6
867	185	68	api::product.product	images	7
868	179	176	api::product.product	images	1
869	181	176	api::product.product	images	2
870	180	176	api::product.product	images	3
871	182	176	api::product.product	images	4
872	183	176	api::product.product	images	5
873	184	176	api::product.product	images	6
874	185	176	api::product.product	images	7
875	209	86	api::product.product	images	1
876	210	86	api::product.product	images	2
877	208	86	api::product.product	images	3
878	209	177	api::product.product	images	1
879	210	177	api::product.product	images	2
880	208	177	api::product.product	images	3
899	92	31	api::product.product	images	1
900	91	31	api::product.product	images	2
901	93	31	api::product.product	images	3
902	95	31	api::product.product	images	4
903	94	31	api::product.product	images	5
904	96	31	api::product.product	images	6
905	97	31	api::product.product	images	7
906	98	31	api::product.product	images	8
907	99	31	api::product.product	images	9
908	92	181	api::product.product	images	1
909	91	181	api::product.product	images	2
910	93	181	api::product.product	images	3
911	95	181	api::product.product	images	4
912	94	181	api::product.product	images	5
913	96	181	api::product.product	images	6
914	97	181	api::product.product	images	7
915	98	181	api::product.product	images	8
916	99	181	api::product.product	images	9
935	225	96	api::product.product	images	1
936	226	96	api::product.product	images	2
937	227	96	api::product.product	images	3
938	228	96	api::product.product	images	4
939	225	185	api::product.product	images	1
940	226	185	api::product.product	images	2
941	227	185	api::product.product	images	3
942	228	185	api::product.product	images	4
1035	75	21	api::product.product	images	1
1036	76	21	api::product.product	images	2
1037	77	21	api::product.product	images	3
1038	78	21	api::product.product	images	4
1039	75	200	api::product.product	images	1
1040	76	200	api::product.product	images	2
1041	77	200	api::product.product	images	3
1042	78	200	api::product.product	images	4
1089	82	27	api::product.product	images	1
1090	83	27	api::product.product	images	2
1091	84	27	api::product.product	images	3
1092	85	27	api::product.product	images	4
1093	82	210	api::product.product	images	1
1094	83	210	api::product.product	images	2
1095	84	210	api::product.product	images	3
1096	85	210	api::product.product	images	4
1267	57	13	api::product.product	images	1
1268	58	13	api::product.product	images	2
1269	59	13	api::product.product	images	3
1270	60	13	api::product.product	images	4
739	252	115	api::product.product	images	1
740	252	160	api::product.product	images	1
745	262	125	api::product.product	images	1
746	261	125	api::product.product	images	2
747	262	162	api::product.product	images	1
748	261	162	api::product.product	images	2
749	266	131	api::product.product	images	1
750	267	131	api::product.product	images	2
751	266	163	api::product.product	images	1
752	267	163	api::product.product	images	2
753	198	76	api::product.product	images	1
754	198	164	api::product.product	images	1
755	203	82	api::product.product	images	1
756	205	82	api::product.product	images	2
757	204	82	api::product.product	images	3
758	206	82	api::product.product	images	4
759	203	165	api::product.product	images	1
760	205	165	api::product.product	images	2
761	204	165	api::product.product	images	3
762	206	165	api::product.product	images	4
763	61	15	api::product.product	images	1
764	62	15	api::product.product	images	2
765	64	15	api::product.product	images	3
766	63	15	api::product.product	images	4
767	65	15	api::product.product	images	5
768	66	15	api::product.product	images	6
769	61	166	api::product.product	images	1
770	62	166	api::product.product	images	2
771	64	166	api::product.product	images	3
772	63	166	api::product.product	images	4
773	65	166	api::product.product	images	5
774	66	166	api::product.product	images	6
775	116	39	api::product.product	images	1
776	117	39	api::product.product	images	2
777	118	39	api::product.product	images	3
778	119	39	api::product.product	images	4
779	116	167	api::product.product	images	1
780	117	167	api::product.product	images	2
781	118	167	api::product.product	images	3
782	119	167	api::product.product	images	4
783	143	52	api::product.product	images	1
784	144	52	api::product.product	images	2
785	146	52	api::product.product	images	3
786	145	52	api::product.product	images	4
787	147	52	api::product.product	images	5
788	148	52	api::product.product	images	6
789	149	52	api::product.product	images	7
790	143	168	api::product.product	images	1
791	144	168	api::product.product	images	2
792	146	168	api::product.product	images	3
793	145	168	api::product.product	images	4
794	147	168	api::product.product	images	5
795	148	168	api::product.product	images	6
796	149	168	api::product.product	images	7
797	242	109	api::product.product	images	1
798	243	109	api::product.product	images	2
799	244	109	api::product.product	images	3
800	242	169	api::product.product	images	1
801	243	169	api::product.product	images	2
802	244	169	api::product.product	images	3
881	39	7	api::product.product	images	1
882	40	7	api::product.product	images	2
883	41	7	api::product.product	images	3
943	194	74	api::product.product	images	1
944	195	74	api::product.product	images	2
945	196	74	api::product.product	images	3
946	197	74	api::product.product	images	4
947	194	186	api::product.product	images	1
948	195	186	api::product.product	images	2
949	196	186	api::product.product	images	3
950	197	186	api::product.product	images	4
1043	268	133	api::product.product	images	1
1044	269	133	api::product.product	images	2
1045	268	201	api::product.product	images	1
1046	269	201	api::product.product	images	2
1065	235	105	api::product.product	images	1
1066	237	105	api::product.product	images	2
1067	236	105	api::product.product	images	3
1068	238	105	api::product.product	images	4
1069	239	105	api::product.product	images	5
1070	235	206	api::product.product	images	1
1071	237	206	api::product.product	images	2
1072	236	206	api::product.product	images	3
1073	238	206	api::product.product	images	4
1074	239	206	api::product.product	images	5
1097	35	5	api::product.product	images	1
1098	36	5	api::product.product	images	2
1099	37	5	api::product.product	images	3
1100	38	5	api::product.product	images	4
1781	39	392	api::product.product	images	1
1121	42	9	api::product.product	images	1
1122	43	9	api::product.product	images	2
1123	44	9	api::product.product	images	3
1124	45	9	api::product.product	images	4
1125	46	9	api::product.product	images	5
1126	47	9	api::product.product	images	6
1127	48	9	api::product.product	images	7
1128	49	9	api::product.product	images	8
1782	40	392	api::product.product	images	2
1783	41	392	api::product.product	images	3
\.


--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.i18n_locale (id, document_id, name, code, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	eev2r0zq9qumplx0wcmajnpc	English (en)	en	2025-04-14 19:18:04.312	2025-04-14 19:18:04.312	2025-04-14 19:18:04.313	\N	\N	\N
\.


--
-- Data for Name: image_generals; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.image_generals (id, document_id, image_general_name, slug, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, text_general, links) FROM stdin;
1	q58o6tryvfhp8rnp25mmdxxw	image1	image1	2025-04-19 19:07:34.848	2025-04-19 19:07:34.848	\N	1	1	\N	[{"type": "paragraph", "children": [{"text": "Tu tienda de impresoras 3D", "type": "text"}]}]	\N
2	q58o6tryvfhp8rnp25mmdxxw	image1	image1	2025-04-19 19:07:34.848	2025-04-19 19:07:34.848	2025-04-19 19:07:34.861	1	1	\N	[{"type": "paragraph", "children": [{"text": "Tu tienda de impresoras 3D", "type": "text"}]}]	\N
3	pozovydytf5cfuevsm9p9gjq	image2	image2	2025-04-19 19:08:28.9	2025-04-19 19:08:28.9	\N	1	1	\N	[{"type": "paragraph", "children": [{"text": "Todo tipo de Accesorios para tu impresora 3D", "type": "text"}]}]	\N
4	pozovydytf5cfuevsm9p9gjq	image2	image2	2025-04-19 19:08:28.9	2025-04-19 19:08:28.9	2025-04-19 19:08:28.913	1	1	\N	[{"type": "paragraph", "children": [{"text": "Todo tipo de Accesorios para tu impresora 3D", "type": "text"}]}]	\N
5	pf4ikfifn6h0wbfowagsahur	image3	image3	2025-04-19 19:09:13.906	2025-04-19 19:09:13.906	\N	1	1	\N	[{"type": "paragraph", "children": [{"text": "Todo tipo de Impresoras", "type": "text"}]}]	\N
6	pf4ikfifn6h0wbfowagsahur	image3	image3	2025-04-19 19:09:13.906	2025-04-19 19:09:13.906	2025-04-19 19:09:13.922	1	1	\N	[{"type": "paragraph", "children": [{"text": "Todo tipo de Impresoras", "type": "text"}]}]	\N
7	vkfl4rew3ap1as7xe5a5hsyp	image4	image4	2025-04-19 19:09:46.095	2025-04-19 19:09:46.095	\N	1	1	\N	\N	\N
8	vkfl4rew3ap1as7xe5a5hsyp	image4	image4	2025-04-19 19:09:46.095	2025-04-19 19:09:46.095	2025-04-19 19:09:46.105	1	1	\N	\N	\N
9	xpe3ulf7dfjkffu7vhxc888y	image5	image5	2025-04-19 19:11:04.419	2025-04-19 19:11:04.419	\N	1	1	\N	[{"type": "paragraph", "children": [{"text": "Todo tipo de Filamento y Resinas", "type": "text"}]}]	\N
10	xpe3ulf7dfjkffu7vhxc888y	image5	image5	2025-04-19 19:11:04.419	2025-04-19 19:11:04.419	2025-04-19 19:11:04.429	1	1	\N	[{"type": "paragraph", "children": [{"text": "Todo tipo de Filamento y Resinas", "type": "text"}]}]	\N
11	v7jxg0d092odq5gfne8p728f	image6	image6	2025-04-24 18:46:35.462	2025-04-24 18:46:35.462	\N	1	1	\N	\N	\N
12	v7jxg0d092odq5gfne8p728f	image6	image6	2025-04-24 18:46:35.462	2025-04-24 18:46:35.462	2025-04-24 18:46:35.473	1	1	\N	\N	\N
\.


--
-- Data for Name: product_ratings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.product_ratings (id, document_id, rating, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
10	mc2lwupcpl4pepm936xuhhfg	5	2025-04-26 21:19:47.36	2025-04-26 21:19:47.36	\N	\N	\N	\N
11	mc2lwupcpl4pepm936xuhhfg	5	2025-04-26 21:19:47.36	2025-04-26 21:19:47.36	2025-04-26 21:19:47.375	\N	\N	\N
12	mjtugqr6xm2cacmsj1gi5j17	4	2025-04-27 12:37:39.01	2025-04-27 12:37:39.01	\N	\N	\N	\N
13	mjtugqr6xm2cacmsj1gi5j17	4	2025-04-27 12:37:39.01	2025-04-27 12:37:39.01	2025-04-27 12:37:39.018	\N	\N	\N
14	o2ezc8bequv5q8cgj4fg5y8v	5	2025-04-27 12:52:18.924	2025-04-27 12:52:18.924	\N	\N	\N	\N
15	o2ezc8bequv5q8cgj4fg5y8v	5	2025-04-27 12:52:18.924	2025-04-27 12:52:18.924	2025-04-27 12:52:18.935	\N	\N	\N
16	s8pgw1ebx6uzdg8lvte34txg	5	2025-04-27 18:18:49.161	2025-04-27 18:18:49.161	\N	\N	\N	\N
17	s8pgw1ebx6uzdg8lvte34txg	5	2025-04-27 18:18:49.161	2025-04-27 18:18:49.161	2025-04-27 18:18:49.171	\N	\N	\N
18	oigkzp91o1z5gmgrnjpeg1bi	5	2025-04-27 18:21:30.196	2025-04-27 18:21:30.196	\N	\N	\N	\N
19	oigkzp91o1z5gmgrnjpeg1bi	5	2025-04-27 18:21:30.196	2025-04-27 18:21:30.196	2025-04-27 18:21:30.209	\N	\N	\N
20	wdyizoqgvgvesd5d1elwlxxv	4	2025-04-27 18:22:26.149	2025-04-27 18:22:26.149	\N	\N	\N	\N
21	wdyizoqgvgvesd5d1elwlxxv	4	2025-04-27 18:22:26.149	2025-04-27 18:22:26.149	2025-04-27 18:22:26.157	\N	\N	\N
22	k3cotuhmjgbzli2476q2wbob	4	2025-04-27 18:22:34.523	2025-04-27 18:22:34.523	\N	\N	\N	\N
23	k3cotuhmjgbzli2476q2wbob	4	2025-04-27 18:22:34.523	2025-04-27 18:22:34.523	2025-04-27 18:22:34.529	\N	\N	\N
24	lvwh1vmipgzox1qdy40b0nau	5	2025-04-27 18:24:07.992	2025-04-27 18:24:07.992	\N	\N	\N	\N
25	lvwh1vmipgzox1qdy40b0nau	5	2025-04-27 18:24:07.992	2025-04-27 18:24:07.992	2025-04-27 18:24:07.998	\N	\N	\N
26	t4rz18p2ib9ckzfsb82tqshb	4	2025-04-27 18:24:58.83	2025-04-27 18:24:58.83	\N	\N	\N	\N
27	t4rz18p2ib9ckzfsb82tqshb	4	2025-04-27 18:24:58.83	2025-04-27 18:24:58.83	2025-04-27 18:24:58.838	\N	\N	\N
28	co5jafimv7m5t2emdb81l6d6	4	2025-04-27 18:25:05.385	2025-04-27 18:25:05.385	\N	\N	\N	\N
29	co5jafimv7m5t2emdb81l6d6	4	2025-04-27 18:25:05.385	2025-04-27 18:25:05.385	2025-04-27 18:25:05.39	\N	\N	\N
30	djcv6150i23tyrwkmy5rxq3s	4	2025-04-27 18:27:15.874	2025-04-27 18:27:15.874	\N	\N	\N	\N
31	djcv6150i23tyrwkmy5rxq3s	4	2025-04-27 18:27:15.874	2025-04-27 18:27:15.874	2025-04-27 18:27:15.881	\N	\N	\N
32	msknwzv6vyq0nabmm0ety5o7	4	2025-04-27 18:29:17.275	2025-04-27 18:29:17.275	\N	\N	\N	\N
33	msknwzv6vyq0nabmm0ety5o7	4	2025-04-27 18:29:17.275	2025-04-27 18:29:17.275	2025-04-27 18:29:17.283	\N	\N	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products (id, document_id, product_name, slug, description, active, price, is_featured, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, weight, dimensions, date_manufactured, remainin_warranty, state, city_name, province_name, country_name, direction_name, latitud, longitud, average_rating, total_ratings, views, create_by, owner_id) FROM stdin;
25	tc58t9w31z4yy7woiie3vq1m	Two Trees Blu	two-trees-blu	Impresora 3D Two Trees Blu de alta velocidad	t	299.99	\N	2025-04-15 21:19:44.02	2025-04-23 21:26:32.935	\N	1	1	\N	10.00	30x30x30	2024-04-01	12 meses	Seminuevo	Albacete	Albacete	España	Calle Mayor 1212	38.986545	-1.863517	\N	\N	\N	\N	\N
495	sj59677asb34lqxb7dksoero	Elegoo Neptune 3 Pro	elegoo-neptune-3-pro	Impresora 3D Elegoo Neptune 3 Pro con pantalla táctil	t	349.99	t	2025-04-15 20:58:03.776	2025-05-01 21:57:01.846	2025-05-01 21:57:01.867	1	1	\N	8.50	35x35x30	2022-04-07	Sin Garantia	Seminuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	\N	\N	6	\N	\N
27	t20pjkmj1tr7xe3pvfuotgn0	Sovol SV04	sovol-sv-04	Impresora 3D Sovol SV04 con estructura metálica	t	249.99	\N	2025-04-15 21:24:02.723	2025-04-23 21:26:45.875	\N	1	1	\N	8.50	30x30x35	2022-04-06	Sin Garantia	Seminuevo	Palma de Mallorca	Palma de Mallorca	España	Calle Jaime III 1313	39.5696	2.65016	\N	\N	\N	\N	\N
3	yn64s1gjh4zeztx7n3q2fuep	Ender 3 V2 Seminueva	ender-3-v2-seminueva	Impresora 3D Ender 3 V2 en perfecto estado	t	249.99	t	2025-04-15 20:24:04.384	2025-05-01 21:42:01.124	\N	1	1	\N	7.80	45x45x35	2023-01-02	12 meses	Seminuevo	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	8	\N	\N
7	oy6b14o2kiqvh9j8nc7tb7mh	Form 3+ Profesional	form-3-profesional	Impresora 3D Form 3+ de resina	t	3499.99	t	2025-04-15 20:33:22.676	2025-05-01 18:22:39.104	\N	1	1	\N	17.50	60x60x45	2022-04-06	Sin Garantia	Seminuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	\N	\N	9	\N	\N
524	c522t3yqwwnxi0h6z4b8ivk4	prueba dd	prueba-dd	t23ty234t	t	2000.00	f	2025-05-03 20:22:13.392	2025-05-03 20:31:39.646	2025-05-03 20:31:39.662	\N	\N	\N	0.00		\N	\N	Nuevo			España		\N	\N	\N	\N	0	\N	3
23	hb0jw6xs8tzgcykmjiq491o6	Artillery Genius	artillery-genius	Impresora 3D Artillery Genius con cama calefactada	t	249.99	\N	2025-04-15 21:10:54.071	2025-04-15 21:10:54.071	\N	1	1	\N	9.00	30x30x35	2022-04-17	Sin Garantia	Seminuevo	Las Palmas	Las Palmas	España	Calle Triana 1111	28.123546	-15.436257	\N	\N	\N	\N	\N
24	hb0jw6xs8tzgcykmjiq491o6	Artillery Genius	artillery-genius	Impresora 3D Artillery Genius con cama calefactada	t	249.99	\N	2025-04-15 21:10:54.071	2025-04-15 21:10:54.071	2025-04-15 21:10:54.1	1	1	\N	9.00	30x30x35	2022-04-17	Sin Garantia	Seminuevo	Las Palmas	Las Palmas	España	Calle Triana 1111	28.123546	-15.436257	\N	\N	\N	\N	\N
5	q3dqna1hds38k35dixvphaia	Ultimaker S5 Pro	ultimaker-s5-pro	Impresora 3D Ultimaker S5 profesional	t	5999.99	t	2025-04-15 20:28:49.714	2025-04-27 18:29:10.626	\N	1	1	\N	20.50	70x70x50	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	4.00	1	23	\N	\N
29	m13d9g822adhxw2quyulqb7c	FLSUN QQ-S Pro	flsun-qq-s-pro	Impresora 3D FLSUN QQ-S Pro con impresión delta	t	399.99	\N	2025-04-15 21:29:13.321	2025-04-15 21:29:13.321	\N	1	1	\N	10.00	25x25x30	2024-04-01	6 meses	Nuevo Precintado	Bilbao	Bilbao	España	Calle Licenciado Poza 1515	43.262706	-2.925281	\N	\N	\N	\N	\N
30	m13d9g822adhxw2quyulqb7c	FLSUN QQ-S Pro	flsun-qq-s-pro	Impresora 3D FLSUN QQ-S Pro con impresión delta	t	399.99	\N	2025-04-15 21:29:13.321	2025-04-15 21:29:13.321	2025-04-15 21:29:13.355	1	1	\N	10.00	25x25x30	2024-04-01	6 meses	Nuevo Precintado	Bilbao	Bilbao	España	Calle Licenciado Poza 1515	43.262706	-2.925281	\N	\N	\N	\N	\N
15	yd1mldnahwlv23n93oaym0gq	Creality CR-10 Smart Pro	creality-cr-10-smart-pro	Impresora 3D Creality CR-10 Smart Pro con funciones inteligentes	t	549.99	\N	2025-04-15 20:52:55.253	2025-04-23 21:12:15.912	\N	1	1	\N	10.50	40x40x45	2024-02-13	6 meses	Seminuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
1	oodgs988cb2lekulqngpx2d8	Prusa i3 MK3S+ Nueva	prusa-i3-mk-3-s-nueva	Impresora 3D Prusa i3 MK3S+ nueva sin usar	t	799.99	t	2025-04-15 20:17:24.247	2025-05-01 19:25:58.375	\N	1	1	\N	8.50	50x50x40	2024-04-01	24 meses	Seminuevo	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	6	\N	\N
17	sj59677asb34lqxb7dksoero	Elegoo Neptune 3 Pro	elegoo-neptune-3-pro	Impresora 3D Elegoo Neptune 3 Pro con pantalla táctil	t	349.99	t	2025-04-15 20:58:03.776	2025-05-01 21:57:01.846	\N	1	1	\N	8.50	35x35x30	2022-04-07	Sin Garantia	Seminuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	\N	\N	6	\N	\N
31	ut17mxlcgw21wtu004mke273	Kingroon KP3S Pro	kingroon-kp-3-s-pro	Impresora 3D Kingroon KP3S Pro con diseño modular	t	299.99	\N	2025-04-15 21:33:56.157	2025-04-23 21:17:17.74	\N	1	1	\N	8.50	30x30x35	2023-01-02	12 meses	Seminuevo	Valencia	Valencia	España	Calle Paz 1717	39.462258	-0.376953	\N	\N	\N	\N	\N
19	o2jm4dl77udoyf5m50bdnb6y	Prusa Mini+	prusa-mini	Impresora 3D compacta Prusa Mini+	t	399.99	\N	2025-04-15 21:02:37.937	2025-04-23 21:22:30.443	\N	1	1	\N	6.50	20x20x20	2024-04-01	24 meses	Nuevo Precintado	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
21	heo4lbb3xhkmual1l8rhadt7	Qidi Tech X-Plus	qidi-tech-x-plus	Impresora 3D Qidi Tech X-Plus con doble extrusor	t	699.99	\N	2025-04-15 21:06:45.881	2025-04-23 21:23:01.688	\N	1	1	\N	15.00	35x35x35	2023-01-13	Sin Garantia	Seminuevo	Oviedo	Oviedo	España	Calle Uría 909	43.361914	-5.849389	\N	\N	\N	\N	\N
13	to82yuctzvpsq25kwgzcwpl2	Bambu Lab X1 Carbon	bambu-lab-x1-carbon	Impresora 3D Bambu Lab X1 Carbon de alta velocidad	t	799.99	t	2025-04-15 20:48:13.646	2025-04-27 13:58:07.336	\N	1	1	\N	12.00	30x30x35	2024-04-01	12 meses	Seminuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	37	\N	\N
209	tc58t9w31z4yy7woiie3vq1m	Two Trees Blu	two-trees-blu	Impresora 3D Two Trees Blu de alta velocidad	t	299.99	\N	2025-04-15 21:19:44.02	2025-04-23 21:26:32.935	2025-04-23 21:26:32.954	1	1	\N	10.00	30x30x30	2024-04-01	12 meses	Seminuevo	Albacete	Albacete	España	Calle Mayor 1212	38.986545	-1.863517	\N	\N	\N	\N	\N
212	m16kw5ej6sfi67al6f97psgz	Ventilador 40x40x10mm	ventilador-40x40x10mm	Ventilador 40x40x10mm para impresoras 3D	t	29.99	\N	2025-04-16 21:28:11.108	2025-04-23 21:27:16.647	2025-04-23 21:27:16.662	1	1	\N	0.50	10x10x2	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	\N	\N	\N	\N	\N
46	xvovw402sxjyir3r239evgiq	Voxelab Proxima 6.0	voxelab-proxima-6-0	Impresora 3D de resina Voxelab Proxima 6.0	t	249.99	\N	2025-04-15 22:21:35.037	2025-04-23 21:27:40.598	\N	1	1	\N	6.40	20x20x20	2024-04-01	12 meses	Seminuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	\N	\N	\N
523	lik1gex8bfp3kx6zzpmjoh4p	prueba	prueba	t23ty234t	t	2000.00	f	2025-05-03 19:50:45.155	2025-05-03 20:30:45.559	2025-05-03 20:30:45.576	\N	\N	\N	0.00		\N	\N	Nuevo			España		\N	\N	\N	\N	0	\N	3
50	ng0o3sc0a6b14tw2p5rq177l	Anycubic Photon Mono SE	anycubic-photon-mono-se	Impresora 3D de resina Anycubic Photon Mono SE	t	299.99	\N	2025-04-16 19:17:32.213	2025-04-27 19:16:36.769	\N	1	1	\N	6.50	20x20x20	2024-04-01	12 meses	Seminuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	\N	\N	4	\N	\N
60	jzaphmiisctpwo3uuq2j2p5b	Nova3D Bene6 Mono	nova3-d-bene6-mono	Impresora 3D de resina Nova3D Bene6 Mono	t	349.99	\N	2025-04-16 19:44:20.545	2025-04-16 19:44:20.545	\N	1	1	\N	7.80	25x25x30	2022-04-06	12 meses	Seminuevo	Las Palmas	Las Palmas	España	Calle Triana 1111	28.123546	-15.436257	\N	\N	\N	\N	\N
61	jzaphmiisctpwo3uuq2j2p5b	Nova3D Bene6 Mono	nova3-d-bene6-mono	Impresora 3D de resina Nova3D Bene6 Mono	t	349.99	\N	2025-04-16 19:44:20.545	2025-04-16 19:44:20.545	2025-04-16 19:44:20.58	1	1	\N	7.80	25x25x30	2022-04-06	12 meses	Seminuevo	Las Palmas	Las Palmas	España	Calle Triana 1111	28.123546	-15.436257	\N	\N	\N	\N	\N
39	rcp3yfzafwbljr8gezd5k8ka	Creality Halot-One	creality-halot-one	Impresora 3D de resina Creality Halot-One	t	199.99	\N	2025-04-15 22:06:17.492	2025-04-23 21:12:35.592	\N	1	1	\N	5.50	20x20x20	2023-01-02	6 meses	Seminuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	\N	\N	\N	\N	\N
52	j4j4jbbiriwjnjn8poflst8r	Creality LD-002R	creality-ld-002-r	Impresora 3D de resina Creality LD-002R	t	99.99	\N	2025-04-16 19:22:34.617	2025-04-23 21:12:55.998	\N	1	1	\N	5.50	20x20x20	2023-01-02	6 meses	Seminuevo	Santiago de Compostela	Santiago de Compostela	España	Rúa do Franco 707	42.878213	-8.544844	\N	\N	\N	\N	\N
33	qqcvjn7w8dhgbcs1uvs4nbua	Elegoo Mars 3	elegoo-mars-3	Impresora 3D de resina Elegoo Mars 3 con alta precisión	t	299.99	\N	2025-04-15 21:38:32.345	2025-04-23 21:13:42.838	\N	1	1	\N	7.80	25x25x30	2025-04-03	24 meses	Nuevo Precintado	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	\N	\N	\N
54	xl3zwgvhwkau8po3q5n1byzg	Elegoo Saturn 2	elegoo-saturn-2	Impresora 3D de resina Elegoo Saturn 2	t	499.99	\N	2025-04-16 19:28:28.18	2025-04-23 21:14:14.824	\N	1	1	\N	7.80	30x30x35	2022-04-06	Sin Garantia	Seminuevo	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
44	c1oenb0xnwmwjrm35itwr597	Epax E6 Mono	epax-e6-mono	Impresora 3D de resina Epax E6 Mono	t	499.99	\N	2025-04-15 22:16:16.503	2025-04-23 21:14:59.184	\N	1	1	\N	8.50	25x25x30	2022-04-06	Sin Garantia	Seminuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	\N	\N	\N
42	c4v6ox4e2ay1urfoumsstcuu	Nova3D Bene4 Mono	nova3-d-bene4-mono	Impresora 3D de resina Nova3D Bene4 Mono	t	249.99	\N	2025-04-15 22:11:58.135	2025-04-23 21:19:16.26	\N	1	1	\N	6.20	20x20x20	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	\N	\N	\N	\N	\N
56	g1qd0zyd7j8nv1bjnqghwswq	Phrozen Sonic Mega 8K	phrozen-sonic-mega-8-k	Impresora 3D de resina Phrozen Sonic Mega 8K	t	899.99	\N	2025-04-16 19:32:54.873	2025-04-23 21:20:49.352	\N	1	1	\N	10.00	35x35x40	2024-04-01	12 meses	Seminuevo	Oviedo	Oviedo	España	Calle Uría 909	43.361914	-5.849389	\N	\N	\N	\N	\N
48	y4clvedcwp6cwtjs0w5baoki	Phrozen Sonic Mighty 4K	phrozen-sonic-mighty-4-k	Impresora 3D de resina Phrozen Sonic Mighty 4K	t	249.99	\N	2025-04-16 19:01:36.15	2025-04-23 21:21:06.442	\N	1	1	\N	10.00	30x30x35	2025-04-02	24 meses	Nuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
35	sxw3cqnv1p9dz5kn1q3u33ki	Phrozen Sonic Mini 4K	phrozen-sonic-mini-4-k	Impresora 3D de resina Phrozen Sonic Mini 4K	t	349.99	\N	2025-04-15 21:57:19.726	2025-04-23 21:21:23.673	\N	1	1	\N	6.50	20x20x20	2025-04-05	24 meses	Nuevo Precintado	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	\N	\N	\N
210	t20pjkmj1tr7xe3pvfuotgn0	Sovol SV04	sovol-sv-04	Impresora 3D Sovol SV04 con estructura metálica	t	249.99	\N	2025-04-15 21:24:02.723	2025-04-23 21:26:45.875	2025-04-23 21:26:45.892	1	1	\N	8.50	30x30x35	2022-04-06	Sin Garantia	Seminuevo	Palma de Mallorca	Palma de Mallorca	España	Calle Jaime III 1313	39.5696	2.65016	\N	\N	\N	\N	\N
78	m16kw5ej6sfi67al6f97psgz	Ventilador 40x40x10mm	ventilador-40x40x10mm	Ventilador 40x40x10mm para impresoras 3D	t	29.99	\N	2025-04-16 21:28:11.108	2025-04-23 21:27:16.647	\N	1	1	\N	0.50	10x10x2	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	\N	\N	\N	\N	\N
329	ng0o3sc0a6b14tw2p5rq177l	Anycubic Photon Mono SE	anycubic-photon-mono-se	Impresora 3D de resina Anycubic Photon Mono SE	t	299.99	\N	2025-04-16 19:17:32.213	2025-04-27 19:16:36.769	2025-04-27 19:16:36.784	1	1	\N	6.50	20x20x20	2024-04-01	12 meses	Seminuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	\N	\N	4	\N	\N
395	mnwrql80g2drj1ndwfz5kr96	Kit de tornillería para perfiles	kit-de-tornilleria-para-perfiles	Kit de tornillería para perfiles de aluminio	t	29.99	\N	2025-04-16 22:18:10.344	2025-05-01 18:32:39.664	2025-05-01 18:32:39.674	1	1	\N	5.50	5x5x5	2024-04-01	24 meses	Nuevo	Albacete	Albacete	España	Calle Mayor 1212	38.986545	-1.863517	\N	\N	1	\N	\N
80	rlufa1rgrejsahm23ebc7abu	Termistor 100K	termistor-100-k	Termistor 100K para impresoras 3D	t	19.99	\N	2025-04-16 21:31:03.782	2025-04-27 13:00:22.388	\N	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	4.50	2	15	\N	\N
82	spd8m8iu1ozvhst4m8ymcjkt	Cama magnética PEI	cama-magnetica-pei	Cama magnética PEI para impresoras 3D	t	29.99	\N	2025-04-16 21:43:52.09	2025-04-23 21:11:55.643	\N	1	1	\N	0.40	20x20x2	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	\N	\N	\N	\N	\N
68	lh93qhvtqbkt2iorazkgsrgs	Extrusor BMG Clone	extrusor-bmg-clone	Extrusor BMG Clone para impresoras 3D	t	29.99	\N	2025-04-16 21:05:16.22	2025-04-23 21:15:18.735	\N	1	1	\N	0.40	10x10x2	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Licenciado Poza 1515	43.262706	-2.925281	\N	\N	\N	\N	\N
86	q5nflzh5x14t3f4wt9o3otrt	Extrusor directo Hemera	extrusor-directo-hemera	Extrusor directo Hemera para impresoras 3D	t	99.99	\N	2025-04-16 21:51:21.541	2025-04-23 21:15:39.149	\N	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	\N	\N	\N
72	xcwyn1hus070qfq0alarvgb4	Fuente de alimentación 24V 15A	fuente-de-alimentacion-24-v-15-a	Fuente de alimentación 24V 15A para impresoras 3D	t	49.99	\N	2025-04-16 21:15:05.661	2025-04-23 21:16:36.64	\N	1	1	\N	1.00	10x10x2	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Paz 1717	39.462258	-0.376953	\N	\N	\N	\N	\N
84	eazmnhlkfrwe40zuxv2yuxct	Kit de cables para impresoras 3D	kit-de-cables-para-impresoras-3-d	Kit de cables para impresoras 3D	t	19.99	\N	2025-04-16 21:46:41.404	2025-04-23 21:17:42.719	\N	1	1	\N	0.40	10x10x2	2025-04-02	24 meses	Nuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	\N	\N	\N
74	hvmu2rtjuhzo3ttqrxpfvy1x	Motor paso a paso NEMA 17	motor-paso-a-paso-nema-17	Motor paso a paso NEMA 17 para impresoras 3D	t	29.99	\N	2025-04-16 21:22:04.667	2025-04-23 21:18:59.436	\N	1	1	\N	0.40	10x10x10	2025-04-02	24 meses	Nuevo	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	\N	\N	\N
62	ue868twewfhbu3yb6qtel60o	Nozzle de 0.4mm para Ender 3	nozzle-de-0-4mm-para-ender-3	Nozzle de repuesto de 0.4mm para impresoras Ender 3	t	9.99	\N	2025-04-16 19:48:20.824	2025-04-23 21:19:35.385	\N	1	1	\N	0.01	1x1x1	2025-04-02	24 meses	Nuevo	Albacete	Albacete	España	Calle Mayor 1212	38.986545	-1.863517	\N	\N	\N	\N	\N
66	g7fuoe486a94glppbmwuphkh	Pantalla táctil TFT35 E3	pantalla-tactil-tft-35-e3	Pantalla táctil TFT35 E3 para impresoras 3D	t	39.99	\N	2025-04-16 21:00:36.13	2025-04-23 21:19:51.57	\N	1	1	\N	0.30	10x10x2	2025-04-02	24 meses	Nuevo Precintado	Vigo	Vigo	España	Calle Progreso 1414	42.231356	-8.712447	\N	\N	\N	\N	\N
64	bf0yldcnyjjh5j3i5r89a99v	Placa base SKR Mini E3 V3	placa-base-skr-mini-e3-v3	Placa base SKR Mini E3 V3 para impresoras 3D	t	49.99	\N	2025-04-16 20:57:13.597	2025-04-23 21:21:47.753	\N	1	1	\N	0.20	10x10x2	2025-04-02	24 meses	Nuevo Precintado	Palma de Mallorca	Palma de Mallorca	España	Calle Jaime III 1313	39.5696	2.65016	\N	\N	\N	\N	\N
88	ktv23hp5aaa1b343i5r006w3	Sensor de filamento	sensor-de-filamento	Sensor de filamento para impresoras 3D	t	29.99	\N	2025-04-16 21:54:03.144	2025-04-23 21:24:28.799	\N	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
70	qidhd0gpt6pizg6cx20gsjgy	Sensor de nivelación BLTouch	sensor-de-nivelacion-bl-touch	Sensor de nivelación BLTouch para impresoras 3D	t	34.99	\N	2025-04-16 21:11:48.902	2025-04-23 21:24:59.213	\N	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Sevilla	Sevilla	España	Calle Sierpes 1616	37.38264	-5.996295	\N	\N	\N	\N	\N
213	xvovw402sxjyir3r239evgiq	Voxelab Proxima 6.0	voxelab-proxima-6-0	Impresora 3D de resina Voxelab Proxima 6.0	t	249.99	\N	2025-04-15 22:21:35.037	2025-04-23 21:27:40.598	2025-04-23 21:27:40.615	1	1	\N	6.40	20x20x20	2024-04-01	12 meses	Seminuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	\N	\N	\N
351	dtqpbjtfslcjxo9jbtdzs0b2	Impresora de prueba final	impresora-de-prueba-final	Esta es una prueba final sin el campo createBy	t	299.99	f	2025-04-29 20:36:48.52	2025-04-29 21:23:36.529	\N	\N	\N	\N	0.00		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N
103	mnwrql80g2drj1ndwfz5kr96	Kit de tornillería para perfiles	kit-de-tornilleria-para-perfiles	Kit de tornillería para perfiles de aluminio	t	29.99	\N	2025-04-16 22:18:10.344	2025-05-01 18:32:39.664	\N	1	1	\N	5.50	5x5x5	2024-04-01	24 meses	Nuevo	Albacete	Albacete	España	Calle Mayor 1212	38.986545	-1.863517	\N	\N	1	\N	\N
115	vjgtbnt06vrn1n22lau5ov71	Bobina filamanto PLA color	bobina-filamanto-pla-color	Bobina filamanto PLA color variado	t	29.99	\N	2025-04-17 10:59:09.737	2025-04-23 21:09:03.728	\N	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	\N	\N	\N
117	ecwi7vjayk28jnix7ibwiqkc	Bobina filamanto PTG	bobina-filamanto-ptg	Bobina filamanto PTG para impresoras	t	29.99	\N	2025-04-17 11:05:23.393	2025-04-23 21:09:24.156	\N	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	\N	\N	\N	\N	\N
109	q85j4slc5bplb4sqofoa0em0	Cubre perfiles 20x20	cubre-perfiles-20x20	Cubre perfiles de aluminio 20x20	t	9.99	\N	2025-04-16 22:29:23.825	2025-04-23 21:13:12.396	\N	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Licenciado Poza 1515	43.262706	-2.925281	\N	\N	\N	\N	\N
111	vudmtx0konmb031ewetr3e06	Cubre perfiles 40x40	cubre-perfiles-40x40	Cubre perfiles de aluminio 40x40	t	19.99	\N	2025-04-16 22:32:03.654	2025-04-23 21:13:27.764	\N	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Santander	Santander	España	Calle San Juan 1616	37.38264	-5.996295	\N	\N	\N	\N	\N
107	fzftlszyqi1oa41nu6rknq7p	Junta de goma para perfiles	junta-de-goma-para-perfiles	Junta de goma para perfiles de aluminio	t	29.99	\N	2025-04-16 22:26:11.448	2025-04-23 21:16:52.258	\N	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Vigo	Vigo	España	Calle Progreso 1414	42.231356	-8.712447	\N	\N	\N	\N	\N
96	b68q5lwslqmjvcfluj6sinhq	Kit de uniones para perfiles	kit-de-uniones-para-perfiles	Kit de uniones para perfiles de aluminio	t	29.99	\N	2025-04-16 22:08:09.628	2025-04-23 21:18:41.724	\N	1	1	\N	8.50	20x20x2	2025-04-02	24 meses	Nuevo	Oviedo	Oviedo	España	Calle Uría 909	43.361914	-5.849389	\N	\N	\N	\N	\N
92	f6w8s4dcgbxibogflilgywp4	Perfil de aluminio 20x20	perfil-de-aluminio-20x20	Perfil de aluminio 20x20 para estructuras de impresoras 3D	t	14.99	\N	2025-04-16 22:01:41.619	2025-04-23 21:20:13.033	\N	1	1	\N	7.80	100x2x2	2025-04-02	24 meses	Nuevo	Santiago de Compostela	Santiago de Compostela	España	Rúa do Franco 707	42.878213	-8.544844	\N	\N	\N	\N	\N
94	wl3scnbusnjashe0j8qh6rdb	Perfil de aluminio 40x40	perfil-de-aluminio-40x40	Perfil de aluminio 40x40 para estructuras de impresoras 3D	t	29.99	\N	2025-04-16 22:05:10.632	2025-04-23 21:20:33.46	\N	1	1	\N	0.40	100x2x2	2025-04-02	24 meses	Nuevo	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
98	ac25edb9xil9lovz3jfwh1lt	Placa base para perfil 20x20	placa-base-para-perfil-20x20	Placa base para perfil de aluminio 20x20	t	19.99	\N	2025-04-16 22:11:44.497	2025-04-23 21:22:01.977	\N	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Cádiz	Cádiz	España	Calle Ancha 1010	36.529781	-6.292657	\N	\N	\N	\N	\N
100	rpa768ug8q83vha469m76we4	Placa base para perfil 40x40	placa-base-para-perfil-40x40	Placa base para perfil de aluminio 40x40	t	29.99	\N	2025-04-16 22:14:36.143	2025-04-23 21:22:13.787	\N	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Las Palmas	Las Palmas	España	Calle Triana 1111	28.123546	-15.436257	\N	\N	\N	\N	\N
105	f5om3kms72w835mm6gk88you	Soporte angular para perfiles	soporte-angular-para-perfiles	Soporte angular para perfiles de aluminio	t	29.99	\N	2025-04-16 22:22:52.573	2025-04-23 21:24:43.052	\N	1	1	\N	5.50	5x5x5	2023-01-02	24 meses	Nuevo	Palma de Mallorca	Palma de Mallorca	España	Calle Jaime III 1313	39.5696	2.65016	\N	\N	\N	\N	\N
137	fafwisrkf8g6o51kup5n7kgd	Resina para impresoras 3D verde	resina-para-impresoras-3-d-verde	Resina para impresoras 3D verde	t	29.99	\N	2025-04-17 11:46:44.33	2025-04-27 19:24:32.765	\N	1	1	\N	6.50	10x10x5	2025-04-02	24 meses	Nuevo	Barcelona	Barcelona	España	Avenida Diagonal 142	41.385063	2.173404	\N	\N	3	\N	\N
121	mjr06pz89x7yz3lp4r0j0mjk	Bobina filamanto PETG color	bobina-filamanto-ptg-color	Bobina de filamento PETG para impresoras 3D	t	29.99	\N	2025-04-17 11:12:35.243	2025-04-27 18:20:12.246	\N	1	1	\N	5.50	10x10x5	2024-04-01	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	\N	\N	2	\N	\N
129	hmlm9qh69dbtzmu7gv97m39i	Bobina Filamento Tecnico	bobina-filamento-tecnico	Bobina de filamento tecnico para impreoras 3D	t	29.99	f	2025-04-17 11:30:40.035	2025-04-29 20:54:46.799	\N	1	1	\N	0.00		2025-04-02	24 meses	Nuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	4.00	1	6	\N	\N
141	w0j0zu7b86cis1ksonpkcmsx	Resina para impresoras 3D dental	resina-para-impresoras-3-d-dental	Resina para impresoras 3D para uso dental	t	29.99	\N	2025-04-17 11:51:40.285	2025-04-17 11:51:40.285	\N	1	1	\N	6.50	10x10x5	2025-04-02	24 meses	Nuevo	Sevilla	Sevilla	España	Calle Mateos Gago 8	37.389091	-5.984459	\N	\N	\N	\N	\N
142	w0j0zu7b86cis1ksonpkcmsx	Resina para impresoras 3D dental	resina-para-impresoras-3-d-dental	Resina para impresoras 3D para uso dental	t	29.99	\N	2025-04-17 11:51:40.285	2025-04-17 11:51:40.285	2025-04-17 11:51:40.317	1	1	\N	6.50	10x10x5	2025-04-02	24 meses	Nuevo	Sevilla	Sevilla	España	Calle Mateos Gago 8	37.389091	-5.984459	\N	\N	\N	\N	\N
58	wbbmy79cr4t6l6rtivaph4f0	Anycubic Photon Mono X 6K	anycubic-photon-mono-x-6-k	Impresora 3D de resina Anycubic Photon Mono X 6K	t	599.99	t	2025-04-16 19:37:09.791	2025-05-01 22:12:33.976	\N	1	1	\N	7.80	25x25x30	2023-01-02	6 meses	Seminuevo	Cádiz	Cádiz	España	Calle Ancha 1010	36.529781	-6.292657	\N	\N	14	\N	\N
123	np96for89kz534v9wa30kwgb	Bobina Filamento PC 	bobina-filamento-pc	Bobina de PC para impresoras 3D	t	29.99	\N	2025-04-17 11:15:48.104	2025-04-23 21:06:47.919	\N	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	\N	\N	\N
119	gwnufsjobcxgg10pvh5413et	Bobina filamanto ASA	bobina-filamanto-asa	Bobina filamento ASA para impresora 3d	t	29.99	\N	2025-04-17 11:08:17.39	2025-04-23 21:07:09.477	\N	1	1	\N	0.40	10x10x5	2024-04-01	24 meses	Nuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	\N	\N	\N	\N	\N
127	nip0j5ij18adqwtrtbe6xe0u	Bobina filamanto ASA color	bobina-filamanto-asa-color	Bobina de filamento ASA en color para impresoras 3D	t	29.99	\N	2025-04-17 11:25:09.164	2025-04-23 21:08:13.647	\N	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
125	ha25n2ys7vk15m3cutvyhxld	Bobina filamanto para soportes	bobina-filamanto-para-soportes	Bobina de filamento para soportes de pla y petg	t	29.99	\N	2025-04-17 11:19:57.523	2025-04-23 21:10:57.3	\N	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	\N	\N	\N
131	zz3fhrvlw2yyikgcaaa7tfwl	Bobina filamanto tecnico color	bobina-filamanto-tecnico-color	Bobina filamento tecnico color para impresora 3D	t	29.99	\N	2025-04-17 11:34:08.237	2025-04-23 21:11:12.449	\N	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Santiago de Compostela	Santiago de Compostela	España	Rúa do Franco 707	42.878213	-8.544844	\N	\N	\N	\N	\N
133	cgstyn7kf9jxwb4qwa9hdmle	Resina para impresoras 3D	resina-para-impresoras-3-d	Resina para impresoras 3D	t	29.99	\N	2025-04-17 11:38:43.142	2025-04-23 21:23:23.258	\N	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
139	m3bgw6j6x0s4ydcn0ocb47hd	Resina para impresoras 3D color carne	resina-para-impresoras-3-d-color-carne	Resina para impresoras 3D color carne	t	29.99	\N	2025-04-17 11:48:20.007	2025-04-23 21:23:38.465	\N	1	1	\N	6.50	10x10x5	2025-04-02	24 meses	Nuevo	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
135	s8qlhnj4kxz3hoburl09qv4c	Resina para impresoras 3D transparente	resina-para-impresoras-3-d-transparente	Resina para impresoras 3D transparente	t	29.99	\N	2025-04-17 11:44:08.698	2025-04-23 21:23:58.067	\N	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Madrid	Madrid	España	Calle San Miguel 23	40.416775	-3.70379	\N	\N	\N	\N	\N
335	fafwisrkf8g6o51kup5n7kgd	Resina para impresoras 3D verde	resina-para-impresoras-3-d-verde	Resina para impresoras 3D verde	t	29.99	\N	2025-04-17 11:46:44.33	2025-04-27 19:24:32.765	2025-04-27 19:24:32.787	1	1	\N	6.50	10x10x5	2025-04-02	24 meses	Nuevo	Barcelona	Barcelona	España	Avenida Diagonal 142	41.385063	2.173404	\N	\N	3	\N	\N
37	g1dfmafhy45ce7wamfgvk6l6	Anycubic Photon Mono 4K	anycubic-photon-mono-4-k	Impresora 3D de resina Anycubic Photon Mono 4K	t	279.99	\N	2025-04-15 22:01:26.236	2025-04-23 21:05:23.702	\N	1	1	\N	6.00	20x20x20	2023-01-02	Sin Garantia	Seminuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	\N	\N	\N	\N	\N
149	g1dfmafhy45ce7wamfgvk6l6	Anycubic Photon Mono 4K	anycubic-photon-mono-4-k	Impresora 3D de resina Anycubic Photon Mono 4K	t	279.99	\N	2025-04-15 22:01:26.236	2025-04-23 21:05:23.702	2025-04-23 21:05:23.721	1	1	\N	6.00	20x20x20	2023-01-02	Sin Garantia	Seminuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	\N	\N	\N	\N	\N
9	q4h4qhlwkm5xo49gvnnef5ws	Anycubic Kobra 2 Max	anycubic-kobra-2-max	Impresora 3D Anycubic Kobra 2 Max en excelente estado	t	399.99	t	2025-04-15 20:39:05.367	2025-05-01 21:44:41.949	\N	1	1	\N	9.20	45x45x40	2025-04-03	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	4.50	2	24	\N	\N
499	wbbmy79cr4t6l6rtivaph4f0	Anycubic Photon Mono X 6K	anycubic-photon-mono-x-6-k	Impresora 3D de resina Anycubic Photon Mono X 6K	t	599.99	t	2025-04-16 19:37:09.791	2025-05-01 22:12:33.976	2025-05-01 22:12:33.998	1	1	\N	7.80	25x25x30	2023-01-02	6 meses	Seminuevo	Cádiz	Cádiz	España	Calle Ancha 1010	36.529781	-6.292657	\N	\N	14	\N	\N
154	np96for89kz534v9wa30kwgb	Bobina Filamento PC 	bobina-filamento-pc	Bobina de PC para impresoras 3D	t	29.99	\N	2025-04-17 11:15:48.104	2025-04-23 21:06:47.919	2025-04-23 21:06:47.936	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	\N	\N	\N
156	gwnufsjobcxgg10pvh5413et	Bobina filamanto ASA	bobina-filamanto-asa	Bobina filamento ASA para impresora 3d	t	29.99	\N	2025-04-17 11:08:17.39	2025-04-23 21:07:09.477	2025-04-23 21:07:09.493	1	1	\N	0.40	10x10x5	2024-04-01	24 meses	Nuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	\N	\N	\N	\N	\N
157	nip0j5ij18adqwtrtbe6xe0u	Bobina filamanto ASA color	bobina-filamanto-asa-color	Bobina de filamento ASA en color para impresoras 3D	t	29.99	\N	2025-04-17 11:25:09.164	2025-04-23 21:08:13.647	2025-04-23 21:08:13.662	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
11	oge9xhtfdtb0selfez1cpmkr	Anycubic Photon Mono X	anycubic-photon-mono-x	Impresora 3D de resina Anycubic Photon Mono X	t	499.99	t	2025-04-15 20:44:08.546	2025-05-01 21:40:38.078	\N	1	1	\N	7.80	25x25x30	2023-01-02	Sin Garantia	Seminuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	35	\N	\N
113	e72jf9j4bkom2ye6zvod5xq7	Bobina filamanto PLA	bobina-filamanto-pla	Bobina de filamaneto PLA para impresoras 3d	t	19.99	\N	2025-04-17 10:55:39.695	2025-04-23 21:08:50.43	\N	1	1	\N	0.40	10x10x5	2024-04-01	24 meses	Nuevo	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	\N	\N	\N
159	e72jf9j4bkom2ye6zvod5xq7	Bobina filamanto PLA	bobina-filamanto-pla	Bobina de filamaneto PLA para impresoras 3d	t	19.99	\N	2025-04-17 10:55:39.695	2025-04-23 21:08:50.43	2025-04-23 21:08:50.448	1	1	\N	0.40	10x10x5	2024-04-01	24 meses	Nuevo	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	\N	\N	\N
160	vjgtbnt06vrn1n22lau5ov71	Bobina filamanto PLA color	bobina-filamanto-pla-color	Bobina filamanto PLA color variado	t	29.99	\N	2025-04-17 10:59:09.737	2025-04-23 21:09:03.728	2025-04-23 21:09:03.744	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	\N	\N	\N
161	ecwi7vjayk28jnix7ibwiqkc	Bobina filamanto PTG	bobina-filamanto-ptg	Bobina filamanto PTG para impresoras	t	29.99	\N	2025-04-17 11:05:23.393	2025-04-23 21:09:24.156	2025-04-23 21:09:24.173	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	\N	\N	\N	\N	\N
162	ha25n2ys7vk15m3cutvyhxld	Bobina filamanto para soportes	bobina-filamanto-para-soportes	Bobina de filamento para soportes de pla y petg	t	29.99	\N	2025-04-17 11:19:57.523	2025-04-23 21:10:57.3	2025-04-23 21:10:57.318	1	1	\N	0.40	10x10x5	2025-04-02	24 meses	Nuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	\N	\N	\N
163	zz3fhrvlw2yyikgcaaa7tfwl	Bobina filamanto tecnico color	bobina-filamanto-tecnico-color	Bobina filamento tecnico color para impresora 3D	t	29.99	\N	2025-04-17 11:34:08.237	2025-04-23 21:11:12.449	2025-04-23 21:11:12.465	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Santiago de Compostela	Santiago de Compostela	España	Rúa do Franco 707	42.878213	-8.544844	\N	\N	\N	\N	\N
76	vb7rj16rsl2dg1jqnygseirs	Cable de alimentación para impresoras 3D	cable-de-alimentacion-para-impresoras-3-d	Cable de alimentación para impresoras 3D	t	9.99	\N	2025-04-16 21:25:12.386	2025-04-23 21:11:37.893	\N	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	\N	\N	\N
164	vb7rj16rsl2dg1jqnygseirs	Cable de alimentación para impresoras 3D	cable-de-alimentacion-para-impresoras-3-d	Cable de alimentación para impresoras 3D	t	9.99	\N	2025-04-16 21:25:12.386	2025-04-23 21:11:37.893	2025-04-23 21:11:37.919	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	\N	\N	\N
165	spd8m8iu1ozvhst4m8ymcjkt	Cama magnética PEI	cama-magnetica-pei	Cama magnética PEI para impresoras 3D	t	29.99	\N	2025-04-16 21:43:52.09	2025-04-23 21:11:55.643	2025-04-23 21:11:55.661	1	1	\N	0.40	20x20x2	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	\N	\N	\N	\N	\N
173	xl3zwgvhwkau8po3q5n1byzg	Elegoo Saturn 2	elegoo-saturn-2	Impresora 3D de resina Elegoo Saturn 2	t	499.99	\N	2025-04-16 19:28:28.18	2025-04-23 21:14:14.824	2025-04-23 21:14:14.844	1	1	\N	7.80	30x30x35	2022-04-06	Sin Garantia	Seminuevo	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
166	yd1mldnahwlv23n93oaym0gq	Creality CR-10 Smart Pro	creality-cr-10-smart-pro	Impresora 3D Creality CR-10 Smart Pro con funciones inteligentes	t	549.99	\N	2025-04-15 20:52:55.253	2025-04-23 21:12:15.912	2025-04-23 21:12:15.94	1	1	\N	10.50	40x40x45	2024-02-13	6 meses	Seminuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
167	rcp3yfzafwbljr8gezd5k8ka	Creality Halot-One	creality-halot-one	Impresora 3D de resina Creality Halot-One	t	199.99	\N	2025-04-15 22:06:17.492	2025-04-23 21:12:35.592	2025-04-23 21:12:35.606	1	1	\N	5.50	20x20x20	2023-01-02	6 meses	Seminuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	\N	\N	\N	\N	\N
168	j4j4jbbiriwjnjn8poflst8r	Creality LD-002R	creality-ld-002-r	Impresora 3D de resina Creality LD-002R	t	99.99	\N	2025-04-16 19:22:34.617	2025-04-23 21:12:55.998	2025-04-23 21:12:56.015	1	1	\N	5.50	20x20x20	2023-01-02	6 meses	Seminuevo	Santiago de Compostela	Santiago de Compostela	España	Rúa do Franco 707	42.878213	-8.544844	\N	\N	\N	\N	\N
169	q85j4slc5bplb4sqofoa0em0	Cubre perfiles 20x20	cubre-perfiles-20x20	Cubre perfiles de aluminio 20x20	t	9.99	\N	2025-04-16 22:29:23.825	2025-04-23 21:13:12.396	2025-04-23 21:13:12.412	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Licenciado Poza 1515	43.262706	-2.925281	\N	\N	\N	\N	\N
358	hmlm9qh69dbtzmu7gv97m39i	Bobina Filamento Tecnico	bobina-filamento-tecnico	Bobina de filamento tecnico para impreoras 3D	t	29.99	f	2025-04-17 11:30:40.035	2025-04-29 20:54:46.799	2025-04-29 20:54:46.813	1	1	\N	0.00		2025-04-02	24 meses	Nuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	4.00	1	6	\N	\N
170	vudmtx0konmb031ewetr3e06	Cubre perfiles 40x40	cubre-perfiles-40x40	Cubre perfiles de aluminio 40x40	t	19.99	\N	2025-04-16 22:32:03.654	2025-04-23 21:13:27.764	2025-04-23 21:13:27.777	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Santander	Santander	España	Calle San Juan 1616	37.38264	-5.996295	\N	\N	\N	\N	\N
504	x750yufmey1bekoymdo0dhyx	Kit de reparación para impresoras 3D	kit-de-reparacion-para-impresoras-3-d	Kit de reparación para impresoras 3D	t	29.99	t	2025-04-16 21:57:54.317	2025-05-03 18:59:26.076	2025-05-03 18:59:26.107	1	1	\N	5.50	20x20x5	2025-04-02	24 meses	Nuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	\N	\N	17	\N	\N
171	qqcvjn7w8dhgbcs1uvs4nbua	Elegoo Mars 3	elegoo-mars-3	Impresora 3D de resina Elegoo Mars 3 con alta precisión	t	299.99	\N	2025-04-15 21:38:32.345	2025-04-23 21:13:42.838	2025-04-23 21:13:42.855	1	1	\N	7.80	25x25x30	2025-04-03	24 meses	Nuevo Precintado	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	\N	\N	\N
289	mjr06pz89x7yz3lp4r0j0mjk	Bobina filamanto PETG color	bobina-filamanto-ptg-color	Bobina de filamento PETG para impresoras 3D	t	29.99	\N	2025-04-17 11:12:35.243	2025-04-27 18:20:12.246	2025-04-27 18:20:12.259	1	1	\N	5.50	10x10x5	2024-04-01	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	\N	\N	2	\N	\N
505	he791r9cz0446lz816e25k4h	Test Product	test-product	Test Description	t	100.00	\N	2025-05-03 19:03:48.033	2025-05-03 19:03:48.033	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N
506	he791r9cz0446lz816e25k4h	Test Product	test-product	Test Description	t	100.00	\N	2025-05-03 19:03:48.033	2025-05-03 19:03:48.033	2025-05-03 19:03:48.048	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N
175	c1oenb0xnwmwjrm35itwr597	Epax E6 Mono	epax-e6-mono	Impresora 3D de resina Epax E6 Mono	t	499.99	\N	2025-04-15 22:16:16.503	2025-04-23 21:14:59.184	2025-04-23 21:14:59.2	1	1	\N	8.50	25x25x30	2022-04-06	Sin Garantia	Seminuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	\N	\N	\N
176	lh93qhvtqbkt2iorazkgsrgs	Extrusor BMG Clone	extrusor-bmg-clone	Extrusor BMG Clone para impresoras 3D	t	29.99	\N	2025-04-16 21:05:16.22	2025-04-23 21:15:18.735	2025-04-23 21:15:18.751	1	1	\N	0.40	10x10x2	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Licenciado Poza 1515	43.262706	-2.925281	\N	\N	\N	\N	\N
177	q5nflzh5x14t3f4wt9o3otrt	Extrusor directo Hemera	extrusor-directo-hemera	Extrusor directo Hemera para impresoras 3D	t	99.99	\N	2025-04-16 21:51:21.541	2025-04-23 21:15:39.149	2025-04-23 21:15:39.166	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	\N	\N	\N
179	xcwyn1hus070qfq0alarvgb4	Fuente de alimentación 24V 15A	fuente-de-alimentacion-24-v-15-a	Fuente de alimentación 24V 15A para impresoras 3D	t	49.99	\N	2025-04-16 21:15:05.661	2025-04-23 21:16:36.64	2025-04-23 21:16:36.657	1	1	\N	1.00	10x10x2	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Paz 1717	39.462258	-0.376953	\N	\N	\N	\N	\N
180	fzftlszyqi1oa41nu6rknq7p	Junta de goma para perfiles	junta-de-goma-para-perfiles	Junta de goma para perfiles de aluminio	t	29.99	\N	2025-04-16 22:26:11.448	2025-04-23 21:16:52.258	2025-04-23 21:16:52.292	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Vigo	Vigo	España	Calle Progreso 1414	42.231356	-8.712447	\N	\N	\N	\N	\N
181	ut17mxlcgw21wtu004mke273	Kingroon KP3S Pro	kingroon-kp-3-s-pro	Impresora 3D Kingroon KP3S Pro con diseño modular	t	299.99	\N	2025-04-15 21:33:56.157	2025-04-23 21:17:17.74	2025-04-23 21:17:17.758	1	1	\N	8.50	30x30x35	2023-01-02	12 meses	Seminuevo	Valencia	Valencia	España	Calle Paz 1717	39.462258	-0.376953	\N	\N	\N	\N	\N
182	eazmnhlkfrwe40zuxv2yuxct	Kit de cables para impresoras 3D	kit-de-cables-para-impresoras-3-d	Kit de cables para impresoras 3D	t	19.99	\N	2025-04-16 21:46:41.404	2025-04-23 21:17:42.719	2025-04-23 21:17:42.734	1	1	\N	0.40	10x10x2	2025-04-02	24 meses	Nuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	\N	\N	\N
185	b68q5lwslqmjvcfluj6sinhq	Kit de uniones para perfiles	kit-de-uniones-para-perfiles	Kit de uniones para perfiles de aluminio	t	29.99	\N	2025-04-16 22:08:09.628	2025-04-23 21:18:41.724	2025-04-23 21:18:41.744	1	1	\N	8.50	20x20x2	2025-04-02	24 meses	Nuevo	Oviedo	Oviedo	España	Calle Uría 909	43.361914	-5.849389	\N	\N	\N	\N	\N
186	hvmu2rtjuhzo3ttqrxpfvy1x	Motor paso a paso NEMA 17	motor-paso-a-paso-nema-17	Motor paso a paso NEMA 17 para impresoras 3D	t	29.99	\N	2025-04-16 21:22:04.667	2025-04-23 21:18:59.436	2025-04-23 21:18:59.452	1	1	\N	0.40	10x10x10	2025-04-02	24 meses	Nuevo	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	\N	\N	\N
187	c4v6ox4e2ay1urfoumsstcuu	Nova3D Bene4 Mono	nova3-d-bene4-mono	Impresora 3D de resina Nova3D Bene4 Mono	t	249.99	\N	2025-04-15 22:11:58.135	2025-04-23 21:19:16.26	2025-04-23 21:19:16.275	1	1	\N	6.20	20x20x20	2025-04-02	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	\N	\N	\N	\N	\N
188	ue868twewfhbu3yb6qtel60o	Nozzle de 0.4mm para Ender 3	nozzle-de-0-4mm-para-ender-3	Nozzle de repuesto de 0.4mm para impresoras Ender 3	t	9.99	\N	2025-04-16 19:48:20.824	2025-04-23 21:19:35.385	2025-04-23 21:19:35.4	1	1	\N	0.01	1x1x1	2025-04-02	24 meses	Nuevo	Albacete	Albacete	España	Calle Mayor 1212	38.986545	-1.863517	\N	\N	\N	\N	\N
189	g7fuoe486a94glppbmwuphkh	Pantalla táctil TFT35 E3	pantalla-tactil-tft-35-e3	Pantalla táctil TFT35 E3 para impresoras 3D	t	39.99	\N	2025-04-16 21:00:36.13	2025-04-23 21:19:51.57	2025-04-23 21:19:51.589	1	1	\N	0.30	10x10x2	2025-04-02	24 meses	Nuevo Precintado	Vigo	Vigo	España	Calle Progreso 1414	42.231356	-8.712447	\N	\N	\N	\N	\N
190	f6w8s4dcgbxibogflilgywp4	Perfil de aluminio 20x20	perfil-de-aluminio-20x20	Perfil de aluminio 20x20 para estructuras de impresoras 3D	t	14.99	\N	2025-04-16 22:01:41.619	2025-04-23 21:20:13.033	2025-04-23 21:20:13.048	1	1	\N	7.80	100x2x2	2025-04-02	24 meses	Nuevo	Santiago de Compostela	Santiago de Compostela	España	Rúa do Franco 707	42.878213	-8.544844	\N	\N	\N	\N	\N
191	wl3scnbusnjashe0j8qh6rdb	Perfil de aluminio 40x40	perfil-de-aluminio-40x40	Perfil de aluminio 40x40 para estructuras de impresoras 3D	t	29.99	\N	2025-04-16 22:05:10.632	2025-04-23 21:20:33.46	2025-04-23 21:20:33.477	1	1	\N	0.40	100x2x2	2025-04-02	24 meses	Nuevo	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
192	g1qd0zyd7j8nv1bjnqghwswq	Phrozen Sonic Mega 8K	phrozen-sonic-mega-8-k	Impresora 3D de resina Phrozen Sonic Mega 8K	t	899.99	\N	2025-04-16 19:32:54.873	2025-04-23 21:20:49.352	2025-04-23 21:20:49.368	1	1	\N	10.00	35x35x40	2024-04-01	12 meses	Seminuevo	Oviedo	Oviedo	España	Calle Uría 909	43.361914	-5.849389	\N	\N	\N	\N	\N
193	y4clvedcwp6cwtjs0w5baoki	Phrozen Sonic Mighty 4K	phrozen-sonic-mighty-4-k	Impresora 3D de resina Phrozen Sonic Mighty 4K	t	249.99	\N	2025-04-16 19:01:36.15	2025-04-23 21:21:06.442	2025-04-23 21:21:06.463	1	1	\N	10.00	30x30x35	2025-04-02	24 meses	Nuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
194	sxw3cqnv1p9dz5kn1q3u33ki	Phrozen Sonic Mini 4K	phrozen-sonic-mini-4-k	Impresora 3D de resina Phrozen Sonic Mini 4K	t	349.99	\N	2025-04-15 21:57:19.726	2025-04-23 21:21:23.673	2025-04-23 21:21:23.69	1	1	\N	6.50	20x20x20	2025-04-05	24 meses	Nuevo Precintado	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	\N	\N	\N
195	bf0yldcnyjjh5j3i5r89a99v	Placa base SKR Mini E3 V3	placa-base-skr-mini-e3-v3	Placa base SKR Mini E3 V3 para impresoras 3D	t	49.99	\N	2025-04-16 20:57:13.597	2025-04-23 21:21:47.753	2025-04-23 21:21:47.771	1	1	\N	0.20	10x10x2	2025-04-02	24 meses	Nuevo Precintado	Palma de Mallorca	Palma de Mallorca	España	Calle Jaime III 1313	39.5696	2.65016	\N	\N	\N	\N	\N
196	ac25edb9xil9lovz3jfwh1lt	Placa base para perfil 20x20	placa-base-para-perfil-20x20	Placa base para perfil de aluminio 20x20	t	19.99	\N	2025-04-16 22:11:44.497	2025-04-23 21:22:01.977	2025-04-23 21:22:01.994	1	1	\N	5.50	5x5x5	2025-04-02	24 meses	Nuevo	Cádiz	Cádiz	España	Calle Ancha 1010	36.529781	-6.292657	\N	\N	\N	\N	\N
197	rpa768ug8q83vha469m76we4	Placa base para perfil 40x40	placa-base-para-perfil-40x40	Placa base para perfil de aluminio 40x40	t	29.99	\N	2025-04-16 22:14:36.143	2025-04-23 21:22:13.787	2025-04-23 21:22:13.802	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Las Palmas	Las Palmas	España	Calle Triana 1111	28.123546	-15.436257	\N	\N	\N	\N	\N
509	lik1gex8bfp3kx6zzpmjoh4p	prueba	prueba	t23ty234t	t	2000.00	f	2025-05-03 19:50:45.155	2025-05-03 20:30:45.559	\N	\N	\N	\N	0.00		\N	\N	Nuevo			España		\N	\N	\N	\N	0	\N	3
363	dtqpbjtfslcjxo9jbtdzs0b2	Impresora de prueba final	impresora-de-prueba-final	Esta es una prueba final sin el campo createBy	t	299.99	f	2025-04-29 20:36:48.52	2025-04-29 21:23:36.529	2025-04-29 21:23:36.546	\N	\N	\N	0.00		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	\N
198	o2jm4dl77udoyf5m50bdnb6y	Prusa Mini+	prusa-mini	Impresora 3D compacta Prusa Mini+	t	399.99	\N	2025-04-15 21:02:37.937	2025-04-23 21:22:30.443	2025-04-23 21:22:30.46	1	1	\N	6.50	20x20x20	2024-04-01	24 meses	Nuevo Precintado	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
201	cgstyn7kf9jxwb4qwa9hdmle	Resina para impresoras 3D	resina-para-impresoras-3-d	Resina para impresoras 3D	t	29.99	\N	2025-04-17 11:38:43.142	2025-04-23 21:23:23.258	2025-04-23 21:23:23.278	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Murcia	Murcia	España	Calle Trapería 808	37.99224	-1.130654	\N	\N	\N	\N	\N
206	f5om3kms72w835mm6gk88you	Soporte angular para perfiles	soporte-angular-para-perfiles	Soporte angular para perfiles de aluminio	t	29.99	\N	2025-04-16 22:22:52.573	2025-04-23 21:24:43.052	2025-04-23 21:24:43.068	1	1	\N	5.50	5x5x5	2023-01-02	24 meses	Nuevo	Palma de Mallorca	Palma de Mallorca	España	Calle Jaime III 1313	39.5696	2.65016	\N	\N	\N	\N	\N
200	heo4lbb3xhkmual1l8rhadt7	Qidi Tech X-Plus	qidi-tech-x-plus	Impresora 3D Qidi Tech X-Plus con doble extrusor	t	699.99	\N	2025-04-15 21:06:45.881	2025-04-23 21:23:01.688	2025-04-23 21:23:01.707	1	1	\N	15.00	35x35x35	2023-01-13	Sin Garantia	Seminuevo	Oviedo	Oviedo	España	Calle Uría 909	43.361914	-5.849389	\N	\N	\N	\N	\N
486	oge9xhtfdtb0selfez1cpmkr	Anycubic Photon Mono X	anycubic-photon-mono-x	Impresora 3D de resina Anycubic Photon Mono X	t	499.99	t	2025-04-15 20:44:08.546	2025-05-01 21:40:38.078	2025-05-01 21:40:38.141	1	1	\N	7.80	25x25x30	2023-01-02	Sin Garantia	Seminuevo	Málaga	Málaga	España	Avenida Andalucía 303	36.721261	-4.421266	\N	\N	35	\N	\N
90	x750yufmey1bekoymdo0dhyx	Kit de reparación para impresoras 3D	kit-de-reparacion-para-impresoras-3-d	Kit de reparación para impresoras 3D	t	29.99	t	2025-04-16 21:57:54.317	2025-05-03 18:59:26.076	\N	1	1	\N	5.50	20x20x5	2025-04-02	24 meses	Nuevo	Toledo	Toledo	España	Calle Real 606	39.862832	-4.027323	\N	\N	17	\N	\N
513	zxqt0brjz9wu085lzi23891m	Bambu Lab X1 Carbon prueba2	bambu-lab-x1-carbon-prueba2	joiuoiu	t	2000.00	f	2025-05-03 20:03:12.123	2025-05-03 20:03:12.123	\N	\N	\N	\N	5.50	20x20x20	\N	\N	Seminuevo	Ontinyent	Valencia	España	C/Purisima n11	\N	\N	\N	\N	0	\N	3
514	zxqt0brjz9wu085lzi23891m	Bambu Lab X1 Carbon prueba2	bambu-lab-x1-carbon-prueba2	joiuoiu	t	2000.00	f	2025-05-03 20:03:12.123	2025-05-03 20:03:12.123	2025-05-03 20:03:12.137	\N	\N	\N	5.50	20x20x20	\N	\N	Seminuevo	Ontinyent	Valencia	España	C/Purisima n11	\N	\N	\N	\N	0	\N	3
202	m3bgw6j6x0s4ydcn0ocb47hd	Resina para impresoras 3D color carne	resina-para-impresoras-3-d-color-carne	Resina para impresoras 3D color carne	t	29.99	\N	2025-04-17 11:48:20.007	2025-04-23 21:23:38.465	2025-04-23 21:23:38.491	1	1	\N	6.50	10x10x5	2025-04-02	24 meses	Nuevo	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
299	q3dqna1hds38k35dixvphaia	Ultimaker S5 Pro	ultimaker-s5-pro	Impresora 3D Ultimaker S5 profesional	t	5999.99	t	2025-04-15 20:28:49.714	2025-04-27 18:29:10.626	2025-04-27 18:29:10.644	1	1	\N	20.50	70x70x50	2025-04-02	24 meses	Nuevo	Valencia	Valencia	España	Calle Colón 789	39.469907	-0.376288	4.00	1	23	\N	\N
368	qsldm2xs8apwrdniyc33ia8k	prueba final	prueba-final	wgqwegq	t	29.99	f	2025-04-29 21:40:23.016	2025-04-29 21:40:23.016	\N	\N	\N	\N	0.40	10x10x5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	3
369	qsldm2xs8apwrdniyc33ia8k	prueba final	prueba-final	wgqwegq	t	29.99	f	2025-04-29 21:40:23.016	2025-04-29 21:40:23.016	2025-04-29 21:40:23.033	\N	\N	\N	0.40	10x10x5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	3
488	yn64s1gjh4zeztx7n3q2fuep	Ender 3 V2 Seminueva	ender-3-v2-seminueva	Impresora 3D Ender 3 V2 en perfecto estado	t	249.99	t	2025-04-15 20:24:04.384	2025-05-01 21:42:01.124	2025-05-01 21:42:01.147	1	1	\N	7.80	45x45x35	2023-01-02	12 meses	Seminuevo	Barcelona	Barcelona	España	Avenida Diagonal 456	41.385063	2.173404	\N	\N	8	\N	\N
515	jkv886vj86amc67vgqddvvkt	Producto de Prueba3	producto-de-prueba3	Descripción del producto de prueba	t	150.00	f	2025-05-03 20:16:52.111	2025-05-03 20:16:52.111	\N	\N	\N	\N	0.00		\N	\N	Nuevo			España		\N	\N	\N	\N	0	\N	3
516	jkv886vj86amc67vgqddvvkt	Producto de Prueba3	producto-de-prueba3	Descripción del producto de prueba	t	150.00	f	2025-05-03 20:16:52.111	2025-05-03 20:16:52.111	2025-05-03 20:16:52.136	\N	\N	\N	0.00		\N	\N	Nuevo			España		\N	\N	\N	\N	0	\N	3
203	s8qlhnj4kxz3hoburl09qv4c	Resina para impresoras 3D transparente	resina-para-impresoras-3-d-transparente	Resina para impresoras 3D transparente	t	29.99	\N	2025-04-17 11:44:08.698	2025-04-23 21:23:58.067	2025-04-23 21:23:58.083	1	1	\N	5.50	10x10x5	2025-04-02	24 meses	Nuevo	Madrid	Madrid	España	Calle San Miguel 23	40.416775	-3.70379	\N	\N	\N	\N	\N
207	qidhd0gpt6pizg6cx20gsjgy	Sensor de nivelación BLTouch	sensor-de-nivelacion-bl-touch	Sensor de nivelación BLTouch para impresoras 3D	t	34.99	\N	2025-04-16 21:11:48.902	2025-04-23 21:24:59.213	2025-04-23 21:24:59.231	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Sevilla	Sevilla	España	Calle Sierpes 1616	37.38264	-5.996295	\N	\N	\N	\N	\N
225	rlufa1rgrejsahm23ebc7abu	Termistor 100K	termistor-100-k	Termistor 100K para impresoras 3D	t	19.99	\N	2025-04-16 21:31:03.782	2025-04-27 13:00:22.388	2025-04-27 13:00:22.406	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	4.50	2	15	\N	\N
490	q4h4qhlwkm5xo49gvnnef5ws	Anycubic Kobra 2 Max	anycubic-kobra-2-max	Impresora 3D Anycubic Kobra 2 Max en excelente estado	t	399.99	t	2025-04-15 20:39:05.367	2025-05-01 21:44:41.949	2025-05-01 21:44:41.978	1	1	\N	9.20	45x45x40	2025-04-03	24 meses	Nuevo	Bilbao	Bilbao	España	Calle Ledesma 202	43.263013	-2.934985	4.50	2	24	\N	\N
517	i9agss42qu6zt3lt4s394i9l	Bambu Lab X1 Carbon prueba4	bambu-lab-x1-carbon-prueba4	joiuoiu	t	2000.00	f	2025-05-03 20:17:22.13	2025-05-03 20:17:22.13	\N	\N	\N	\N	5.50	20x20x20	\N	\N	Seminuevo	Ontinyent	Valencia	España	C/Purisima n11	\N	\N	\N	\N	0	\N	3
270	to82yuctzvpsq25kwgzcwpl2	Bambu Lab X1 Carbon	bambu-lab-x1-carbon	Impresora 3D Bambu Lab X1 Carbon de alta velocidad	t	799.99	t	2025-04-15 20:48:13.646	2025-04-27 13:58:07.336	2025-04-27 13:58:07.351	1	1	\N	12.00	30x30x35	2024-04-01	12 meses	Seminuevo	Alicante	Alicante	España	Calle Gabriel Miró 404	38.345996	-0.490686	\N	\N	37	\N	\N
518	i9agss42qu6zt3lt4s394i9l	Bambu Lab X1 Carbon prueba4	bambu-lab-x1-carbon-prueba4	joiuoiu	t	2000.00	f	2025-05-03 20:17:22.13	2025-05-03 20:17:22.13	2025-05-03 20:17:22.142	\N	\N	\N	5.50	20x20x20	\N	\N	Seminuevo	Ontinyent	Valencia	España	C/Purisima n11	\N	\N	\N	\N	0	\N	3
205	ktv23hp5aaa1b343i5r006w3	Sensor de filamento	sensor-de-filamento	Sensor de filamento para impresoras 3D	t	29.99	\N	2025-04-16 21:54:03.144	2025-04-23 21:24:28.799	2025-04-23 21:24:28.812	1	1	\N	0.40	5x5x5	2025-04-02	24 meses	Nuevo	Zaragoza	Zaragoza	España	Calle San Miguel 505	41.648823	-0.889085	\N	\N	\N	\N	\N
424	oodgs988cb2lekulqngpx2d8	Prusa i3 MK3S+ Nueva	prusa-i3-mk-3-s-nueva	Impresora 3D Prusa i3 MK3S+ nueva sin usar	t	799.99	t	2025-04-15 20:17:24.247	2025-05-01 19:25:58.375	2025-05-01 19:25:58.403	1	1	\N	8.50	50x50x40	2024-04-01	24 meses	Seminuevo	Madrid	Madrid	España	Calle Gran Vía 123	40.416775	-3.70379	\N	\N	6	\N	\N
392	oy6b14o2kiqvh9j8nc7tb7mh	Form 3+ Profesional	form-3-profesional	Impresora 3D Form 3+ de resina	t	3499.99	t	2025-04-15 20:33:22.676	2025-05-01 18:22:39.104	2025-05-01 18:22:39.116	1	1	\N	17.50	60x60x45	2022-04-06	Sin Garantia	Seminuevo	Sevilla	Sevilla	España	Plaza Nueva 101	37.389092	-5.984459	\N	\N	9	\N	\N
519	c522t3yqwwnxi0h6z4b8ivk4	prueba dd	prueba-dd	t23ty234t	t	2000.00	f	2025-05-03 20:22:13.392	2025-05-03 20:31:39.646	\N	\N	\N	\N	0.00		\N	\N	Nuevo			España		\N	\N	\N	\N	0	\N	3
\.


--
-- Data for Name: products_categories_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products_categories_lnk (id, product_id, category_id, category_ord, product_ord) FROM stdin;
1	1	1	0	1
3	3	1	0	2
5	5	1	0	3
7	7	3	0	1
252	188	14	1	1
9	9	1	0	4
11	11	3	0	2
13	13	1	0	5
15	15	1	0	6
17	17	1	0	7
19	19	1	0	8
21	21	1	0	9
23	25	1	0	10
25	29	1	0	11
27	31	1	0	12
29	33	3	0	3
31	35	3	0	4
33	37	3	0	5
35	39	3	0	6
38	42	3	0	7
40	44	3	0	8
42	46	3	0	9
44	48	3	0	10
46	50	3	0	11
48	52	3	0	12
50	54	3	0	13
52	56	3	0	14
54	58	3	0	15
56	60	3	0	16
58	62	9	0	1
60	64	9	0	2
62	66	9	0	3
64	68	9	0	4
66	70	9	0	5
68	72	9	0	6
70	74	9	0	7
72	76	9	0	8
74	78	9	0	9
76	80	9	0	10
78	82	9	0	11
80	84	9	0	12
82	86	9	0	13
84	88	9	0	14
86	90	9	0	15
88	92	7	0	1
90	94	7	0	2
92	96	7	0	3
94	98	7	0	4
96	100	7	0	5
99	103	7	0	6
101	105	7	0	7
103	107	7	0	8
105	109	7	0	9
107	111	7	0	10
109	113	5	0	1
111	115	5	0	2
113	117	5	0	3
115	119	5	0	4
117	121	5	0	5
119	123	5	0	6
121	125	5	0	7
123	127	5	0	8
125	129	5	0	9
127	131	5	0	10
129	133	12	0	1
131	135	12	0	2
133	137	12	0	3
135	139	12	0	4
137	141	12	0	5
254	190	18	1	1
259	195	14	1	2
515	486	17	1	2
261	197	18	1	5
262	198	16	1	8
519	490	16	1	4
265	201	19	1	1
266	202	19	1	4
524	495	16	1	7
269	205	14	1	14
270	206	18	1	7
529	504	14	1	15
174	30	16	1	11
273	209	16	1	10
275	212	14	1	9
362	299	16	1	3
191	61	17	1	16
333	270	16	1	5
206	142	19	1	5
424	395	18	1	6
253	189	14	1	3
213	149	17	1	5
255	191	18	1	2
256	192	17	1	14
218	154	15	1	6
257	193	17	1	10
517	488	16	1	2
220	156	15	1	4
258	194	17	1	4
221	157	15	1	8
260	196	18	1	4
223	159	15	1	1
224	160	15	1	2
264	200	16	1	9
225	161	15	1	3
226	162	15	1	7
227	163	15	1	10
267	203	19	1	2
228	164	14	1	8
229	165	14	1	11
271	207	14	1	5
230	166	16	1	6
231	167	17	1	6
232	168	17	1	12
392	329	17	1	11
233	169	18	1	9
234	170	18	1	10
235	171	17	1	3
276	213	17	1	9
237	173	17	1	13
352	289	15	1	5
528	499	17	1	15
239	175	17	1	8
240	176	14	1	4
241	177	14	1	13
398	335	19	1	3
243	179	14	1	6
244	180	18	1	8
245	181	16	1	12
246	182	14	1	12
453	424	16	1	1
402	358	15	1	9
249	185	18	1	3
250	186	14	1	7
288	225	14	1	10
251	187	17	1	7
421	392	17	1	1
\.


--
-- Data for Name: products_product_ratings_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products_product_ratings_lnk (id, product_id, product_rating_id, product_rating_ord, product_ord) FROM stdin;
66	299	11	1	1
67	299	17	2	1
8	5	10	1	1
68	299	27	3	1
10	80	12	1	1
69	299	29	4	1
70	299	31	5	1
71	129	32	1	1
14	80	14	2	1
18	225	13	1	1
19	225	15	2	1
80	358	33	1	1
28	5	16	2	1
30	121	18	1	1
31	289	19	1	1
32	58	20	1	1
35	58	22	2	1
37	58	24	3	1
114	499	21	1	1
115	499	23	2	1
43	5	26	3	1
116	499	25	3	1
48	5	28	4	1
54	5	30	5	1
\.


--
-- Data for Name: products_shipping_types_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products_shipping_types_lnk (id, product_id, shipping_type_id, shipping_type_ord, product_ord) FROM stdin;
1	1	1	0	1
3	3	3	0	1
5	5	5	0	1
7	7	1	0	2
9	9	5	0	2
11	11	7	0	1
13	13	3	0	2
15	15	5	0	3
17	17	7	0	2
19	19	5	0	4
21	21	3	0	3
23	23	1	0	3
25	25	5	0	5
27	27	3	0	4
29	29	3	0	5
31	31	5	0	6
33	33	5	0	7
35	35	3	0	6
37	37	5	0	8
39	39	3	0	7
42	42	3	0	8
44	44	3	0	9
46	46	1	0	4
48	48	1	0	5
50	50	3	0	10
52	52	5	0	9
54	54	1	0	6
56	56	3	0	11
58	58	1	0	7
60	60	5	0	10
62	62	3	0	12
64	64	3	0	13
66	66	5	0	11
68	68	1	0	8
70	70	1	0	9
72	72	1	0	10
74	74	1	0	11
76	76	1	0	12
78	78	1	0	13
80	80	1	0	14
82	82	1	0	15
84	84	1	0	16
86	86	1	0	17
88	88	1	0	18
189	30	11	1	5
90	90	1	0	19
92	92	1	0	20
258	188	11	1	12
94	94	1	0	21
96	96	1	0	22
260	190	10	1	20
98	98	1	0	23
100	100	1	0	24
103	103	1	0	25
265	195	11	1	13
105	105	1	0	26
107	107	1	0	27
109	109	1	0	28
111	111	1	0	29
113	113	1	0	30
115	115	1	0	31
117	117	1	0	32
119	119	1	0	33
121	121	1	0	34
123	123	1	0	35
125	125	1	0	36
127	127	3	0	14
129	129	1	0	37
131	131	1	0	38
133	133	1	0	39
135	135	1	0	40
399	329	11	1	10
137	137	1	0	41
267	197	10	1	24
268	198	12	1	4
208	61	12	1	10
522	486	13	1	1
210	142	12	1	12
139	139	1	0	42
141	141	5	0	12
359	289	10	1	34
271	201	10	1	39
145	24	10	1	3
405	335	10	1	41
272	202	10	1	42
526	490	12	1	2
531	495	13	1	2
275	205	10	1	18
276	206	10	1	26
536	504	10	1	19
279	209	12	1	5
282	212	10	1	13
283	213	10	1	4
340	270	11	1	2
431	395	10	1	25
259	189	12	1	11
261	191	10	1	21
262	192	11	1	11
219	149	12	1	8
263	193	10	1	5
264	194	11	1	6
224	154	10	1	35
266	196	10	1	23
226	156	10	1	33
227	157	11	1	14
270	200	11	1	3
524	488	11	1	1
229	159	10	1	30
273	203	10	1	40
230	160	10	1	31
231	161	10	1	32
277	207	10	1	9
232	162	10	1	36
233	163	10	1	38
234	164	10	1	12
235	165	10	1	15
280	210	11	1	4
236	166	12	1	3
237	167	11	1	7
238	168	12	1	9
409	358	10	1	37
239	169	10	1	28
240	170	10	1	29
241	171	12	1	7
535	499	10	1	7
243	173	10	1	6
245	175	11	1	9
246	176	10	1	8
369	299	12	1	1
247	177	10	1	17
295	225	10	1	14
249	179	10	1	10
250	180	10	1	27
251	181	12	1	6
460	424	10	1	1
252	182	10	1	16
255	185	10	1	22
256	186	10	1	11
257	187	11	1	8
428	392	10	1	2
\.


--
-- Data for Name: products_users_permissions_users_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.products_users_permissions_users_lnk (id, product_id, user_id, user_ord, product_ord) FROM stdin;
\.


--
-- Data for Name: reactions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.reactions (id, document_id, nombre, tipo, descripcion, "timestamp", type, active, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
3	rxqycrejaoo9thhwudfrh132	\N	\N	\N	\N	dislike	t	2025-05-01 20:56:25.221	2025-05-01 20:58:41.401	\N	\N	\N	\N
5	rxqycrejaoo9thhwudfrh132	\N	\N	\N	\N	dislike	t	2025-05-01 20:56:25.221	2025-05-01 20:58:41.401	2025-05-01 20:58:41.41	\N	\N	\N
6	jms7oj8qcb9gy6ra7mb8dddo	\N	\N	\N	\N	like	t	2025-05-01 21:17:05.461	2025-05-01 21:17:05.461	\N	\N	\N	\N
7	jms7oj8qcb9gy6ra7mb8dddo	\N	\N	\N	\N	like	t	2025-05-01 21:17:05.461	2025-05-01 21:17:05.461	2025-05-01 21:17:05.467	\N	\N	\N
8	n56lequtmff72jhiah0p85mn	\N	\N	\N	\N	like	t	2025-05-01 21:26:03.127	2025-05-01 21:26:03.127	\N	\N	\N	\N
9	n56lequtmff72jhiah0p85mn	\N	\N	\N	\N	like	t	2025-05-01 21:26:03.127	2025-05-01 21:26:03.127	2025-05-01 21:26:03.137	\N	\N	\N
10	qfryr1dust0un7vk7dpd4qxj	\N	\N	\N	\N	like	t	2025-05-01 21:26:15.113	2025-05-01 21:26:15.113	\N	\N	\N	\N
11	qfryr1dust0un7vk7dpd4qxj	\N	\N	\N	\N	like	t	2025-05-01 21:26:15.113	2025-05-01 21:26:15.113	2025-05-01 21:26:15.119	\N	\N	\N
12	eh3kv6j8flhytll6jjgudgxi	\N	\N	\N	\N	like	t	2025-05-01 21:28:41.131	2025-05-01 21:28:41.131	\N	\N	\N	\N
13	eh3kv6j8flhytll6jjgudgxi	\N	\N	\N	\N	like	t	2025-05-01 21:28:41.131	2025-05-01 21:28:41.131	2025-05-01 21:28:41.137	\N	\N	\N
14	lczbeexclkb02boqjv62wa81	\N	\N	\N	\N	like	t	2025-05-01 21:31:52.539	2025-05-01 21:31:52.539	\N	\N	\N	\N
15	lczbeexclkb02boqjv62wa81	\N	\N	\N	\N	like	t	2025-05-01 21:31:52.539	2025-05-01 21:31:52.539	2025-05-01 21:31:52.547	\N	\N	\N
16	s5mxpnrke7r3ooxpe2w2c1lf	\N	\N	\N	\N	like	t	2025-05-01 21:35:18.364	2025-05-01 21:35:18.364	\N	\N	\N	\N
17	s5mxpnrke7r3ooxpe2w2c1lf	\N	\N	\N	\N	like	t	2025-05-01 21:35:18.364	2025-05-01 21:35:18.364	2025-05-01 21:35:18.369	\N	\N	\N
18	xo9sqofygxhcm304dh4wgtay	\N	\N	\N	\N	like	t	2025-05-01 21:37:50.678	2025-05-01 21:37:50.678	\N	\N	\N	\N
19	xo9sqofygxhcm304dh4wgtay	\N	\N	\N	\N	like	t	2025-05-01 21:37:50.678	2025-05-01 21:37:50.678	2025-05-01 21:37:50.686	\N	\N	\N
20	qmvlmhgfh6y7hebx0cxt2jg0	\N	\N	\N	\N	like	t	2025-05-01 21:37:57.564	2025-05-01 21:37:57.564	\N	\N	\N	\N
21	qmvlmhgfh6y7hebx0cxt2jg0	\N	\N	\N	\N	like	t	2025-05-01 21:37:57.564	2025-05-01 21:37:57.564	2025-05-01 21:37:57.572	\N	\N	\N
22	gm4caskyrtzrzqq95w9xf3an	\N	\N	\N	\N	like	t	2025-05-01 21:39:19.97	2025-05-01 21:39:19.97	\N	\N	\N	\N
23	gm4caskyrtzrzqq95w9xf3an	\N	\N	\N	\N	like	t	2025-05-01 21:39:19.97	2025-05-01 21:39:19.97	2025-05-01 21:39:19.978	\N	\N	\N
24	rbg4tp9l92fsenmq65bfr4k1	\N	\N	\N	\N	dislike	t	2025-05-01 21:42:03.739	2025-05-01 21:42:21.028	\N	\N	\N	\N
27	rbg4tp9l92fsenmq65bfr4k1	\N	\N	\N	\N	dislike	t	2025-05-01 21:42:03.739	2025-05-01 21:42:21.028	2025-05-01 21:42:21.035	\N	\N	\N
1	ovsyds30b01atbuhti2suel6	\N	\N	\N	\N	like	f	2025-05-01 20:45:30.762	2025-05-01 21:44:43.136	\N	\N	\N	\N
28	ovsyds30b01atbuhti2suel6	\N	\N	\N	\N	like	f	2025-05-01 20:45:30.762	2025-05-01 21:44:43.136	2025-05-01 21:44:43.143	\N	\N	\N
29	tveu4uimy8rijk0qsrxoninn	\N	\N	\N	\N	like	t	2025-05-01 21:48:16.186	2025-05-01 21:48:16.186	\N	\N	\N	\N
30	tveu4uimy8rijk0qsrxoninn	\N	\N	\N	\N	like	t	2025-05-01 21:48:16.186	2025-05-01 21:48:16.186	2025-05-01 21:48:16.195	\N	\N	\N
31	lexu688teddp8rpioibox3n6	\N	\N	\N	\N	like	t	2025-05-01 22:12:39.966	2025-05-01 22:12:39.966	\N	\N	\N	\N
32	lexu688teddp8rpioibox3n6	\N	\N	\N	\N	like	t	2025-05-01 22:12:39.966	2025-05-01 22:12:39.966	2025-05-01 22:12:39.973	\N	\N	\N
\.


--
-- Data for Name: reactions_product_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.reactions_product_lnk (id, reaction_id, product_id, reaction_ord) FROM stdin;
1	1	9	1
76	9	486	1
77	11	486	2
78	13	486	3
79	15	486	4
6	3	23	1
80	17	486	5
8	5	24	1
81	19	486	6
82	21	486	7
83	23	486	8
12	6	23	2
13	7	24	2
84	24	3	1
16	8	11	1
18	10	11	2
22	12	11	3
87	27	488	1
90	28	490	1
91	29	17	1
95	30	495	1
33	14	11	4
96	31	58	1
97	32	499	1
43	16	11	5
50	18	11	6
58	20	11	7
74	22	11	8
\.


--
-- Data for Name: reactions_users_permissions_user_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.reactions_users_permissions_user_lnk (id, reaction_id, user_id, reaction_ord) FROM stdin;
\.


--
-- Data for Name: shipping_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.shipping_types (id, document_id, shipping_type, slug, name_shipping_type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	v552xcub1mf8644b51fxjxv3	Entrega en Mano	entrega-en-mano	Entrega en mano	2025-04-14 22:09:34.466	2025-04-17 11:57:33.959	\N	1	1	\N
10	v552xcub1mf8644b51fxjxv3	Entrega en Mano	entrega-en-mano	Entrega en mano	2025-04-14 22:09:34.466	2025-04-17 11:57:33.959	2025-04-17 11:57:33.979	1	1	\N
3	rm2j5q0ltps48voxue1twbd0	Envio Estandar	envio-estandar	Envio Estandar	2025-04-14 22:11:54.511	2025-04-17 11:58:22.887	\N	1	1	\N
11	rm2j5q0ltps48voxue1twbd0	Envio Estandar	envio-estandar	Envio Estandar	2025-04-14 22:11:54.511	2025-04-17 11:58:22.887	2025-04-17 11:58:22.928	1	1	\N
5	detlyqigdey9n7phbjt8h5zw	Envio Express	envio-express	Envio Express	2025-04-14 22:12:30.247	2025-04-17 11:58:54.832	\N	1	1	\N
12	detlyqigdey9n7phbjt8h5zw	Envio Express	envio-express	Envio Express	2025-04-14 22:12:30.247	2025-04-17 11:58:54.832	2025-04-17 11:58:54.87	1	1	\N
7	z4geuuxzddh7pae878qm8zc3	Recogida en Tienda	recogida-en-tienda	Recogida en Tienda	2025-04-14 22:15:30.029	2025-04-17 12:00:09.62	\N	1	1	\N
13	z4geuuxzddh7pae878qm8zc3	Recogida en Tienda	recogida-en-tienda	Recogida en Tienda	2025-04-14 22:15:30.029	2025-04-17 12:00:09.62	2025-04-17 12:00:09.65	1	1	\N
\.


--
-- Data for Name: strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_api_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_api_token_permissions_token_lnk (id, api_token_permission_id, api_token_id, api_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_api_tokens (id, document_id, name, description, type, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	onpq97o6brhbzp3i6xybl08z	Read Only	A default API token with read-only permissions, only used for accessing resources	read-only	067fc32c13e15e1324529772de9e5f00cb72595002dab515db35775d4ec07d11fd0381d61c1fbf74f1e06cbb73eb512d965a54b56205efabab5007561656a8a3	\N	\N	\N	2025-04-14 19:18:04.473	2025-04-14 19:18:04.473	2025-04-14 19:18:04.473	\N	\N	\N
2	ponotugav3mfwrr6sx2guqf3	Full Access	A default API token with full access permissions, used for accessing or modifying resources	full-access	123fe553d13ff20aca7e8a787c7ff6755745000b9a7ce7768c3d8cba83eeb903f9300324de134dd657d3f8ffa67cefc1425675487739829bcb07bc0df166ea75	\N	\N	\N	2025-04-14 19:18:04.475	2025-04-14 19:18:04.475	2025-04-14 19:18:04.475	\N	\N	\N
3	ju6v45znswzyx3jo969anzg3	Frontend Read Access		read-only	f3f75b8e22f68fd46d9f5b543127b6f8d51ccaba9dfcc8871de6f6d3a8be5a256bf98266e648d469a08cc52e536d92c04bac85f57a45aeb8f8b3d65103396663	\N	\N	\N	2025-04-20 21:39:53.027	2025-04-20 21:40:02.637	2025-04-20 21:39:53.028	\N	\N	\N
\.


--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
2	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]},"uid":"plugin::upload.folder"}	object	\N	\N
3	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"stages":{"edit":{"label":"stages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stages","searchable":false,"sortable":false}},"stageRequiredToPublish":{"edit":{"label":"stageRequiredToPublish","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stageRequiredToPublish","searchable":true,"sortable":true}},"contentTypes":{"edit":{"label":"contentTypes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentTypes","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","stages","stageRequiredToPublish"],"edit":[[{"name":"name","size":6},{"name":"stages","size":6}],[{"name":"stageRequiredToPublish","size":6}],[{"name":"contentTypes","size":12}]]},"uid":"plugin::review-workflows.workflow"}	object	\N	\N
4	plugin_content_manager_configuration_content_types::plugin::content-releases.release-action	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"contentType","defaultSortBy":"contentType","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"contentType":{"edit":{"label":"contentType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentType","searchable":true,"sortable":true}},"entryDocumentId":{"edit":{"label":"entryDocumentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"entryDocumentId","searchable":true,"sortable":true}},"release":{"edit":{"label":"release","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"release","searchable":true,"sortable":true}},"isEntryValid":{"edit":{"label":"isEntryValid","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isEntryValid","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","contentType","entryDocumentId"],"edit":[[{"name":"type","size":6},{"name":"contentType","size":6}],[{"name":"entryDocumentId","size":6},{"name":"release","size":6}],[{"name":"isEntryValid","size":4}]]},"uid":"plugin::content-releases.release-action"}	object	\N	\N
5	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow-stage	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"color":{"edit":{"label":"color","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"color","searchable":true,"sortable":true}},"workflow":{"edit":{"label":"workflow","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"workflow","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","color","workflow"],"edit":[[{"name":"name","size":6},{"name":"color","size":6}],[{"name":"workflow","size":6},{"name":"permissions","size":6}]]},"uid":"plugin::review-workflows.workflow-stage"}	object	\N	\N
6	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.permission"}	object	\N	\N
7	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]},"uid":"plugin::users-permissions.role"}	object	\N	\N
8	plugin_content_manager_configuration_content_types::admin::permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]},"uid":"admin::permission"}	object	\N	\N
9	plugin_content_manager_configuration_content_types::admin::role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]},"uid":"admin::role"}	object	\N	\N
1	strapi_content_types_schema	{"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"files"}}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"plugin":"upload","globalId":"UploadFile","uid":"plugin::upload.file","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"file"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"upload_folders"}}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"plugin":"upload","globalId":"UploadFolder","uid":"plugin::upload.folder","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true}},"kind":"collectionType"},"modelName":"folder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::i18n.locale","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"i18n_locale"}}},"plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale","uid":"plugin::i18n.locale","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"i18n_locale","info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelName":"locale"},"plugin::content-releases.release":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_releases"}}},"plugin":"content-releases","globalId":"ContentReleasesRelease","uid":"plugin::content-releases.release","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"}},"kind":"collectionType"},"modelName":"release"},"plugin::content-releases.release-action":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_release_actions"}}},"plugin":"content-releases","globalId":"ContentReleasesReleaseAction","uid":"plugin::content-releases.release-action","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"}},"kind":"collectionType"},"modelName":"release-action"},"plugin::review-workflows.workflow":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflow","uid":"plugin::review-workflows.workflow","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"}},"kind":"collectionType"},"modelName":"workflow"},"plugin::review-workflows.workflow-stage":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0","draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow-stage","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows_stages"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflowStage","uid":"plugin::review-workflows.workflow-stage","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false}},"kind":"collectionType"},"modelName":"workflow-stage"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_permissions"}}},"plugin":"users-permissions","globalId":"UsersPermissionsPermission","uid":"plugin::users-permissions.permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelName":"permission","options":{"draftAndPublish":false}},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_roles"}}},"plugin":"users-permissions","globalId":"UsersPermissionsRole","uid":"plugin::users-permissions.role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelName":"role","options":{"draftAndPublish":false}},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"product_ratings":{"type":"relation","relation":"manyToMany","target":"api::product-rating.product-rating","inversedBy":"users_permissions_users"},"avatar":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"users_permissions_users"},"userId":{"type":"uid","targetField":"username"},"reactions":{"type":"relation","relation":"oneToMany","target":"api::reaction.reaction","mappedBy":"users_permissions_user"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"plugin":"users-permissions","globalId":"UsersPermissionsUser","kind":"collectionType","__filename__":"schema.json","uid":"plugin::users-permissions.user","modelType":"contentType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"draftAndPublish":false},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"product_ratings":{"type":"relation","relation":"manyToMany","target":"api::product-rating.product-rating","inversedBy":"users_permissions_users"},"avatar":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"users_permissions_users"},"userId":{"type":"uid","targetField":"username"},"reactions":{"type":"relation","relation":"oneToMany","target":"api::reaction.reaction","mappedBy":"users_permissions_user"}},"kind":"collectionType"},"modelName":"user"},"api::brand.brand":{"kind":"collectionType","collectionName":"brands","info":{"singularName":"brand","pluralName":"brands","displayName":"Brand","description":""},"options":{"draftAndPublish":true},"attributes":{"brandName":{"type":"string"},"slug":{"type":"uid","targetField":"brandName"},"mainimage":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","inversedBy":"brands"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::brand.brand","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"brands"}}},"apiName":"brand","globalId":"Brand","uid":"api::brand.brand","modelType":"contentType","__schema__":{"collectionName":"brands","info":{"singularName":"brand","pluralName":"brands","displayName":"Brand","description":""},"options":{"draftAndPublish":true},"attributes":{"brandName":{"type":"string"},"slug":{"type":"uid","targetField":"brandName"},"mainimage":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","inversedBy":"brands"}},"kind":"collectionType"},"modelName":"brand","actions":{},"lifecycles":{}},"api::category.category":{"kind":"collectionType","collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category","description":""},"options":{"draftAndPublish":true},"attributes":{"categoryName":{"type":"string"},"slug":{"type":"uid","targetField":"categoryName"},"mainimage":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"categories"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::category.category","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"categories"}}},"apiName":"category","globalId":"Category","uid":"api::category.category","modelType":"contentType","__schema__":{"collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category","description":""},"options":{"draftAndPublish":true},"attributes":{"categoryName":{"type":"string"},"slug":{"type":"uid","targetField":"categoryName"},"mainimage":{"type":"media","multiple":false,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"categories"}},"kind":"collectionType"},"modelName":"category","actions":{},"lifecycles":{}},"api::favorite.favorite":{"kind":"collectionType","collectionName":"favorites","info":{"singularName":"favorite","pluralName":"favorites","displayName":"Favorite"},"options":{"draftAndPublish":true},"attributes":{"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","inversedBy":"favorites"},"users_permissions_user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::favorite.favorite","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"favorites"}}},"apiName":"favorite","globalId":"Favorite","uid":"api::favorite.favorite","modelType":"contentType","__schema__":{"collectionName":"favorites","info":{"singularName":"favorite","pluralName":"favorites","displayName":"Favorite"},"options":{"draftAndPublish":true},"attributes":{"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","inversedBy":"favorites"},"users_permissions_user":{"type":"relation","relation":"oneToOne","target":"plugin::users-permissions.user"}},"kind":"collectionType"},"modelName":"favorite","actions":{},"lifecycles":{}},"api::image-general.image-general":{"kind":"collectionType","collectionName":"image_generals","info":{"singularName":"image-general","pluralName":"image-generals","displayName":"imageGeneral","description":""},"options":{"draftAndPublish":true},"attributes":{"imageGeneralName":{"type":"string"},"slug":{"type":"uid","targetField":"imageGeneralName"},"nameGeneralImage":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"textGeneral":{"type":"blocks"},"links":{"type":"blocks"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::image-general.image-general","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"image_generals"}}},"apiName":"image-general","globalId":"ImageGeneral","uid":"api::image-general.image-general","modelType":"contentType","__schema__":{"collectionName":"image_generals","info":{"singularName":"image-general","pluralName":"image-generals","displayName":"imageGeneral","description":""},"options":{"draftAndPublish":true},"attributes":{"imageGeneralName":{"type":"string"},"slug":{"type":"uid","targetField":"imageGeneralName"},"nameGeneralImage":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"textGeneral":{"type":"blocks"},"links":{"type":"blocks"}},"kind":"collectionType"},"modelName":"image-general","actions":{},"lifecycles":{}},"api::product.product":{"kind":"collectionType","collectionName":"products","info":{"singularName":"product","pluralName":"products","displayName":"Product","description":""},"options":{"draftAndPublish":true},"attributes":{"productName":{"type":"string"},"slug":{"type":"uid","targetField":"productName"},"description":{"type":"text"},"images":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"active":{"type":"boolean","default":true},"price":{"type":"decimal"},"isFeatured":{"type":"boolean"},"categories":{"type":"relation","relation":"manyToMany","target":"api::category.category","inversedBy":"products"},"weight":{"type":"decimal"},"dimensions":{"type":"string"},"dateManufactured":{"type":"date"},"remaininWarranty":{"type":"string"},"State":{"type":"enumeration","enum":["Nuevo","Seminuevo","Nuevo Precintado"]},"cityName":{"type":"string"},"provinceName":{"type":"string"},"countryName":{"type":"string"},"directionName":{"type":"string"},"latitud":{"type":"float"},"longitud":{"type":"float"},"shipping_types":{"type":"relation","relation":"manyToMany","target":"api::shipping-type.shipping-type","inversedBy":"products"},"brands":{"type":"relation","relation":"manyToMany","target":"api::brand.brand","mappedBy":"products"},"product_ratings":{"type":"relation","relation":"manyToMany","target":"api::product-rating.product-rating","inversedBy":"products"},"averageRating":{"type":"decimal"},"totalRatings":{"type":"integer"},"views":{"type":"integer","default":0},"favorites":{"type":"relation","relation":"manyToMany","target":"api::favorite.favorite","mappedBy":"products"},"createBy":{"type":"string"},"users_permissions_users":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"products"},"owner_id":{"type":"string"},"reactions":{"type":"relation","relation":"oneToMany","target":"api::reaction.reaction","mappedBy":"product"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::product.product","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"products"}}},"apiName":"product","globalId":"Product","uid":"api::product.product","modelType":"contentType","__schema__":{"collectionName":"products","info":{"singularName":"product","pluralName":"products","displayName":"Product","description":""},"options":{"draftAndPublish":true},"attributes":{"productName":{"type":"string"},"slug":{"type":"uid","targetField":"productName"},"description":{"type":"text"},"images":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"active":{"type":"boolean","default":true},"price":{"type":"decimal"},"isFeatured":{"type":"boolean"},"categories":{"type":"relation","relation":"manyToMany","target":"api::category.category","inversedBy":"products"},"weight":{"type":"decimal"},"dimensions":{"type":"string"},"dateManufactured":{"type":"date"},"remaininWarranty":{"type":"string"},"State":{"type":"enumeration","enum":["Nuevo","Seminuevo","Nuevo Precintado"]},"cityName":{"type":"string"},"provinceName":{"type":"string"},"countryName":{"type":"string"},"directionName":{"type":"string"},"latitud":{"type":"float"},"longitud":{"type":"float"},"shipping_types":{"type":"relation","relation":"manyToMany","target":"api::shipping-type.shipping-type","inversedBy":"products"},"brands":{"type":"relation","relation":"manyToMany","target":"api::brand.brand","mappedBy":"products"},"product_ratings":{"type":"relation","relation":"manyToMany","target":"api::product-rating.product-rating","inversedBy":"products"},"averageRating":{"type":"decimal"},"totalRatings":{"type":"integer"},"views":{"type":"integer","default":0},"favorites":{"type":"relation","relation":"manyToMany","target":"api::favorite.favorite","mappedBy":"products"},"createBy":{"type":"string"},"users_permissions_users":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","inversedBy":"products"},"owner_id":{"type":"string"},"reactions":{"type":"relation","relation":"oneToMany","target":"api::reaction.reaction","mappedBy":"product"}},"kind":"collectionType"},"modelName":"product","actions":{},"lifecycles":{}},"api::product-rating.product-rating":{"kind":"collectionType","collectionName":"product_ratings","info":{"singularName":"product-rating","pluralName":"product-ratings","displayName":"product-rating","description":""},"options":{"draftAndPublish":true},"attributes":{"rating":{"type":"integer"},"users_permissions_users":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","mappedBy":"product_ratings"},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"product_ratings"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::product-rating.product-rating","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"product_ratings"}}},"apiName":"product-rating","globalId":"ProductRating","uid":"api::product-rating.product-rating","modelType":"contentType","__schema__":{"collectionName":"product_ratings","info":{"singularName":"product-rating","pluralName":"product-ratings","displayName":"product-rating","description":""},"options":{"draftAndPublish":true},"attributes":{"rating":{"type":"integer"},"users_permissions_users":{"type":"relation","relation":"manyToMany","target":"plugin::users-permissions.user","mappedBy":"product_ratings"},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"product_ratings"}},"kind":"collectionType"},"modelName":"product-rating","actions":{},"lifecycles":{}},"api::reaction.reaction":{"kind":"collectionType","collectionName":"reactions","info":{"singularName":"reaction","pluralName":"reactions","displayName":"reaction"},"options":{"draftAndPublish":true},"attributes":{"nombre":{"type":"string"},"Tipo":{"type":"string"},"Descripcion":{"type":"string"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"reactions"},"users_permissions_user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"reactions"},"timestamp":{"type":"datetime"},"type":{"type":"enumeration","enum":["like","dislike"]},"active":{"type":"boolean"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::reaction.reaction","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"reactions"}}},"apiName":"reaction","globalId":"Reaction","uid":"api::reaction.reaction","modelType":"contentType","__schema__":{"collectionName":"reactions","info":{"singularName":"reaction","pluralName":"reactions","displayName":"reaction"},"options":{"draftAndPublish":true},"attributes":{"nombre":{"type":"string"},"Tipo":{"type":"string"},"Descripcion":{"type":"string"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"reactions"},"users_permissions_user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"reactions"},"timestamp":{"type":"datetime"},"type":{"type":"enumeration","enum":["like","dislike"]},"active":{"type":"boolean"}},"kind":"collectionType"},"modelName":"reaction","actions":{},"lifecycles":{}},"api::shipping-type.shipping-type":{"kind":"collectionType","collectionName":"shipping_types","info":{"singularName":"shipping-type","pluralName":"shipping-types","displayName":"shippingType","description":""},"options":{"draftAndPublish":true},"attributes":{"shippingType":{"type":"string"},"slug":{"type":"uid","targetField":"shippingType"},"nameShippingType":{"type":"enumeration","enum":["Entrega en mano","Envio Estandar","Envio Express","Recogida en Tienda"]},"mediaShippingType":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"shipping_types"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::shipping-type.shipping-type","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"shipping_types"}}},"apiName":"shipping-type","globalId":"ShippingType","uid":"api::shipping-type.shipping-type","modelType":"contentType","__schema__":{"collectionName":"shipping_types","info":{"singularName":"shipping-type","pluralName":"shipping-types","displayName":"shippingType","description":""},"options":{"draftAndPublish":true},"attributes":{"shippingType":{"type":"string"},"slug":{"type":"uid","targetField":"shippingType"},"nameShippingType":{"type":"enumeration","enum":["Entrega en mano","Envio Estandar","Envio Express","Recogida en Tienda"]},"mediaShippingType":{"type":"media","multiple":true,"required":false,"allowedTypes":["images","files","videos","audios"]},"products":{"type":"relation","relation":"manyToMany","target":"api::product.product","mappedBy":"shipping_types"}},"kind":"collectionType"},"modelName":"shipping-type","actions":{},"lifecycles":{}},"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_permissions"}}},"plugin":"admin","globalId":"AdminPermission","uid":"admin::permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelName":"permission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"plugin":"admin","globalId":"AdminUser","uid":"admin::user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelName":"user","options":{"draftAndPublish":false}},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_roles"}}},"plugin":"admin","globalId":"AdminRole","uid":"admin::role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelName":"role"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_tokens"}}},"plugin":"admin","globalId":"AdminApiToken","uid":"admin::api-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"api-token"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_token_permissions"}}},"plugin":"admin","globalId":"AdminApiTokenPermission","uid":"admin::api-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelName":"api-token-permission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_tokens"}}},"plugin":"admin","globalId":"AdminTransferToken","uid":"admin::transfer-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"transfer-token"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_token_permissions"}}},"plugin":"admin","globalId":"AdminTransferTokenPermission","uid":"admin::transfer-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelName":"transfer-token-permission"}}	object	\N	\N
11	plugin_content_manager_configuration_content_types::plugin::upload.file	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6},{"name":"width","size":4}],[{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]},"uid":"plugin::upload.file"}	object	\N	\N
12	plugin_content_manager_configuration_content_types::plugin::content-releases.release	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"releasedAt":{"edit":{"label":"releasedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"releasedAt","searchable":true,"sortable":true}},"scheduledAt":{"edit":{"label":"scheduledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledAt","searchable":true,"sortable":true}},"timezone":{"edit":{"label":"timezone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timezone","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"actions":{"edit":{"label":"actions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"contentType"},"list":{"label":"actions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","releasedAt","scheduledAt"],"edit":[[{"name":"name","size":6},{"name":"releasedAt","size":6}],[{"name":"scheduledAt","size":6},{"name":"timezone","size":6}],[{"name":"status","size":6},{"name":"actions","size":6}]]},"uid":"plugin::content-releases.release"}	object	\N	\N
22	plugin_i18n_default_locale	"en"	string	\N	\N
23	plugin_users-permissions_grant	{"email":{"icon":"envelope","enabled":true},"discord":{"icon":"discord","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"icon":"facebook-square","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/facebook/callback","scope":["email"]},"google":{"icon":"google","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/google/callback","scope":["email"]},"github":{"icon":"github","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"icon":"windows","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"icon":"twitter","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitter/callback"},"instagram":{"icon":"instagram","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"icon":"vk","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/vk/callback","scope":["email"]},"twitch":{"icon":"twitch","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"icon":"linkedin","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"icon":"aws","enabled":false,"key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"icon":"reddit","enabled":false,"key":"","secret":"","callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"icon":"book","enabled":false,"key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"icon":"","enabled":false,"key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]},"keycloak":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"myKeycloakProvider.com/realms/myrealm","callback":"api/auth/keycloak/callback","scope":["openid","email","profile"]}}	object	\N	\N
24	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
25	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object	\N	\N
13	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]},"uid":"plugin::i18n.locale"}	object	\N	\N
14	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::api-token-permission"}	object	\N	\N
15	plugin_content_manager_configuration_content_types::admin::transfer-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::transfer-token"}	object	\N	\N
26	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object	\N	\N
16	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::transfer-token-permission"}	object	\N	\N
28	plugin_content_manager_configuration_content_types::api::category.category	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"categoryName","defaultSortBy":"categoryName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"categoryName":{"edit":{"label":"categoryName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"categoryName","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"mainimage":{"edit":{"label":"mainimage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mainimage","searchable":false,"sortable":false}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"productName"},"list":{"label":"products","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","categoryName","slug","mainimage"],"edit":[[{"name":"categoryName","size":6},{"name":"slug","size":6}],[{"name":"mainimage","size":6},{"name":"products","size":6}]]},"uid":"api::category.category"}	object	\N	\N
17	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"product_ratings":{"edit":{"label":"product_ratings","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"product_ratings","searchable":false,"sortable":false}},"avatar":{"edit":{"label":"avatar","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"avatar","searchable":false,"sortable":false}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"productName"},"list":{"label":"products","searchable":false,"sortable":false}},"userId":{"edit":{"label":"userId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"userId","searchable":true,"sortable":true}},"reactions":{"edit":{"label":"reactions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"nombre"},"list":{"label":"reactions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}],[{"name":"product_ratings","size":6},{"name":"avatar","size":6}],[{"name":"products","size":6},{"name":"userId","size":6}],[{"name":"reactions","size":6}]]},"uid":"plugin::users-permissions.user"}	object	\N	\N
30	plugin_content_manager_configuration_content_types::api::image-general.image-general	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"imageGeneralName","defaultSortBy":"imageGeneralName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"imageGeneralName":{"edit":{"label":"imageGeneralName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"imageGeneralName","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"nameGeneralImage":{"edit":{"label":"nameGeneralImage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"nameGeneralImage","searchable":false,"sortable":false}},"textGeneral":{"edit":{"label":"textGeneral","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"textGeneral","searchable":false,"sortable":false}},"links":{"edit":{"label":"links","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"links","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","imageGeneralName","slug","nameGeneralImage"],"edit":[[{"name":"imageGeneralName","size":6},{"name":"slug","size":6}],[{"name":"nameGeneralImage","size":6}],[{"name":"textGeneral","size":12}],[{"name":"links","size":12}]]},"uid":"api::image-general.image-general"}	object	\N	\N
10	plugin_content_manager_configuration_content_types::admin::user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]},"uid":"admin::user"}	object	\N	\N
19	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":false}	object	\N	\N
20	plugin_upload_view_configuration	{"pageSize":10,"sort":"createdAt:DESC"}	object	\N	\N
36	plugin_content_manager_configuration_content_types::api::shipping-type.shipping-type	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"shippingType","defaultSortBy":"shippingType","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"shippingType":{"edit":{"label":"shippingType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"shippingType","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"nameShippingType":{"edit":{"label":"nameShippingType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"nameShippingType","searchable":true,"sortable":true}},"mediaShippingType":{"edit":{"label":"mediaShippingType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mediaShippingType","searchable":false,"sortable":false}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"productName"},"list":{"label":"products","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","shippingType","slug","nameShippingType"],"edit":[[{"name":"shippingType","size":6},{"name":"slug","size":6}],[{"name":"nameShippingType","size":6},{"name":"mediaShippingType","size":6}],[{"name":"products","size":6}]]},"uid":"api::shipping-type.shipping-type"}	object	\N	\N
18	plugin_content_manager_configuration_content_types::admin::api-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"lastUsedAt","size":6},{"name":"permissions","size":6}],[{"name":"expiresAt","size":6},{"name":"lifespan","size":4}]]},"uid":"admin::api-token"}	object	\N	\N
29	plugin_content_manager_configuration_content_types::api::brand.brand	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"brandName","defaultSortBy":"brandName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"brandName":{"edit":{"label":"brandName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"brandName","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"mainimage":{"edit":{"label":"mainimage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mainimage","searchable":false,"sortable":false}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"productName"},"list":{"label":"products","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","brandName","slug","mainimage"],"edit":[[{"name":"brandName","size":6},{"name":"slug","size":6}],[{"name":"mainimage","size":6},{"name":"products","size":6}]]},"uid":"api::brand.brand"}	object	\N	\N
21	plugin_upload_metrics	{"weeklySchedule":"22 49 19 * * 2","lastWeeklyUpdate":1745948962025}	object	\N	\N
38	plugin_content_manager_configuration_content_types::api::product-rating.product-rating	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"rating":{"edit":{"label":"rating","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rating","searchable":true,"sortable":true}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"productName"},"list":{"label":"products","searchable":false,"sortable":false}},"users_permissions_users":{"edit":{"label":"users_permissions_users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users_permissions_users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","rating","products","users_permissions_users"],"edit":[[{"name":"rating","size":4},{"name":"products","size":6}],[{"name":"users_permissions_users","size":6}]]},"uid":"api::product-rating.product-rating"}	object	\N	\N
39	plugin_content_manager_configuration_content_types::api::favorite.favorite	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"productName"},"list":{"label":"products","searchable":false,"sortable":false}},"users_permissions_user":{"edit":{"label":"users_permissions_user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users_permissions_user","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","products","users_permissions_user","createdAt"],"edit":[[{"name":"products","size":6},{"name":"users_permissions_user","size":6}]]},"uid":"api::favorite.favorite"}	object	\N	\N
40	plugin_content_manager_configuration_content_types::api::reaction.reaction	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"nombre","defaultSortBy":"nombre","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"nombre":{"edit":{"label":"nombre","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"nombre","searchable":true,"sortable":true}},"Tipo":{"edit":{"label":"Tipo","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Tipo","searchable":true,"sortable":true}},"Descripcion":{"edit":{"label":"Descripcion","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Descripcion","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"productName"},"list":{"label":"product","searchable":true,"sortable":true}},"users_permissions_user":{"edit":{"label":"users_permissions_user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users_permissions_user","searchable":true,"sortable":true}},"timestamp":{"edit":{"label":"timestamp","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timestamp","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"active":{"edit":{"label":"active","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"active","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","nombre","Tipo","Descripcion"],"edit":[[{"name":"nombre","size":6},{"name":"Tipo","size":6}],[{"name":"Descripcion","size":6},{"name":"product","size":6}],[{"name":"users_permissions_user","size":6},{"name":"timestamp","size":6}],[{"name":"type","size":6},{"name":"active","size":4}]]},"uid":"api::reaction.reaction"}	object	\N	\N
27	plugin_content_manager_configuration_content_types::api::product.product	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"productName","defaultSortBy":"productName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"productName":{"edit":{"label":"productName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"productName","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"images":{"edit":{"label":"images","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"images","searchable":false,"sortable":false}},"active":{"edit":{"label":"active","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"active","searchable":true,"sortable":true}},"price":{"edit":{"label":"price","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"price","searchable":true,"sortable":true}},"isFeatured":{"edit":{"label":"isFeatured","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isFeatured","searchable":true,"sortable":true}},"categories":{"edit":{"label":"categories","description":"","placeholder":"","visible":true,"editable":true,"mainField":"categoryName"},"list":{"label":"categories","searchable":false,"sortable":false}},"weight":{"edit":{"label":"weight","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"weight","searchable":true,"sortable":true}},"dimensions":{"edit":{"label":"dimensions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"dimensions","searchable":true,"sortable":true}},"dateManufactured":{"edit":{"label":"dateManufactured","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"dateManufactured","searchable":true,"sortable":true}},"remaininWarranty":{"edit":{"label":"remaininWarranty","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"remaininWarranty","searchable":true,"sortable":true}},"State":{"edit":{"label":"State","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"State","searchable":true,"sortable":true}},"cityName":{"edit":{"label":"cityName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"cityName","searchable":true,"sortable":true}},"provinceName":{"edit":{"label":"provinceName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provinceName","searchable":true,"sortable":true}},"countryName":{"edit":{"label":"countryName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"countryName","searchable":true,"sortable":true}},"directionName":{"edit":{"label":"directionName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"directionName","searchable":true,"sortable":true}},"latitud":{"edit":{"label":"latitud","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"latitud","searchable":true,"sortable":true}},"longitud":{"edit":{"label":"longitud","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"longitud","searchable":true,"sortable":true}},"shipping_types":{"edit":{"label":"shipping_types","description":"","placeholder":"","visible":true,"editable":true,"mainField":"shippingType"},"list":{"label":"shipping_types","searchable":false,"sortable":false}},"brands":{"edit":{"label":"brands","description":"","placeholder":"","visible":true,"editable":true,"mainField":"brandName"},"list":{"label":"brands","searchable":false,"sortable":false}},"product_ratings":{"edit":{"label":"product_ratings","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"product_ratings","searchable":false,"sortable":false}},"averageRating":{"edit":{"label":"averageRating","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"averageRating","searchable":true,"sortable":true}},"totalRatings":{"edit":{"label":"totalRatings","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"totalRatings","searchable":true,"sortable":true}},"views":{"edit":{"label":"views","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"views","searchable":true,"sortable":true}},"favorites":{"edit":{"label":"favorites","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"favorites","searchable":false,"sortable":false}},"createBy":{"edit":{"label":"createBy","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"createBy","searchable":true,"sortable":true}},"users_permissions_users":{"edit":{"label":"users_permissions_users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users_permissions_users","searchable":false,"sortable":false}},"owner_id":{"edit":{"label":"owner_id","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"owner_id","searchable":true,"sortable":true}},"reactions":{"edit":{"label":"reactions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"nombre"},"list":{"label":"reactions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}}},"layouts":{"list":["id","productName","slug","description"],"edit":[[{"name":"productName","size":6},{"name":"slug","size":6}],[{"name":"description","size":6},{"name":"images","size":6}],[{"name":"brands","size":6},{"name":"categories","size":6}],[{"name":"shipping_types","size":6},{"name":"price","size":4}],[{"name":"active","size":4},{"name":"isFeatured","size":4}],[{"name":"weight","size":4},{"name":"dimensions","size":6}],[{"name":"State","size":6},{"name":"remaininWarranty","size":6}],[{"name":"dateManufactured","size":4}],[{"name":"directionName","size":6},{"name":"cityName","size":6}],[{"name":"provinceName","size":6},{"name":"countryName","size":6}],[{"name":"latitud","size":4},{"name":"longitud","size":4}],[{"name":"averageRating","size":4}],[{"name":"totalRatings","size":4},{"name":"product_ratings","size":6}],[{"name":"views","size":4},{"name":"favorites","size":6}],[{"name":"createBy","size":6},{"name":"users_permissions_users","size":6}],[{"name":"owner_id","size":6},{"name":"reactions","size":6}]]},"uid":"api::product.product"}	object	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
50	{"tables":[{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_documents_idx","columns":["document_id","locale","published_at"]},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_documents_idx","columns":["document_id","locale","published_at"]},{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_releases","indexes":[{"name":"strapi_releases_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"released_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timezone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_release_actions","indexes":[{"name":"strapi_release_actions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"entry_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_entry_valid","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows","indexes":[{"name":"strapi_workflows_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_types","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_workflows_stages","indexes":[{"name":"strapi_workflows_stages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_roles","indexes":[{"name":"up_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_users","indexes":[{"name":"up_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"user_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"brands","indexes":[{"name":"brands_documents_idx","columns":["document_id","locale","published_at"]},{"name":"brands_created_by_id_fk","columns":["created_by_id"]},{"name":"brands_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"brands_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"brands_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"brand_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"categories","indexes":[{"name":"categories_documents_idx","columns":["document_id","locale","published_at"]},{"name":"categories_created_by_id_fk","columns":["created_by_id"]},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"categories_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"category_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"favorites","indexes":[{"name":"favorites_documents_idx","columns":["document_id","locale","published_at"]},{"name":"favorites_created_by_id_fk","columns":["created_by_id"]},{"name":"favorites_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"favorites_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"favorites_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"image_generals","indexes":[{"name":"image_generals_documents_idx","columns":["document_id","locale","published_at"]},{"name":"image_generals_created_by_id_fk","columns":["created_by_id"]},{"name":"image_generals_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"image_generals_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"image_generals_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"image_general_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"text_general","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"links","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"products","indexes":[{"name":"products_documents_idx","columns":["document_id","locale","published_at"]},{"name":"products_created_by_id_fk","columns":["created_by_id"]},{"name":"products_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"products_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"products_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"product_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"price","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_featured","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"weight","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"dimensions","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"date_manufactured","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"remainin_warranty","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"state","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"city_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"province_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"country_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"direction_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"latitud","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"longitud","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"average_rating","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"total_ratings","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"views","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"create_by","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"owner_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"product_ratings","indexes":[{"name":"product_ratings_documents_idx","columns":["document_id","locale","published_at"]},{"name":"product_ratings_created_by_id_fk","columns":["created_by_id"]},{"name":"product_ratings_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"product_ratings_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"product_ratings_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rating","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"reactions","indexes":[{"name":"reactions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"reactions_created_by_id_fk","columns":["created_by_id"]},{"name":"reactions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"reactions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"reactions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"nombre","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tipo","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"descripcion","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timestamp","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"shipping_types","indexes":[{"name":"shipping_types_documents_idx","columns":["document_id","locale","published_at"]},{"name":"shipping_types_created_by_id_fk","columns":["created_by_id"]},{"name":"shipping_types_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"shipping_types_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"shipping_types_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"shipping_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name_shipping_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_users","indexes":[{"name":"admin_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_history_versions","indexes":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"]}],"foreignKeys":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"data","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"schema","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_related_mph","indexes":[{"name":"files_related_mph_fk","columns":["file_id"]},{"name":"files_related_mph_oidx","columns":["order"]},{"name":"files_related_mph_idix","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_mph_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_lnk","indexes":[{"name":"files_folder_lnk_fk","columns":["file_id"]},{"name":"files_folder_lnk_ifk","columns":["folder_id"]},{"name":"files_folder_lnk_uq","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_lnk_oifk","columns":["file_ord"]}],"foreignKeys":[{"name":"files_folder_lnk_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_lnk_ifk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_lnk","indexes":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"]},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_lnk_uq","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_lnk_oifk","columns":["folder_ord"]}],"foreignKeys":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_release_actions_release_lnk","indexes":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"]},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"]},{"name":"strapi_release_actions_release_lnk_uq","columns":["release_action_id","release_id"],"type":"unique"},{"name":"strapi_release_actions_release_lnk_oifk","columns":["release_action_ord"]}],"foreignKeys":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"],"referencedColumns":["id"],"referencedTable":"strapi_release_actions","onDelete":"CASCADE"},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"],"referencedColumns":["id"],"referencedTable":"strapi_releases","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"release_action_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_action_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stage_required_to_publish_lnk","indexes":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_uq","columns":["workflow_id","workflow_stage_id"],"type":"unique"}],"foreignKeys":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_workflow_lnk","indexes":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"]},{"name":"strapi_workflows_stages_workflow_lnk_uq","columns":["workflow_stage_id","workflow_id"],"type":"unique"},{"name":"strapi_workflows_stages_workflow_lnk_oifk","columns":["workflow_stage_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_permissions_lnk","indexes":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"]},{"name":"strapi_workflows_stages_permissions_lnk_uq","columns":["workflow_stage_id","permission_id"],"type":"unique"},{"name":"strapi_workflows_stages_permissions_lnk_ofk","columns":["permission_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_lnk","indexes":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"up_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_lnk","indexes":[{"name":"up_users_role_lnk_fk","columns":["user_id"]},{"name":"up_users_role_lnk_ifk","columns":["role_id"]},{"name":"up_users_role_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"up_users_role_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_product_ratings_lnk","indexes":[{"name":"up_users_product_ratings_lnk_fk","columns":["user_id"]},{"name":"up_users_product_ratings_lnk_ifk","columns":["product_rating_id"]},{"name":"up_users_product_ratings_lnk_uq","columns":["user_id","product_rating_id"],"type":"unique"},{"name":"up_users_product_ratings_lnk_ofk","columns":["product_rating_ord"]},{"name":"up_users_product_ratings_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"up_users_product_ratings_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_product_ratings_lnk_ifk","columns":["product_rating_id"],"referencedColumns":["id"],"referencedTable":"product_ratings","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_rating_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_rating_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"brands_products_lnk","indexes":[{"name":"brands_products_lnk_fk","columns":["brand_id"]},{"name":"brands_products_lnk_ifk","columns":["product_id"]},{"name":"brands_products_lnk_uq","columns":["brand_id","product_id"],"type":"unique"},{"name":"brands_products_lnk_ofk","columns":["product_ord"]},{"name":"brands_products_lnk_oifk","columns":["brand_ord"]}],"foreignKeys":[{"name":"brands_products_lnk_fk","columns":["brand_id"],"referencedColumns":["id"],"referencedTable":"brands","onDelete":"CASCADE"},{"name":"brands_products_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"brand_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"brand_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"favorites_products_lnk","indexes":[{"name":"favorites_products_lnk_fk","columns":["favorite_id"]},{"name":"favorites_products_lnk_ifk","columns":["product_id"]},{"name":"favorites_products_lnk_uq","columns":["favorite_id","product_id"],"type":"unique"},{"name":"favorites_products_lnk_ofk","columns":["product_ord"]},{"name":"favorites_products_lnk_oifk","columns":["favorite_ord"]}],"foreignKeys":[{"name":"favorites_products_lnk_fk","columns":["favorite_id"],"referencedColumns":["id"],"referencedTable":"favorites","onDelete":"CASCADE"},{"name":"favorites_products_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"favorite_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"favorite_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"favorites_users_permissions_user_lnk","indexes":[{"name":"favorites_users_permissions_user_lnk_fk","columns":["favorite_id"]},{"name":"favorites_users_permissions_user_lnk_ifk","columns":["user_id"]},{"name":"favorites_users_permissions_user_lnk_uq","columns":["favorite_id","user_id"],"type":"unique"}],"foreignKeys":[{"name":"favorites_users_permissions_user_lnk_fk","columns":["favorite_id"],"referencedColumns":["id"],"referencedTable":"favorites","onDelete":"CASCADE"},{"name":"favorites_users_permissions_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"favorite_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_categories_lnk","indexes":[{"name":"products_categories_lnk_fk","columns":["product_id"]},{"name":"products_categories_lnk_ifk","columns":["category_id"]},{"name":"products_categories_lnk_uq","columns":["product_id","category_id"],"type":"unique"},{"name":"products_categories_lnk_ofk","columns":["category_ord"]},{"name":"products_categories_lnk_oifk","columns":["product_ord"]}],"foreignKeys":[{"name":"products_categories_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_categories_lnk_ifk","columns":["category_id"],"referencedColumns":["id"],"referencedTable":"categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_shipping_types_lnk","indexes":[{"name":"products_shipping_types_lnk_fk","columns":["product_id"]},{"name":"products_shipping_types_lnk_ifk","columns":["shipping_type_id"]},{"name":"products_shipping_types_lnk_uq","columns":["product_id","shipping_type_id"],"type":"unique"},{"name":"products_shipping_types_lnk_ofk","columns":["shipping_type_ord"]},{"name":"products_shipping_types_lnk_oifk","columns":["product_ord"]}],"foreignKeys":[{"name":"products_shipping_types_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_shipping_types_lnk_ifk","columns":["shipping_type_id"],"referencedColumns":["id"],"referencedTable":"shipping_types","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"shipping_type_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"shipping_type_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_product_ratings_lnk","indexes":[{"name":"products_product_ratings_lnk_fk","columns":["product_id"]},{"name":"products_product_ratings_lnk_ifk","columns":["product_rating_id"]},{"name":"products_product_ratings_lnk_uq","columns":["product_id","product_rating_id"],"type":"unique"},{"name":"products_product_ratings_lnk_ofk","columns":["product_rating_ord"]},{"name":"products_product_ratings_lnk_oifk","columns":["product_ord"]}],"foreignKeys":[{"name":"products_product_ratings_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_product_ratings_lnk_ifk","columns":["product_rating_id"],"referencedColumns":["id"],"referencedTable":"product_ratings","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_rating_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_rating_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_users_permissions_users_lnk","indexes":[{"name":"products_users_permissions_users_lnk_fk","columns":["product_id"]},{"name":"products_users_permissions_users_lnk_ifk","columns":["user_id"]},{"name":"products_users_permissions_users_lnk_uq","columns":["product_id","user_id"],"type":"unique"},{"name":"products_users_permissions_users_lnk_ofk","columns":["user_ord"]},{"name":"products_users_permissions_users_lnk_oifk","columns":["product_ord"]}],"foreignKeys":[{"name":"products_users_permissions_users_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_users_permissions_users_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"reactions_product_lnk","indexes":[{"name":"reactions_product_lnk_fk","columns":["reaction_id"]},{"name":"reactions_product_lnk_ifk","columns":["product_id"]},{"name":"reactions_product_lnk_uq","columns":["reaction_id","product_id"],"type":"unique"},{"name":"reactions_product_lnk_oifk","columns":["reaction_ord"]}],"foreignKeys":[{"name":"reactions_product_lnk_fk","columns":["reaction_id"],"referencedColumns":["id"],"referencedTable":"reactions","onDelete":"CASCADE"},{"name":"reactions_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reaction_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"reaction_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"reactions_users_permissions_user_lnk","indexes":[{"name":"reactions_users_permissions_user_lnk_fk","columns":["reaction_id"]},{"name":"reactions_users_permissions_user_lnk_ifk","columns":["user_id"]},{"name":"reactions_users_permissions_user_lnk_uq","columns":["reaction_id","user_id"],"type":"unique"},{"name":"reactions_users_permissions_user_lnk_oifk","columns":["reaction_ord"]}],"foreignKeys":[{"name":"reactions_users_permissions_user_lnk_fk","columns":["reaction_id"],"referencedColumns":["id"],"referencedTable":"reactions","onDelete":"CASCADE"},{"name":"reactions_users_permissions_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"reaction_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"reaction_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_role_lnk","indexes":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"admin_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_lnk","indexes":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"]},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"]},{"name":"admin_users_roles_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_lnk_ofk","columns":["role_ord"]},{"name":"admin_users_roles_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_lnk","indexes":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_lnk_uq","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_lnk_oifk","columns":["api_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_lnk","indexes":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_uq","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_lnk_oifk","columns":["transfer_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2025-05-01 17:49:10.22	cc9b45d017c72493925d7a74a1667740
\.


--
-- Data for Name: strapi_history_versions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_history_versions (id, content_type, related_document_id, locale, status, data, schema, created_at, created_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: strapi_migrations_internal; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_migrations_internal (id, name, "time") FROM stdin;
1	5.0.0-rename-identifiers-longer-than-max-length	2025-04-14 19:18:03.931
2	5.0.0-02-created-document-id	2025-04-14 19:18:03.949
3	5.0.0-03-created-locale	2025-04-14 19:18:03.965
4	5.0.0-04-created-published-at	2025-04-14 19:18:03.979
5	5.0.0-05-drop-slug-fields-index	2025-04-14 19:18:03.992
6	core::5.0.0-discard-drafts	2025-04-14 19:18:04.007
\.


--
-- Data for Name: strapi_release_actions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_release_actions (id, document_id, type, content_type, entry_document_id, locale, is_entry_valid, created_at, updated_at, published_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_release_actions_release_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_release_actions_release_lnk (id, release_action_id, release_id, release_action_ord) FROM stdin;
\.


--
-- Data for Name: strapi_releases; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_releases (id, document_id, name, released_at, scheduled_at, timezone, status, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_transfer_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_transfer_token_permissions_token_lnk (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_transfer_tokens (id, document_id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: strapi_workflows; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_workflows (id, document_id, name, content_types, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_workflows_stage_required_to_publish_lnk (id, workflow_id, workflow_stage_id) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_workflows_stages (id, document_id, name, color, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_permissions_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_workflows_stages_permissions_lnk (id, workflow_stage_id, permission_id, permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_workflow_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.strapi_workflows_stages_workflow_lnk (id, workflow_stage_id, workflow_id, workflow_stage_ord) FROM stdin;
\.


--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.up_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	ps9nju0sywc82qnl3atjfdbq	plugin::users-permissions.user.me	2025-04-14 19:18:04.33	2025-04-14 19:18:04.33	2025-04-14 19:18:04.33	\N	\N	\N
2	u3fgm5xoifdhy0gxm92sc2ro	plugin::users-permissions.auth.changePassword	2025-04-14 19:18:04.33	2025-04-14 19:18:04.33	2025-04-14 19:18:04.33	\N	\N	\N
3	vqg1714awtyvngojqsk2lxmb	plugin::users-permissions.auth.connect	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	\N	\N	\N
4	z4wlbbxbmgs7zu38yrwt14df	plugin::users-permissions.auth.callback	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	\N	\N	\N
7	wdwkct9b28f7kz3q2p2369y7	plugin::users-permissions.auth.forgotPassword	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	\N	\N	\N
5	s13a4q88tu3oxlhsdt7mif3a	plugin::users-permissions.auth.resetPassword	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	\N	\N	\N
6	cwfntfb8q01m0nix80foduxu	plugin::users-permissions.auth.register	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	\N	\N	\N
8	xcxsaljr7prvsqrhywv80a3j	plugin::users-permissions.auth.emailConfirmation	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	\N	\N	\N
9	ay5gabb9iifvl2fyodvfd8bt	plugin::users-permissions.auth.sendEmailConfirmation	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	2025-04-14 19:18:04.334	\N	\N	\N
10	c4iqlddcsj98f6x2w59ozxkn	api::category.category.find	2025-04-18 19:37:28.455	2025-04-18 19:37:28.455	2025-04-18 19:37:28.456	\N	\N	\N
11	gk9k2decvtno60a0i8bgzos1	api::category.category.findOne	2025-04-18 19:37:28.455	2025-04-18 19:37:28.455	2025-04-18 19:37:28.456	\N	\N	\N
12	sn994q5hhmvbc3uen6fa6nif	api::product.product.findOne	2025-04-18 19:37:28.455	2025-04-18 19:37:28.455	2025-04-18 19:37:28.457	\N	\N	\N
13	dr2sitsb14ad8f93vmcspb6v	api::product.product.find	2025-04-18 19:37:28.455	2025-04-18 19:37:28.455	2025-04-18 19:37:28.457	\N	\N	\N
14	uhdx8hmxkww61pcfm0otncgx	api::brand.brand.find	2025-04-18 19:40:37.557	2025-04-18 19:40:37.557	2025-04-18 19:40:37.558	\N	\N	\N
15	p68wdq7w7jexken5hqz407fs	api::brand.brand.findOne	2025-04-18 19:40:37.557	2025-04-18 19:40:37.557	2025-04-18 19:40:37.558	\N	\N	\N
16	rlk33zyjtoyexedj6x0q8ogl	api::image-general.image-general.find	2025-04-18 19:40:37.557	2025-04-18 19:40:37.557	2025-04-18 19:40:37.558	\N	\N	\N
17	r3brqnp9dkq1rrweznmunp4h	api::image-general.image-general.findOne	2025-04-18 19:40:37.557	2025-04-18 19:40:37.557	2025-04-18 19:40:37.558	\N	\N	\N
18	q9ssbzokj9mhs77m6l4c401z	api::shipping-type.shipping-type.find	2025-04-18 19:40:37.557	2025-04-18 19:40:37.557	2025-04-18 19:40:37.559	\N	\N	\N
19	cuwzxbej78w3nn4j73ap4kpn	api::shipping-type.shipping-type.findOne	2025-04-18 19:40:37.558	2025-04-18 19:40:37.558	2025-04-18 19:40:37.559	\N	\N	\N
20	w3fu0o6ljs4tr382ds05fb3u	plugin::content-type-builder.components.getComponents	2025-04-18 19:40:37.558	2025-04-18 19:40:37.558	2025-04-18 19:40:37.559	\N	\N	\N
21	cy4li4j9hx5ywvu7axinv8rc	plugin::content-type-builder.content-types.getContentType	2025-04-18 19:40:37.558	2025-04-18 19:40:37.558	2025-04-18 19:40:37.559	\N	\N	\N
23	hocm4w3mffsuqvh4d36qfp6m	plugin::content-type-builder.components.getComponent	2025-04-18 19:40:37.558	2025-04-18 19:40:37.558	2025-04-18 19:40:37.559	\N	\N	\N
22	cyh5kkghirwktns4lddko3wt	plugin::content-type-builder.content-types.getContentTypes	2025-04-18 19:40:37.558	2025-04-18 19:40:37.558	2025-04-18 19:40:37.559	\N	\N	\N
24	z62or3ymfvx4ctigb4gkpkr2	api::product.product.find	2025-04-20 17:53:26.254	2025-04-20 17:53:26.254	2025-04-20 17:53:26.254	\N	\N	\N
25	hik5ne1grjvisb9gcwvru6az	api::product.product.findOne	2025-04-20 17:53:26.254	2025-04-20 17:53:26.254	2025-04-20 17:53:26.254	\N	\N	\N
26	nvdhnjx1wbcatlouzs4l89vo	api::brand.brand.find	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.216	\N	\N	\N
27	pmkqsf1zda06p76sfpq1hawq	api::brand.brand.findOne	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.216	\N	\N	\N
28	k8rm8ral1ht9srd7mscn6xd5	api::category.category.find	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.217	\N	\N	\N
29	yuyuvhy3lhyov5loxhodfqj9	api::category.category.findOne	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.217	\N	\N	\N
30	vdjaq4a8d354ekv9d7nh8fpz	api::image-general.image-general.find	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.218	\N	\N	\N
31	nfq1l36mqk70q8x99uckrr5e	api::image-general.image-general.findOne	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.218	\N	\N	\N
32	im60pbta7pumkitsu55an6ma	plugin::content-type-builder.components.getComponents	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.219	\N	\N	\N
33	fxpsscf6hp0jh9vlvy1xit35	api::shipping-type.shipping-type.findOne	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.219	\N	\N	\N
34	fly5rx5oaepnemukvg5v133h	api::shipping-type.shipping-type.find	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.219	\N	\N	\N
37	s3kamayosmc9e4bbdxl5v54q	plugin::content-type-builder.content-types.getContentType	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.22	\N	\N	\N
35	jzywylse5elg5c6vrokdqywp	plugin::content-type-builder.content-types.getContentTypes	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.22	\N	\N	\N
36	i6kkz4xfkcjpogn8e4u64ev3	plugin::content-type-builder.components.getComponent	2025-04-20 21:14:28.215	2025-04-20 21:14:28.215	2025-04-20 21:14:28.22	\N	\N	\N
38	u37ftc4ik7vph03g7r4ujequ	api::product-rating.product-rating.find	2025-04-26 09:49:32.88	2025-04-26 09:49:32.88	2025-04-26 09:49:32.88	\N	\N	\N
39	q8969u6y0o4p73h7arc72atr	api::product-rating.product-rating.findOne	2025-04-26 09:49:32.88	2025-04-26 09:49:32.88	2025-04-26 09:49:32.88	\N	\N	\N
40	rm5bxn49l3hxasl12dickq1h	api::product-rating.product-rating.create	2025-04-26 10:04:24.342	2025-04-26 10:04:24.342	2025-04-26 10:04:24.342	\N	\N	\N
41	zg69534le85aiwudnvdrz7mg	api::product-rating.product-rating.update	2025-04-26 10:04:24.342	2025-04-26 10:04:24.342	2025-04-26 10:04:24.342	\N	\N	\N
42	v7if2zaw6ahzkb3j8kr34xcy	api::product-rating.product-rating.delete	2025-04-26 10:04:24.342	2025-04-26 10:04:24.342	2025-04-26 10:04:24.342	\N	\N	\N
44	ijbjwuxn729afjr5le8n1cnn	api::product-rating.product-rating.findOne	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	\N	\N	\N
43	ar9odkpodyow0ir9vato2gm5	api::product-rating.product-rating.find	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	\N	\N	\N
45	jadxedaiirwscivxlj4hhaao	api::product-rating.product-rating.create	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	\N	\N	\N
46	x6aotnhoca3auwrtd7o5fbcz	api::product-rating.product-rating.update	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	\N	\N	\N
47	b1y93b7u1pj9gw235gk2tvda	api::product-rating.product-rating.delete	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	2025-04-26 10:26:46.163	\N	\N	\N
48	rkgarfg2tst675p46d3bptln	api::product.product.update	2025-04-26 11:02:20.713	2025-04-26 11:02:20.713	2025-04-26 11:02:20.714	\N	\N	\N
49	l4omxvr649uyfbjvo4y362vg	api::favorite.favorite.find	2025-04-27 18:58:39.941	2025-04-27 18:58:39.941	2025-04-27 18:58:39.941	\N	\N	\N
50	c6hhm37ig6pqeojl9bccexy6	api::favorite.favorite.create	2025-04-27 18:58:39.941	2025-04-27 18:58:39.941	2025-04-27 18:58:39.942	\N	\N	\N
51	vlfdbrlxs5mi9crlkq8w1p3n	api::favorite.favorite.findOne	2025-04-27 18:58:39.941	2025-04-27 18:58:39.941	2025-04-27 18:58:39.941	\N	\N	\N
52	qd3t05vuprkagm7b2oe9xrcl	api::favorite.favorite.update	2025-04-27 18:58:39.941	2025-04-27 18:58:39.941	2025-04-27 18:58:39.942	\N	\N	\N
53	pk6y1rmnyjh2l4rqojcpp2mu	api::favorite.favorite.delete	2025-04-27 18:58:39.941	2025-04-27 18:58:39.941	2025-04-27 18:58:39.942	\N	\N	\N
54	s0k40u62zoimv84dwob577np	api::favorite.favorite.find	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	\N	\N	\N
55	qvrmcbv5cnl633svu0mlv6m5	api::favorite.favorite.findOne	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	\N	\N	\N
56	kmof07goipf2xr94vldy9nqu	api::favorite.favorite.create	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	\N	\N	\N
57	ayhunjuubjtnkaivsolbrb7b	api::favorite.favorite.update	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	2025-04-27 18:59:26.328	\N	\N	\N
58	qb9sfnvo77ewent93s0pzuyo	api::favorite.favorite.delete	2025-04-27 18:59:26.327	2025-04-27 18:59:26.327	2025-04-27 18:59:26.328	\N	\N	\N
59	hr46b4nzxs9u04g7vzvtk2nc	api::product.product.create	2025-04-27 19:04:57.002	2025-04-27 19:04:57.002	2025-04-27 19:04:57.002	\N	\N	\N
60	pdw8jsq4b9ghzfz7u0y1hd3y	api::product.product.delete	2025-04-27 19:04:57.002	2025-04-27 19:04:57.002	2025-04-27 19:04:57.002	\N	\N	\N
61	inv673gnk45kubipkw36z7t6	api::product.product.delete	2025-04-27 21:59:24.138	2025-04-27 21:59:24.138	2025-04-27 21:59:24.139	\N	\N	\N
62	i3tbdsszhikir3ckfjfsov4e	api::product.product.create	2025-04-27 21:59:24.138	2025-04-27 21:59:24.138	2025-04-27 21:59:24.138	\N	\N	\N
63	ibzon2mcnsjwxl60ctwy8slf	api::product.product.update	2025-04-27 21:59:24.138	2025-04-27 21:59:24.138	2025-04-27 21:59:24.139	\N	\N	\N
64	cnf2lknjq25trl2ucmx4q52r	plugin::email.email.send	2025-04-29 21:02:03.092	2025-04-29 21:02:03.092	2025-04-29 21:02:03.093	\N	\N	\N
65	kz7hzotw74fcan5058zb0c9e	plugin::upload.content-api.find	2025-04-29 21:02:03.092	2025-04-29 21:02:03.092	2025-04-29 21:02:03.093	\N	\N	\N
66	q6b48a4lbnqzuzo7fomxu1s5	plugin::upload.content-api.findOne	2025-04-29 21:02:03.092	2025-04-29 21:02:03.092	2025-04-29 21:02:03.093	\N	\N	\N
67	lequt9dlup0kb8zlsusiv1k1	plugin::upload.content-api.destroy	2025-04-29 21:02:03.092	2025-04-29 21:02:03.092	2025-04-29 21:02:03.094	\N	\N	\N
68	a7mp6tgcbn76g2qp3hzit16q	plugin::upload.content-api.upload	2025-04-29 21:02:03.092	2025-04-29 21:02:03.092	2025-04-29 21:02:03.094	\N	\N	\N
69	jbfs17rhiqkosiujtim5zl7i	plugin::users-permissions.role.findOne	2025-04-29 21:07:22.975	2025-04-29 21:07:22.975	2025-04-29 21:07:22.975	\N	\N	\N
70	zye636n19z8hs24rxtbxrcs8	plugin::users-permissions.role.find	2025-04-29 21:07:22.975	2025-04-29 21:07:22.975	2025-04-29 21:07:22.975	\N	\N	\N
71	h7r81xl1dv4ec0twjepgdyqi	plugin::users-permissions.permissions.getPermissions	2025-04-29 21:38:17.475	2025-04-29 21:38:17.475	2025-04-29 21:38:17.476	\N	\N	\N
72	yhjmzuynywl5o4nravj4gdi0	api::reaction.reaction.find	2025-05-01 19:03:55.703	2025-05-01 19:03:55.703	2025-05-01 19:03:55.704	\N	\N	\N
73	vxu7w5f6h56usiogdd0hxz32	api::reaction.reaction.create	2025-05-01 19:03:55.703	2025-05-01 19:03:55.703	2025-05-01 19:03:55.705	\N	\N	\N
74	mhimbaj33fcwuex9vc7aeyf1	api::reaction.reaction.findOne	2025-05-01 19:03:55.703	2025-05-01 19:03:55.703	2025-05-01 19:03:55.704	\N	\N	\N
75	u54k2uxjos1rja9mq51l6y7t	api::reaction.reaction.update	2025-05-01 19:03:55.703	2025-05-01 19:03:55.703	2025-05-01 19:03:55.705	\N	\N	\N
76	r7oaf24r4x90g67h6y15d7ne	api::reaction.reaction.delete	2025-05-01 19:03:55.703	2025-05-01 19:03:55.703	2025-05-01 19:03:55.706	\N	\N	\N
77	op6pnifgpp2upiepp0etsc6t	api::reaction.reaction.find	2025-05-01 19:24:23.224	2025-05-01 19:24:23.224	2025-05-01 19:24:23.224	\N	\N	\N
78	av8pbsmmflt6e3mth4hdzqvd	api::reaction.reaction.findOne	2025-05-01 19:24:23.224	2025-05-01 19:24:23.224	2025-05-01 19:24:23.225	\N	\N	\N
\.


--
-- Data for Name: up_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.up_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	1	1
2	2	1	1
3	3	2	1
4	4	2	1
5	7	2	1
6	9	2	1
7	6	2	1
8	5	2	1
9	8	2	2
10	13	2	3
11	11	2	3
12	10	2	3
13	12	2	3
14	16	2	4
15	15	2	4
16	14	2	4
18	23	2	4
17	17	2	4
19	19	2	4
20	20	2	5
21	18	2	4
22	22	2	5
23	21	2	5
24	24	1	2
25	25	1	3
26	27	1	4
27	30	1	4
28	26	1	4
29	31	1	4
30	28	1	4
31	34	1	4
32	29	1	4
33	33	1	4
34	32	1	4
35	35	1	5
36	37	1	5
37	36	1	5
38	38	2	6
39	39	2	6
40	40	2	7
41	41	2	7
42	42	2	8
43	44	1	6
44	45	1	6
45	43	1	6
46	47	1	7
47	46	1	7
48	48	2	9
49	50	2	10
50	51	2	10
51	49	2	10
52	52	2	11
53	53	2	11
54	54	1	8
55	55	1	8
56	56	1	8
57	58	1	9
58	57	1	9
59	59	2	12
60	60	2	13
61	61	1	10
62	62	1	10
63	63	1	11
64	64	1	12
65	65	1	12
66	68	1	12
67	66	1	12
68	67	1	13
69	69	1	14
70	70	1	15
71	71	1	16
72	72	1	17
73	74	1	17
74	73	1	17
75	75	1	18
76	76	1	18
77	78	2	14
78	77	2	14
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.up_roles (id, document_id, name, description, type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	en6dr53lyxsdi8xeoclld0n2	Authenticated	Default role given to authenticated user.	authenticated	2025-04-14 19:18:04.326	2025-05-01 19:11:04.857	2025-04-14 19:18:04.326	\N	\N	\N
2	fiis7geysekpl7vpoqhwuaxn	Public	Default role given to unauthenticated user.	public	2025-04-14 19:18:04.327	2025-05-01 19:24:23.218	2025-04-14 19:18:04.327	\N	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.up_users (id, document_id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, user_id) FROM stdin;
1	nrbtq4714ycfnzrndlgi92ge	test_user	test@example.com	local	$2a$10$MskqMZPpDfU2S3CWOCaay.wsC4Fx2c4WxtSYtuCrJEUAUNcC.5iVa	\N	\N	t	f	2025-04-27 19:43:30.24	2025-04-27 20:01:50.9	2025-04-27 20:01:50.823	\N	1	\N	\N
2	dijmmldo638hhq144w891ay4	testuser	testuser@example.com	local	$2a$10$IpEu8rS.HR9FNYfxr0VtC.D0si3JoWuFae3TNgrZNJL8yKXRtHvGy	\N	\N	t	f	2025-04-27 20:09:42.862	2025-04-27 20:09:42.862	2025-04-27 20:09:42.862	\N	\N	\N	\N
3	hc82z0ar5q26bngrttuwnull	yop	yopsn80@gmail.com	local	$2a$10$amTAmsdJkEb.48hwd.Gg9u2GRZRsAu4SDovii0jIJLHzPbcOIgM0e	\N	\N	t	f	2025-04-27 20:16:55.261	2025-04-27 20:16:55.261	2025-04-27 20:16:55.261	\N	\N	\N	\N
\.


--
-- Data for Name: up_users_product_ratings_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.up_users_product_ratings_lnk (id, user_id, product_rating_id, product_rating_ord, user_ord) FROM stdin;
\.


--
-- Data for Name: up_users_role_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.up_users_role_lnk (id, user_id, role_id, user_ord) FROM stdin;
1	1	1	1
2	2	1	2
3	3	1	3
\.


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.upload_folders (id, document_id, name, path_id, path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	wxwsjgae4yosaxn0fp86uo5d	brand	1	/1	2025-04-15 17:37:27.869	2025-04-15 17:37:27.869	2025-04-15 17:37:27.869	1	1	\N
2	dt8meufus73mub7elw2hynnt	productos	2	/2	2025-04-15 20:16:52.579	2025-04-15 20:16:52.579	2025-04-15 20:16:52.58	1	1	\N
3	t3psuf694h41ocl7f1sb9vnh	prusa	3	/2/3	2025-04-15 20:17:03.438	2025-04-15 20:17:03.438	2025-04-15 20:17:03.439	1	1	\N
4	g665m91bshbd7nh7g1g9ks78	ender	4	/2/4	2025-04-15 20:23:43.866	2025-04-15 20:23:43.866	2025-04-15 20:23:43.866	1	1	\N
5	ildr6t4gyx2tr81vl8nlv6wf	ultimaker	5	/2/5	2025-04-15 20:28:35.662	2025-04-15 20:28:35.662	2025-04-15 20:28:35.662	1	1	\N
6	uo09ab30ayuf71c12rxw3vs8	formlab	6	/2/6	2025-04-15 20:33:10.942	2025-04-15 20:33:10.942	2025-04-15 20:33:10.943	1	1	\N
7	vb3b21tw109mqnjvtfgklukx	anycubic	7	/2/7	2025-04-15 20:38:51.737	2025-04-15 20:38:51.737	2025-04-15 20:38:51.737	1	1	\N
8	stcvsn7vbtck83ewm9fud11t	bambu	8	/2/8	2025-04-15 20:47:59.542	2025-04-15 20:47:59.542	2025-04-15 20:47:59.542	1	1	\N
9	nzxvrgjnj5g5ka2ph6h17rj5	elegoo	9	/2/9	2025-04-15 20:57:43.938	2025-04-15 20:57:43.938	2025-04-15 20:57:43.938	1	1	\N
10	cc9k9ycyxkq6n6a7cs5lhp6k	qidi	10	/2/10	2025-04-15 21:06:31.853	2025-04-15 21:06:31.853	2025-04-15 21:06:31.853	1	1	\N
11	hbzxp7zzo3pyu83hch3x0vj0	artillery	11	/2/11	2025-04-15 21:10:41.948	2025-04-15 21:10:41.948	2025-04-15 21:10:41.948	1	1	\N
12	sw6azak2vu1wg7na5gedkduf	sovol	12	/2/12	2025-04-15 21:23:51.249	2025-04-15 21:23:51.249	2025-04-15 21:23:51.249	1	1	\N
13	dly0zgo6p8epdwukg6gi7v0m	flsun	13	/2/13	2025-04-15 21:28:55.479	2025-04-15 21:28:55.479	2025-04-15 21:28:55.479	1	1	\N
14	jp39mj6giigtb4tb22dju68b	kingroon	14	/2/14	2025-04-15 21:33:42.534	2025-04-15 21:33:42.534	2025-04-15 21:33:42.534	1	1	\N
15	mz254p3hlfpzixfcs28f94x8	phrozen	15	/2/15	2025-04-15 21:41:55.206	2025-04-15 21:41:55.206	2025-04-15 21:41:55.206	1	1	\N
48	jx2drf7qceo8jnxhto3yipxa	nova	16	/2/16	2025-04-15 22:11:46.477	2025-04-15 22:11:46.477	2025-04-15 22:11:46.477	1	1	\N
49	v8pggk1im34ftof2u0adadcv	epax	17	/2/17	2025-04-15 22:16:06.409	2025-04-15 22:16:06.409	2025-04-15 22:16:06.409	1	1	\N
50	rgfx8eult0iofgqz44pkkzoz	voxelab	18	/2/18	2025-04-15 22:21:23.156	2025-04-15 22:21:23.156	2025-04-15 22:21:23.156	1	1	\N
51	nrojk3etti92nfxoretvcuux	bigtreetech	19	/2/19	2025-04-16 20:56:57.674	2025-04-16 20:56:57.674	2025-04-16 20:56:57.674	1	1	\N
52	qnityo572lri5x4jmjyth9ck	e3d	20	/2/20	2025-04-16 21:05:00.201	2025-04-16 21:05:00.201	2025-04-16 21:05:00.201	1	1	\N
53	kk8i5yrlosx27lzwvtidmhx1	bltouch	21	/2/21	2025-04-16 21:11:37.704	2025-04-16 21:11:37.704	2025-04-16 21:11:37.704	1	1	\N
54	gknnkx1nya5xy5j2qhpahyw4	noctua	22	/2/22	2025-04-16 21:27:59.839	2025-04-16 21:27:59.839	2025-04-16 21:27:59.839	1	1	\N
55	t26dgcqbmv9oj83oevicunkm	8020	23	/2/23	2025-04-16 21:57:39.31	2025-04-16 21:57:39.31	2025-04-16 21:57:39.31	1	1	\N
56	doqf6rh3v4s750p1tqae39y6	3dfils	24	/2/24	2025-04-17 11:12:19.612	2025-04-17 11:12:19.612	2025-04-17 11:12:19.613	1	1	\N
57	n1vomzm0xorbifx26g727pnx	category	25	/25	2025-04-17 11:52:37.404	2025-04-17 11:52:37.404	2025-04-17 11:52:37.404	1	1	\N
58	v5sbxk2f1l8lsb2ena9t3t72	shippingType	26	/26	2025-04-17 11:57:22.589	2025-04-17 11:57:22.589	2025-04-17 11:57:22.589	1	1	\N
59	vwsf0tqp2jwrvwa7n52upbj4	firstCarrusel	27	/27	2025-04-19 19:06:07.44	2025-04-19 19:06:07.44	2025-04-19 19:06:07.441	1	1	\N
\.


--
-- Data for Name: upload_folders_parent_lnk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.upload_folders_parent_lnk (id, folder_id, inv_folder_id, folder_ord) FROM stdin;
1	3	2	1
2	4	2	2
3	5	2	3
4	6	2	4
5	7	2	5
6	8	2	6
7	9	2	7
8	10	2	8
9	11	2	9
10	12	2	10
11	13	2	11
12	14	2	12
13	15	2	13
46	48	2	14
47	49	2	15
48	50	2	16
49	51	2	17
50	52	2	18
51	53	2	19
52	54	2	20
53	55	2	21
54	56	2	22
\.


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 351, true);


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.admin_permissions_role_lnk_id_seq', 351, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.admin_users_roles_lnk_id_seq', 1, true);


--
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.brands_id_seq', 54, true);


--
-- Name: brands_products_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.brands_products_lnk_id_seq', 385, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.categories_id_seq', 19, true);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.favorites_id_seq', 24, true);


--
-- Name: favorites_products_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.favorites_products_lnk_id_seq', 74, true);


--
-- Name: favorites_users_permissions_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.favorites_users_permissions_user_lnk_id_seq', 1, false);


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.files_folder_lnk_id_seq', 297, true);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.files_id_seq', 295, true);


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.files_related_mph_id_seq', 2458, true);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);


--
-- Name: image_generals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.image_generals_id_seq', 12, true);


--
-- Name: product_ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.product_ratings_id_seq', 33, true);


--
-- Name: products_categories_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_categories_lnk_id_seq', 529, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_id_seq', 524, true);


--
-- Name: products_product_ratings_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_product_ratings_lnk_id_seq', 116, true);


--
-- Name: products_shipping_types_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_shipping_types_lnk_id_seq', 536, true);


--
-- Name: products_users_permissions_users_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.products_users_permissions_users_lnk_id_seq', 1, false);


--
-- Name: reactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.reactions_id_seq', 32, true);


--
-- Name: reactions_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.reactions_product_lnk_id_seq', 97, true);


--
-- Name: reactions_users_permissions_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.reactions_users_permissions_user_lnk_id_seq', 1, false);


--
-- Name: shipping_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shipping_types_id_seq', 13, true);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 3, true);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 40, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 50, true);


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_history_versions_id_seq', 1, false);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_migrations_internal_id_seq', 6, true);


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_release_actions_id_seq', 1, false);


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_release_actions_release_lnk_id_seq', 1, false);


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_releases_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_workflows_id_seq', 1, false);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_permissions_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_workflow_lnk_id_seq', 1, false);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 78, true);


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.up_permissions_role_lnk_id_seq', 78, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.up_users_id_seq', 3, true);


--
-- Name: up_users_product_ratings_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.up_users_product_ratings_lnk_id_seq', 1, false);


--
-- Name: up_users_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.up_users_role_lnk_id_seq', 3, true);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 59, true);


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.upload_folders_parent_lnk_id_seq', 54, true);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: brands_products_lnk brands_products_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands_products_lnk
    ADD CONSTRAINT brands_products_lnk_pkey PRIMARY KEY (id);


--
-- Name: brands_products_lnk brands_products_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands_products_lnk
    ADD CONSTRAINT brands_products_lnk_uq UNIQUE (brand_id, product_id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: favorites_products_lnk favorites_products_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_products_lnk
    ADD CONSTRAINT favorites_products_lnk_pkey PRIMARY KEY (id);


--
-- Name: favorites_products_lnk favorites_products_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_products_lnk
    ADD CONSTRAINT favorites_products_lnk_uq UNIQUE (favorite_id, product_id);


--
-- Name: favorites_users_permissions_user_lnk favorites_users_permissions_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_users_permissions_user_lnk
    ADD CONSTRAINT favorites_users_permissions_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: favorites_users_permissions_user_lnk favorites_users_permissions_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_users_permissions_user_lnk
    ADD CONSTRAINT favorites_users_permissions_user_lnk_uq UNIQUE (favorite_id, user_id);


--
-- Name: files_folder_lnk files_folder_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_uq UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_mph files_related_mph_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_pkey PRIMARY KEY (id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: image_generals image_generals_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.image_generals
    ADD CONSTRAINT image_generals_pkey PRIMARY KEY (id);


--
-- Name: product_ratings product_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT product_ratings_pkey PRIMARY KEY (id);


--
-- Name: products_categories_lnk products_categories_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_categories_lnk products_categories_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_uq UNIQUE (product_id, category_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products_product_ratings_lnk products_product_ratings_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_product_ratings_lnk
    ADD CONSTRAINT products_product_ratings_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_product_ratings_lnk products_product_ratings_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_product_ratings_lnk
    ADD CONSTRAINT products_product_ratings_lnk_uq UNIQUE (product_id, product_rating_id);


--
-- Name: products_shipping_types_lnk products_shipping_types_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_shipping_types_lnk
    ADD CONSTRAINT products_shipping_types_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_shipping_types_lnk products_shipping_types_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_shipping_types_lnk
    ADD CONSTRAINT products_shipping_types_lnk_uq UNIQUE (product_id, shipping_type_id);


--
-- Name: products_users_permissions_users_lnk products_users_permissions_users_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_users_permissions_users_lnk
    ADD CONSTRAINT products_users_permissions_users_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_users_permissions_users_lnk products_users_permissions_users_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_users_permissions_users_lnk
    ADD CONSTRAINT products_users_permissions_users_lnk_uq UNIQUE (product_id, user_id);


--
-- Name: reactions reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_pkey PRIMARY KEY (id);


--
-- Name: reactions_product_lnk reactions_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_product_lnk
    ADD CONSTRAINT reactions_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: reactions_product_lnk reactions_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_product_lnk
    ADD CONSTRAINT reactions_product_lnk_uq UNIQUE (reaction_id, product_id);


--
-- Name: reactions_users_permissions_user_lnk reactions_users_permissions_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_users_permissions_user_lnk
    ADD CONSTRAINT reactions_users_permissions_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: reactions_users_permissions_user_lnk reactions_users_permissions_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_users_permissions_user_lnk
    ADD CONSTRAINT reactions_users_permissions_user_lnk_uq UNIQUE (reaction_id, user_id);


--
-- Name: shipping_types shipping_types_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shipping_types
    ADD CONSTRAINT shipping_types_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_uq UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_history_versions strapi_history_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations_internal strapi_migrations_internal_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_migrations_internal
    ADD CONSTRAINT strapi_migrations_internal_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions strapi_release_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_uq UNIQUE (release_action_id, release_id);


--
-- Name: strapi_releases strapi_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_uq UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows strapi_workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_uq UNIQUE (workflow_id, workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_uq UNIQUE (workflow_stage_id, permission_id);


--
-- Name: strapi_workflows_stages strapi_workflows_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_uq UNIQUE (workflow_stage_id, workflow_id);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: up_users_product_ratings_lnk up_users_product_ratings_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_product_ratings_lnk
    ADD CONSTRAINT up_users_product_ratings_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_users_product_ratings_lnk up_users_product_ratings_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_product_ratings_lnk
    ADD CONSTRAINT up_users_product_ratings_lnk_uq UNIQUE (user_id, product_rating_id);


--
-- Name: up_users_role_lnk up_users_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_users_role_lnk up_users_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_uq UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_permissions_documents_idx ON public.admin_permissions USING btree (document_id, locale, published_at);


--
-- Name: admin_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_permissions_role_lnk_fk ON public.admin_permissions_role_lnk USING btree (permission_id);


--
-- Name: admin_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_permissions_role_lnk_ifk ON public.admin_permissions_role_lnk USING btree (role_id);


--
-- Name: admin_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_permissions_role_lnk_oifk ON public.admin_permissions_role_lnk USING btree (permission_ord);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_roles_documents_idx ON public.admin_roles USING btree (document_id, locale, published_at);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_users_documents_idx ON public.admin_users USING btree (document_id, locale, published_at);


--
-- Name: admin_users_roles_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_users_roles_lnk_fk ON public.admin_users_roles_lnk USING btree (user_id);


--
-- Name: admin_users_roles_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_users_roles_lnk_ifk ON public.admin_users_roles_lnk USING btree (role_id);


--
-- Name: admin_users_roles_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_users_roles_lnk_ofk ON public.admin_users_roles_lnk USING btree (role_ord);


--
-- Name: admin_users_roles_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_users_roles_lnk_oifk ON public.admin_users_roles_lnk USING btree (user_ord);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: brands_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX brands_created_by_id_fk ON public.brands USING btree (created_by_id);


--
-- Name: brands_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX brands_documents_idx ON public.brands USING btree (document_id, locale, published_at);


--
-- Name: brands_products_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX brands_products_lnk_fk ON public.brands_products_lnk USING btree (brand_id);


--
-- Name: brands_products_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX brands_products_lnk_ifk ON public.brands_products_lnk USING btree (product_id);


--
-- Name: brands_products_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX brands_products_lnk_ofk ON public.brands_products_lnk USING btree (product_ord);


--
-- Name: brands_products_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX brands_products_lnk_oifk ON public.brands_products_lnk USING btree (brand_ord);


--
-- Name: brands_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX brands_updated_by_id_fk ON public.brands USING btree (updated_by_id);


--
-- Name: categories_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX categories_created_by_id_fk ON public.categories USING btree (created_by_id);


--
-- Name: categories_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX categories_documents_idx ON public.categories USING btree (document_id, locale, published_at);


--
-- Name: categories_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX categories_updated_by_id_fk ON public.categories USING btree (updated_by_id);


--
-- Name: favorites_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_created_by_id_fk ON public.favorites USING btree (created_by_id);


--
-- Name: favorites_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_documents_idx ON public.favorites USING btree (document_id, locale, published_at);


--
-- Name: favorites_products_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_products_lnk_fk ON public.favorites_products_lnk USING btree (favorite_id);


--
-- Name: favorites_products_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_products_lnk_ifk ON public.favorites_products_lnk USING btree (product_id);


--
-- Name: favorites_products_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_products_lnk_ofk ON public.favorites_products_lnk USING btree (product_ord);


--
-- Name: favorites_products_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_products_lnk_oifk ON public.favorites_products_lnk USING btree (favorite_ord);


--
-- Name: favorites_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_updated_by_id_fk ON public.favorites USING btree (updated_by_id);


--
-- Name: favorites_users_permissions_user_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_users_permissions_user_lnk_fk ON public.favorites_users_permissions_user_lnk USING btree (favorite_id);


--
-- Name: favorites_users_permissions_user_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX favorites_users_permissions_user_lnk_ifk ON public.favorites_users_permissions_user_lnk USING btree (user_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_documents_idx ON public.files USING btree (document_id, locale, published_at);


--
-- Name: files_folder_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_folder_lnk_fk ON public.files_folder_lnk USING btree (file_id);


--
-- Name: files_folder_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_folder_lnk_ifk ON public.files_folder_lnk USING btree (folder_id);


--
-- Name: files_folder_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_folder_lnk_oifk ON public.files_folder_lnk USING btree (file_ord);


--
-- Name: files_related_mph_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_related_mph_fk ON public.files_related_mph USING btree (file_id);


--
-- Name: files_related_mph_idix; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_related_mph_idix ON public.files_related_mph USING btree (related_id);


--
-- Name: files_related_mph_oidx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_related_mph_oidx ON public.files_related_mph USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX i18n_locale_documents_idx ON public.i18n_locale USING btree (document_id, locale, published_at);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: image_generals_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX image_generals_created_by_id_fk ON public.image_generals USING btree (created_by_id);


--
-- Name: image_generals_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX image_generals_documents_idx ON public.image_generals USING btree (document_id, locale, published_at);


--
-- Name: image_generals_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX image_generals_updated_by_id_fk ON public.image_generals USING btree (updated_by_id);


--
-- Name: product_ratings_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX product_ratings_created_by_id_fk ON public.product_ratings USING btree (created_by_id);


--
-- Name: product_ratings_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX product_ratings_documents_idx ON public.product_ratings USING btree (document_id, locale, published_at);


--
-- Name: product_ratings_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX product_ratings_updated_by_id_fk ON public.product_ratings USING btree (updated_by_id);


--
-- Name: products_categories_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_categories_lnk_fk ON public.products_categories_lnk USING btree (product_id);


--
-- Name: products_categories_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_categories_lnk_ifk ON public.products_categories_lnk USING btree (category_id);


--
-- Name: products_categories_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_categories_lnk_ofk ON public.products_categories_lnk USING btree (category_ord);


--
-- Name: products_categories_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_categories_lnk_oifk ON public.products_categories_lnk USING btree (product_ord);


--
-- Name: products_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_created_by_id_fk ON public.products USING btree (created_by_id);


--
-- Name: products_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_documents_idx ON public.products USING btree (document_id, locale, published_at);


--
-- Name: products_product_ratings_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_product_ratings_lnk_fk ON public.products_product_ratings_lnk USING btree (product_id);


--
-- Name: products_product_ratings_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_product_ratings_lnk_ifk ON public.products_product_ratings_lnk USING btree (product_rating_id);


--
-- Name: products_product_ratings_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_product_ratings_lnk_ofk ON public.products_product_ratings_lnk USING btree (product_rating_ord);


--
-- Name: products_product_ratings_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_product_ratings_lnk_oifk ON public.products_product_ratings_lnk USING btree (product_ord);


--
-- Name: products_shipping_types_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_shipping_types_lnk_fk ON public.products_shipping_types_lnk USING btree (product_id);


--
-- Name: products_shipping_types_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_shipping_types_lnk_ifk ON public.products_shipping_types_lnk USING btree (shipping_type_id);


--
-- Name: products_shipping_types_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_shipping_types_lnk_ofk ON public.products_shipping_types_lnk USING btree (shipping_type_ord);


--
-- Name: products_shipping_types_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_shipping_types_lnk_oifk ON public.products_shipping_types_lnk USING btree (product_ord);


--
-- Name: products_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_updated_by_id_fk ON public.products USING btree (updated_by_id);


--
-- Name: products_users_permissions_users_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_users_permissions_users_lnk_fk ON public.products_users_permissions_users_lnk USING btree (product_id);


--
-- Name: products_users_permissions_users_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_users_permissions_users_lnk_ifk ON public.products_users_permissions_users_lnk USING btree (user_id);


--
-- Name: products_users_permissions_users_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_users_permissions_users_lnk_ofk ON public.products_users_permissions_users_lnk USING btree (user_ord);


--
-- Name: products_users_permissions_users_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX products_users_permissions_users_lnk_oifk ON public.products_users_permissions_users_lnk USING btree (product_ord);


--
-- Name: reactions_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_created_by_id_fk ON public.reactions USING btree (created_by_id);


--
-- Name: reactions_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_documents_idx ON public.reactions USING btree (document_id, locale, published_at);


--
-- Name: reactions_product_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_product_lnk_fk ON public.reactions_product_lnk USING btree (reaction_id);


--
-- Name: reactions_product_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_product_lnk_ifk ON public.reactions_product_lnk USING btree (product_id);


--
-- Name: reactions_product_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_product_lnk_oifk ON public.reactions_product_lnk USING btree (reaction_ord);


--
-- Name: reactions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_updated_by_id_fk ON public.reactions USING btree (updated_by_id);


--
-- Name: reactions_users_permissions_user_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_users_permissions_user_lnk_fk ON public.reactions_users_permissions_user_lnk USING btree (reaction_id);


--
-- Name: reactions_users_permissions_user_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_users_permissions_user_lnk_ifk ON public.reactions_users_permissions_user_lnk USING btree (user_id);


--
-- Name: reactions_users_permissions_user_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX reactions_users_permissions_user_lnk_oifk ON public.reactions_users_permissions_user_lnk USING btree (reaction_ord);


--
-- Name: shipping_types_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX shipping_types_created_by_id_fk ON public.shipping_types USING btree (created_by_id);


--
-- Name: shipping_types_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX shipping_types_documents_idx ON public.shipping_types USING btree (document_id, locale, published_at);


--
-- Name: shipping_types_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX shipping_types_updated_by_id_fk ON public.shipping_types USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_token_permissions_documents_idx ON public.strapi_api_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_token_permissions_token_lnk_fk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_token_permissions_token_lnk_ifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_token_permissions_token_lnk_oifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_ord);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_tokens_documents_idx ON public.strapi_api_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_history_versions_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_history_versions_created_by_id_fk ON public.strapi_history_versions USING btree (created_by_id);


--
-- Name: strapi_release_actions_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_release_actions_created_by_id_fk ON public.strapi_release_actions USING btree (created_by_id);


--
-- Name: strapi_release_actions_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_release_actions_documents_idx ON public.strapi_release_actions USING btree (document_id, locale, published_at);


--
-- Name: strapi_release_actions_release_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_release_actions_release_lnk_fk ON public.strapi_release_actions_release_lnk USING btree (release_action_id);


--
-- Name: strapi_release_actions_release_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_release_actions_release_lnk_ifk ON public.strapi_release_actions_release_lnk USING btree (release_id);


--
-- Name: strapi_release_actions_release_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_release_actions_release_lnk_oifk ON public.strapi_release_actions_release_lnk USING btree (release_action_ord);


--
-- Name: strapi_release_actions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_release_actions_updated_by_id_fk ON public.strapi_release_actions USING btree (updated_by_id);


--
-- Name: strapi_releases_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_releases_created_by_id_fk ON public.strapi_releases USING btree (created_by_id);


--
-- Name: strapi_releases_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_releases_documents_idx ON public.strapi_releases USING btree (document_id, locale, published_at);


--
-- Name: strapi_releases_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_releases_updated_by_id_fk ON public.strapi_releases USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_token_permissions_documents_idx ON public.strapi_transfer_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_fk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_ifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_oifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_ord);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_tokens_documents_idx ON public.strapi_transfer_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: strapi_workflows_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_created_by_id_fk ON public.strapi_workflows USING btree (created_by_id);


--
-- Name: strapi_workflows_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_documents_idx ON public.strapi_workflows USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_fk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_ifk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_created_by_id_fk ON public.strapi_workflows_stages USING btree (created_by_id);


--
-- Name: strapi_workflows_stages_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_documents_idx ON public.strapi_workflows_stages USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stages_permissions_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_fk ON public.strapi_workflows_stages_permissions_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ifk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ofk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_ord);


--
-- Name: strapi_workflows_stages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_updated_by_id_fk ON public.strapi_workflows_stages USING btree (updated_by_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_fk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_ifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_oifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_ord);


--
-- Name: strapi_workflows_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX strapi_workflows_updated_by_id_fk ON public.strapi_workflows USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_permissions_documents_idx ON public.up_permissions USING btree (document_id, locale, published_at);


--
-- Name: up_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_permissions_role_lnk_fk ON public.up_permissions_role_lnk USING btree (permission_id);


--
-- Name: up_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_permissions_role_lnk_ifk ON public.up_permissions_role_lnk USING btree (role_id);


--
-- Name: up_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_permissions_role_lnk_oifk ON public.up_permissions_role_lnk USING btree (permission_ord);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_roles_documents_idx ON public.up_roles USING btree (document_id, locale, published_at);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_documents_idx ON public.up_users USING btree (document_id, locale, published_at);


--
-- Name: up_users_product_ratings_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_product_ratings_lnk_fk ON public.up_users_product_ratings_lnk USING btree (user_id);


--
-- Name: up_users_product_ratings_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_product_ratings_lnk_ifk ON public.up_users_product_ratings_lnk USING btree (product_rating_id);


--
-- Name: up_users_product_ratings_lnk_ofk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_product_ratings_lnk_ofk ON public.up_users_product_ratings_lnk USING btree (product_rating_ord);


--
-- Name: up_users_product_ratings_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_product_ratings_lnk_oifk ON public.up_users_product_ratings_lnk USING btree (user_ord);


--
-- Name: up_users_role_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_role_lnk_fk ON public.up_users_role_lnk USING btree (user_id);


--
-- Name: up_users_role_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_role_lnk_ifk ON public.up_users_role_lnk USING btree (role_id);


--
-- Name: up_users_role_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_role_lnk_oifk ON public.up_users_role_lnk USING btree (user_ord);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_documents_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_folders_documents_idx ON public.upload_folders USING btree (document_id, locale, published_at);


--
-- Name: upload_folders_parent_lnk_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_folders_parent_lnk_fk ON public.upload_folders_parent_lnk USING btree (folder_id);


--
-- Name: upload_folders_parent_lnk_ifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_folders_parent_lnk_ifk ON public.upload_folders_parent_lnk USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_lnk_oifk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_folders_parent_lnk_oifk ON public.upload_folders_parent_lnk USING btree (folder_ord);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: brands brands_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: brands_products_lnk brands_products_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands_products_lnk
    ADD CONSTRAINT brands_products_lnk_fk FOREIGN KEY (brand_id) REFERENCES public.brands(id) ON DELETE CASCADE;


--
-- Name: brands_products_lnk brands_products_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands_products_lnk
    ADD CONSTRAINT brands_products_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: brands brands_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: categories categories_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: categories categories_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: favorites favorites_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: favorites_products_lnk favorites_products_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_products_lnk
    ADD CONSTRAINT favorites_products_lnk_fk FOREIGN KEY (favorite_id) REFERENCES public.favorites(id) ON DELETE CASCADE;


--
-- Name: favorites_products_lnk favorites_products_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_products_lnk
    ADD CONSTRAINT favorites_products_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: favorites favorites_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: favorites_users_permissions_user_lnk favorites_users_permissions_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_users_permissions_user_lnk
    ADD CONSTRAINT favorites_users_permissions_user_lnk_fk FOREIGN KEY (favorite_id) REFERENCES public.favorites(id) ON DELETE CASCADE;


--
-- Name: favorites_users_permissions_user_lnk favorites_users_permissions_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.favorites_users_permissions_user_lnk
    ADD CONSTRAINT favorites_users_permissions_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_lnk files_folder_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_lnk files_folder_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_ifk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_mph files_related_mph_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: image_generals image_generals_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.image_generals
    ADD CONSTRAINT image_generals_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: image_generals image_generals_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.image_generals
    ADD CONSTRAINT image_generals_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: product_ratings product_ratings_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT product_ratings_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: product_ratings product_ratings_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product_ratings
    ADD CONSTRAINT product_ratings_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: products_categories_lnk products_categories_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_categories_lnk products_categories_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_categories_lnk
    ADD CONSTRAINT products_categories_lnk_ifk FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: products products_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: products_product_ratings_lnk products_product_ratings_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_product_ratings_lnk
    ADD CONSTRAINT products_product_ratings_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_product_ratings_lnk products_product_ratings_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_product_ratings_lnk
    ADD CONSTRAINT products_product_ratings_lnk_ifk FOREIGN KEY (product_rating_id) REFERENCES public.product_ratings(id) ON DELETE CASCADE;


--
-- Name: products_shipping_types_lnk products_shipping_types_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_shipping_types_lnk
    ADD CONSTRAINT products_shipping_types_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_shipping_types_lnk products_shipping_types_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_shipping_types_lnk
    ADD CONSTRAINT products_shipping_types_lnk_ifk FOREIGN KEY (shipping_type_id) REFERENCES public.shipping_types(id) ON DELETE CASCADE;


--
-- Name: products products_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: products_users_permissions_users_lnk products_users_permissions_users_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_users_permissions_users_lnk
    ADD CONSTRAINT products_users_permissions_users_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_users_permissions_users_lnk products_users_permissions_users_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.products_users_permissions_users_lnk
    ADD CONSTRAINT products_users_permissions_users_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: reactions reactions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reactions_product_lnk reactions_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_product_lnk
    ADD CONSTRAINT reactions_product_lnk_fk FOREIGN KEY (reaction_id) REFERENCES public.reactions(id) ON DELETE CASCADE;


--
-- Name: reactions_product_lnk reactions_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_product_lnk
    ADD CONSTRAINT reactions_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: reactions reactions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reactions_users_permissions_user_lnk reactions_users_permissions_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_users_permissions_user_lnk
    ADD CONSTRAINT reactions_users_permissions_user_lnk_fk FOREIGN KEY (reaction_id) REFERENCES public.reactions(id) ON DELETE CASCADE;


--
-- Name: reactions_users_permissions_user_lnk reactions_users_permissions_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reactions_users_permissions_user_lnk
    ADD CONSTRAINT reactions_users_permissions_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: shipping_types shipping_types_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shipping_types
    ADD CONSTRAINT shipping_types_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: shipping_types shipping_types_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shipping_types
    ADD CONSTRAINT shipping_types_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_ifk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_history_versions strapi_history_versions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions strapi_release_actions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_fk FOREIGN KEY (release_action_id) REFERENCES public.strapi_release_actions(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_ifk FOREIGN KEY (release_id) REFERENCES public.strapi_releases(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions strapi_release_actions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_ifk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows strapi_workflows_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_fk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_ifk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_ifk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_ifk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows strapi_workflows_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users_product_ratings_lnk up_users_product_ratings_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_product_ratings_lnk
    ADD CONSTRAINT up_users_product_ratings_lnk_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_product_ratings_lnk up_users_product_ratings_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_product_ratings_lnk
    ADD CONSTRAINT up_users_product_ratings_lnk_ifk FOREIGN KEY (product_rating_id) REFERENCES public.product_ratings(id) ON DELETE CASCADE;


--
-- Name: up_users_role_lnk up_users_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_fk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: up_users_role_lnk up_users_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users_role_lnk
    ADD CONSTRAINT up_users_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_ifk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

