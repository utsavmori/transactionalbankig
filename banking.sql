-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2017 at 10:47 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `banking`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `maketransaction` (IN `login` TEXT, IN `toacc` BIGINT(20), IN `amount` DOUBLE, OUT `ret` INT(1))  BEGIN
DECLARE x DOUBLE;
DECLARE y DOUBLE;
DECLARE z DOUBLE;
DECLARE w DOUBLE;
SET ret = 0;
	SET y = (select acno from acholder where loginid=login);
    SET x = (select balance from acholder where loginid=login);
    SET w = (select balance from acholder where acno=toacc);
       
   SET x = x-amount;
   IF x > 0 THEN
    SET w = w+amount;
    INSERT INTO transaction (onac,toac,txntype,amt,bal) VALUES (y,toacc,"DEBIT",amount,x);
     INSERT INTO transaction (onac,toac,txntype,amt,bal) VALUES (toacc,y,"CREDIT",amount,w);
    UPDATE acholder SET balance=x where loginid=login;
    UPDATE acholder SET balance=w where acno=toacc;
 SET ret = 1;

ELSE  SET x=x+amount;
 END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `acholder`
--

CREATE TABLE `acholder` (
  `acno` bigint(20) NOT NULL,
  `bdate` date NOT NULL,
  `name` text NOT NULL,
  `actype` text NOT NULL,
  `balance` double NOT NULL,
  `minbal` double NOT NULL,
  `idcardtype` text NOT NULL,
  `idcardno` text NOT NULL,
  `debitcardno` bigint(20) NOT NULL,
  `loginid` text NOT NULL,
  `pass` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acholder`
--

INSERT INTO `acholder` (`acno`, `bdate`, `name`, `actype`, `balance`, `minbal`, `idcardtype`, `idcardno`, `debitcardno`, `loginid`, `pass`) VALUES
(123456789, '1996-02-26', 'PRATIK BARVALIYA', 'SAVING', 90341, 0, 'AADHAR', '056956892365', 2658965423659658, 'pk', 'pk'),
(987654321, '1996-05-05', 'SEJAL M', 'SAVING', 57659, 0, 'DL', 'GJ0596874', 5698263546985, 'sm', 'sm');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `uname` text NOT NULL,
  `pass` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`uname`, `pass`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `onac` bigint(20) NOT NULL,
  `toac` bigint(20) NOT NULL,
  `txntype` varchar(6) NOT NULL,
  `amt` double NOT NULL,
  `bal` double NOT NULL,
  `txndate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`onac`, `toac`, `txntype`, `amt`, `bal`, `txndate`) VALUES
(123456789, 987654321, 'DEBIT', 2659, 90341, '2017-04-08 07:43:57'),
(987654321, 123456789, 'CREDIT', 2659, 57659, '2017-04-08 07:43:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acholder`
--
ALTER TABLE `acholder`
  ADD PRIMARY KEY (`acno`),
  ADD UNIQUE KEY `UNIQUE` (`loginid`(10));

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD KEY `toac` (`toac`),
  ADD KEY `fromac` (`onac`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acholder`
--
ALTER TABLE `acholder`
  MODIFY `acno` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=987654324;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`toac`) REFERENCES `acholder` (`acno`),
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`onac`) REFERENCES `acholder` (`acno`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
