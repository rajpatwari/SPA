# SHALEY POSHAN AHAR - Supply Chain Management System

## Project Overview

**SHALEY POSHAN AHAR** (शाळे पोषण आहार) is a comprehensive **Supply Chain Management & Distribution System** designed for managing school meal (mid-day meal scheme) supplies, inventory, orders, and distribution across districts and talukas in Maharashtra, India.

The system provides end-to-end tracking of:
- Item inventory and stock management
- Purchase orders and supplier management
- District and taluka-level order creation and dispatch
- Invoice and challan (waybill) generation
- Material inward/receiving management
- Reporting and analytics for procurement and distribution

---

## System Architecture

### High-Level Flow

```
Login (index.jsp)
    ↓
Dashboard (dashboard.jsp)
    ├─ Master Data Management
    │  ├─ Root (Stores/Warehouses)
    │  ├─ Districts & Talukas
    │  ├─ Schools
    │  ├─ Supplier Management
    │  └─ Item Masters
    │
    ├─ Inward Operations
    │  ├─ Material Receipt
    │  └─ Stock Updates
    │
    ├─ Order Management
    │  ├─ District Orders
    │  ├─ Taluka Orders
    │  ├─ School-wise Orders
    │  └─ Challan Generation
    │
    ├─ Dispatch & Distribution
    │  ├─ Create Dispatch
    │  ├─ Taluka Order Dispatch
    │  └─ Track Shipments
    │
    └─ Reports & Analytics
       ├─ Invoice Reports
       ├─ Challan Reports
       ├─ Stock Reports
       └─ District/Taluka Reports
```

---

## Project Structure

```
SPA_code/
├── src/
│   └── org/spa/
│       ├── connect/
│       │   └── dbConnection.java          # Database connection manager
│       ├── entity/
│       │   ├── Beat.java                  # Beat (area division) entity
│       │   ├── Dispatch.java              # Dispatch/shipment entity
│       │   ├── District.java              # District entity
│       │   ├── Item.java                  # Product item entity
│       │   ├── Root.java                  # Warehouse/store entity
│       │   ├── School.java                # School entity
│       │   ├── Section.java               # Section entity
│       │   ├── InwardMaterialStock.java   # Inward stock entity
│       │   ├── InvoiceDS.java             # Invoice data structure
│       │   └── ...
│       ├── helper/
│       │   └── [Helper classes for calculations & utilities]
│       ├── convert/
│       │   ├── NumberToMarathiWord.java   # Number to Marathi word conversion
│       │   └── monthYearToMarathi.java    # Date to Marathi conversion
│       ├── query/
│       │   └── [Database query builders]
│       └── ds/
│           └── [Data structure classes]
│
├── WebContent/
│   ├── index.jsp                          # Login page
│   ├── dashboard.jsp                      # Dashboard
│   ├── master.jsp                         # Master data menu
│   ├── root_master.jsp                    # Root (warehouse) management
│   ├── district_master.jsp                # District management
│   ├── supplier-master.jsp                # Supplier management
│   ├── orders.jsp                         # Orders management
│   ├── stock.jsp                          # Stock management
│   ├── inward.jsp                         # Inward materials
│   ├── dispatch.jsp                       # Dispatch operations
│   ├── reports.jsp                        # Reports menu
│   │
│   ├── create/                            # JSPs for create operations
│   │   ├── create-root.jsp
│   │   ├── create-district.jsp
│   │   ├── create-school.jsp
│   │   ├── create-taluka.jsp
│   │   ├── create-bilty.jsp               # Create bill of lading
│   │   ├── create-invoice.jsp
│   │   ├── create-challans.jsp
│   │   ├── create-dispatch.jsp
│   │   └── ...
│   │
│   ├── read/                              # JSPs for data retrieval (REST-like endpoints)
│   │   ├── get-all-districts.jsp
│   │   ├── get-all-roots.jsp
│   │   ├── get-all-items.jsp
│   │   ├── get-all-inward-material.jsp
│   │   ├── get-all-beat-order.jsp
│   │   └── ...
│   │
│   ├── update/                            # JSPs for update operations
│   │   └── [Update operations]
│   │
│   ├── delete/                            # JSPs for delete operations
│   │   ├── delete-root.jsp
│   │   ├── delete-school-from-root.jsp
│   │   ├── delete-dispatch.jsp
│   │   └── ...
│   │
│   ├── reports/                           # JSPs for report generation
│   │   ├── print-invoice.jsp
│   │   ├── print-all-challan.jsp
│   │   ├── print-district-ration-invoice.jsp
│   │   ├── print-district-rice-invoice.jsp
│   │   ├── print-all-challan-formatted_current.jsp
│   │   ├── print-all-challan-formatted_raj_patwari.jsp
│   │   └── ...
│   │
│   ├── JS/                                # JavaScript files (ExtJS grids & forms)
│   │   ├── master_menu.js
│   │   ├── root_masters.js
│   │   ├── district_masters.js
│   │   ├── orders.js                      # Orders grid and form logic
│   │   ├── stock.js                       # Stock grid and form logic
│   │   ├── inward.js
│   │   ├── dispatch.js
│   │   ├── reports.js
│   │   └── ...
│   │
│   ├── resources/
│   │   ├── css/                           # Stylesheets
│   │   ├── images/                        # Images & logos
│   │   └── ...
│   │
│   └── WEB-INF/
│       └── lib/                           # External JARs
│           ├── mysql-connector-java-5.1.6-bin.jar
│           ├── commons-*.jar             # Apache Commons libraries
│           ├── json-lib-*.jar             # JSON processing
│           ├── itextpdf-*.jar             # PDF generation
│           ├── axis-*.jar                 # SOAP/Web services
│           └── ...
│
├── build/
│   └── classes/                           # Compiled Java classes (auto-generated)
│
├── .classpath                             # Eclipse classpath configuration
├── .project                               # Eclipse project configuration
└── README.md                              # This file
```

---

## Technology Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| **Language** | Java | Java 8 (JavaSE-1.8) |
| **Web Framework** | JSP/Servlet | Java EE / Tomcat |
| **Frontend** | ExtJS + JavaScript | ExtJS 3.x |
| **Database** | MySQL | 5.x |
| **Build Tool** | Eclipse IDE | (Manual compilation or Tomcat deployment) |
| **PDF Generation** | iText | 5.1.3 |
| **JSON Processing** | json-lib | 2.3 |
| **Utilities** | Apache Commons | lang, collections, io |

---

## Key Features & Modules

### 1. **Master Data Management**
- **Root (Warehouse) Management**: Create, read, update, delete warehouse/store locations
- **District & Taluka Management**: Manage geographic divisions
- **School Management**: Register schools and assign to roots
- **Supplier Management**: Maintain supplier information and rates
- **Item Masters**: Define product items (15+ items including extra product categories)
- **Section & Beat Management**: Organizational hierarchy for distribution

### 2. **Inventory & Stock Management**
- **Inward Material Receipt**: Track incoming stock from suppliers
- **Stock Balance Management**: Real-time stock tracking at root/warehouse level
- **Stock Differencing**: Adjust stock for breakage, losses, or reconciliation
- **Material Categorization**: 19+ product categories including:
  - मुंगदाळ (Mung dal)
  - मठी (Matki)
  - Other pulses, oils, spices, rice varieties
  - Extra1, Extra2, Extra3, Extra4, Extra5, Extra6 (flexible product slots)

### 3. **Order Management**
- **District Orders**: Place orders at district level
- **Taluka Orders**: Create taluka-specific orders
- **School-wise Orders**: Assign items to individual schools
- **Order Copy & Modification**: Duplicate and adjust existing orders
- **Order Dispatch**: Link orders to dispatch shipments

### 4. **Dispatch & Distribution**
- **Create Dispatch**: Generate shipment records
- **Taluka Order Dispatch**: Track taluka-level shipments
- **Delete Dispatch**: Revoke incorrect shipments
- **Dispatch Management**: Associate orders with transport/delivery

### 5. **Reporting & Analytics**
- **Invoice Reports**:
  - General invoices (print-invoice.jsp)
  - District ration invoices (print-district-ration-invoice.jsp)
  - District rice invoices (print-district-rice-invoice.jsp)
- **Challan Reports** (Waybills):
  - print-all-challan.jsp
  - print-all-challan-formatted_current.jsp
  - print-all-challan-formatted_raj_patwari.jsp
- **Stock Reports**: Detailed inventory snippets
- **Bill of Lading (Bilty)**: Transport documentation
- **PDF Export**: All reports support PDF generation via iText

---

## Items Managed (19+ Products)

| ItemID | Marathi Name | English Name | Extra Columns |
|--------|-------------|--------------|---|
| 1 | मुंगदाळ | Mung dal | — |
| 2 | मठी | Matki | — |
| 3 | मुग | Mung | — |
| 4 | मसुळदाळ | Masur dal | — |
| 5 | हरबरा | Harbara | — |
| 6 | वटाणा | Vatana | — |
| 7 | Extra1 | Extra1 | सोया वडी (Soya Vadi) |
| 8 | चवळी | Chvli | — |
| 9 | तेल | Oil | — |
| 10 | मिठ | Salt | — |
| 11 | मिरची | Chili | — |
| 12 | हलद | Turmeric | — |
| 13 | जिरे | Cumin | — |
| 14 | मोहरी | Fenugreek | — |
| 15 | Tandul (चावल) | Tandul Rice | — |
| 16 | Extra2 | Extra2 | ItemID 16 |
| 17 | Extra3 | Extra3 | ItemID 17 |
| 18 | Extra4 | Extra4 | ItemID 18 |
| 19 | Extra5 | Extra5 | ItemID 19 |
| 20 | Extra6 | Extra6 | ItemID 20 |

**Note**: Extra1-Extra6 are flexible product slots that can store any commodity. Rate and VAT are managed separately for each extra item.

---

## Prerequisites

### System Requirements
- **OS**: Windows / Linux / macOS
- **Java**: JDK 8+ (JavaSE-1.8)
- **Tomcat**: Apache Tomcat 8.5+ or equivalent servlet container
- **MySQL**: MySQL Server 5.5+
- **IDE**: Eclipse IDE for Enterprise Java Developers (recommended)
- **RAM**: 2GB+ recommended

### Software Installation
1. **JDK 8**: https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html
2. **Apache Tomcat 8.5+**: https://archive.apache.org/dist/tomcat/
3. **MySQL Server**: https://www.mysql.com/downloads/
4. **Eclipse IDE**: https://www.eclipse.org/downloads/

---

## Setup & Installation

### Step 1: Clone or Import Project
```bash
# Clone repository (if using Git)
git clone <repository-url>
cd SPA_code

# OR import into Eclipse:
# File → Import → Existing Projects into Workspace
```

### Step 2: Configure Eclipse IDE
1. Open Eclipse IDE for Enterprise Java Developers
2. Go to **File** → **Import** → **Existing Projects into Workspace**
3. Select this project folder (`SPA_code`)
4. Click **Finish**

### Step 3: Configure Server Runtime (Tomcat)
1. In Eclipse: **Window** → **Preferences** → **Server** → **Runtime Environments**
2. Click **Add**
3. Select **Apache Tomcat v8.5** (or your version)
4. Point to your Tomcat installation directory
5. Click **Finish** and **OK**

### Step 4: Configure Project Facets
1. Right-click project → **Properties**
2. Go to **Project Facets**
3. Click **Convert to faceted form**
4. Select:
   - **Dynamic Web Module** (version 3.0)
   - **Java** (1.8)
5. Under **Runtimes** tab, select your Tomcat runtime
6. Click **Apply and Close**

### Step 5: Set Up MySQL Database
1. Create database and schema:
```sql
CREATE DATABASE shaley_poshan_ahar;
USE shaley_poshan_ahar;

-- Import existing schema if available:
-- SOURCE path/to/database_dump.sql;
```

2. Create necessary tables (root, district, school, item, inward_material, etc.)
   - Reference: Check existing query files in `src/org/spa/query/` for table structure

3. Verify connection in **src/org/spa/connect/dbConnection.java**

### Step 6: Build Project
1. In Eclipse: Right-click project → **Build Project**
2. Verify no compilation errors in **Problems** view
3. Check compiled classes in `build/classes/org/spa/`

---

## How to Run

### Option 1: Run on Embedded Tomcat (Recommended for Development)
1. Right-click project → **Run As** → **Run on Server**
2. Select Apache Tomcat v8.5
3. Click **Finish**
4. Eclipse will:
   - Package the project as a WAR
   - Deploy to Tomcat
   - Start Tomcat server
   - Open default browser to `http://localhost:8080/SPA_code/`

### Option 2: Manual Compilation & Deployment
```bash
# Navigate to project
cd D:\Workspaces\thr_sabla_Workspace\SPA_code

# Compile Java files
javac -version  # Verify Java 8
javac -d build/classes -cp "WebContent/WEB-INF/lib/*:." src/org/spa/**/*.java

# Package as WAR
cd WebContent
jar cvf ../SPA_code.war .
cd ..

# Deploy to Tomcat
# Copy SPA_code.war to TOMCAT_HOME/webapps/

# Start Tomcat
# Windows: TOMCAT_HOME/bin/startup.bat
# Linux/Mac: TOMCAT_HOME/bin/startup.sh
```

### Option 3: Run from Command Line (Windows PowerShell)
```powershell
# Navigate to project
cd D:\Workspaces\thr_sabla_Workspace\SPA_code

# Clean and build
Remove-Item -Recurse -Force build/classes/*
javac -d build/classes -cp "WebContent/WEB-INF/lib/*" src/org/spa/**/*.java

# Start Tomcat (if using Tomcat 9 bundled or installed)
# Verify CATALINA_HOME environment variable is set
# System.setProperty("catalina.home", "C:\Tomcat8.5")
```

---

## Accessing the Application

### Default URL
```
http://localhost:8080/SPA_code/
```

### Login
- **Page**: `index.jsp`
- **Default Credentials**: (Configure in database)
- **Sessions**: sessionStorage is used for year selections and user context

### Main Sections
1. **Dashboard** (`dashboard.jsp`): Central hub for all operations
2. **Masters** (`master.jsp`): Manage root/warehouse, district, school, suppliers
3. **Inward** (`inward.jsp`): Receive and track incoming materials
4. **Orders** (`orders.jsp`): Create and manage orders
5. **Stock** (`stock.jsp`): View stock levels and adjustments
6. **Dispatch** (`dispatch.jsp`): Manage shipments
7. **Reports** (`reports.jsp`): Generate invoices, challans, reports

---

## User Interface Technology

### ExtJS Grid & Form Components
The application extensively uses **Sencha ExtJS 3.x** for rich, interactive UI:

```javascript
// Example from orders.js
var schoolWiseOrderGridEditable = new Ext.grid.GridPanel({
    title: 'School-wise Orders',
    columns: [
        { header: 'School', width: 150, dataIndex: 'schoolName' },
        { header: 'Item', width: 100, dataIndex: 'itemName' },
        { header: 'Quantity', width: 80, dataIndex: 'quantity' },
        { header: 'Extra1', width: 80, dataIndex: 'extra1' },
        { header: 'Extra2', width: 80, dataIndex: 'extra2' },
        // ... more columns
    ],
    // Store, event handlers, etc.
});
```

### Key JS Files
- **orders.js**: Order grid, forms, taluka order grouping, column visibility control
- **stock.js**: Stock grid, balance adjustments, quantity tracking
- **master_menu.js**: Master data navigation and operations
- **dispatch.js**: Dispatch form and operations
- **inward.js**: Inward material receipt forms

---

## Important Notes on Recent Updates

### Extra Product Columns (Extra1-Extra6)
As of the recent session, the system has been enhanced with flexible product columns:

- **ItemID 15-20** map to **Extra1-Extra6** product slots
- Each extra column has:
  - **Quantity tracking** across all modules
  - **Rate per kg** (stored per item master)
  - **VAT percentage** (stored per item master)
  - **Tax calculation** using formula: `quantity × ((rate × vat%) / (100 + vat%))`
  - **Amount calculation**: `quantity × rate`

### Affected Files
All report JSPs now include Extra1-Extra6 columns:
- `reports/print-invoice.jsp`
- `reports/print-all-challan.jsp`
- `reports/print-district-ration-invoice.jsp`
- `reports/print-district-rice-invoice.jsp`
- And others...

### Frontend Grid Columns
ExtJS grids in orders.js and stock.js now display Extra1-Extra6 alongside main items.

---

## Database Configuration

### Connection Details (src/org/spa/connect/dbConnection.java)
```java
public class dbConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/shaley_poshan_ahar";
    private static final String USER = "root";              // MySQL user
    private static final String PASSWORD = "password";     // MySQL password
    // Connection pooling or direct connection
}
```

### Key Tables
- **root**: Warehouse/store locations
- **district**: District information
- **taluka**: Taluka (sub-district) information
- **school**: School information
- **section**: Section/division organization
- **beat**: Beat (small area division)
- **item**: Product item master
- **inward_material**: Incoming material records
- **inward_material_stock**: Stock tracking
- **district_order**: Orders at district level
- **dispatch**: Shipment/dispatch records

---

## Compilation & Error Handling

### Common Issues

#### Issue 1: JSP Compilation Error
```
Error: System.out cannot be resolved to a type
```
**Solution**: Remove `System.out.println()` statements from JSP files. Use `System.err` if debugging is required.

**Example**:
```jsp
<!-- ❌ WRONG -->
<%
    System.out.println("Debug message");
%>

<!-- ✅ CORRECT -->
<!-- Use logging framework or conditional debug output -->
<%
    // request.setAttribute("debug", value);
%>
```

#### Issue 2: ExtJS Runtime Error
```
Uncaught TypeError: Cannot read properties of undefined (reading 'hidden')
```
**Solution**: Validate column index before calling `cm.setHidden(index, ...)`.

**Example (orders.js)**:
```javascript
var cm = grid.getColumnModel();
// ❌ WRONG: May crash if column 27 doesn't exist
cm.setHidden(27, true);

// ✅ CORRECT: Guard with index bounds check
if(cm.config && cm.config.length > 27) { 
    cm.setHidden(27, true); 
}
```

#### Issue 3: Connection Refused (MySQL)
```
java.sql.SQLException: Cannot get a connection, pool error
```
**Solution**:
1. Verify MySQL server is running: `mysql -u root -p`
2. Check connection URL, user, and password in `dbConnection.java`
3. Ensure database and tables exist
4. Check MySQL JDBC driver in `WEB-INF/lib/`

---

## Troubleshooting

### Application Won't Start
1. Check Tomcat logs: `TOMCAT_HOME/logs/catalina.out`
2. Verify port 8080 is not in use: `netstat -an | find ":8080"`
3. Recheck Java version: `java -version` (must be 1.8+)

### Pages Not Loading
1. Check browser console for 404 errors (F12 → Network tab)
2. Verify JSP files are in `WebContent/` and `.jsp` extension is correct
3. Check server-side errors in Tomcat logs

### Database Queries Failing
1. Test connection separately using MySQL CLI
2. Verify table names, column names match queries (case-sensitive on Linux)
3. Check user permissions: `GRANT ALL PRIVILEGES ON shaley_poshan_ahar.* TO 'user'@'localhost';`

### ExtJS Grid Not Rendering
1. Verify `resources/` folder contains ExtJS library (`ext-all.js`, `ext-all.css`)
2. Check browser console for JS errors
3. Inspect column definitions in grid config (orders.js, stock.js)

---

## Project Workflow Example: Creating a District Order

1. **Login** (`index.jsp`) with valid credentials
2. Navigate to **Orders** → **Create District Order** (`create/add-district-order.jsp`)
3. **Select Year**: Choose academic year (e.g., 2024-2025)
4. **Select District**: Choose target district from dropdown
5. **Enter Items & Quantities**: Fill in quantities for all 19+ items (including Extra1-Extra6)
6. **Set Rates & VAT**: System auto-fetches from item master
7. **Calculate Totals**: Backend computes:
   - Weight total (sum of all quantities)
   - Tax total (sum of taxes for all items)
   - Amount total (sum of amounts for all items)
8. **Review Report** (`reports/print-district-ration-invoice.jsp`): PDF preview
9. **Create Dispatch** (`create/create-dispatch.jsp`): Link to shipment
10. **Print Challan** (`reports/print-all-challan.jsp`): Generate waybill

---

## Development Best Practices

### Java Code
- Use entity classes (Beat.java, District.java, etc.) for data modeling
- Use query builders (in `query/` folder) for SQL abstraction
- Implement null checks and validation before processing
- Use try-catch for database operations

### JSP Development
- **Avoid** System.out.println() — causes compilation errors
- Use **session** for user context and authentication
- Use **request** for form parameters
- Encapsulate Java logic in `<% %>` blocks; keep HTML clean
- Use NumberFormatter classes for consistent decimal/percentage display

### JavaScript (ExtJS)
- Use **EditorGridPanel** for inline editing
- Always validate grid column index before calling `setHidden(index, ...)`
- Load data asynchronously via AJAX (JSON responses from read/ JSPs)
- Use **event listeners** for user interactions (click, double-click, etc.)

### Database
- Index frequently queried columns (school_id, item_id, etc.)
- Use transactions for multi-table operations
- Log failed queries for debugging

---

## Performance Optimization

1. **Database**:
   - Add indexes on foreign keys (district_id, school_id, item_id)
   - Use pagination for large result sets (Paging.java)
   - Archive old records to a separate table

2. **Frontend**:
   - Lazy-load grids (load data on demand, not on page load)
   - Use ExtJS Remote sorting/filtering instead of client-side
   - Cache item master data (rates, VAT) in session

3. **Backend**:
   - Pool database connections
   - Cache frequently accessed data (district list, school list)
   - Use batch operations for bulk inserts/updates

---

## Backup & Recovery

### Backup Database
```bash
# MySQL dump
mysqldump -u root -p shaley_poshan_ahar > backup_$(date +"% Y%m%d").sql
```

### Backup Application Files
```bash
# Archive WebContent and src
tar -czf SPA_code_backup_$(date +"%Y%m%d").tar.gz src/ WebContent/
```

---

## Support & Documentation

### InternalContacts
- **Database Admin**: Check `dbConnection.java` for connection config
- **Frontend Dev**: Review `orders.js`, `stock.js` for ExtJS patterns
- **Backend Dev**: Review entity classes in `src/org/spa/entity/`

### External Resources
- **Sencha ExtJS 3.x Docs**: https://docs.sencha.com/extjs/3.4.0/
- **Apache Tomcat**: https://tomcat.apache.org/
- **MySQL**: https://dev.mysql.com/doc/

---

## License & Credits

This project is developed for educational and public food distribution systems in Maharashtra, India.

**Project Name**: SHALEY POSHAN AHAR (शाळे पोषण आहार)  
**Purpose**: School Mid-Day Meal Scheme Supply & Distribution Management  
**Technology**: Java, JSP, ExtJS, MySQL, Tomcat

---

## Changelog

### v1.0 - Current (Enhanced with Extra Product Columns)
- ✅ Fixed Extra1-Extra6 column rendering across all reports
- ✅ Implemented bounds checking in ExtJS grid column operations (orders.js, stock.js)
- ✅ Resolved JSP compilation errors (removed System.out.println statements)
- ✅ Ensured parity of extra1..extra6 across backend calculations and frontend display
- ✅ Added comprehensive README documentation

### Previous Versions
- Multi-item inventory management with 15 core items
- District, taluka, school-wise order management
- Comprehensive reporting (invoices, challans, etc.)
- User authentication and session management

---

## Quick Reference: Key File Paths

| Purpose | File Path |
|---------|-----------|
| Main Login | `WebContent/index.jsp` |
| Dashboard | `WebContent/dashboard.jsp` |
| Orders Management JS | `WebContent/JS/orders.js` |
| Stock Management JS | `WebContent/JS/stock.js` |
| Invoice Report | `WebContent/reports/print-invoice.jsp` |
| Challan Report | `WebContent/reports/print-all-challan.jsp` |
| DB Connection | `src/org/spa/connect/dbConnection.java` |
| Entity Models | `src/org/spa/entity/*.java` |
| Data Read Endpoints | `WebContent/read/get-all-*.jsp` |
| Create Operations | `WebContent/create/*.jsp` |

---

**Last Updated**: June 2026  
**Status**: Production Ready  
**Maintainer**: SPA Development Team

