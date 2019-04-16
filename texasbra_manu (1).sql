-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 14, 2019 at 11:35 AM
-- Server version: 10.1.38-MariaDB-cll-lve
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `texasbra_manu`
--
CREATE DATABASE IF NOT EXISTS `texasbra_manu` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `texasbra_manu`;

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
CREATE TABLE `branch` (
  `branchid` int(11) NOT NULL,
  `primarybranchid` int(11) NOT NULL,
  `branchaccountnumber` varchar(20) DEFAULT NULL,
  `branchsubaccountnumber` varchar(20) DEFAULT NULL,
  `usermainid` int(11) DEFAULT NULL,
  `branchname` varchar(255) NOT NULL,
  `description` text,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `address1physical` varchar(255) DEFAULT NULL,
  `address2physical` varchar(255) DEFAULT NULL,
  `cityphysical` varchar(255) DEFAULT NULL,
  `statephysical` char(2) NOT NULL DEFAULT 'TX',
  `postalcodephysical` varchar(9) DEFAULT NULL,
  `countryphysical` char(2) DEFAULT 'US',
  `address1mailing` varchar(255) DEFAULT NULL,
  `address2mailing` varchar(255) DEFAULT NULL,
  `citymailing` varchar(255) DEFAULT NULL,
  `statemailing` char(2) DEFAULT 'TX',
  `postalcodemailing` varchar(9) DEFAULT NULL,
  `countrymailing` char(2) DEFAULT 'US',
  `address1billing` varchar(255) DEFAULT NULL,
  `address2billing` varchar(255) DEFAULT NULL,
  `citybilling` varchar(255) DEFAULT NULL,
  `statebilling` char(2) DEFAULT 'TX',
  `postalcodebilling` varchar(9) DEFAULT NULL,
  `countrybilling` char(2) DEFAULT 'US',
  `phonemainline1` char(10) DEFAULT NULL,
  `phonemainline2` char(10) DEFAULT NULL,
  `phonemainline3` char(10) DEFAULT NULL,
  `phonemainline4` char(10) DEFAULT NULL,
  `phonemainline5` char(10) DEFAULT NULL,
  `phonecell1` char(10) DEFAULT NULL,
  `phonecell2` char(10) DEFAULT NULL,
  `phonecellcarrierid1` int(11) DEFAULT NULL,
  `phonecellcarrierid2` int(11) DEFAULT NULL,
  `faxmain1` char(10) DEFAULT '0',
  `faxmain2` char(10) DEFAULT NULL,
  `faxmain3` char(10) DEFAULT NULL,
  `faxmain4` char(10) DEFAULT NULL,
  `faxmain5` char(10) DEFAULT NULL,
  `emailorders` varchar(255) DEFAULT '',
  `emailbilling` varchar(255) DEFAULT NULL,
  `emailsales` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `tagline` varchar(255) DEFAULT NULL,
  `drivemiles` decimal(10,0) DEFAULT NULL,
  `drivetime` decimal(10,2) DEFAULT NULL,
  `freightperload` decimal(19,2) DEFAULT NULL,
  `shippingdefault` varchar(255) DEFAULT NULL,
  `trailersperload` decimal(4,0) DEFAULT NULL,
  `licensedealer` varchar(255) DEFAULT NULL,
  `licensedrivers` varchar(255) DEFAULT NULL,
  `agreement` varchar(255) DEFAULT NULL,
  `u130` varchar(255) DEFAULT NULL,
  `creditapplication` varchar(255) DEFAULT NULL,
  `autoorder` varchar(1) DEFAULT 'Y',
  `paymentmethodid1` int(11) DEFAULT NULL,
  `paymentmethodid2` int(11) DEFAULT NULL,
  `ordernotificationmethodid` int(11) DEFAULT NULL,
  `stateinspection` varchar(1) DEFAULT NULL,
  `dealerrating` varchar(1) DEFAULT NULL,
  `dealeralert` text,
  `callfrequency` decimal(4,0) DEFAULT NULL,
  `invoicesmaxunpaid` decimal(4,0) DEFAULT NULL,
  `creditlimit` decimal(19,2) DEFAULT NULL,
  `specialdeals` varchar(255) DEFAULT NULL,
  `dealergroupid` int(11) DEFAULT NULL,
  `dealertypeid` int(11) DEFAULT NULL,
  `monthsnopayment` decimal(4,0) DEFAULT NULL,
  `monthsnointerest` decimal(4,0) DEFAULT NULL,
  `monthsinterest1` decimal(4,0) DEFAULT NULL,
  `monthsinterest2` decimal(4,0) DEFAULT NULL,
  `monthsinterest3` decimal(4,0) DEFAULT NULL,
  `monthsinterest4` decimal(4,0) DEFAULT NULL,
  `monthsinterest5` decimal(4,0) DEFAULT NULL,
  `interestpercent1` decimal(4,2) DEFAULT NULL,
  `interestpercent2` decimal(4,2) DEFAULT NULL,
  `interestpercent3` decimal(4,2) DEFAULT NULL,
  `interestpercent4` decimal(4,2) DEFAULT NULL,
  `interestpercent5` decimal(4,2) DEFAULT NULL,
  `curtailmentpayments` decimal(4,0) DEFAULT NULL,
  `dateadded` date DEFAULT NULL,
  `lastchangedbyid` int(11) DEFAULT NULL,
  `lastchangeddate` date DEFAULT NULL,
  `active` varchar(1) NOT NULL DEFAULT 'Y',
  `dealernotes` mediumtext,
  `lastinventorieddate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 11264 kB; InnoDB free: 11264 kB; InnoDB free: 1';

-- --------------------------------------------------------

--
-- Table structure for table `commentbranch`
--

DROP TABLE IF EXISTS `commentbranch`;
CREATE TABLE `commentbranch` (
  `commentid` int(11) NOT NULL,
  `txbuserid` int(11) DEFAULT NULL,
  `branchid` int(11) DEFAULT NULL,
  `commentdetails` text,
  `commentdate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `countrytable`
--

DROP TABLE IF EXISTS `countrytable`;
CREATE TABLE `countrytable` (
  `countryid` char(2) NOT NULL,
  `countryname` varchar(100) NOT NULL,
  `active` char(1) NOT NULL DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealergroup`
--

DROP TABLE IF EXISTS `dealergroup`;
CREATE TABLE `dealergroup` (
  `dealergroupid` int(11) NOT NULL,
  `dealergroupname` varchar(255) DEFAULT NULL,
  `dealergroupdescription` varchar(255) DEFAULT NULL,
  `dealergroupprice` varchar(256) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealertype`
--

DROP TABLE IF EXISTS `dealertype`;
CREATE TABLE `dealertype` (
  `dealertypeid` int(11) NOT NULL,
  `dealertypename` varchar(255) DEFAULT NULL,
  `dealertypedescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
CREATE TABLE `feature` (
  `featureid` int(11) NOT NULL,
  `featurename` varchar(255) DEFAULT NULL,
  `featurehint` varchar(255) DEFAULT NULL,
  `featuredescription` varchar(255) DEFAULT NULL,
  `featureprice` decimal(10,2) DEFAULT NULL,
  `featurecost` decimal(10,2) DEFAULT NULL,
  `featureqtymax` decimal(10,0) DEFAULT NULL,
  `featuregroupid` int(11) DEFAULT NULL,
  `featureabbr` varchar(255) DEFAULT NULL,
  `active` char(1) DEFAULT 'Y',
  `featureinches` decimal(10,2) DEFAULT NULL,
  `gaterampgroupid` int(11) DEFAULT NULL,
  `showwelding` varchar(1) NOT NULL DEFAULT 'N',
  `showpaint` varchar(1) NOT NULL DEFAULT 'N',
  `showfinishing` varchar(1) NOT NULL DEFAULT 'N',
  `showstacking` varchar(1) NOT NULL DEFAULT 'N',
  `showcleanup` varchar(1) NOT NULL DEFAULT 'N',
  `showlabeling` varchar(1) NOT NULL DEFAULT 'N',
  `gawr` decimal(10,0) DEFAULT NULL,
  `rimsize` varchar(255) DEFAULT NULL,
  `tiresize` varchar(255) DEFAULT NULL,
  `tirepsi` varchar(255) DEFAULT NULL,
  `tiresizeabbr` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `featuregroup`
--

DROP TABLE IF EXISTS `featuregroup`;
CREATE TABLE `featuregroup` (
  `featuregroupid` int(11) NOT NULL,
  `featuregroupname` varchar(255) DEFAULT NULL,
  `featuregroupdescription` varchar(255) DEFAULT NULL,
  `active` char(1) DEFAULT 'Y',
  `featuregrouptypeid` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `featuregrouptype`
--

DROP TABLE IF EXISTS `featuregrouptype`;
CREATE TABLE `featuregrouptype` (
  `featuregrouptypeid` int(11) NOT NULL,
  `featuregrouptypename` varchar(255) DEFAULT NULL,
  `featuregrouptypedescription` varchar(255) DEFAULT NULL,
  `active` char(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `featuretype`
--

DROP TABLE IF EXISTS `featuretype`;
CREATE TABLE `featuretype` (
  `featuretypeid` int(11) NOT NULL,
  `featuretypename` varchar(255) DEFAULT NULL,
  `featuretypedescription` varchar(255) DEFAULT NULL,
  `active` char(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gaterampgroup`
--

DROP TABLE IF EXISTS `gaterampgroup`;
CREATE TABLE `gaterampgroup` (
  `gaterampgroupid` int(11) NOT NULL,
  `gaterampgroupname` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gvwr`
--

DROP TABLE IF EXISTS `gvwr`;
CREATE TABLE `gvwr` (
  `gvwrid` int(11) NOT NULL,
  `gvwrname` varchar(255) DEFAULT NULL,
  `gvwrdescription` varchar(255) DEFAULT NULL,
  `active` char(1) DEFAULT 'Y',
  `gvwrpounds` decimal(10,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inventorycolor`
--

DROP TABLE IF EXISTS `inventorycolor`;
CREATE TABLE `inventorycolor` (
  `inventorycolorid` int(11) NOT NULL,
  `inventorycolorname` varchar(255) DEFAULT NULL,
  `inventorycolordescription` varchar(255) DEFAULT NULL,
  `inventorycolorprice` decimal(4,0) DEFAULT NULL,
  `inventorycolorphoto` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inventorytype`
--

DROP TABLE IF EXISTS `inventorytype`;
CREATE TABLE `inventorytype` (
  `inventorytypeid` int(11) NOT NULL,
  `inventorytypename` varchar(255) DEFAULT NULL,
  `inventorytypedescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invoicetype`
--

DROP TABLE IF EXISTS `invoicetype`;
CREATE TABLE `invoicetype` (
  `invoicetypeid` int(11) NOT NULL,
  `invoicetypename` varchar(255) DEFAULT NULL,
  `invoicetypeabbr` varchar(255) DEFAULT NULL,
  `invoicetypedescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `materialtype`
--

DROP TABLE IF EXISTS `materialtype`;
CREATE TABLE `materialtype` (
  `materialtypeid` int(11) NOT NULL,
  `materialtype` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `numberfromdb`
--

DROP TABLE IF EXISTS `numberfromdb`;
CREATE TABLE `numberfromdb` (
  `numberfromdb` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orderfile`
--

DROP TABLE IF EXISTS `orderfile`;
CREATE TABLE `orderfile` (
  `orderfileid` int(11) NOT NULL,
  `orderid` int(11) DEFAULT NULL,
  `orderfilename` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ordernotificationmethod`
--

DROP TABLE IF EXISTS `ordernotificationmethod`;
CREATE TABLE `ordernotificationmethod` (
  `ordernotificationmethodid` int(11) NOT NULL,
  `ordernotificationmethodname` varchar(255) DEFAULT NULL,
  `ordernotificationmethoddescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orderoptionalfeature`
--

DROP TABLE IF EXISTS `orderoptionalfeature`;
CREATE TABLE `orderoptionalfeature` (
  `orderoptionalfeatureid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `featureid` int(11) NOT NULL,
  `optionpricetotal` decimal(10,2) DEFAULT NULL,
  `optionqty` varchar(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orderpartextra`
--

DROP TABLE IF EXISTS `orderpartextra`;
CREATE TABLE `orderpartextra` (
  `orderpartextraid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `orderpartextraname` varchar(255) NOT NULL,
  `orderpartextrapriceeach` decimal(10,2) DEFAULT NULL,
  `orderpartextraqty` varchar(5) DEFAULT NULL,
  `orderpartextracost` decimal(10,2) DEFAULT NULL,
  `orderpartextrapricetotal` decimal(10,2) DEFAULT NULL,
  `active` varchar(1) NOT NULL DEFAULT 'Y',
  `orderpartextraoptionnumber` decimal(10,0) DEFAULT NULL,
  `disabledbyid` int(11) DEFAULT NULL,
  `datedisabled` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `OrderPayment`
--

DROP TABLE IF EXISTS `OrderPayment`;
CREATE TABLE `OrderPayment` (
  `OrderPaymentID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `OrderTotal` decimal(10,4) UNSIGNED ZEROFILL NOT NULL,
  `CurrentTotalPaid` decimal(10,4) UNSIGNED ZEROFILL DEFAULT NULL,
  `CreditCardFees` decimal(8,4) UNSIGNED ZEROFILL DEFAULT NULL,
  `CreatedBy` varchar(25) NOT NULL,
  `CreatedDate` date NOT NULL,
  `UpdatedBy` varchar(25) DEFAULT NULL,
  `UpdatedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Order Payment Header Table';

-- --------------------------------------------------------

--
-- Table structure for table `OrderPaymentDetail`
--

DROP TABLE IF EXISTS `OrderPaymentDetail`;
CREATE TABLE `OrderPaymentDetail` (
  `OrderPaymentDetailID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `PaymentDetailLineNumber` int(11) NOT NULL,
  `PaymentType` varchar(15) NOT NULL,
  `PaymentDate` date NOT NULL,
  `PaymentAmount` decimal(9,4) UNSIGNED ZEROFILL NOT NULL,
  `CheckNumber` varchar(15) DEFAULT NULL,
  `CheckDate` date DEFAULT NULL,
  `CheckAccountNumber` varchar(25) DEFAULT NULL,
  `CheckRoutingNumber` varchar(25) DEFAULT NULL,
  `CheckName` varchar(50) DEFAULT NULL,
  `CreditCardType` varchar(20) DEFAULT NULL,
  `CreditCardName` varchar(50) DEFAULT NULL,
  `CreditCardNumber` varchar(25) DEFAULT NULL,
  `CreditCardExpiration` varchar(6) DEFAULT NULL,
  `CreditCardCVC` text,
  `CreditCardFee` decimal(8,4) UNSIGNED ZEROFILL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `OrderPaymentDetail`
--
DROP TRIGGER IF EXISTS `UpdateUserTriggerAI`;
DELIMITER $$
CREATE TRIGGER `UpdateUserTriggerAI` AFTER INSERT ON `OrderPaymentDetail` FOR EACH ROW BEGIN
DECLARE vUser VARCHAR(50);

-- This trigger will update the UpdatedBy field for the OrderID in 
-- OrderPayment table (After Insert) when the second line of detail 
-- is added into the OrderPaymentDetails table. Order Payment info
-- for the orderid has already been created; it's the additional
-- payments that 'update' the OrderPayment table.

-- Find username of person performing the UPDATE into Table

SELECT USER() INTO vUser;

UPDATE OrderPayment
   SET OrderPayment.UpdatedBy=vUser,
       OrderPayment.UpdatedDate=SYSDATE()
 WHERE OrderPayment.OrderID=NEW.OrderID
   AND NEW.PaymentDetailLineNumber>1;

END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `updateUserTriggerAU`;
DELIMITER $$
CREATE TRIGGER `updateUserTriggerAU` AFTER UPDATE ON `OrderPaymentDetail` FOR EACH ROW BEGIN
DECLARE vUser VARCHAR(50);

-- This trigger will be executed when individual payments have been
-- updated in the OrderPaymentDetails table.

-- Find username of person performing the UPDATE into Table

SELECT USER() INTO vUser;

UPDATE OrderPayment
   SET OrderPayment.UpdatedBy=vUser,
       OrderPayment.UpdatedDate=SYSDATE()
 WHERE OrderPayment.OrderID=NEW.OrderID;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orderstatus`
--

DROP TABLE IF EXISTS `orderstatus`;
CREATE TABLE `orderstatus` (
  `orderstatusid` int(11) NOT NULL,
  `orderstatusname` varchar(255) DEFAULT NULL,
  `orderstatusdescription` varchar(255) DEFAULT NULL,
  `active` char(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

DROP TABLE IF EXISTS `ordertable`;
CREATE TABLE `ordertable` (
  `orderid` int(11) NOT NULL,
  `branchid` int(11) NOT NULL,
  `trailerid` int(11) NOT NULL,
  `trailerprice` decimal(10,2) DEFAULT NULL,
  `orderby` int(11) NOT NULL,
  `orderrefnum` varchar(255) DEFAULT NULL,
  `orderstatus` varchar(255) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `dateapproved` datetime DEFAULT NULL,
  `markedapprovedby` int(11) DEFAULT NULL,
  `ordernotes` mediumtext,
  `trailercolorid` int(11) DEFAULT NULL,
  `trailercolorstripeid` int(11) DEFAULT NULL,
  `orderforcustomerfirstname` varchar(255) DEFAULT NULL,
  `orderforcustomerlastname` varchar(255) DEFAULT NULL,
  `orderforcustomeraddress1` varchar(255) DEFAULT NULL,
  `orderforcustomeraddress2` varchar(255) DEFAULT NULL,
  `orderforcustomercity` varchar(255) DEFAULT NULL,
  `orderforcustomerstate` char(2) DEFAULT NULL,
  `orderforcustomerpostalcode` varchar(9) DEFAULT NULL,
  `orderforcustomercountry` char(2) DEFAULT NULL,
  `orderforcustomerphone` char(10) DEFAULT NULL,
  `orderforcustomeremail` varchar(255) DEFAULT NULL,
  `orderforcustomerpaymenttype` int(11) DEFAULT NULL,
  `orderforcustomerpaymentterms` mediumtext,
  `orderweldingcomplete` varchar(1) NOT NULL DEFAULT 'N',
  `orderpaintcomplete` varchar(1) NOT NULL DEFAULT 'N',
  `orderfinishingcomplete` varchar(1) NOT NULL DEFAULT 'N',
  `orderstackingcomplete` varchar(1) NOT NULL DEFAULT 'N',
  `ordercleanupcomplete` varchar(1) NOT NULL DEFAULT 'N',
  `orderlabelingcomplete` varchar(1) NOT NULL DEFAULT 'N',
  `ordershipped` varchar(1) NOT NULL DEFAULT 'N',
  `weldingdate` datetime DEFAULT NULL,
  `weldinguserid` int(11) DEFAULT NULL,
  `paintdate` datetime DEFAULT NULL,
  `paintuserid` int(11) DEFAULT NULL,
  `finishingdate` datetime DEFAULT NULL,
  `finishinguserid` int(11) DEFAULT NULL,
  `orderstackingdate` datetime DEFAULT NULL,
  `orderstackinguserid` int(11) DEFAULT NULL,
  `cleanupdate` datetime DEFAULT NULL,
  `cleanupuserid` int(11) DEFAULT NULL,
  `labelingdate` datetime DEFAULT NULL,
  `labelinguserid` int(11) DEFAULT NULL,
  `ordershippeddate` datetime DEFAULT NULL,
  `ordershippeduserid` int(11) DEFAULT NULL,
  `invoicetypeid` int(11) DEFAULT NULL,
  `paymentmethodid` int(11) DEFAULT NULL,
  `paymentstatusid` int(11) DEFAULT '3'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ordertrailerdetails`
--

DROP TABLE IF EXISTS `ordertrailerdetails`;
CREATE TABLE `ordertrailerdetails` (
  `ordertrailerdetailsid` int(11) NOT NULL,
  `orderid` int(11) DEFAULT NULL,
  `ordertdvincompanyid` int(11) DEFAULT NULL,
  `ordertdvintypeid` int(11) DEFAULT NULL,
  `ordertdvinseriesid` int(11) DEFAULT NULL,
  `ordertdaxlesnumber` decimal(2,0) DEFAULT NULL,
  `ordertdtraileryearid` int(11) DEFAULT NULL,
  `ordertdplantnumberid` int(11) DEFAULT NULL,
  `ordertdsoldyearid` int(11) DEFAULT NULL,
  `ordertdsequential` decimal(20,0) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ordertrailerfeaturedropdown`
--

DROP TABLE IF EXISTS `ordertrailerfeaturedropdown`;
CREATE TABLE `ordertrailerfeaturedropdown` (
  `ordertrailerfeaturedropdownid` int(11) NOT NULL,
  `orderid` int(11) DEFAULT NULL,
  `hiddenlengthfinalfull` varchar(255) DEFAULT NULL,
  `hiddenlengthfinalidONLY` int(11) DEFAULT NULL,
  `hiddenlengthfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenlengthfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddentonguefinalfull` varchar(255) DEFAULT NULL,
  `hiddentonguefinalidONLY` int(11) DEFAULT NULL,
  `hiddentonguefinalprice` decimal(10,2) DEFAULT NULL,
  `hiddentonguefinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddencouplerfinalfull` varchar(255) DEFAULT NULL,
  `hiddencouplerfinalidONLY` int(11) DEFAULT NULL,
  `hiddencouplerfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddencouplerfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenjackfinalfull` varchar(255) DEFAULT NULL,
  `hiddenjackfinalidONLY` int(11) DEFAULT NULL,
  `hiddenjackfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenjackfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenbrakefinalfull` varchar(255) DEFAULT NULL,
  `hiddenbrakefinalidONLY` int(11) DEFAULT NULL,
  `hiddenbrakefinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenbrakefinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenaxlefinalfull` varchar(255) DEFAULT NULL,
  `hiddenaxlefinalidONLY` int(11) DEFAULT NULL,
  `hiddenaxlefinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenaxlefinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenrampsfinalfull` varchar(255) DEFAULT NULL,
  `hiddenrampsfinalidONLY` int(11) DEFAULT NULL,
  `hiddenrampsfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenrampsfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenfloorfinalfull` varchar(255) DEFAULT NULL,
  `hiddenfloorfinalidONLY` int(11) DEFAULT NULL,
  `hiddenfloorfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenfloorfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddentiresfinalfull` varchar(255) DEFAULT NULL,
  `hiddentiresfinalidONLY` int(11) DEFAULT NULL,
  `hiddentiresfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddentiresfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddentiressparefinalfull` varchar(255) DEFAULT NULL,
  `hiddentiressparefinalidONLY` int(11) DEFAULT NULL,
  `hiddentiressparefinalprice` decimal(10,2) DEFAULT NULL,
  `hiddentiressparefinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddentiresrackfinalfull` varchar(255) DEFAULT NULL,
  `hiddentiresrackfinalidONLY` int(11) DEFAULT NULL,
  `hiddentiresrackfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddentiresrackfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenfenderfinalfull` varchar(255) DEFAULT NULL,
  `hiddenfenderfinalidONLY` int(11) DEFAULT NULL,
  `hiddenfenderfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenfenderfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenlightsfinalfull` varchar(255) DEFAULT NULL,
  `hiddenlightsfinalidONLY` int(11) DEFAULT NULL,
  `hiddenlightsfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenlightsfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddentoolboxfinalfull` varchar(255) DEFAULT NULL,
  `hiddentoolboxfinalidONLY` int(11) DEFAULT NULL,
  `hiddentoolboxfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddentoolboxfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddensidesfinalfull` varchar(255) DEFAULT NULL,
  `hiddensidesfinalidONLY` int(11) DEFAULT NULL,
  `hiddensidesfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddensidesfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddentoprailfinalfull` varchar(255) DEFAULT NULL,
  `hiddentoprailfinalidONLY` int(11) DEFAULT NULL,
  `hiddentoprailfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddentoprailfinalpriceONLY` decimal(10,2) DEFAULT NULL,
  `hiddenwheelsfinalfull` varchar(255) DEFAULT NULL,
  `hiddenwheelsfinalidONLY` int(11) DEFAULT NULL,
  `hiddenwheelsfinalprice` decimal(10,2) DEFAULT NULL,
  `hiddenwheelsfinalpriceONLY` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `paymentmethod`
--

DROP TABLE IF EXISTS `paymentmethod`;
CREATE TABLE `paymentmethod` (
  `paymentmethodid` int(11) NOT NULL,
  `paymentmethodname` varchar(255) DEFAULT NULL,
  `paymentmethoddescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `paymentstatus`
--

DROP TABLE IF EXISTS `paymentstatus`;
CREATE TABLE `paymentstatus` (
  `paymentstatusid` int(11) NOT NULL,
  `paymentstatusname` varchar(255) DEFAULT NULL,
  `paymentstatusdescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) NOT NULL DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `permissionstable`
--

DROP TABLE IF EXISTS `permissionstable`;
CREATE TABLE `permissionstable` (
  `permissionsid` int(11) NOT NULL,
  `permissionsname` varchar(255) DEFAULT NULL,
  `permissionsdescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phonecellcarrier`
--

DROP TABLE IF EXISTS `phonecellcarrier`;
CREATE TABLE `phonecellcarrier` (
  `phonecellcarrierid` int(11) NOT NULL,
  `phonecellcarriername` varchar(255) DEFAULT NULL,
  `phonecellcarrierdescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `plantnumber`
--

DROP TABLE IF EXISTS `plantnumber`;
CREATE TABLE `plantnumber` (
  `plantnumberid` int(11) NOT NULL,
  `plantnumbername` varchar(255) DEFAULT NULL,
  `plantnumbercode` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shippingmethod`
--

DROP TABLE IF EXISTS `shippingmethod`;
CREATE TABLE `shippingmethod` (
  `shippingmethodid` int(11) NOT NULL,
  `shippingmethodname` varchar(255) DEFAULT NULL,
  `shippingmethoddescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `soldyear`
--

DROP TABLE IF EXISTS `soldyear`;
CREATE TABLE `soldyear` (
  `soldyearid` int(11) NOT NULL,
  `soldyearname` varchar(255) DEFAULT NULL,
  `soldyearcode` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `statetable`
--

DROP TABLE IF EXISTS `statetable`;
CREATE TABLE `statetable` (
  `stateid` char(2) NOT NULL DEFAULT '',
  `statename` varchar(50) DEFAULT NULL,
  `active` char(1) NOT NULL DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplierid` int(11) NOT NULL,
  `suppliername` varchar(255) DEFAULT NULL,
  `supplierdescription` varchar(255) DEFAULT NULL,
  `supplierphone` varchar(10) DEFAULT NULL,
  `supplierfax` varchar(10) DEFAULT NULL,
  `supplieraddress1` varchar(255) DEFAULT NULL,
  `supplieraddress2` varchar(255) DEFAULT NULL,
  `suppliercity` varchar(255) DEFAULT NULL,
  `supplierstate` char(2) DEFAULT 'TX',
  `supplierpostalcode` varchar(9) DEFAULT NULL,
  `suppliercountry` char(2) DEFAULT 'US',
  `supplierwebsite` varchar(255) DEFAULT NULL,
  `supplieremail` varchar(255) DEFAULT NULL,
  `supplierlogo` varchar(255) DEFAULT NULL,
  `supplierapproxshipdays` varchar(255) DEFAULT NULL,
  `supplierpayfreight` char(1) DEFAULT 'N',
  `active` char(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailer`
--

DROP TABLE IF EXISTS `trailer`;
CREATE TABLE `trailer` (
  `trailerid` int(11) NOT NULL,
  `trailername` varchar(255) DEFAULT NULL,
  `trailerdescription` varchar(8000) DEFAULT NULL,
  `trailerimage` varchar(256) DEFAULT NULL,
  `trailergvwrid` int(11) DEFAULT NULL,
  `trailertypeidmain` int(11) DEFAULT NULL,
  `trailermodelidgroup` int(11) DEFAULT NULL,
  `addedbyid` int(11) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `lastupdatedbyid` int(11) DEFAULT NULL,
  `lastupdateddate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `active` char(1) DEFAULT 'Y',
  `trailerlength` varchar(255) DEFAULT NULL,
  `trailerwidth` varchar(255) DEFAULT NULL,
  `trailerheight` varchar(255) DEFAULT NULL,
  `trailerweight` varchar(255) DEFAULT NULL,
  `freightperfoot` decimal(10,2) DEFAULT NULL,
  `loadspotsrequired` decimal(10,2) DEFAULT NULL,
  `builtperday` decimal(10,2) DEFAULT NULL,
  `warrantymonths` decimal(10,2) DEFAULT NULL,
  `trailerabbr` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailercolor`
--

DROP TABLE IF EXISTS `trailercolor`;
CREATE TABLE `trailercolor` (
  `trailercolorid` int(11) NOT NULL,
  `trailerid` int(11) DEFAULT NULL,
  `inventorycolorid` int(11) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailercolorstripe`
--

DROP TABLE IF EXISTS `trailercolorstripe`;
CREATE TABLE `trailercolorstripe` (
  `trailercolorstripeid` int(11) NOT NULL,
  `trailerid` int(11) DEFAULT NULL,
  `inventorycolorid` int(11) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailerfeature`
--

DROP TABLE IF EXISTS `trailerfeature`;
CREATE TABLE `trailerfeature` (
  `trailerfeatureid` int(11) NOT NULL,
  `trailerid` int(11) NOT NULL,
  `featureid` int(11) NOT NULL,
  `featuretypeid` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailerfeatureoptional`
--

DROP TABLE IF EXISTS `trailerfeatureoptional`;
CREATE TABLE `trailerfeatureoptional` (
  `trailerfeatureoptionalid` int(11) NOT NULL,
  `trailerid` int(11) NOT NULL,
  `featureid` int(11) NOT NULL,
  `featuretypeid` int(11) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailerfeaturestandard`
--

DROP TABLE IF EXISTS `trailerfeaturestandard`;
CREATE TABLE `trailerfeaturestandard` (
  `trailerfeaturestandardid` int(11) NOT NULL,
  `trailerid` int(11) NOT NULL,
  `featureid` int(11) NOT NULL,
  `featuretypeid` int(11) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailermodelgroup`
--

DROP TABLE IF EXISTS `trailermodelgroup`;
CREATE TABLE `trailermodelgroup` (
  `trailermodelgroupid` int(11) NOT NULL,
  `trailermodelgroupabbr` varchar(255) DEFAULT NULL,
  `trailermodelgroupname` varchar(255) DEFAULT NULL,
  `trailermodelgroupdescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailerprice`
--

DROP TABLE IF EXISTS `trailerprice`;
CREATE TABLE `trailerprice` (
  `trailerpriceid` int(11) NOT NULL,
  `trailerid` int(11) NOT NULL,
  `dealergroupid` int(11) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailersperload`
--

DROP TABLE IF EXISTS `trailersperload`;
CREATE TABLE `trailersperload` (
  `trailersperloadid` int(11) NOT NULL,
  `trailersperload` decimal(10,0) NOT NULL,
  `active` char(1) NOT NULL DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trailertype`
--

DROP TABLE IF EXISTS `trailertype`;
CREATE TABLE `trailertype` (
  `trailertypeid` int(11) NOT NULL,
  `trailertypename` varchar(255) DEFAULT NULL,
  `trailertypedescription` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `traileryear`
--

DROP TABLE IF EXISTS `traileryear`;
CREATE TABLE `traileryear` (
  `traileryearid` int(11) NOT NULL,
  `traileryearname` varchar(255) DEFAULT NULL,
  `traileryearcode` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usertable`
--

DROP TABLE IF EXISTS `usertable`;
CREATE TABLE `usertable` (
  `userid` int(11) NOT NULL,
  `firstname` varchar(70) NOT NULL,
  `lastname` varchar(70) NOT NULL,
  `description` text,
  `branchid` int(11) DEFAULT '0',
  `primarybranchid` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `phone` char(20) DEFAULT NULL,
  `ext` char(10) DEFAULT NULL,
  `fax` char(20) DEFAULT NULL,
  `phonecell` char(20) DEFAULT NULL,
  `phonecellcarrierid` int(11) DEFAULT NULL,
  `permissionsid` int(11) DEFAULT '1',
  `sdate` date DEFAULT NULL,
  `lastchangedbyid` int(11) DEFAULT NULL,
  `disableddate` date DEFAULT NULL,
  `disabledbyid` int(11) DEFAULT NULL,
  `validation_code` varchar(50) DEFAULT '0',
  `active` varchar(1) DEFAULT 'Y',
  `secdealerinfo` int(11) DEFAULT '4',
  `secuserinfo` int(11) DEFAULT '4',
  `secdealerreports` int(11) DEFAULT '4',
  `secuserreports` int(11) DEFAULT '4',
  `secinventory` int(11) DEFAULT '4',
  `secinventoryreports` int(11) DEFAULT '4',
  `secplaceorders` varchar(1) DEFAULT 'Y',
  `secquotes` int(11) DEFAULT '4',
  `secorders` int(11) DEFAULT '4',
  `secordersreports` int(11) DEFAULT '4',
  `secscheduling` int(11) DEFAULT '4',
  `secschedulingreports` int(11) DEFAULT '4',
  `secvin` int(11) DEFAULT '4',
  `secvinreports` int(11) DEFAULT '4',
  `secproduction` int(11) DEFAULT '4',
  `secproductionreports` int(11) DEFAULT '4',
  `secinvoice` int(11) DEFAULT '4',
  `secinvoicereports` int(11) DEFAULT '4',
  `secpayment` int(11) DEFAULT '4',
  `secpaymentreports` int(11) DEFAULT '4',
  `emailorderapproved` varchar(1) DEFAULT NULL,
  `emailordertoproduction` varchar(1) DEFAULT NULL,
  `emailshippedtoday` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 4096 kB; InnoDB free: 4096 kB; InnoDB free: 409';

-- --------------------------------------------------------

--
-- Table structure for table `vincompany`
--

DROP TABLE IF EXISTS `vincompany`;
CREATE TABLE `vincompany` (
  `vincompanyid` int(11) NOT NULL,
  `vincompanyname` varchar(255) DEFAULT NULL,
  `vincompanycode` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vinseries`
--

DROP TABLE IF EXISTS `vinseries`;
CREATE TABLE `vinseries` (
  `vinseriesid` int(11) NOT NULL,
  `vinseriesname` varchar(255) DEFAULT NULL,
  `vinseries` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vintype`
--

DROP TABLE IF EXISTS `vintype`;
CREATE TABLE `vintype` (
  `vintypeid` int(11) NOT NULL,
  `vintypename` varchar(255) DEFAULT NULL,
  `vintype` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branchid`);

--
-- Indexes for table `commentbranch`
--
ALTER TABLE `commentbranch`
  ADD PRIMARY KEY (`commentid`);

--
-- Indexes for table `dealergroup`
--
ALTER TABLE `dealergroup`
  ADD PRIMARY KEY (`dealergroupid`);

--
-- Indexes for table `dealertype`
--
ALTER TABLE `dealertype`
  ADD PRIMARY KEY (`dealertypeid`);

--
-- Indexes for table `feature`
--
ALTER TABLE `feature`
  ADD PRIMARY KEY (`featureid`);

--
-- Indexes for table `featuregroup`
--
ALTER TABLE `featuregroup`
  ADD PRIMARY KEY (`featuregroupid`);

--
-- Indexes for table `featuregrouptype`
--
ALTER TABLE `featuregrouptype`
  ADD PRIMARY KEY (`featuregrouptypeid`);

--
-- Indexes for table `featuretype`
--
ALTER TABLE `featuretype`
  ADD PRIMARY KEY (`featuretypeid`);

--
-- Indexes for table `gaterampgroup`
--
ALTER TABLE `gaterampgroup`
  ADD PRIMARY KEY (`gaterampgroupid`);

--
-- Indexes for table `gvwr`
--
ALTER TABLE `gvwr`
  ADD PRIMARY KEY (`gvwrid`);

--
-- Indexes for table `inventorycolor`
--
ALTER TABLE `inventorycolor`
  ADD PRIMARY KEY (`inventorycolorid`);

--
-- Indexes for table `inventorytype`
--
ALTER TABLE `inventorytype`
  ADD PRIMARY KEY (`inventorytypeid`);

--
-- Indexes for table `invoicetype`
--
ALTER TABLE `invoicetype`
  ADD PRIMARY KEY (`invoicetypeid`);

--
-- Indexes for table `materialtype`
--
ALTER TABLE `materialtype`
  ADD PRIMARY KEY (`materialtypeid`);

--
-- Indexes for table `numberfromdb`
--
ALTER TABLE `numberfromdb`
  ADD PRIMARY KEY (`numberfromdb`);

--
-- Indexes for table `orderfile`
--
ALTER TABLE `orderfile`
  ADD PRIMARY KEY (`orderfileid`);

--
-- Indexes for table `ordernotificationmethod`
--
ALTER TABLE `ordernotificationmethod`
  ADD PRIMARY KEY (`ordernotificationmethodid`);

--
-- Indexes for table `orderoptionalfeature`
--
ALTER TABLE `orderoptionalfeature`
  ADD PRIMARY KEY (`orderoptionalfeatureid`);

--
-- Indexes for table `orderpartextra`
--
ALTER TABLE `orderpartextra`
  ADD PRIMARY KEY (`orderpartextraid`);

--
-- Indexes for table `OrderPayment`
--
ALTER TABLE `OrderPayment`
  ADD PRIMARY KEY (`OrderPaymentID`),
  ADD UNIQUE KEY `OrderID` (`OrderID`);

--
-- Indexes for table `OrderPaymentDetail`
--
ALTER TABLE `OrderPaymentDetail`
  ADD PRIMARY KEY (`OrderPaymentDetailID`),
  ADD UNIQUE KEY `OrderPaymentDetail-OrderID-LineNo-INDX` (`OrderID`,`PaymentDetailLineNumber`) USING BTREE,
  ADD KEY `OrderPaymentType-INDX-02` (`PaymentType`),
  ADD KEY `OrderPaymentDetailDate` (`PaymentDate`),
  ADD KEY `OrderID` (`OrderID`);

--
-- Indexes for table `orderstatus`
--
ALTER TABLE `orderstatus`
  ADD PRIMARY KEY (`orderstatusid`);

--
-- Indexes for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD PRIMARY KEY (`orderid`);

--
-- Indexes for table `ordertrailerdetails`
--
ALTER TABLE `ordertrailerdetails`
  ADD PRIMARY KEY (`ordertrailerdetailsid`);

--
-- Indexes for table `ordertrailerfeaturedropdown`
--
ALTER TABLE `ordertrailerfeaturedropdown`
  ADD PRIMARY KEY (`ordertrailerfeaturedropdownid`);

--
-- Indexes for table `paymentmethod`
--
ALTER TABLE `paymentmethod`
  ADD PRIMARY KEY (`paymentmethodid`);

--
-- Indexes for table `paymentstatus`
--
ALTER TABLE `paymentstatus`
  ADD PRIMARY KEY (`paymentstatusid`);

--
-- Indexes for table `permissionstable`
--
ALTER TABLE `permissionstable`
  ADD PRIMARY KEY (`permissionsid`);

--
-- Indexes for table `phonecellcarrier`
--
ALTER TABLE `phonecellcarrier`
  ADD PRIMARY KEY (`phonecellcarrierid`);

--
-- Indexes for table `plantnumber`
--
ALTER TABLE `plantnumber`
  ADD PRIMARY KEY (`plantnumberid`);

--
-- Indexes for table `shippingmethod`
--
ALTER TABLE `shippingmethod`
  ADD PRIMARY KEY (`shippingmethodid`);

--
-- Indexes for table `soldyear`
--
ALTER TABLE `soldyear`
  ADD PRIMARY KEY (`soldyearid`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplierid`);

--
-- Indexes for table `trailer`
--
ALTER TABLE `trailer`
  ADD PRIMARY KEY (`trailerid`);

--
-- Indexes for table `trailercolor`
--
ALTER TABLE `trailercolor`
  ADD PRIMARY KEY (`trailercolorid`);

--
-- Indexes for table `trailercolorstripe`
--
ALTER TABLE `trailercolorstripe`
  ADD PRIMARY KEY (`trailercolorstripeid`);

--
-- Indexes for table `trailerfeature`
--
ALTER TABLE `trailerfeature`
  ADD PRIMARY KEY (`trailerfeatureid`);

--
-- Indexes for table `trailerfeatureoptional`
--
ALTER TABLE `trailerfeatureoptional`
  ADD PRIMARY KEY (`trailerfeatureoptionalid`);

--
-- Indexes for table `trailerfeaturestandard`
--
ALTER TABLE `trailerfeaturestandard`
  ADD PRIMARY KEY (`trailerfeaturestandardid`);

--
-- Indexes for table `trailermodelgroup`
--
ALTER TABLE `trailermodelgroup`
  ADD PRIMARY KEY (`trailermodelgroupid`);

--
-- Indexes for table `trailerprice`
--
ALTER TABLE `trailerprice`
  ADD PRIMARY KEY (`trailerpriceid`);

--
-- Indexes for table `trailersperload`
--
ALTER TABLE `trailersperload`
  ADD PRIMARY KEY (`trailersperloadid`);

--
-- Indexes for table `trailertype`
--
ALTER TABLE `trailertype`
  ADD PRIMARY KEY (`trailertypeid`);

--
-- Indexes for table `traileryear`
--
ALTER TABLE `traileryear`
  ADD PRIMARY KEY (`traileryearid`);

--
-- Indexes for table `usertable`
--
ALTER TABLE `usertable`
  ADD PRIMARY KEY (`userid`),
  ADD KEY `branchid` (`branchid`);

--
-- Indexes for table `vincompany`
--
ALTER TABLE `vincompany`
  ADD PRIMARY KEY (`vincompanyid`);

--
-- Indexes for table `vinseries`
--
ALTER TABLE `vinseries`
  ADD PRIMARY KEY (`vinseriesid`);

--
-- Indexes for table `vintype`
--
ALTER TABLE `vintype`
  ADD PRIMARY KEY (`vintypeid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `branchid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `commentbranch`
--
ALTER TABLE `commentbranch`
  MODIFY `commentid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dealergroup`
--
ALTER TABLE `dealergroup`
  MODIFY `dealergroupid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dealertype`
--
ALTER TABLE `dealertype`
  MODIFY `dealertypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feature`
--
ALTER TABLE `feature`
  MODIFY `featureid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `featuregroup`
--
ALTER TABLE `featuregroup`
  MODIFY `featuregroupid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `featuregrouptype`
--
ALTER TABLE `featuregrouptype`
  MODIFY `featuregrouptypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `featuretype`
--
ALTER TABLE `featuretype`
  MODIFY `featuretypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gaterampgroup`
--
ALTER TABLE `gaterampgroup`
  MODIFY `gaterampgroupid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gvwr`
--
ALTER TABLE `gvwr`
  MODIFY `gvwrid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventorycolor`
--
ALTER TABLE `inventorycolor`
  MODIFY `inventorycolorid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventorytype`
--
ALTER TABLE `inventorytype`
  MODIFY `inventorytypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoicetype`
--
ALTER TABLE `invoicetype`
  MODIFY `invoicetypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `materialtype`
--
ALTER TABLE `materialtype`
  MODIFY `materialtypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderfile`
--
ALTER TABLE `orderfile`
  MODIFY `orderfileid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordernotificationmethod`
--
ALTER TABLE `ordernotificationmethod`
  MODIFY `ordernotificationmethodid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderoptionalfeature`
--
ALTER TABLE `orderoptionalfeature`
  MODIFY `orderoptionalfeatureid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderpartextra`
--
ALTER TABLE `orderpartextra`
  MODIFY `orderpartextraid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `OrderPayment`
--
ALTER TABLE `OrderPayment`
  MODIFY `OrderPaymentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `OrderPaymentDetail`
--
ALTER TABLE `OrderPaymentDetail`
  MODIFY `OrderPaymentDetailID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderstatus`
--
ALTER TABLE `orderstatus`
  MODIFY `orderstatusid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordertable`
--
ALTER TABLE `ordertable`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordertrailerdetails`
--
ALTER TABLE `ordertrailerdetails`
  MODIFY `ordertrailerdetailsid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ordertrailerfeaturedropdown`
--
ALTER TABLE `ordertrailerfeaturedropdown`
  MODIFY `ordertrailerfeaturedropdownid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paymentmethod`
--
ALTER TABLE `paymentmethod`
  MODIFY `paymentmethodid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paymentstatus`
--
ALTER TABLE `paymentstatus`
  MODIFY `paymentstatusid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissionstable`
--
ALTER TABLE `permissionstable`
  MODIFY `permissionsid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phonecellcarrier`
--
ALTER TABLE `phonecellcarrier`
  MODIFY `phonecellcarrierid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plantnumber`
--
ALTER TABLE `plantnumber`
  MODIFY `plantnumberid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shippingmethod`
--
ALTER TABLE `shippingmethod`
  MODIFY `shippingmethodid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `soldyear`
--
ALTER TABLE `soldyear`
  MODIFY `soldyearid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplierid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailer`
--
ALTER TABLE `trailer`
  MODIFY `trailerid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailercolor`
--
ALTER TABLE `trailercolor`
  MODIFY `trailercolorid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailercolorstripe`
--
ALTER TABLE `trailercolorstripe`
  MODIFY `trailercolorstripeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailerfeature`
--
ALTER TABLE `trailerfeature`
  MODIFY `trailerfeatureid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailerfeatureoptional`
--
ALTER TABLE `trailerfeatureoptional`
  MODIFY `trailerfeatureoptionalid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailerfeaturestandard`
--
ALTER TABLE `trailerfeaturestandard`
  MODIFY `trailerfeaturestandardid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailermodelgroup`
--
ALTER TABLE `trailermodelgroup`
  MODIFY `trailermodelgroupid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailerprice`
--
ALTER TABLE `trailerprice`
  MODIFY `trailerpriceid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailersperload`
--
ALTER TABLE `trailersperload`
  MODIFY `trailersperloadid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trailertype`
--
ALTER TABLE `trailertype`
  MODIFY `trailertypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `traileryear`
--
ALTER TABLE `traileryear`
  MODIFY `traileryearid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usertable`
--
ALTER TABLE `usertable`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vincompany`
--
ALTER TABLE `vincompany`
  MODIFY `vincompanyid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vinseries`
--
ALTER TABLE `vinseries`
  MODIFY `vinseriesid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vintype`
--
ALTER TABLE `vintype`
  MODIFY `vintypeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `OrderPaymentDetail`
--
ALTER TABLE `OrderPaymentDetail`
  ADD CONSTRAINT `OrderPayment_OrderID_FKey` FOREIGN KEY (`OrderID`) REFERENCES `OrderPayment` (`OrderID`);

--
-- Constraints for table `usertable`
--
ALTER TABLE `usertable`
  ADD CONSTRAINT `branchid` FOREIGN KEY (`branchid`) REFERENCES `branch` (`branchid`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
