-- Create schema scott if not exists
CREATE SCHEMA IF NOT EXISTS scott;

-- Switch to the scott schema
SET search_path TO scott;

-- Create table DEPT
CREATE TABLE dept (
    deptno INT NOT NULL,
    dname VARCHAR(14) NOT NULL,
    loc VARCHAR(13) NOT NULL,
    CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

-- Create table EMP
CREATE TABLE emp (
    empno INT NOT NULL,
    ename VARCHAR(10) NOT NULL,
    job VARCHAR(9) NOT NULL,
    mgr INT,
    hiredate DATE NOT NULL,
    sal DECIMAL(7,2) NOT NULL,
    comm DECIMAL(7,2),
    deptno INT NOT NULL,
    CONSTRAINT pk_emp PRIMARY KEY (empno),
    CONSTRAINT fk_emp_relation__dept FOREIGN KEY (deptno) REFERENCES dept (deptno),
    CONSTRAINT fk_emp_relation__emp FOREIGN KEY (mgr) REFERENCES emp (empno)
);

-- Create index RELATION_3_FK
CREATE INDEX relation_3_fk ON emp (deptno);

-- Create index RELATION_16_FK
CREATE INDEX relation_16_fk ON emp (mgr);
