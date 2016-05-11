# PROBLEM

I got following error with vertica jdbc driver while reading more than 4.2 billion records.

```
java.sql.SQLException: [Vertica][JDBC](10180) Error fetching data, cursor positioned before first row.
```

Looking inside of jar file,

```
com/vertica/dsi/core/impl/JDBCMessages.properties
12:CURSOR_AFTER_LAST_ROW = (10170) Error fetching data, cursor positioned after last row.
13:CURSOR_BEFORE_FIRST_ROW = (10180) Error fetching data, cursor positioned before first row.
com/vertica/jdbc/common/SForwardResultSet.java
2164:      throw ExceptionConverter.getInstance().toSQLException(JDBCMessageKey.CURSOR_BEFORE_FIRST_ROW, this.m_warningListener, ExceptionType.DEFAULT, new Object[0]);
com/vertica/jdbc/common/SForwardResultSet.java
55:  protected int m_currentRow = 0;
```

It seems that this is caused because `m_currentRow` is `int` and overflowed.

# HOW TO REPRODUCE

First, create a table with data. Go to [./create_table](./create_table).
Then, run a program to reproduce problem. Go to [./reproduce](./reproduce).
