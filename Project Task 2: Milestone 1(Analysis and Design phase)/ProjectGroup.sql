CREATE SCHEMA IF NOT EXISTS `cs331project`;

CREATE TABLE IF NOT EXISTS `cs331project`.`CleaningSupply` (
  `name` VARCHAR(45) NOT NULL,
  `descriptionOfUsage` VARCHAR(45) NOT NULL,
  `currentInventory` INT NULL,
  `safetyStockLevel` VARCHAR(45)  NOT NULL,
  PRIMARY KEY (`name`)
);

CREATE TABLE IF NOT EXISTS `cs331project`.`Customer` (
  `ID_Number` INT NOT NULL,
  `name` VARCHAR(45)  NOT NULL,
  `address` VARCHAR(45)  NOT NULL,
  `email` VARCHAR(45)  NOT NULL,
  `telephoneNumber` VARCHAR(45)  NOT NULL,
  `creditCardInfo` VARCHAR(16)  NOT NULL,
  `currentBalance` FLOAT  NOT NULL,
  PRIMARY KEY (`ID_Number`)
);

CREATE TABLE IF NOT EXISTS `cs331project`.`ServiceProvided` (
  `customer_ID` VARCHAR(45) NOT NULL,
  `service_ID` VARCHAR(45) NOT NULL,
  `employee_ID` VARCHAR(45) NOT NULL,
  `date` DATE NULL,
  `amountCharged` VARCHAR(45)  NOT NULL,
  `description` VARCHAR(45)  NOT NULL,
  `satisfaction` VARCHAR(45)  NOT NULL,
  PRIMARY KEY (`customer_ID`, `service_ID`, `employee_ID`)
);

CREATE TABLE IF NOT EXISTS `cs331project`.`Employee` (
  `ID_Number` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45)  NOT NULL,
  `address` VARCHAR(45)  NOT NULL,
  `gender` VARCHAR(45)  NOT NULL,
  `dateOfEmployment` DATE  NOT NULL,
  `positionHiredFor` VARCHAR(45)  NOT NULL,
  `schedule` VARCHAR(45)  NOT NULL,
  `Employeecol` VARCHAR(45)  NOT NULL,
  `ServiceProvided_customer_ID` VARCHAR(45) NOT NULL,
  `ServiceProvided_service_ID` VARCHAR(45) NOT NULL,
  `ServiceProvided_employee_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Number`, `ServiceProvided_customer_ID`, `ServiceProvided_service_ID`, `ServiceProvided_employee_ID`),
    FOREIGN KEY (`ServiceProvided_customer_ID` , `ServiceProvided_service_ID` , `ServiceProvided_employee_ID`)
    REFERENCES `cs331project`.`ServiceProvided` (`customer_ID` , `service_ID` , `employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `cs331project`.`Equipment` (
  `ID_Number` VARCHAR(9) NOT NULL,
  `brandName` VARCHAR(45)  NOT NULL,
  `purchaseDate` DATE  NOT NULL,
  `purchasePrice` FLOAT  NOT NULL,
  `type` VARCHAR(45)  NOT NULL,
  PRIMARY KEY (`ID_Number`)
);

CREATE TABLE IF NOT EXISTS `cs331project`.`schedule` (
  `day` DATE NOT NULL,
  `startTime` TIME  NOT NULL,
  `endTime` TIME NOT NULL,
  `Employee_ID_Number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`day`, `Employee_ID_Number`),
  FOREIGN KEY (`Employee_ID_Number`) REFERENCES `cs331project`.`Employee` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `cs331project`.`Supplier` (
  `ID_Number` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45)  NOT NULL,
  `address` VARCHAR(45)  NOT NULL,
  `phoneNumber` VARCHAR(45)  NOT NULL,
  `currentBalance` FLOAT  NOT NULL,
  PRIMARY KEY (`ID_Number`)
);

CREATE TABLE IF NOT EXISTS `cs331project`.`Service` (
  `ID_Number` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45)  NOT NULL,
  `description` VARCHAR(45)  NOT NULL,
  `rateCharged` VARCHAR(45)  NOT NULL,
  `duration` VARCHAR(45)  NOT NULL,
  `ServiceProvided_customer_ID` VARCHAR(45) NOT NULL,
  `ServiceProvided_service_ID` VARCHAR(45) NOT NULL,
  `ServiceProvided_employee_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Number`),
    FOREIGN KEY (`ServiceProvided_customer_ID` , `ServiceProvided_service_ID` , `ServiceProvided_employee_ID`)
    REFERENCES `cs331project`.`ServiceProvided` (`customer_ID` , `service_ID` , `employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `cs331project`.`supplierTransaction` (
  `ID_Number` VARCHAR(45) NOT NULL,
  `date` DATE NULL,
  `itemPurchased` VARCHAR(45)  NOT NULL,
  `quantityPurchased` VARCHAR(45)  NOT NULL,
  `amountDue` VARCHAR(45)  NOT NULL,
  `dueDate` DATE  NOT NULL,
  `description` VARCHAR(45)  NOT NULL,
  `deliveryDate` DATE  NOT NULL,
  PRIMARY KEY (`ID_Number`)
  
);

CREATE TABLE IF NOT EXISTS `cs331project`.`Customer_has_ServiceProvided` (
  `Customer_ID_Number` INT NOT NULL,
  `ServiceProvided_customer_ID` VARCHAR(45) NOT NULL,
  `ServiceProvided_service_ID` VARCHAR(45) NOT NULL,
  `ServiceProvided_employee_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Customer_ID_Number`, `ServiceProvided_customer_ID`, `ServiceProvided_service_ID`, `ServiceProvided_employee_ID`),
    FOREIGN KEY (`Customer_ID_Number`)REFERENCES `cs331project`.`Customer` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`ServiceProvided_customer_ID` , `ServiceProvided_service_ID` , `ServiceProvided_employee_ID`)
    REFERENCES `cs331project`.`ServiceProvided` (`customer_ID` , `service_ID` , `employee_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

);

CREATE TABLE IF NOT EXISTS `cs331project`.`SupplierAndTransaction` (
  `Supplier_ID_Number` VARCHAR(45) NOT NULL,
  `supplierTransaction_ID_Number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Supplier_ID_Number`, `supplierTransaction_ID_Number`),
    FOREIGN KEY (`Supplier_ID_Number`)
    REFERENCES `cs331project`.`Supplier` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`supplierTransaction_ID_Number`)
    REFERENCES `cs331project`.`supplierTransaction` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `cs331project`.`CleaningTransaction` (
  `supplierTransaction_ID_Number` VARCHAR(45) NOT NULL,
  `CleaningSupply_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplierTransaction_ID_Number`, `CleaningSupply_name`),
    FOREIGN KEY (`supplierTransaction_ID_Number`)
    REFERENCES `cs331project`.`supplierTransaction` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplierTransaction_has_CleaningSupply_CleaningSupply1`
    FOREIGN KEY (`CleaningSupply_name`)
    REFERENCES `cs331project`.`CleaningSupply` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);




CREATE TABLE IF NOT EXISTS `cs331project`.`supplierEquipment` (
  `supplierTransaction_ID_Number` VARCHAR(45) NOT NULL,
  `Equipment_ID_Number` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`supplierTransaction_ID_Number`, `Equipment_ID_Number`),
    FOREIGN KEY (`supplierTransaction_ID_Number`)
    REFERENCES `cs331project`.`supplierTransaction` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`Equipment_ID_Number`)
    REFERENCES `cs331project`.`Equipment` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `cs331project`.`mainSchedule` (
  `maintenanceDate` DATE NOT NULL,
  `Equipment_ID_Number` VARCHAR(9) NOT NULL,
  `Employee_ID_Number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`maintenanceDate`, `Equipment_ID_Number`, `Employee_ID_Number`),
    FOREIGN KEY (`Equipment_ID_Number`)
    REFERENCES `cs331project`.`Equipment` (`ID_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mainSchedule_Employee1`
    FOREIGN KEY (`Employee_ID_Number`)
    REFERENCES `cs331project`.`Employee` (`ID_Number`)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION
);

