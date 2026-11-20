-- Закупки

SELECT
'bm_StorageOperations - bm_StorageOperationsType by OperationID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.bm_StorageOperationsType AS b ON b.ID = a.OperationID
WHERE a.OperationID = 1

UNION ALL

SELECT
'bm_StorageOperations - product by ProductID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.ProductID
WHERE a.OperationID = 1

UNION ALL

SELECT
'bm_StorageOperations - bm_JournalBarnetDocs by DocumentID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.bm_JournalBarnetDocs AS b ON b.ID = a.DocumentID
WHERE a.OperationID = 1

UNION ALL

SELECT
'bm_StorageOperations - storages by StorageID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.storages AS b ON b.id = a.StorageID
WHERE a.OperationID = 1

UNION ALL

SELECT
'bm_JournalBarnetDocs - bm_JournalTypeDocuments by DocumentTypeID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_JournalBarnetDocs AS a
    LEFT JOIN Front.dbo.bm_JournalTypeDocuments AS b ON b.ID = a.DocumentTypeID
WHERE a.ID IN (SELECT DocumentID FROM Front.dbo.bm_StorageOperations WHERE OperationID = 1)

UNION ALL

SELECT
'bm_StorageOperations_Table - bm_JournalBarnetDocs by DocumentID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_StorageOperations_Table AS a
    LEFT JOIN Front.dbo.bm_JournalBarnetDocs AS b ON b.ID = a.DocumentID

UNION ALL

SELECT
'pricelist - product by productid' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.pricelist AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.productid

UNION ALL

SELECT
'pricelist - bm_JournalBarnetDocs by DocumentID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.pricelist AS a
    LEFT JOIN Front.dbo.bm_JournalBarnetDocs AS b ON b.ID = a.DocumentID
WHERE a.DocumentID IN (SELECT DocumentID FROM Front.dbo.bm_StorageOperations WHERE OperationID = 1)

UNION ALL

SELECT
'bm_StorageOperations - vendors by VendorID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.vendors AS b ON b.id = a.VendorID
WHERE a.VendorID <> 0 AND a.OperationID = 1

UNION ALL

SELECT
'bm_StorageOperations_Table - product by BludoID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations_Table AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.BludoID
WHERE a.BludoID <> 0;

-- Продажи

SELECT
'journal - transtype by transtype' AS "Link",
COUNT(*) AS "All",
COUNT(b.transtypeid) AS "Found"
FROM Front.dbo.journal AS a
    LEFT JOIN Front.dbo.transtype AS b ON b.transtypeid = a.transtype
WHERE a.transtype = 101

UNION ALL

SELECT
'bm_Journal_Details - journal by SourceID' AS "Link",
COUNT(*) AS "All",
COUNT(b.transnumber) AS "Found"
FROM Front.dbo.bm_Journal_Details AS a
    LEFT JOIN Front.dbo.journal AS b ON b.transnumber = a.SourceID
WHERE a.SourceID IN (SELECT transnumber FROM Front.dbo.journal WHERE transtype = 101)

UNION ALL

SELECT
'bm_Journal_Details - product by BludoID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_Journal_Details AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.BludoID
WHERE a.SourceID IN (SELECT transnumber FROM Front.dbo.journal WHERE transtype = 101)

UNION ALL

SELECT
'bm_Journal_Details - product by ProductID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_Journal_Details AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.ProductID
WHERE a.SourceID IN (SELECT transnumber FROM Front.dbo.journal WHERE transtype = 101)

UNION ALL

SELECT
'bm_Journal_Details - size by RangeID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_Journal_Details AS a
    LEFT JOIN Front.dbo.size AS b ON b.ID = a.RangeID
WHERE a.SourceID IN (SELECT transnumber FROM Front.dbo.journal WHERE transtype = 101)

UNION ALL

SELECT
'product - category by CategoryID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.product AS a
    LEFT JOIN Front.dbo.category AS b ON b.id = a.CategoryID

UNION ALL

SELECT
'journal - product by id' AS "Link",
COUNT(*) AS "All",
COUNT(b.productid) AS "Found"
FROM Front.dbo.journal AS a
    LEFT JOIN Front.dbo.product AS b ON b.productid = a.id
WHERE a.transtype = 101

UNION ALL

SELECT
'journal - category by categoryid' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.journal AS a
    LEFT JOIN Front.dbo.category AS b ON b.id = a.categoryid
WHERE a.transtype = 101

UNION ALL

SELECT
'bm_Journal_Details - journal by TicketNumber' AS "Link",
COUNT(*) AS "All",
COUNT(b.receiptn) AS "Found"
FROM Front.dbo.bm_Journal_Details AS a
    LEFT JOIN (SELECT DISTINCT receiptn FROM Front.dbo.journal) AS b ON b.receiptn = a.TicketNumber
WHERE a.SourceID IN (SELECT transnumber FROM Front.dbo.journal WHERE transtype = 101)

UNION ALL

SELECT
'product - size by SizeID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.product AS a
    LEFT JOIN Front.dbo.size AS b ON b.ID = a.SizeID

UNION ALL

SELECT
'bm_Journal_Details - bm_classifierSizes by SizeID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_Journal_Details AS a
    LEFT JOIN Front.dbo.bm_classifierSizes AS b ON b.ID = a.SizeID
WHERE a.SourceID IN (SELECT transnumber FROM Front.dbo.journal WHERE transtype = 101);

-- Поставщики

SELECT
'vendors - vendorgroup by clientgroup' AS "Link",
COUNT(*) AS "All",
COUNT(b.vendorgroupid) AS "Found"
FROM Front.dbo.vendors AS a
    LEFT JOIN Front.dbo.vendorgroup AS b ON b.vendorgroupid = a.clientgroup

UNION ALL

SELECT
'bm_StorageOperations - bm_JournalBarnetDocs by DocumentID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.bm_JournalBarnetDocs AS b ON b.ID = a.DocumentID
WHERE a.OperationID = 1 AND a.VendorID <> 0

UNION ALL

SELECT
'bm_JournalBarnetDocs - bm_Companies by CompanyID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_JournalBarnetDocs AS a
    LEFT JOIN Front.dbo.bm_Companies AS b ON b.ID = a.CompanyID

UNION ALL

SELECT
'bm_StorageOperations - vendors by VendorID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.vendors AS b ON b.id = a.VendorID
WHERE a.VendorID <> 0 AND a.OperationID = 1

UNION ALL

SELECT
'storages - bm_Companies by CompanyID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.storages AS a
    LEFT JOIN Front.dbo.bm_Companies AS b ON b.ID = a.CompanyID;

-- Персонал

SELECT
'bm_BonusHistory - personnel by PersonID' AS "Link",
COUNT(*) AS "All",
COUNT(b.personid) AS "Found"
FROM Front.dbo.bm_BonusHistory AS a
    LEFT JOIN Front.dbo.personnel AS b ON b.personid = a.PersonID

UNION ALL

SELECT
'bm_PersonnelSecurity - bm_SecurityObjects by ObjectID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_PersonnelSecurity AS a
    LEFT JOIN Front.dbo.bm_SecurityObjects AS b ON b.ID = a.ObjectID

UNION ALL

SELECT
'bm_SecurityObjects_Info - bm_SecurityObjects by ParentID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_SecurityObjects_Info AS a
    LEFT JOIN Front.dbo.bm_SecurityObjects AS b ON b.ID = a.ParentID

UNION ALL

SELECT
'bm_PersonnelSecurity - personnel by PersonID' AS "Link",
COUNT(*) AS "All",
COUNT(b.personid) AS "Found"
FROM Front.dbo.bm_PersonnelSecurity AS a
    LEFT JOIN Front.dbo.personnel AS b ON b.personid = a.PersonID

UNION ALL

SELECT
'bm_JournalSessions - personnel by PersonID' AS "Link",
COUNT(*) AS "All",
COUNT(b.personid) AS "Found"
FROM Front.dbo.bm_JournalSessions AS a
    LEFT JOIN Front.dbo.personnel AS b ON b.personid = a.PersonID
WHERE a.PersonID <> 0

UNION ALL

SELECT
'bm_JournalBarnetDocs - personnel by PersonID' AS "Link",
COUNT(*) AS "All",
COUNT(b.personid) AS "Found"
FROM Front.dbo.bm_JournalBarnetDocs AS a
    LEFT JOIN Front.dbo.personnel AS b ON b.personid = a.PersonID
WHERE a.PersonID <> 0

UNION ALL

SELECT
'bm_JournalBarnetDocs - bm_ShiftsOperations by ShiftID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_JournalBarnetDocs AS a
    LEFT JOIN Front.dbo.bm_ShiftsOperations AS b ON b.ID = a.ShiftID

UNION ALL

SELECT
'wastemessages - personnel by loginid' AS "Link",
COUNT(*) AS "All",
COUNT(b.personid) AS "Found"
FROM Front.dbo.wastemessages AS a
    LEFT JOIN Front.dbo.personnel AS b ON b.personid = a.loginid;

-- Остатки

SELECT
'bm_StorageOperations - product by ProductID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.ProductID

UNION ALL

SELECT
'bm_StorageOperations - storages by StorageID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.storages AS b ON b.id = a.StorageID

UNION ALL

SELECT
'bm_StorageOperations - bm_StorageOperationsType by OperationID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.bm_StorageOperationsType AS b ON b.ID = a.OperationID

UNION ALL

SELECT
'recipe - product by recipeid' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.recipe AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.recipeid

UNION ALL

SELECT
'recipe - product by ingredientid' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.recipe AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.ingredientid

UNION ALL

SELECT
'bm_StorageOperations - product by BludoID' AS "Link",
COUNT(*) AS "All",
COUNT(b.id) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.product AS b ON b.id = a.BludoID
WHERE a.BludoID <> 0 AND a.OperationID = 2

UNION ALL

SELECT
'bm_StorageOperations - bm_ReasonDebit by ReasonID' AS "Link",
COUNT(*) AS "All",
COUNT(b.ID) AS "Found"
FROM Front.dbo.bm_StorageOperations AS a
    LEFT JOIN Front.dbo.bm_ReasonDebit AS b ON b.ID = a.ReasonID
WHERE a.ReasonID <> 0

UNION ALL

SELECT
'wastemessages - product by productid' AS "Link",
COUNT(*) AS "All",
COUNT(b.productid) AS "Found"
FROM Front.dbo.wastemessages AS a
    LEFT JOIN Front.dbo.product AS b ON b.productid = a.productid
WHERE a.productid <> '';

