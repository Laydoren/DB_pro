DO $$
BEGIN

-- create database db2026;

create SEQUENCE seq_dim_ranges;

-- Ресурсы еди ницы изхмерения
create table dim_ranges
(
      --- Внутрений код
    id bigint primary key DEFAULT nextval('public.seq_dim_ranges'),
    external_id bigint,
    name text,
    factor float,
    -- Дата добавления
    date_add timestamp default now()
);

-- Категории товаров
create sequence seq_dim_categories;

create table dim_categories
(
    id bigint primary key default nextval('public.seq_dim_categories'),
    external_id bigint not null unique,
    name text,
    parent_id bigint,
    date_add timestamp default now()
);

-- Поставщики
create sequence seq_dim_vendors;

create table dim_vendors
(
    id bigint primary key default nextval('public.seq_dim_vendors'),
    external_id bigint not null unique,
    name text,
    parent_id bigint,
    parent_name text,
    date_add timestamp default now()
);

-- Товары
create sequence seq_dim_products;

create table dim_products
(
    id bigint primary key default nextval('public.seq_dim_products'),
    external_id bigint not null unique,
    code text,
    name text,
    category_id bigint,
    range_id bigint,
    date_add timestamp default now()
);

-- Типы документов
create sequence seq_dim_document_types;

create table dim_document_types
(
    id bigint primary key default nextval('public.seq_dim_document_types'),
    external_id bigint not null unique,
    name text,
    journal_id bigint,
    date_add timestamp default now()
);

-- Типы транзакций
create sequence seq_dim_transaction_types;

create table dim_transaction_types
(
    id bigint primary key default nextval('public.seq_dim_transaction_types'),
    external_id bigint not null unique,
    group_id bigint,
    preview_group_id text,
    name text,
    date_add timestamp default now()
);

-- Сотрудники
create sequence seq_dim_personnel;

create table dim_personnel
(
    id bigint primary key default nextval('public.seq_dim_personnel'),
    external_id bigint not null unique,
    last_name text,
    first_name text,
    middle_name text,
    security_access int,
    date_add timestamp default now()
);

-- Склады
create sequence seq_dim_storages;

create table dim_storages
(
    id bigint primary key default nextval('public.seq_dim_storages'),
    external_id bigint not null unique,
    name text,
    company_id bigint,
    date_add timestamp default now()
);

-- Типы складских операций
create sequence seq_dim_operation_types;

create table dim_operation_types
(
    id bigint primary key default nextval('public.seq_dim_operation_types'),
    external_id bigint not null unique,
    name text,
    factor int,
    date_add timestamp default now()
);

-- Причины списания
create sequence seq_dim_reasons;

create table dim_reasons
(
    id bigint primary key default nextval('public.seq_dim_reasons'),
    external_id bigint not null unique,
    name text,
    parent_id bigint,
    date_add timestamp default now()
);

-- Организации
create sequence seq_dim_companies;

create table dim_companies
(
    id bigint primary key default nextval('public.seq_dim_companies'),
    external_id bigint not null unique,
    name text,
    short_name text,
    inn text,
    kpp text,
    ogrn text,
    date_add timestamp default now()
);

-- Виды учета
create sequence seq_dim_journal_types;

create table dim_journal_types
(
    id bigint primary key default nextval('public.seq_dim_journal_types'),
    external_id bigint not null unique,
    name text,
    date_add timestamp default now()
);

-- Виды цен
create sequence seq_dim_price_groups;

create table dim_price_groups
(
    id bigint primary key default nextval('public.seq_dim_price_groups'),
    external_id bigint not null unique,
    name text,
    date_add timestamp default now()
);

-- Типы кассовых операций
create sequence seq_dim_cash_operations_types;

create table dim_cash_operations_types
(
    id bigint primary key default nextval('public.seq_dim_cash_operations_types'),
    external_id bigint not null unique,
    name text,
    factor int,
    date_add timestamp default now()
);

END $$;

