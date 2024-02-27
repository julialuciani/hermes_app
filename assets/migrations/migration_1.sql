CREATE TABLE `movement_type` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `name` TEXT NOT NULL
);

--SPLIT--
CREATE TABLE `category` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `name` TEXT NOT NULL,
    `movementTypeId` INTEGER NOT NULL,
    `icon` TEXT NOT NULL,
    `red` INTEGER NOT NULL,
    `green` INTEGER NOT NULL,
    `blue` INTEGER NOT NULL,
    CONSTRAINT `category_FK` FOREIGN KEY (`movementTypeId`) REFERENCES `movement_type`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

--SPLIT--
CREATE TABLE `movement` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `description` TEXT NULL,
    `value` REAL NOT NULL,
    `categoryId` INTEGER NOT NULL,
    `date` INTEGER NOT NULL,
    `image` BLOB NULL,
    CONSTRAINT `category_FK` FOREIGN KEY (`categoryId`) REFERENCES `category`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

--SPLIT--
INSERT
    OR IGNORE INTO `transaction_type`
VALUES
    (1, 'income'),
    (2, 'expenses'),
    (3, 'investments');