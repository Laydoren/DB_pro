use Front

-- Единицы изм
select id, sizeid as name, 
portionrate as factor from [size] 

select 'insert into dim_ranges(external_id, name, factor ) values ('
    + cast(id as varchar(max)) + ','''   
    + [sizeid] + ''','  
    + caST(portionrate as varchar(max))   + ');' 
    as [sql]
 from [size] 


-- категории
select * FROM
(
select id,  description as name,
   case when coalesce( ParentID,0) = 0 
        then null else parentId end as parent_id
          from category
) as t1
order  by parent_id, name

select 'insert into dim_categories(external_id, name, parent_id) values ('
    + cast(id as varchar(max)) + ','''
    + name + ''','
    + isnull(cast(parent_id as varchar(max)), 'null') + ');'
    as [sql]
from
(
    select id,  description as name,
       case when coalesce(ParentID,0) = 0
            then null else parentId end as parent_id
              from category
) as t1
order  by id


-- Поставщики
select * FROM
(
    select id,  clientid as name, clientgroup as parent_id,
    t2.[description] as parent_name
    from vendors t1
    inner join vendorgroup t2 on t1.clientgroup = t2.vendorgroupid
) as t1 order by parent_id

select 'insert into dim_vendors(external_id, name, parent_id, parent_name) values ('
    + cast(id as varchar(max)) + ','''
    + name + ''','
    + isnull(cast(parent_id as varchar(max)), 'null') + ','''
    + parent_name + ''');'
    as [sql]
from
(
    select id,  clientid as name, nullif(clientgroup,0) as parent_id,
    t2.[description] as parent_name
    from vendors t1
    inner join vendorgroup t2 on t1.clientgroup = t2.vendorgroupid
) as t1 order by id


SELECT * FROM product;
-- Товары
select id, productid as code, description as name,categoryid as category_id, sizeid as range_id
from product
order by id

select 'insert into dim_products(external_id, code, name, category_id, range_id) values ('
    + cast(id as varchar(max)) + ','''
    + code + ''','''
    + name + ''','
    + isnull(cast(category_id as varchar(max)), 'null') + ','
    + isnull(cast(range_id as varchar(max)), 'null') + ');'
    as [sql]
from
(
    select id, productid as code, description as name,
        nullif(categoryid,0) as category_id, nullif(sizeid,0) as range_id
    from product
) as t1
order by id


-- Типы документов
SELECT * FROM bm_JournalTypeDocuments;
select id, description as name, JournalID as journal_id
from bm_JournalTypeDocuments

select 'insert into dim_document_types(external_id, name, journal_id) values ('
    + cast(id as varchar(max)) + ','''
    + description + ''','
    + cast(JournalID as varchar(max)) + ');'
    as [sql]
from bm_JournalTypeDocuments
order by id


-- Типы транзакций
SELECT * FROM transtype;
select transtypeid as id, transgroupid as group_id, PreviewGroupType as preview_group_type, description as name 
from transtype

select 'insert into dim_transaction_types(external_id, group_id, preview_group_id, name) values ('
    + cast(transtypeid as varchar(max)) + ','
    + isnull(cast(transgroupid as varchar(max)), 'null') + ','
    + isnull('''' + PreviewGroupType + '''', 'null') + ','
    + isnull('''' + description + '''', 'null') + ');'
    as [sql]
from transtype
order by transtypeid


-- Сотрудники
SELECT * FROM personnel;
select personid as id, lastname as last_name, firstname as first_name, middlename as middle_name, securityaccess as security_access 
from personnel

select 'insert into dim_personnel(external_id, last_name, first_name, middle_name, security_access) values ('
    + cast(personid as varchar(max)) + ','''
    + lastname + ''','''
    + firstname + ''','''
    + middlename + ''','
    + isnull(cast(securityaccess as varchar(max)), 'null') + ');'
    as [sql]
from personnel
order by personid


-- Склады
SELECT * FROM storages;
select id, description as name, CompanyID as company_id 
from storages

select 'insert into dim_storages(external_id, name, company_id) values ('
    + cast(id as varchar(max)) + ','''
    + description + ''','
    + isnull(cast(CompanyID as varchar(max)), 'null') + ');'
    as [sql]
from storages
order by id


-- Типы складских операций
SELECT * FROM bm_StorageOperationsType;
select id, description as name, factor 
from bm_StorageOperationsType

select 'insert into dim_operation_types(external_id, name, factor) values ('
    + cast(id as varchar(max)) + ','''
    + description + ''','
    + cast(factor as varchar(max)) + ');'
    as [sql]
from bm_StorageOperationsType
order by id


-- Причины списания
SELECT * FROM bm_ReasonDebit;
select * from
(
select id, description as name,
   case when coalesce( ParentID,0) = 0
        then null else ParentID end as parent_id
          from bm_ReasonDebit
) as t1
order by id

select 'insert into dim_reasons(external_id, name, parent_id) values ('
    + cast(id as varchar(max)) + ','''
    + name + ''','
    + isnull(cast(parent_id as varchar(max)), 'null') + ');'
    as [sql]
from
(
    select id,  description as name,
       case when coalesce(ParentID,0) = 0
            then null else ParentID end as parent_id
              from bm_ReasonDebit
) as t1
order by id


-- Компании
SELECT * FROM bm_Companies;
select id, CompanyName as name, ShortName as short_name, INN as inn, KPP as kpp, OGRN as ogrn 
from bm_Companies

select 'insert into dim_companies(external_id, name, short_name, inn, kpp, ogrn) values ('
    + cast(id as varchar(max)) + ','''
    + CompanyName + ''','''
    + ShortName + ''','''
    + INN + ''','''
    + KPP + ''','''
    + OGRN + ''');'
    as [sql]
from bm_Companies
order by id


-- Тип учёта
SELECT * FROM bm_JournalType;
select id, JournalName as name 
from bm_JournalType

select 'insert into dim_journal_types(external_id, name) values ('
    + cast(id as varchar(max)) + ','''
    + JournalName + ''');'
    as [sql]
from bm_JournalType
order by id


-- Тип цен
SELECT * FROM pricegroup;
select pricegroupid, description as name 
from pricegroup

select 'insert into dim_price_groups(external_id, name) values ('
    + cast(pricegroupid as varchar(max)) + ','''
    + description + ''');'
    as [sql]
from pricegroup
order by pricegroupid


-- Тип кассовых операций
SELECT * FROM bm_CashOperationsType;
select id, Description as name, Factor as factor 
from bm_CashOperationsType

select 'insert into dim_cash_operations_types(external_id, name, factor) values ('
    + cast(id as varchar(max)) + ','''
    + Description + ''','
    + cast(Factor as varchar(max)) + ');'
    as [sql]
from bm_CashOperationsType
order by id


