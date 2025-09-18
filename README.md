# Bash RDBMS (Relational Database Management System)

## 📂 Project Structure

```bash
.
├── main.sh                  # Main entry point (shows the first menu)
├── scripts/
│   ├── create_db.sh         # Create a new database (folder)
│   ├── select_db.sh         # Select an existing database
│   ├── create_table.sh      # Create a new table (file with schema)
│   ├── insert_row.sh        # Insert rows into a table
│   ├── view_table.sh        # View table data
│   ├── delete_row.sh        # Delete rows from a table
│   ├── drop_table.sh        # Drop (delete) a table
└── Databases/               # Databases will be created here
```

- **Database** → represented as a folder.
- **Table** → represented as a file inside a database folder.
- **Schema** (columns & types) → stored in the first line of the table file.
- **Rows** → stored in subsequent lines, using `:` as a delimiter (similar to `/etc/passwd` format).

---

## ⚙️ Features

✅ Create a new database
✅ Select an existing database
✅ Create a table with columns & types (`int`, `string`, `float`)
✅ Insert data into a table (with type validation)
✅ View all table data
✅ Delete rows by value
✅ Drop (remove) a table
✅ Menu-driven navigation for ease of use

---

## 🚀 How to Run

1. Clone the repository:

```bash
git clone https://github.com/your-username/bash-rdbms.git
cd bash-rdbms
```

2. Make scripts executable:

```bash
chmod +x main.sh scripts/*.sh
```

3. Run the main script:

```bash
./main.sh
```

---

## 📖 Example Workflow

1. Run `./main.sh`
2. Choose **Create New Database** → enter name → `Databases/YourDB` is created
3. Inside the DB menu:

   - **Create Table** → specify columns & types
   - **Insert into Table** → add rows of data
   - **View Table** → see contents
   - **Delete Row(s)** → remove records by matching values
   - **Drop Table** → delete entire table

---

## 🛠️ Implementation Notes

- Data is **delimited by `:`** for easy parsing with `cut`, `awk`, etc.

- Column **types are validated** during data entry:

  - `int` → must be numbers only
  - `float` → decimal numbers allowed
  - `string` → any text

- Uses `select` and `case` for clean **menu navigation**.

- Tables store schema in the **first line**, e.g.:

```bash
id:name:salary:int:string:float
1:Alice:4500.5
2:Bob:5000.0
```
